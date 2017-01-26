-- uspgethourlywindspeed2.sql
--      a function for updating daily_hourlyspeeddatavalues with data from new 
-- sources.
--
-- version 1.0.1
-- updated 2017-01-09
-- 
-- changelog:
-- 1.0.1: added NPS-RAWS, BOEM
-- 1.0.0: added metadata comments

-- Function: tables.uspgethourlywindspeed2(integer, integer)

-- DROP FUNCTION tables.uspgethourlywindspeed2(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgethourlywindspeed2(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
	avgValue float;
	offsetValue float;
	offsetType float;
	loopCursor refcursor;


BEGIN 
-- no offsets for:
--   NCDC: windspeed ms
--   SourceID = 209, VariableID = 335
-- OR
--   ARM Windspeed/ms
--   SourceID = 202, VariableID = 529
-- OR
--   ARM Windspeed/ms
--   SourceID = 1,203, VariableID = 541
-- OR
--   ARM Windspeed/ms
--   SourceID = 203, VariableID = 535
-- OR
--   LPeters Windspeed/ms
--   SourceID = 182, VariableID = 292
-- OR
--   NOAA Windspeed/ms
--   SourceID = 35, VariableID = 511
-- OR
--   RWSI Windspeed/ms
--   SourceID = 213, VariableID = 566
-- OR
--   calon Windspeed/ms
--   SourceID = , VariableID = 1133
-- OR
--   BOEM: windspeed
--   sourceIDs: 248 to 258, VariableID: 1035
-- OR
--   NPS-RAWS: winddir
--   sourceIDs: 136, VariableID: 1171
  IF EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and
                                            $2 in ( 335, 529, 541, 535,
                                                    292, 511, 566, 1133, 1035, 
                                                    1171))
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''hour'',dv.datetimeutc) as dateTimeUTC,
                                avg(dv.datavalue)
                                FROM tables.odmdatavalues_metric AS dv 
                        WHERE dv.siteid = $1 AND dv.originalvariableid = $2
                        GROUP BY date_trunc(''hour'',dv.datetimeutc);') using site_id, var_id;
        loop
          fetch loopCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.hourly_windspeeddatavalues(datavalue,utcdatetime,siteID,Originalvariableid,insertdate)
                 Values(avgValue,dateTimeUTC, $1, $2, NOW());
        end loop;
    CLOSE loopCursor;
-- offsets Max offser
--   UAF/WERC Windspeed/ ms AKST
--   soueceID = 29,30,31,34,223, VariableID = 82
-- OR
--   Toolik windspeed/ms. AKST
--   SourceID = 145, VariableID = 469
-- OR 
--   ARC LTER Windspeed/ms, AKST
--   SourceID = 144, VariableID = 827
  ELSIF EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 in (82, 469, 827))
  THEN
    OPEN loopCursor
    for execute format('
        SELECT date_trunc(''hour'', ws.datetimeUTC) as DateTimeUTC,
                AVG(ws.DataValue),
                MAX_Offset.max_OffsetValue,
                MAX_Offset.max_OffsetTypeID 
        FROM tables.ODMDataValues_metric WS
        INNER JOIN
           (SELECT SiteID,
                   DateTimeUTC,
                   MAX(OffsetValue) as max_OffsetValue,
                   OffsetTypeID as max_OffsetTypeID 
            FROM tables.ODMDataValues_metric 
            WHERE SiteID = $1 AND OriginalVariableID = $2
            GROUP BY SiteID,DateTimeUTC,OffsetTypeID) AS MAX_Offset
        ON MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC 
        WHERE WS.SiteID = $1 and OriginalVariableid= $2 AND 
              WS.OffsetValue = MAX_Offset.max_OffsetValue 
        GROUP BY date_trunc(''hour'', ws.datetimeUTC),
                 MAX_Offset.max_OffsetValue,
                 MAX_Offset.max_OffsetTypeID')using site_id, var_id;
        loop
          fetch loopCursor into dateTimeUTC, avgValue, offsetValue, offsetType;
          if not found then
            exit;
          end if;
          INSERT INTO tables.hourly_windspeeddatavalues(datavalue,utcdatetime,siteID,Originalvariableid,offsetvalue, offsettypeid, insertdate)
                 Values(avgValue,dateTimeUTC, $1, $2, offsetValue, offsetType, NOW());
        end loop;
    CLOSE loopCursor;
-- offsets
--   AON Windspeed/ms AKST
--   SourceID = 222, VariableID = 815
-- OR
--   USGS Winsspeed/ms
--   SourceID = 39, VariableID = 313
  ELSIF EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 815) OR
        EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 313)
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''hour'', dv.datetimeutc) as dateTimeUTC,
                               AVG(dv.datavalue), 
                               offsetvalue, 
                               offsetTypeID FROM tables.odmdatavalues_metric AS dv 
                          WHERE dv.siteid = $1 AND dv.originalvariableid = $2 
                          GROUP BY date_trunc(''Hour'', dv.datetimeutc), offsetValue, offsetTypeID;')using site_id, var_id;
        loop
          fetch loopCursor into dateTimeUTC, avgValue, offsetValue, offsetType;
          if not found then
            exit;
          end if;
          INSERT INTO tables.hourly_windspeeddatavalues(datavalue,utcdatetime,siteID,Originalvariableid,offsetvalue, offsettypeid, insertdate)
                 Values(avgValue,dateTimeUTC, $1, $2, offsetValue, offsetType, NOW());
        end loop;
    CLOSE loopCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgethourlywindspeed2(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywindspeed2(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywindspeed2(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywindspeed2(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywindspeed2(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywindspeed2(integer, integer) TO chaase;
