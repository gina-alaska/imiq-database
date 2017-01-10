-- uspgetdailywinddirection.sql
--      updates hourly_winddirectiondatavalues table
--
-- version 1.0.0
-- updated 2017-01-10
--
-- changelog:
-- 1.0.0: added metadata comments.


-- Function: tables.uspgethourlywinddirection(integer, integer)

-- DROP FUNCTION tables.uspgethourlywinddirection(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgethourlywinddirection(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
	avgValue float;
	x float;
	y float;
	offsetValue float;
	offsetType float;
	wsID int;
	maxCursor refcursor;

BEGIN
-- case statemnt to select the proper windspeedID
  CASE
    WHEN $2 = 334 THEN wsID = 335; -- NCDC
    WHEN $2 = 83  THEN wsID = 82;  -- WERC
    WHEN $2 = 471 THEN wsID = 470; -- Toolik wind direction
    WHEN $2 = 829 THEN wsid = 827; -- ARC LTER
    WHEN $2 = 817 THEN wsid = 815; -- AON
    WHEN $2 = 314 THEN wsid = 313; -- USGS
    WHEN $2 = 528 THEN wsid = 529; -- ARM
    WHEN $2 = 290 THEN wsid = 292; -- LPeters
    WHEN $2 = 512 THEN wsid = 511; -- NOAA
    WHEN $2 = 568 THEN wsid = 566; -- RWIS
    WHEN $2 = 1135 THEN wsid = 1133;
    else wsid = -1;
  END CASE;
-- for:
--   NCDC: WindDirection 
--   SourceID = 209, VariableID = 334 
--   WS VariableID = 335
-- OR 
--   ARC LTER: WindDirection 
--   SourceID = 144, VariableID = 829 
--   WS VariableID = 827
-- OR 
--   AON: WindDirection 
--   SourceID = 222, VariableID = 817 
--   WS VariableID = 815
-- OR 
--   USGS: WindDirection 
--   SourceID = 39, VariableID = 314 
--   WS VariableID = 313
-- OR 
--   ARM: WindDirection 
--   SourceID = 202, VariableID = 528 
--   WS VariableID = 529
-- OR 
--   LPeters: WindDirection 
--   SourceID = 182, VariableID = 290 
--   WS VariableID = 292
-- OR 
--   NOAA: WindDirection 
--   SourceID = 35, VariableID = 512 
--   WS VariableID = 511
-- OR 
--   RWIS: WindDirection 
--   SourceID = 213, VariableID = 568 
--   WS VariableID = 566
-- OR 
--   RWIS: WindDirection 
--   SourceID = 263, VariableID = 1135 
--   WS VariableID = 1133
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 334) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 829) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 817) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 314) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 430) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 528) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 290) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 512) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 568) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 1135)
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''hour'',WD.datetimeutc) as DateTimeUTC, AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID FROM tables.ODMDataValues_metric AS WD '
		               'inner join '
                                 '(select SiteID,DateTimeUTC,DataValue as M from tables.ODMDataValues_metric WS where WS.SiteID=$1 and WS.OriginalVariableID=$3) as WS '
		                 'on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC '
		                 'WHERE WD.SiteID = $1 and WD.OriginalVariableid=$2 GROUP BY date_trunc(''hour'',WD.datetimeutc),OffsetValue,OffsetTypeID;') using site_id, var_id, wsID;
        loop
          fetch maxCursor into dateTimeUTC, y, x, offsetValue, offsetType;
          if not found then
            exit;
          end if;
          INSERT INTO tables.hourly_winddirectiondatavalues(datavalue, utcdatetime, siteid, originalvariableid, offsetvalue, offsettypeid, insertdate)
                 VALUES(tables.calcwinddirection(CAST(x as real), CAST(y as real)), dateTimeUTC, $1, $2, offsetValue, offsetType, NOW());
        end loop; 
  CLOSE maxCursor;
-- for:
--   WERC Wind Direction
--   SourceID = 29,30,31,34,223, VariableID = 83
--   WS VariableID = 82
-- OR
--   Toolik Wind Direction
--   SourceID = 145, VariableID = 471
--   WS VariableID = 470
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 83) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 471)
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''hour'',WD.datetimeutc) as DateTimeUTC, AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)), WS.max_OffsetValue,WS.max_OffsetTypeID FROM tables.ODMDataValues_metric AS WD '
		               'inner join '
		               '(select WS.SiteID,WS.DateTimeUTC,DataValue as M,MAX_Offset.max_OffsetValue as max_OffsetValue,MAX_Offset.max_OffsetTypeID from tables.ODMDataValues_metric WS '
                                        'inner join '
                                        '(select SiteID,DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID from tables.ODMDataValues_metric '
                                             'where SiteID= $1 and OriginalVariableID=$3 group by SiteID,DateTimeUTC,OffsetTypeID) as MAX_Offset '
                                        'on MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC '
                                        'WHERE WS.SiteID = $1 and WS.OriginalVariableid=$3 and WS.OffsetValue=MAX_Offset.max_OffsetValue) as WS '
                               'on WD.SiteID=WS.SiteID and WS.DateTimeUTC=WD.DateTimeUTC '	
                               'WHERE WD.SiteID = $1 and WD.OriginalVariableid=$2 and WD.OffsetValue=WS.max_OffsetValue GROUP BY date_trunc(''hour'',WD.datetimeutc),WS.max_OffsetValue,WS.max_OffsetTypeID;') using site_id, var_id, wsID;
        loop
          fetch maxCursor into dateTimeUTC, y, x, offsetValue, offsetType;
          if not found then
            exit;
          end if;
          INSERT INTO tables.hourly_winddirectiondatavalues(datavalue, utcdatetime, siteid, originalvariableid, offsetvalue, offsettypeid, insertdate)
                 VALUES(tables.calcwinddirection(CAST(x as real), CAST(y as real)), dateTimeUTC, $1, $2, offsetValue, offsetType, NOW());
        end loop; 
  CLOSE maxCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgethourlywinddirection(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywinddirection(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywinddirection(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywinddirection(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywinddirection(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgethourlywinddirection(integer, integer) TO chaase;
