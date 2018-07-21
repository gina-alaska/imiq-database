-- uspgetdailyairtempmax.sql
--
--
-- version 1.0.0
-- updated 2017-01-12
--
-- changelog:
-- 1.0.0: added comments
-- Function: tables.uspgetdailyairtempmax(integer, integer)

-- DROP FUNCTION tables.uspgetdailyairtempmax(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailyairtempmax(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE UTC timestamp without time zone;
        value float;
        value1m float;
        value3m float;
        originalVariableID int;
        maxCursor refcursor;


 BEGIN
-- UTC time for:
--   NCDC GHCN.  Temp Max
--   SourceID = 210, VariableID = 403
-- OR
--   RAWS/NPS:  Temp/daily/C, UTC
--   SourceID = 211,214,215,216,217,218,219, VariableID = 433 
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 403) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 433)
  THEN
    OPEN maxCursor
    for execute format('SELECT dv.DateTimeUTC, dv.DataValue FROM tables.ODMDataValues_metric AS dv '
                        'WHERE dv.SiteID = $1 and dv.OriginalVariableid = $2;') USING site_id, var_id;
        loop
        fetch maxCursor into UTC, value;
        if not found then 
	  exit;
	end if;
	INSERT INTO tables.dialy_airtempmaxdatavalues (datavalue, utcdatetime,siteid,originalvariableid, insertdate) 
	       VALUES (value, UTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;
-- Local time (no offset value is given)for:
--   SNOTEL  Temp/daily/F, AST
--   SourceID = 212, VariableID = 628 
-- OR
--   SNOTEL  Temp/daily/F, AST
--   SourceID = 212, VariableID = 668
-- OR
--   SNOTEL  Temp/daily/F, AST
--   SourceID = 212, VariableID = 391
-- OR
--   McCall  Temp/daily/F, AST (TMAX)
--   Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
--   SourceID = 178,182, VariableID = 195 
-- OR
--   UAF. Temp/C/Daily   TMAX
--   Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
--   SourceID = 180, VariableID = 223 
-- OR
--   chamberlin. Temp/F/Daily   TMAX
--   Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
--   SourceID = 183, VariableID = 295 
-- OR
--   GHCN original Station Observation Scans Temp/F/Daily   TMAX
--   Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
--   SourceID = 225, VariableID = 863 
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 628) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 668) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 391) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 195) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 223) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 295) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 863)
  THEN 
    OPEN maxCursor
    for execute format('SELECT dv.LocalDateTime, dv.DataValue FROM tables.ODMDataValues_metric AS dv '
                        'WHERE dv.SiteID = $1 and dv.OriginalVariableid = $2;') USING site_id, var_id;
        loop
        fetch maxCursor into UTC, value;
        if not found then 
	  exit;
	end if;
	INSERT INTO tables.dialy_airtempmaxdatavalues (datavalue, utcdatetime,siteid,originalvariableid, insertdate) 
	       VALUES (value, UTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;
-- Caluculate 2m AT using 1m and 3m AT for:
--   Toolik  Temp/daily/C, AST (TMAX)
--   SourceID = 145, VariableID = 487 
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 487)
  THEN
    OPEN maxCursor
    for execute format('SELECT dv.LocalDateTime, dv.Datavalue FROM tables.ODMDatavalues_metric AS dv '
                         'WHERE dv.SiteID = 2128 and dv.OriginalVariableID=487 and dv.offsetvalue = 1' ) USING site_id, var_id;
      loop
        fetch maxCursor into UTC, value1m;
        if not found then 
          exit;
        end if;
        -- calculate air temp 2m
	SELECT into value3m dv.DataValue FROM tables.ODMDataValues_metric AS dv
               WHERE dv.SiteID = $1 and dv.OriginalVariableID = 487 and dv.offsetvalue = 3 and UTC = dv.LocalDateTime;
        value := (value3m - value1m)/2 + value1m;
        -- check calulated value
        if (value is NULL and value1m is not NUll) then
          value := value1m;
        end if;
        INSERT INTO tables.daily_airtempmaxdatavalues(datavalue, utcdatetime,siteid,originalvariableid, insertdate) 
    	       VALUES (value, UTC, $1, $2,NOW());
      end loop;
    CLOSE maxCursor;
  END IF;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailyairtempmax(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmax(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmax(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmax(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmax(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtempmax(integer, integer) TO chaase;
COMMENT ON FUNCTION tables.uspgetdailyairtempmax(integer, integer) IS 'Used to populate ''daily_airtemmaxdatavalues''  table.';
