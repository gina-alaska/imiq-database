-- uspgetdailywindspeed2.sql
--      a function for updating daily_windspeeddatavalues with data from new 
-- sources.
--
-- version 1.0.1
-- updated 2017-01-09
-- 
-- changelog:
-- 1.0.1: added NPS-RAWS
-- 1.0.0: added metadata comments. Note BOEM is done

-- Function: tables.uspgetdailywindspeed2(integer, integer)

-- DROP FUNCTION tables.uspgetdailywindspeed2(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailywindspeed2(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
	avgValue float;
	offsetValue float;
	offsetTypeID float;
	maxCursor refcursor;

BEGIN
-- Average Values for:
--   NCDC ISH: WindSpeed/ms
--   SourceID = 209, VariableID = 335
-- OR
--   NCDC GHCH: WindSpeed/ms
--   SourceID = 210, VariableID = 743
-- OR
--   AON:  Windspeed/ms, AKST
--   SourceID = 222, VariableID = 815
-- OR
--   USGS: Windspeed/ms
--   SourceID = 39, VariableID = 313
-- OR
--   UAF/BLM
--   SourceID = 164, VariableID = 645
-- OR
--   RAWS Windspeed/ms
--   SourceID = 211, VariableID = 429
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
--   RWIS Windspeed/ms
--   SourceID = 213, VariableID = 566
-- OR
--   RWIS Windspeed/ms
--   SourceID = 261, VariableID = 1133
-- OR
--   BOEM: windspeed
--   sourceIDs: 248 to 258, VariableID: 1035
-- OR
--   NPS-RAWS: winddir
--   sourceIDs: 136, VariableID: 1171
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and 
                $2 in (335, 743, 815, 313, 645, 429, 529,
                       541, 535, 292, 511, 566, 1133, 1035, 1171))
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.datetimeutc) as dateTimeUTC,
                               AVG(dv.DataValue),
                               offsetValue, 
                               offsetTypeID 
                        FROM tables.odmdatavalues_metric AS dv  
                        WHERE dv.siteid = $1 and dv.originalvariableid=$2 
                        GROUP BY date_trunc(''day'',dv.datetimeutc), 
                                 OffsetValue, 
                                 OffsetTypeID;') USING site_id,var_id; -- end of format
        loop
	fetch maxCursor into dateTimeUTC, avgValue, offsetValue, offsetTypeID;
	  if not found then
	    exit;
	  end if;
	  INSERT INTO tables.daily_windspeeddatavalues(datavalue,utcdatetime,siteid,originalvariableid,offsetvalue,offsettypeid,insertdate) VALUES(avgValue, dateTimeUTC, $1, $2 , offsetValue, offsetTypeID,NOW());
	end loop;
     CLOSE maxCursor;
-- Average Values (max offset) for:
--   UAF/WERC:  WindSpeed/ms, AST
--   SourceID = 29,30,31,34,223, VariableID = 82
-- OR
--   Toolik  Windspeed/ms, AST
--   SourceID = 145, VariableID = 469
-- OR
--   ARC LTER  Windspeed/ms, AST
--   SourceID = 144, VariableID = 827
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 in (82, 469, 827))
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',ws.datetimeutc ) AS dateTimeUTC,
                               AVG(DataValue), 
                               MAX_Offset.max_OffsetValue, 
                               MAX_Offset.max_OffsetTypeID 
                       FROM tables.odmdatavalues_metric WS
                         inner join
                           (select siteid, 
                                   DateTimeUTC,MAX(OffsetValue) AS max_OffsetValue, 
                                   OffsetTypeID AS max_OffsetTypeID FROM tables.odmdatavalues_metric 
                              where siteid = $1 AND OriginalVariableID = $2 
                              GROUP by siteid, dateTimeUTC, offsetTypeID) AS MAX_Offset 
                           ON MAX_Offset.siteid=WS.SiteID AND MAX_Offset.DateTimeUTC=WS.DateTimeUTC  
                             WHERE WS.SiteID = $1 AND OriginalVariableid = $2 AND WS.OffsetValue = MAX_Offset.max_OffsetValue 
                             GROUP by date_trunc(''day'',ws.datetimeutc), MAX_Offset.max_OffsetValue, MAX_Offset.max_OffsetTypeID;') USING site_id,var_id; -- end of format
        loop
	fetch maxCursor into dateTimeUTC, avgValue, offsetValue, offsetTypeID;
	  if not found then
	    exit;
	  end if;
	  INSERT INTO tables.daily_windspeeddatavalues(datavalue,utcdatetime,siteid,originalvariableid,offsetvalue,offsettypeid,insertdate) VALUES(avgValue, dateTimeUTC, $1, $2 , offsetValue, offsetTypeID,NOW());
	end loop;
    CLOSE maxCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailywindspeed2(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywindspeed2(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywindspeed2(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywindspeed2(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywindspeed2(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywindspeed2(integer, integer) TO chaase;
COMMENT ON FUNCTION tables.uspgetdailywindspeed2(integer, integer) IS 'used to populate ''daily_windspeeddatavalues''  table';
