-- uspgetdailtyswe.sql
--      function uspgetdailtyswe for updating daily_swedatavalues
--
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
--      1.0.0: initial version

-- Function: tables.uspgethourlyswe(integer, integer)

-- DROP FUNCTION tables.uspgethourlyswe(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgethourlyswe(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
        avgValue float;
        loopCursor refcursor;

BEGIN
--
--  NCDC ISH. SWE/mm/Minute. 
--  SourceID = 209, VariableID = 373
  IF EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 373)
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''hour'', dv.datetimeUTC) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
		         'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''hour'', dv.datetimeUTC);') using site_id, var_id;
        loop
          fetch loopCursor into dateTimeUTC, avgValue;
          if not fount then
            exit;
          end if;
          INSERT INTO tables.hourly_swedatavalues(datavalue,utcdatetime,siteid,originalvariableid,insertdate)
                 VALUES(avgValue,dateTimeUTC, $1, $2, NOW());
        end loop;
    CLOSE loopCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgethourlyswe(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyswe(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyswe(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyswe(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyswe(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyswe(integer, integer) TO chaase;
