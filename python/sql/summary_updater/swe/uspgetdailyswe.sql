-- uspgetdailtyswe.sql
--      function uspgetdailtyswe for updating daily_swedatavalues
--
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
--      1.0.0: initial version
-- Function: tables.uspgetdailyswe(integer, integer)

-- DROP FUNCTION tables.uspgetdailyswe(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailyswe(
    siteid integer,
    varid integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
        avgValue float;
        maxCursor refcursor;


BEGIN
-- average UTC time for:
--   NCDC ISH. SWE
--   SourceI 209, VariableID = 373
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 373)
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'',DateTimeUTC) as DateTimeUTC,AVG(dv.DataValue) FROM tables.odmdatavalues_metric  AS dv '
		           'WHERE dv.SiteID = $1 and dv.OriginalVariableid = $2 GROUP BY date_trunc(''day'',DateTimeUTC);') using siter_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_swedatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue, DateTimeUTC, $1, $2,NOW()); 
        end loop;
    CLOSE maxCursor;
-- average localtime for:
--   NCDC GNCn SWE
--   SourceID = 210, VariableID = 751
-- OR
--   Snow Course:  
--   SourceID = 200, VariableID = 397 
-- OR
--   Snow Course:  
--   SourceID = 212, VariableID = 395 
  ELSIF EXISTS (SELECT * FROM tables.odmdatatvalues_metric where siteid = $1 and $2 = 751 ) OR
               (SELECT * FROM tables.odmdatatvalues_metric where siteid = $1 and $2 = 397 ) 
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'', LocalDateTime) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
		           'WHERE dv.SiteID = $2 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'', LocalDateTime);') using siter_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_swedatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
	         VALUES(avgValue, DateTimeUTC, $1, $2, NOW()); 
        end loop;
    CLOSE maxCursor;
-- average localtime & convert cm to mm for:
--   UAF/WERC
--   SourceID = 193, VariableID = 215
-- OR
--   UAF
--   SourceID = 3, VariableID = 21
  ELSIF EXISTS (SELECT * FROM tables.odmdatatvalues_metric where siteid = $1 and $2 = 215 ) OR
               (SELECT * FROM tables.odmdatatvalues_metric where siteid = $1 and $2 = 21 ) 
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'', LocalDateTime) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
		           'WHERE dv.SiteID = $2 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'', LocalDateTime);') using siter_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          select avgValue = avgValue * 10;
          INSERT INTO tables.daily_swedatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
	         VALUES(avgValue, DateTimeUTC, $1, $2, NOW()); 
        end loop;
    CLOSE maxCursor;
  END IF;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailyswe(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyswe(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyswe(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyswe(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyswe(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyswe(integer, integer) TO chaase;
