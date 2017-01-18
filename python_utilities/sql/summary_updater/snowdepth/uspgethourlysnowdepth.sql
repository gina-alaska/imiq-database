-- uspgethourlysnowdepth.sql
-- 
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
-- 1.0.0: initial version
-- Function: tables.uspgethourlysnowdepth(integer, integer)

-- DROP FUNCTION tables.uspgethourlysnowdepth(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgethourlysnowdepth(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
        avgValue float;
        loopCursor refcursor;

BEGIN
-- convert cm -> meters for:
--   ISH. snowdepth. 
--   SourceID = 209, VariableID = 370
-- OR 
--   UAF/WERC: snow Depth
--   SourceID = 29, 30, 34, 223, VariableID = 75
-- OR
--   USGS: Snow Depth/hourly/cm
--   SourceID = 39. VariableID = 230
-- OR
--   BOEM avg of minute data, convert from cm to m
--   sourceIDs: 248 to 258, VariableID: 1045
  IF EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 370) OR
     EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 75) OR
     EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 230) OR
     EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 1045) 
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''hour'', dv.datetimeUTC) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
		         'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''hour'', dv.datetimeUTC);') using site_id, var_id;
        loop
          fetch loopCursor into dateTimeUTC, avgValue;
          if not fount then
            exit;
          end if;
          INSERT INTO tables.hourly_snowdepthdatavalues(datavalue,utcdatetime,siteid,originalvariableid,insertdate)
                 VALUES(avgValue/100,dateTimeUTC, $1, $2, NOW());
        end loop;
    CLOSE loopCursor;
-- no conversion
--   AON Snow Depth/Meters/Hourly
--   SourceID = 222, VaraibleID = 813
-- OR
--   ARM Snow Depth/Meters/Hourly
--   SourceID = 1, 203, VaraibleID = 543
-- OR
--   AON Snow Depth/Meters/Hourly
--   SourceID = 213, VaraibleID = 584
  ELSIF EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 813) OR
        EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 543) OR
        EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 584) 
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''hour'', dv.datetimeUTC) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
		         'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''hour'', dv.datetimeUTC);') using site_id, var_id;
        loop
          fetch loopCursor into dateTimeUTC, avgValue;
          if not fount then
            exit;
          end if;
          INSERT INTO tables.hourly_snowdepthdatavalues(datavalue,utcdatetime,siteid,originalvariableid,insertdate)
                 VALUES(avgValue,dateTimeUTC, $1, $2, NOW());
        end loop;
    CLOSE loopCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgethourlysnowdepth(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlysnowdepth(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgethourlysnowdepth(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlysnowdepth(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgethourlysnowdepth(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgethourlysnowdepth(integer, integer) TO chaase;
