-- Function: tables.uspgethourlyairtemp(integer, integer)

-- DROP FUNCTION tables.uspgethourlyairtemp(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgethourlyairtemp(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE timeStampUTC timestamp without time zone;
        value float;
        value1m float;
        value3m float;
        originalVariableID int;
        loopCursor refcursor;

BEGIN
-- value is ready
--   ISH
--   SourceID = 209, VariableID = 218
-- OR
--   USGS: Temp/hourly/C, AKST
--   SourceID = 39, VariableID = 310
--   No offset Given.
-- OR
--   BLM/kemenitz: Temp/hourly/C, AKST
--   SourceID = 199, VariableID = 442
-- OR
--   BLM/kementiz: Temp/hourly/C, AKST
--   SourceID = 199, VariableID = 504
-- OR
--   NOAA/ESRL/CRN: Temp/hourly/C, AKST
--   SourceID = 35, VariableID = 519
-- OR
--   ARM: Temp/hourly/C, AKST
--   SourceID = 202,203, VariableID = 527
-- OR
--   ARM: Temp/hourly/C, AKST
--   SourceID = 203, VariableID = 538
-- OR
--   LPeters: Temp/hourly/C, AKST
--   SourceID = 182, VariableID = 279
-- OR
--   LPeters: Temp/hourly/C, AKST
--   SourceID = 182, VariableID = 288
-- OR
--   RWIS: Temp/hourly/C, AKST
--   SourceID = 213, VariableID = 563
-- OR
--   ARC LTER: Temp/hourly/C, AKST
--   SourceID = 144, VariableID = 819
-- OR
--   AON: Temp/hourly/C, AKST
--   SourceID = 222, VariableID = 786
-- OR
--   ADNR AHS: Temp/hourly/C, AKST
--   SourceID = 259, VariableID = 1072
-- OR
--   ADNR AHS: Temp/hourly/f, AKST
--   SourceID = 259, VariableID = 1073
-- OR
--   CALON: Temp/hourly/C, AKST
--   SourceID = 263, VariableID = 1136
-- OR
--   BOEM: Temp/hourly/C, AKST
--   SourceID = 248,249,250,251,252,253,254,255,256,257,258, VariableID = 1032
  IF EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=218) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=310) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=442) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=504) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=519) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=527) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=538) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=279) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=288) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=563) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=819) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=786) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=1072) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=1073) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=1136) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=1032)
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''hour'', dv.datetimeutc) as dateTimeUTC, AVG(datavalue) FROM tables.odmdatavalues_metric as dv
                               WHERE dv.siteid = $1 and dv.originalvariableid = $2 GROUP BY date_trunc(''hour'', dv.datetimeutc);') using site_id, var_id;
        loop
        fetch loopCursor into timeStampUTC, value;
        if not found then
           exit;
        end if ;
        INSERT INTO tables.hourly_airtempdatavalues(datavalue, utcdatetime, siteid, originalvariableid, insertdate)
               VALUES(value, timeStampUTC, $1, $2, NOW());
        end loop;                       
    CLOSE loopCursor;
-- check for 1.5 or 2 meter offset
--   UAF/WERC Temp/Hourly/C. AKST
--   SourceID = 29, 30, 31, 34, 223, VariableID = 81
  ELSIF EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=81 AND (OffsetValue = 2 or OffsetValue = 1.5))
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''hour'', dv.datetimeutc) as dateTimeUTC, AVG(datavalue) FROM tables.odmdatavalues_metric as dv
                               WHERE dv.siteid = $1 and dv.originalvariableid = $2 and (dv.offsetvalue = 2 or dv.offsetvalue = 1.5) GROUP BY date_trunc(''hour'', dv.datetimeutc);') using site_id, var_id;
        loop
        fetch loopCursor into timeStampUTC, value;
        if not found then
           exit;
        end if ;
        INSERT INTO tables.hourly_airtempdatavalues(datavalue, utcdatetime, siteid, originalvariableid, insertdate)
               VALUES(value, timeStampUTC, $1, $2, NOW());
        end loop;                       
    CLOSE loopCursor;
-- average 1 & 3 meters
--   UAF/WERC Temp/Hourly/C. AKST
--   SourceID = 29, 30, 31, 34, 223, VariableID = 81
-- OR
--   Toolik: Temp/hourly/C, AKST
--   SourceID = 145, VariableID = 466
  ELSIF EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=81 AND OffsetValue = 1) OR
        EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=466)    
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''hour'', dv.datetimeutc) as dateTimeUTC, AVG(datavalue) FROM tables.odmdatavalues_metric as dv
                               WHERE dv.siteid = $1 and dv.originalvariableid = $2 and dv.offsetvalue = 1 GROUP BY date_trunc(''hour'', dv.datetimeutc);') using site_id, var_id;
        loop
        fetch loopCursor into timeStampUTC, value1m;
        if not found then
           exit;
        end if ;
        -- calculate air temp 2m
	SELECT into value3m  AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv
               WHERE dv.SiteID = $1 and dv.OriginalVariableID = $2 and dv.offsetvalue = 3 
                     and timeStampUTC =  date_trunc('hour', dv.datetimeutc);

        if (value3m is not null and value1m is not null) then 
	  value := (value3m - value1m)*.5 + value1m;
        -- check calulated value
        elsif (value3m is NULL and value1m is not NUll) then
          value := value1m;
        else
          value := NULL;
        end if;
        
        INSERT INTO tables.hourly_airtempdatavalues(datavalue, utcdatetime, siteid, originalvariableid, insertdate)
               VALUES(value, timeStampUTC, $1, $2, NOW());
        end loop;                       
    CLOSE loopCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgethourlyairtemp(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyairtemp(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyairtemp(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyairtemp(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyairtemp(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyairtemp(integer, integer) TO chaase;
