-- uspgetdailyairtempmin.sql
--
--
-- version 1.0.0
-- updated 2017-01-12
--
-- changelog:
-- 1.0.0: added comments
-- Function: tables.uspgetdailyairtempmin(integer, integer)

-- DROP FUNCTION tables.uspgetdailyairtempmin(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailyairtempmin(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE timeStampVar timestamp without time zone;
        value float;
        value1m float;
        value3m float;
        originalVariableID int;
        maxCursor refcursor;

BEGIN 
-- NOCOUNT?

-- UTC time for (No offset value is given):
--   NCDC GHCN. Temp Min
--   SourceID= 210, VariableID = 404
-- OR
--   RAWS/NPS: Temp Min
--   SourceID = 211, VariableID = 434
-- OR
--   SNOTEL: Temp Min
--   SourceID = 212, VariableID = 627
-- OR
--   SNOTEL: Temp Min
--   SourceID = 212, VariableID = 667
-- OR
--   SNOTEL: Temp Min
--   SourceID = 212, VariableID = 392
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 404) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 434) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 627) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 667) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 392)
  THEN
    OPEN maxCursor
    for execute format('SELECT dv.DateTimeUTC, dv.DataValue FROM ODMDataValues_metric AS dv '
		         'WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;') USING site_id, var_id;
        loop 
          fetch maxCursor into timeStampVar, value;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_airtempmindatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES (value, timeStampVar, $1, $2, NOW());
        end loop;
    CLOSE maxCursor;
-- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value for:
--   McCall Temp/dailyF, AKST
--   SourceID = 178,182, VariableID = 196
-- OR
--   UAF Temp/C/Daily
--   SourceID = 180, VariableID = 225
-- OR
--   Chamberlin. Temp/F/Daily 
--   SourceID = 183, VariableID = 296
-- OR
--   GHCN Original Station Observation Scans, Temp/F/Daily 
--   SourceID = 225, Variable ID = 837
  ELSIF  EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 196) OR
         EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 225) OR
         EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 269) OR
         EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 837)
  THEN
    OPEN maxCursor
    for execute format('SELECT dv.LocalDateTime, dv.DataValue FROM ODMDataValues_metric AS dv '
		         'WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;') USING site_id, var_id;
        loop 
          fetch maxCursor into timeStampVar, value;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_airtempmindatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES (value, timeStampVar, $1, $2, NOW());
        end loop;
    CLOSE maxCursor;
-- Calculate 2m AT using 1m and 3m AT for:
--   Toolik Temp/daily/C, AKST (tmin)
--   SourceID = 145, VaraibleID = 489
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 489)
  THEN
    OPEN maxCursor
    for execute format('SELECT dv.LocalDateTime, dv.Datavalue FROM tables.ODMDatavalues_metric AS dv '
                         'WHERE dv.SiteID = 2128 and dv.OriginalVariableID=489 and dv.offsetvalue = 1' ) USING site_id, var_id;
      loop
        fetch maxCursor into timeStampVar, value1m;
        if not found then 
          exit;
        end if;
        -- calculate air temp 2m
	SELECT INTO value3m dv.DataValue FROM tables.ODMDataValues_metric AS dv
               WHERE dv.SiteID = $1 and dv.OriginalVariableID = 489 and dv.offsetvalue = 3 and timeStampVar = dv.LocalDateTime;
        value := (value3m - value1m)/2 + value1m;
        -- check calulated value
        if (value is NULL and value1m is not NUll) then
          value := value1m;
        end if;
        INSERT INTO tables.daily_airtempmindatavalues(datavalue, utcdatetime, siteid, originalvariableid, insertdate) 
    	       VALUES (value, timeStampVar, $1, $2, NOW());
      end loop;
    CLOSE maxCursor;
  END IF; 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailyairtempmin(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmin(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmin(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmin(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmin(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmin(integer, integer) TO chaase;
COMMENT ON FUNCTION tables.uspgetdailyairtempmin(integer, integer) IS 'used to populate the ''daily_airtempmindatavalues'' table.';
