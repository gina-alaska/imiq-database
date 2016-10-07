--
-- PostgreSQL database cluster dump
--



\connect imiq_staging

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: tables; Type: SCHEMA; Schema: -; Owner: imiq
--



ALTER SCHEMA tables OWNER TO imiq;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: imiq
--



ALTER SCHEMA topology OWNER TO imiq;

--
-- Name: views; Type: SCHEMA; Schema: -; Owner: imiq
--



ALTER SCHEMA views OWNER TO imiq;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = tables, pg_catalog;

--
-- Name: calcwinddirection(real, real); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION calcwinddirection(x real, y real) RETURNS real
    LANGUAGE plpgsql
    AS $$
DECLARE value float;

BEGIN
-- vector components:
--    x, y
-- Offsets, used to go from vector back to radial:
--    if (x > 0  and y > 0) Offset=0
--    if (x < 0 ) Offset=180
--    if (x > 0) and y < 0) Offset=360
-- if x <> 0, and x and y are not null
--    Wind Direction = ARCTAN(y/x)*180/PI + Offset
-- else if x = 0
--    Wind Direction = 0
-- else
--    Wind Direction = null
  IF x is not null AND y is not null AND x != 0 THEN
    IF x >0 AND y > 0 THEN
      value := atan(CAST(y as double precision)/CAST(x as double precision))* 180.0/pi() + 0.0;
    ELSIF x < 0 THEN
      value := atan(CAST(y as double precision)/CAST(x as double precision))* 180.0/pi() + 180.0;
    ELSIF x > 0 and y < 0 THEN
      value := atan(CAST(y as double precision)/CAST(x as double precision))* 180.0/pi() + 360.0;
    END IF;
  ELSIF x = 0 THEN
    value := 0;
  ELSE
    value := NULL;
  END IF;

  RETURN value;
END;
$$;


ALTER FUNCTION tables.calcwinddirection(x real, y real) OWNER TO imiq;

--
-- Name: FUNCTION calcwinddirection(x real, y real); Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON FUNCTION calcwinddirection(x real, y real) IS 'This function takes the x and y values from the uspgetdailywinddirection function and and calculates the direction from them.';


--
-- Name: getmaxdailyprecip(timestamp without time zone, integer, integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION getmaxdailyprecip(currentdatetime timestamp without time zone, siteid integer, mindatavalue integer, maxdatavalue integer) RETURNS TABLE(valueid integer, datavalue double precision, originalvariableid integer)
    LANGUAGE plpgsql
    AS $_$
DECLARE
    currentdatetime ALIAS FOR $1;
    site_id ALIAS FOR $2;
    mindatavalue ALIAS FOR $3;
    maxdatavalue ALIAS FOR $4;
BEGIN
SELECT d.valueid, d.datavalue, d.originalvariableid FROM tables.daily_precipdatavalues d
	WHERE d.UTCDateTime = currentdatetime
	        and (d.DataValue >= mindatavalue and d.DataValue < maxdatavalue)
	        and d.SiteID=site_id
	ORDER BY d.DataValue DESC, d.OriginalVariableID DESC
        LIMIT 1;
END;
$_$;


ALTER FUNCTION tables.getmaxdailyprecip(currentdatetime timestamp without time zone, siteid integer, mindatavalue integer, maxdatavalue integer) OWNER TO imiq;

--
-- Name: uspgetdailyairtemp(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailyairtemp(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE ldateTimeUTC timestamp without time zone;
        maxValue float;
        minValue float;
        maxValue3 float;
        minValue3 float;
        avgValue float;
        avgValue1 float;
        avgValue3 float;
        maxID int;
        minID int;
        maxCursor refcursor;

BEGIN
-- average min & max with utc for:
--   NCDC GHCN
--   Source ID = 210, maxID= 403, minID= 404
  IF EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 404)
  THEN
    
    CASE 
      WHEN $2 = 404 THEN minID = 404; maxID = 403; -- NCDC GHCN
    END CASE;
    OPEN maxCursor
    for execute('Select Distinct dv.DateTimeUTC from tables.ODMDataValues_metric as dv '
                  'where dv.siteID = $1 and (dv.originalVariableid in ($2,$3));') using site_id, minID, maxID;
        loop
          fetch maxCursor into ldateTimeUTC;
          if not found then 
            exit;
          end if;
          -- get max value
          SELECT INTO maxValue dv.datavalue FROM tables.odmdatavalues_metric as dv
                WHERE dv.siteid = $1 and dv.originalvariableid = maxID and dv.datetimeutc = ldateTimeUTC;
          -- get min value
          SELECT INTO minValue dv.datavalue FROM tables.odmdatavalues_metric as dv
                WHERE dv.siteid = $1 and dv.originalvariableid = minID and dv.datetimeutc = ldateTimeUTC;
          -- average
          IF(minValue is not NULL AND maxValue is not NULL) THEN
            avgValue := (maxValue - minValue)/2 + minValue;
          ELSIF(minValue is NULL AND maxValue is not NULL) THEN
            avgValue := maxValue;
          ELSIF(minValue is not NULL AND maxValue is NULL) THEN 
            avgValue := minValue;
          ELSE
            avgValue := NULL;
          END IF;      
          INSERT INTO tables.daily_airtempdatavalues (DataValue, UTCDateTime, SiteID, OriginalVariableID, InsertDate)
                 VALUES (avgValue, ldateTimeUTC, $1, $2, NOW());
        end loop;
    CLOSE maxCursor; 
-- average min & max with Local for:
--   McCall Temp/Daily/F, AKST
--   SourceID = 178,182, MaxID = 195, MinID = 196
-- OR
--   UAF Temp/Daily/C
--   SourceID = 180, MaxID = 223, MinID = 225
-- OR
--   Chamberlin Temp/F/Daily 
--   SourceID = 183, MaxID = 295, MinID = 296
  ELSIF EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 195) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 223) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 495)
  THEN
    CASE
      WHEN $2 = 195 THEN minID = 196; maxID = 195; -- McCall
      WHEN $2 = 223 THEN minID = 225; maxID = 223; -- UAF
      WHEN $2 = 295 THEN minID = 296; maxID = 295; -- Chamberlin
    END CASE;
    OPEN maxCursor
    for execute('Select Distinct dv.localdateTime from tables.ODMDataValues_metric as dv '
                  'where dv.siteID = $1 and (dv.originalVariableid in ($2,$3));') using site_id, minID, maxID;
        loop
          fetch maxCursor into ldateTimeUTC;
          if not found then 
            exit;
          end if;
          -- get max value
          SELECT into maxValue dv.datavalue FROM tables.odmdatavalues_metric as dv
                WHERE dv.siteid = $1 and dv.originalvariableid = maxID and dv.localdatetime = ldateTimeUTC;
          -- get min value
          SELECT into minValue dv.datavalue  FROM tables.odmdatavalues_metric as dv
                WHERE dv.siteid = $1 and dv.originalvariableid = minID and dv.localdatetime = ldateTimeUTC;
          -- average
          IF(minValue is not NULL AND maxValue is not NULL) THEN
            avgValue := (maxValue - minValue)/2 + minValue;
          ELSIF(minValue is NULL AND maxValue is not NULL) THEN
            avgValue := maxValue;
          ELSIF(minValue is not NULL AND maxValue is NULL) THEN 
            avgValue := minValue;
          ELSE
            avgValue := NULL;
          END IF;      
          INSERT INTO tables.daily_airtempdatavalues (DataValue, UTCDateTime, SiteID, OriginalVariableID, InsertDate)
                 VALUES (avgValue, ldateTimeUTC, $1, $2, NOW());
        end loop;
    CLOSE maxCursor;
-- One val Local for:
--   RAWS: Temp/daily/C UTC
--   SourceID = 211,214,215,216,217,218,219, VariableID = 432
-- OR
--   SNOTEL Temp/Daily/F, AKST
--   SourceID = 212, VaraibleID = 626
-- OR
--   SNOTEL Temp/Daily/F, AKST
--   SourceID = 212, VariableID = 666
-- OR 
--   SNOTEL Temp/Daily/F, AKST
--   SourceID = 212, VariableID = 393
-- OR
--   McCall Temp/Daily/C, Akst
--   SourceID = 179, VariableID = 277
-- OR 
--   BLM/Kemenitz Temp/Daily/C
--   SourceID = 199, VariableID = 61
-- OR 
--   UAF Permafrost Temp/Daily/C
--   SourceID = 206, VariableID = 550
-- OR
--   Permafrost GI: Temp/Daily/C
--   SourceID = 224, VariableID = 550
-- OR
--   GHCN ORignal Station Scans: Temp/Daily/F
--   SourceID = 225, VariableID = 838

  ELSIF EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 432) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 626) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 666) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 393) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 277) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 61) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 550) OR 
     -- EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 550) OR --
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 838) 
  THEN
  OPEN maxCursor
    for execute('Select dv.localdateTime, dv.datavalue from tables.ODMDataValues_metric as dv '
                  'where dv.siteID = $1 and dv.originalVariableid = $2;') using site_id, var_id;
        loop
          fetch maxCursor into ldateTimeUTC, avgValue;
          if not found then 
            exit;
          end if;
          INSERT INTO tables.daily_airtempdatavalues (DataValue, UTCDateTime, SiteID, OriginalVariableID, InsertDate)
                 VALUES (avgValue, ldateTimeUTC, $1, $2, NOW());
        end loop;
  CLOSE maxCursor;
-- One Value UTC for:
--   ISH
--   SourceID = 209(dont want dayly sites with GHCN daily), VariableID = 218
-- OR
--   UAF/WERC 
--   SourceID = 29,30,31,34,223, VariableID 667
-- OR
--   BLM/Kemenitz
--   SourceID = 199, VariableID = 422
-- OR 
--   NOAA 
--   SourceID = 35, VariableID = 519
-- OR
--   ARM
--   SourceID = 203,204, VariableID = 527
-- OR 
--   ARM
--   SourceID = 203, VariableID = 538
-- OR 
--   LPeters 
--   SourceID = 182, VariableID = 279
-- OR 
--   LPeters
--   SourceID = 182, VariableID = 288
-- OR 
--   RWIS 
--   SourceID = 213, VariableID = 563
-- OR
--   UAF-BLM Temp/Daily/C
--   SourceID = 164, Variable = 640
-- OR
--   ARC LTER
--   SourcID = 144, VariableID = 819
-- OR 
--   AON 
--   SourceID = 222, VariableID = 786
-- OR 
--   AKMAP
--   SourceID = 247, VariableID = 867
-- OR 
--   ADNR_AHS deg c
--   SourceID = 259, VariableID = 1072
-- OR 
--   ADNR_AHS deg f
--   SourceID = 259, VariableID = 1073
-- OR
--   CALON
--   SourceID = 263, VariableID = 1136
  ELSIF EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 218) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 667) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 422) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 519) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 527) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 538) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 279) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 288) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 563) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 640) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 819) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 786) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 867) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1072) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1073) OR
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1136)
  THEN
  OPEN maxCursor
    for execute('Select date_trunc(''day'',dv.datetimeUTC), AVG(dv.datavalue) from tables.ODMDataValues_metric as dv '
                  'where dv.siteID = $1 and dv.originalVariableid = $2 GROUP BY date_trunc(''day'',dv.datetimeUTC);') using site_id, var_id;
        loop
          fetch maxCursor into ldateTimeUTC, avgValue;
          if not found then 
            exit;
          end if;
          INSERT INTO tables.daily_airtempdatavalues (DataValue, UTCDateTime, SiteID, OriginalVariableID, InsertDate)
                 VALUES (avgValue, ldateTimeUTC, $1, $2, NOW());
        end loop;
  CLOSE maxCursor;
-- averge tmin & max for 1m & 3m then averge for 2m for:
--   Toolik Temp/Daily/C, AKST
--   SourceID = 145, MaxID = 487, MinID = 489
  ELSIF EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 489)
  THEN
   CASE 
      WHEN $2 = 489 THEN minID = 489; maxID = 487; -- NCDC GHCN
   END CASE;
   OPEN maxCursor
   for execute('Select dv.localDateTime, dv.dataValue from tables.ODMDataValues_metric as dv '
                  'where dv.siteID = $1 and dv.originalVariableid = $2 and dv.offsetvalue = 1;') using site_id, var_id;
       loop
          fetch maxCursor into ldateTimeUTC, minValue ; --min1
          if not found then 
            exit;
          end if;
          -- get max value
          select into maxValue dv.datavalue FROM tables.odmdatavalues_metric as dv
                WHERE dv.siteid = $1 and dv.originalvariableid = maxID and dv.offsetvalue = 1 and  dv.localDateTime = ldateTimeUTC;
          -- get min3 value
          select into minValue3 dv.datavalue  FROM tables.odmdatavalues_metric as dv
                WHERE dv.siteid = $1 and dv.originalvariableid = minID and dv.offsetvalue = 3 and dv.localDateTime = ldateTimeUTC;
          -- get max3 value
          select into maxValue3 dv.datavalue   FROM tables.odmdatavalues_metric as dv
                WHERE dv.siteid = $1 and dv.originalvariableid = maxID and dv.offsetvalue = 3 and  dv.localDateTime = ldateTimeUTC;
          
          -- average 1m
          avgValue1 := (maxValue - minValue)/2 + minValue;
          avgValue3 := (maxValue3 - minValue3)/2 + minValue3;
          avgValue := (avgValue3 - avgValue1)/2 + avgValue1;
          
          IF(avgValue is NULL AND avgValue1 is not NULL) THEN
            avgValue := avgValue1;
          ELSIF avgValue is NULL and avgValue1 is null and maxValue is not NULL THEN 
            avgValue := maxValue;
          ELSIF avgValue is NULL and avgValue1 is null and minValue is not NULL THEN 
            avgValue := minValue;
          END IF;    
        
               
          INSERT INTO tables.daily_airtempdatavalues (DataValue, UTCDateTime, SiteID, OriginalVariableID, InsertDate)
                 VALUES (avgValue, ldateTimeUTC, $1, $2, NOW());
        end loop;
    CLOSE maxCursor; 
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailyairtemp(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgetdailyairtempmax(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER FUNCTION tables.uspgetdailyairtempmax(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer); Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer) IS 'Used to populate ''daily_airtemmaxdatavalues''  table.';


--
-- Name: uspgetdailyairtempmin(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER FUNCTION tables.uspgetdailyairtempmin(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer); Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer) IS 'used to populate the ''daily_airtempmindatavalues'' table.';


--
-- Name: uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailyavgsoilmoisture_anaktuvikpass(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE dateTimeUTC timestamp without time zone;
        avgValue float;
        loopCursor refcursor;

BEGIN
-- UAF/WERC: Soil MOisture/hourly, AKST
-- SourceID = 30,29 VariableID = 89
-- need to check offset = 10 cm
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 89 and offserValue = 10)
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''day'',dv.datetimeutc), AVG(dv.DataValue) FROM tables.odmdatavalues_metric AS dv '
                          'WHERE dv.SiteID = 907 and dv.originalVariableID=89 and (dv.offsetvalue = 10) GROUP BY date_trunc(''day'',dv.datetimeutc);') using site_id, var_id;
        loop
        fetch loopCursor into dateTimeUTC, avgValue;
        if not found then 
          exit; 
        end if;
        INSERT INTO tables.DAILY_AnaktuvikPassSoilMoisureDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	       VALUES(avgValue, dateTimeUTC, $2,$1, methodID);
        end loop;                      
    CLOSE loopCursor;
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailyavgsoilmoisture_anaktuvikpass(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgetdailydischarge(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailydischarge(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE DateTimeUTC timestamp without time zone;
	avgValue float;
	max_cursor refcursor;

BEGIN
-- take the value for:
--   NWIS: Discharge/cubic feet per second/ Daily. AKST
--   SourceID = 139,199,  VariableID = 56
-- OR 
--   LChamberlinStreamDischarge_cfs_dataTypeUnk: Discharge/Daily/cfs. AKST
--   SourceID = 183, VariableID = 304
-- OR
--   FWS_Discharge: Discharge/cfs/Daily. AKST
--   SourceID = 154, VariableID = 343
-- OR
--   BLM-WERC_Whitman-Arp_Discharge:  Discharge/sporadic/cms, AKST
--   SourceID = 164, VariableID = 152
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 56)  OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 304) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 343) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 152) 
  THEN
    OPEN max_cursor
    for execute format('SELECT date_trunc(''day'',dv.localdatetime) as DateTimeUTC, dv.DataValue FROM tables.odmdatavalues_metric AS dv '
                         'WHERE dv.siteid = $1 and dv.originalvariableid=$2;') USING site_id,var_id;
        loop
        fetch max_cursor into DateTimeUTC, avgValue;
	  if not found then
	    exit;
	  end if;
	  INSERT INTO tables.daily_dischargedatavalues (datavalue,utcdatetime,originalvariableid,siteid, insertdate) 
	         VALUES(avgValue,DateTimeUTC,$2,$1, NOW());
	end loop;
     close max_cursor;
-- average measurments to get a daily value for: 
--   USGS_BLM_Discharge: Discharge/minutely/cfs. AKST
--   SourceID = 199, VariableID = 445
-- OR 
--   USGS_BLM_Discharge: Discharge/every 30 minuets/cfs. AKST
--   SourceID = 199, VariableID = 497
-- OR
--   UAFWERC_Discharge:  Discharge/hourly/cms. AKST
--   SourceID = 30,29, VariableID = 90
-- OR
--   UAFWERC_Discharge_MINUTE_calculated:  Discharge/minutes/cms. AKST
--   SourceID = 31, VariableID = 145
-- OR
--   UAFWERC_Discharge_QUARTER_HOUR_calculated:  Discharge/every 15 minutes/cms, AKST
--   SourceID = 31, VariableID = 148
-- OR
--   UAFWERC_Discharge_HOURLY_calculated:  Discharge/hourly/cms, AKST
--   SourceID = 31, VariableID = 149
-- OR
--   UAFWERC_Discharge_SPORDAIC:  Discharge/sopradic/cms, AKST
--   SourceID = 31, VariableID = 150
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 445) OR 
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 497) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 90) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 145) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 148) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 149) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 150) OR 
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1084)
  THEN
    OPEN max_cursor
    for execute format('SELECT  date_trunc(''day'',dv.datetimeutc - interval ''18 hours'') as DateTimeUTC, AVG(dv.DataValue) FROM tables.odmdatavalues_metric AS dv
                           WHERE dv.siteid = $1 and dv.originalvariableid= $2
                           GROUP BY date_trunc(''day'',dv.datetimeutc - interval ''18 hours'');') USING site_id,var_id;
        loop
        fetch max_cursor into DateTimeUTC, avgValue;
	  if not found then
	    exit;
	  end if;
	  INSERT INTO tables.daily_dischargedatavalues (datavalue,utcdatetime,originalvariableid,siteid, insertdate) 
 	         VALUES(avgValue,DateTimeUTC,$2,$1, NOW());
	end loop;
     close max_cursor;
  END IF;





END;
$_$;


ALTER FUNCTION tables.uspgetdailydischarge(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgetdailyprecip(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailyprecip(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE DateTimeUTC timestamp without time zone;
	maxValue float;
	max_cursor refcursor;
BEGIN
-- NCDC GHCN
-- VariableID = 398  SourceID = 210
-- Taking the MAX precip recorded in the hour
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 398) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- ISH
-- VariableID = 340 is ISH Precip/UTC hourly/mm.  SourceID = 209
-- SUM of data values from 'hourly_precip'
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 340) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- UAF/WERC:  Precip/mm, AST
-- VariableID = 84. SourceID = 29, 30, 31, 34,223
-- SUM of data values from 'hourly_precip'
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 84) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- USGS:  Precip/hourly/mm, AST
-- VariableID = 319. SourceID = 39
-- SUM of data values from 'hourly_precip'
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 319) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- RAWS:  
-- VariableID = 441. SourceID = 211,214,215,216,217,218,219
-- Taking the MAX for the day
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 441) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- SNOTEL:  
-- AKST, need to use localdatetime to stay on same day
-- No grouping necessary, just one value per day
-- VariableID = 394. SourceID = 212
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 394) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,dv.DataValue FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2;') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- SNOTEL:  
-- AKST, need to use localdatetime to stay on same day
-- VariableID = 610. SourceID = 212
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 610) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,dv.DataValue FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2;') USING site_id,var_id;
	loop
          SELECT dv3.LocalDateTime,
          CASE WHEN dv3.DataValue >= dv3.PrevDataValue THEN dv3.DataValue - dv3.PrevDataValue
               WHEN PrevDataValue > dv3.DataValue THEN 0
               ELSE dv3.DataValue END as CurrentDataValue 
          FROM
            (SELECT  dv.LocalDateTime, dv.DataValue,(SELECT dv2.DataValue as PrevDataValue FROM tables.ODMDataValues_metric dv2
             WHERE dv2.SiteID = @site_id and dv2.OriginalVariableID=@var_id and dv2.LocalDateTime < dv.LocalDateTime and dv2.DataValue >= 0 order by dv2.LocalDateTime DESC LIMIT 1) as PrevDataValue
	     FROM tables.ODMDataValues_metric AS dv
	     WHERE dv.SiteID = @site_id and dv.OriginalVariableID=@var_id and dv.DataValue >= 0) AS dv3
	  where dv3.DataValue >= 0
	  order by dv3.LocalDateTime;
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- SNOTEL:  
-- AKST, need to use localdatetime to stay on same day
-- VariableID = 634. SourceID = 212
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 634) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,dv.DataValue FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2;') USING site_id,var_id;
	loop
          SELECT dv3.LocalDateTime,
          CASE WHEN dv3.DataValue >= dv3.PrevDataValue THEN dv3.DataValue - dv3.PrevDataValue
               WHEN PrevDataValue > dv3.DataValue THEN 0
               ELSE dv3.DataValue END as CurrentDataValue 
          FROM
            (SELECT  dv.LocalDateTime, dv.DataValue,(SELECT dv2.DataValue as PrevDataValue FROM tables.ODMDataValues_metric dv2
             WHERE dv2.SiteID = @site_id and dv2.OriginalVariableID=@var_id and dv2.LocalDateTime < dv.LocalDateTime and dv2.DataValue >= 0 order by dv2.LocalDateTime DESC LIMIT 1) as PrevDataValue
	     FROM tables.ODMDataValues_metric AS dv
	     WHERE dv.SiteID = @site_id and dv.OriginalVariableID=@var_id and dv.DataValue >= 0) AS dv3
	  where dv3.DataValue >= 0
	  order by dv3.LocalDateTime;
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- ARC LTER  Precip/hourly/mm, AST
-- VariableID = 823, SourceID = 144
-- SUM of data values from 'hourly_precip'
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 823) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- AON Precip/hourly/mm, AST
-- VariableID = 811, SourceID = 222
-- SUM of data values from 'hourly_precip'
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 811) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- Toolik  Precip/hourly/mm, AST
-- VariableID = 461, SourceID = 145
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 461) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- GHCN Original Station Observation scans:  
-- VariableID = 839. SourceID = 225
-- Taking the SUM for the day
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 839) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- McCall:  
-- VariableID = 199. SourceID = 178,182
-- Taking the SUM for the day
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 199) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- UAF:  
-- VariableID = 274. SourceID = 180
-- Taking the SUM for the day
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 274) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- Chamberlin:  
-- VariableID = 301. SourceID = 183
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 301) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
 -- BLM/Kemenitz. Precip/mm/Hourly  SourceID = 199
 -- 8/28/2014:  All data values pulled, too many errors
 -- VariableID = 496 
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 496) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
 -- BLM/Kemenitz. Precip/inches/every 15 minutes  SourceID = 199
 -- 8/28/2014:  All data values pulled, too many errors
 -- VariableID = 458 
 -- SUM
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 458) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- BLM:  
-- VariableID = 62 SourceID = 199
-- SUM
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 62) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- BLM/Kemenitz. Precip/inches/Minute  SourceID = 139
-- VariableID = 336
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 336) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- NOAA. Precip/mm/Minute  SourceID = 35
-- VariableID = 522 
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 522) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- ARM TPS. Precip/mm/Minute  SourceID = 1,203, VariableID=539
-- 8/28/2014:  Currently no data values loaded in hourly or daily 
-- SUM, 
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 539) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- LPeters. Precip/Hourly  SourceID = 182
-- VariableID = 294 
-- SUM
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 294) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- RWIS. Precip/Mintues  SourceID = 213
-- VariableID = 575
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 575) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',utcdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.hourly_precip AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- UAF-BLM:  
-- VariableID = 646. SourceID = 164
-- SUM
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 646) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- CALON
-- VariableID = 1139  SourceID = 263
-- Taking the MAX precip recorded in the hour
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1139) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.daily_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailyprecip(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: FUNCTION uspgetdailyprecip(site_id integer, var_id integer); Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON FUNCTION uspgetdailyprecip(site_id integer, var_id integer) IS 'Used to populate the ''daily_precipdatavalues'' table.

If there is are hourly data values for a site, those values are used to compute the daily data value.  This is because the hourly precip has already undergone a threshold test.';


--
-- Name: uspgetdailysnowdepth(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailysnowdepth(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE dateTimeUTC timestamp without time zone;
        avgValue float;
        maxCursor refcursor;

BEGIN
-- UTC time & convert mm to Meteres for:
--   GHCN 
--   SourceI 210, VariableID = 402
-- OR
--   RAWS Snow Depth mm
--   SourceID = 211,214,215,216,217,218,219, VariableID = 440
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 402) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 440)
  THEN
    OPEN maxCursor
    for execute format ('SELECT dv.DateTimeUTC as DateTimeUTC,dv.DataValue FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2;') using siter_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          SELECT avgValue = avgValue / 1000.0; -- convert to meters
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue, DateTimeUTC, $1, $2,NOW()); 
        end loop;
    CLOSE maxCursor;
-- UTC time for: -------- ***** NEED TO FIX *****
--   ISH 
--   SourceID = 209, VariableID = 370
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2=370 
	          and Siteid not in (select siteid from tables.sites where LocationDescription 
	          like '%WBANID:%' and SourceID=209))--the siteids which have a match in GHCN, based on wban
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'',DateTimeUTC) as DateTimeUTC,dv.DataValue FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',DateTimeUTC);') using siter_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue, DateTimeUTC, $1, $2,NOW()); 
        end loop;
    CLOSE maxCursor;
-- average UTC time (variableID change to 680) for:
--   UAF/WERC Snow Depth
--   SourceID = 29,30,34,223, VariableID = 875 
--   Using hourly summary variableID = 680
-- OR
--   AON Snow Depth -- twice?
--   SourceID = 222, VariableID = 813 
--   Using hourly summary variableID = 680
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 975) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 813)
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'',DateTimeUTC) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',DateTimeUTC);') using siter_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue, DateTimeUTC, $1, 680 ,NOW()); -- hourly summary variable ID used here
        end loop;
    CLOSE maxCursor;
-- average UTC time for:
--   AON Snow Depth Meters -- twice ?
--   SourceID = 222. VariableID = 813 
-- OR
--   USGS Snow Depth 
--   SourceID = 39. VariableID = 320 
-- OR
--   SNOTEL Snow Depth 
--   SourceID = 212 VariableID = 612
-- OR
--   Snow Course Snow Depth 
--   SourceID = 200 VariableID = 396
-- OR
--   UAF/WERC Snow Depth 
--   SourceID = 31. VariableID = 193  
-- OR
--   ARM Snow Depth 
--   SourceID = 1, 203 VariableID = 543  
-- OR
--   RIWS Snow Depth
--   SourceID = 213, VariableID = 584
-- OR
--   Permafrost GI Snow Depth
--   SourceID = 224, VariableID = 835
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 813) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 813) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 612) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 396) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 193) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 543) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 584) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 835)
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'',DateTimeUTC) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',DateTimeUTC);') using siter_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue, DateTimeUTC, $1, $2,NOW()); 
        end loop;
    CLOSE maxCursor;
-- Local dateTime Average for:
--   UAF/WERC Snow Depth meters/daily
--   SourceID = 31, VariableID = 339
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 339)
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') using siter_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue, DateTimeUTC, $1, $2,NOW()); 
        end loop;
    CLOSE maxCursor;
-- Local dateTime Average (convert cm to meters) for:
--   UAF/WERC Snow Depth meters/daily
--   SourceID = 3,193, VariableID = 142
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 142)
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') using siter_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue, DateTimeUTC, $1, $2,NOW()); 
        end loop;
    CLOSE maxCursor;
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailysnowdepth(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgetdailysnowdepthmax(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailysnowdepthmax(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE DateTimeUTC timestamp without time zone;
	maxValue float;
	maxCursor refcursor;

BEGIN
-- UTC Datetime $ convert MAX from cm to meters for:
-- USGS:  Snow depth/hourly/cm, AST
-- SourceID = 39, VariableID = 320 
-- Need to convert from cm to meters
  IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= $1 AND 320=$2)
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',DateTimeUTC), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.originalVariableID=320 GROUP BY date_trunc(''day'',DateTimeUTC);') USING site_id, var_id;
        loop
        fetch maxCursor into dateTimeUTC, maxValue;
        if not found then 
	  exit;
	end if;
	SELECT maxValue = maxValue/100;
	INSERT INTO tables.dialy_snowdepthmaxdatavalues (datavalue, utcdatetime,siteid,origianlvariableid, insertdate) 
	       VALUES (maxValue, dateTimeUTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;  
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailysnowdepthmax(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgetdailysnowdepthmin(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailysnowdepthmin(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE DateTimeUTC timestamp without time zone;
	minValue float;
	maxCursor refcursor;

BEGIN
-- UTC Datetime $ convert MIN from cm to meters for:
-- USGS:  Snow depth/hourly/cm, AST
-- SourceID = 39, VariableID = 320 
-- Need to convert from cm to meters
  IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= $1 AND 320=$2)
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',DateTimeUTC), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = 988 and dv.originalVariableID=320 GROUP BY date_trunc(''day'',DateTimeUTC);') USING site_id, var_id;
        loop
        fetch maxCursor into dateTimeUTC, minValue;
        if not found then 
	  exit;
	end if;
	SELECT minValue = minValue/100;
	INSERT INTO tables.dialy_snowdepthmindatavalues (datavalue, utcdatetime,siteid,origianlvariableid, insertdate) 
	       VALUES (minValue, dateTimeUTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;  
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailysnowdepthmin(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgetdailysoiltemp(integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailysoiltemp(site_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE dateTimeUTC timestamp without time zone;
        value float;
        maxCursor refcursor;
BEGIN
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=5 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=5 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=5;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
  -- offset = 10 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=10 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=10 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=10;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;

   -- offset = 15 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=15 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=15 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=15;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
 -- offset = 20 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=20 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=20 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=20;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 25 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=25 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=25 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=25;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 30 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=30 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=30 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=30;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 45 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=45 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=45 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=45;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 70 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=70 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=70 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=70;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 95 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=95 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=95 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=95;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 120 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=120 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=120 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=120;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailysoiltemp(site_id integer) OWNER TO imiq;

--
-- Name: uspgetdailysoiltempmax(integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailysoiltempmax(site_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE dateTimeUTC timestamp without time zone;
        value float;
        maxCursor refcursor;
BEGIN
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=5 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=5 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=5;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
  -- offset = 10 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=10 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=10 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=10;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;

   -- offset = 15 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=15 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=15 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=15;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
 -- offset = 20 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=20 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=20 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=20;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 25 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=25 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=25 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=25;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 30 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=30 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=30 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=30;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 45 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=45 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=45 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=45;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 70 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=70 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=70 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=70;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 95 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=95 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=95 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=95;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 120 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=120 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=120 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=120;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailysoiltempmax(site_id integer) OWNER TO imiq;

--
-- Name: uspgetdailysoiltempmin(integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailysoiltempmin(site_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE dateTimeUTC timestamp without time zone;
        value float;
        maxCursor refcursor;
BEGIN
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=5 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=5 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=5;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
  -- offset = 10 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=10 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=10 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=10;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;

   -- offset = 15 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=15 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=15 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=15;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
 -- offset = 20 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=20 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=20 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=20;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 25 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=25 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=25 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=25;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 30 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=30 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=30 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=30;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 45 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=45 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=45 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=45;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 70 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=70 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=70 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=70;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 95 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=95 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=95 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=95;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 120 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=120 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=120 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=120;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailysoiltempmin(site_id integer) OWNER TO imiq;

--
-- Name: uspgetdailyswe(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailyswe(siteid integer, varid integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER FUNCTION tables.uspgetdailyswe(siteid integer, varid integer) OWNER TO imiq;

--
-- Name: uspgetdailywatertemp(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailywatertemp(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE dateTimeUTC timestamp without time zone;
        value float;
        offsetValue float;
        offsetType int;
        maxCursor refcursor;

BEGIN
-- take utc average for:
--   WERC, water temperature AKST
--   SourceID = 31, VariableID = 221 
-- OR 
--   WERC, water temperature AKST
--   SourceID = 30, VariableID = 92
-- OR 
--   USGS Water Temperature AKST
--   SourceID = 139,199, VariableID = 58
-- OR 
--   Toolik Field Station, Water Temperature, AKST
--   SourceID = 145, VariableID = 481
-- OR 
--   Tooolik Field Station, Water Temerature, AKST 
--   SourceID = 145, Variable = 495
-- OR 
--   WERC/BLM, Water Temperature, AKST
--   SourceID = 164, VariableID = 164
--   164 is variable ID of stream bed 
-- OR 
--   ADNR AHS deg c
--   SourceID = 259, VariableID = 1074
-- OR 
--   ADNR AHS deg f
--   SourceID = 259, VariableID = 1075
-- OR
--   CALON surface temp 
--   SourceID = 261, variableID = 1127
-- OR
--   CALON bedtemp 
--   SourceID = 261, variableID = 1128
-- OR
--   CALON laketemp 
--   SourceID = 261, variableID = 1129
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 221) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 92) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 58) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 481) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 495) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 164) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1074) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1075) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1127) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1128) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1129)
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',DateTimeUTC), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                        'WHERE dv.SiteID = $1 and dv.OriginalVariableid = $2 GROUP BY date_trunc(''day'',DateTimeUTC);') USING site_id, var_id;
        loop
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
	INSERT INTO tables.daily_watertempdatavalues(datavalue, utcdatetime,siteid,originalvariableid, insertdate) 
	       VALUES (value, dateTimeUTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;
-- averages all water temp dephts for
--   WERC NSL Water Temerature. AKST
--   Source ID = 193, VariableID = 155 
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 155)
  THEN 
  OPEN maxCursor
    for execute format('select date_trunc(''day'',wt.DateTimeUTC) as DateTimeUTC,AVG(DataValue),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID from tables.ODMDataValues_metric WT '
          'inner join '
            '(select SiteID,date_trunc(''day'',DateTimeUTC) as DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID from tables.ODMDataValues_metric '
            'where SiteID=$1 and OriginalVariableID=$2 group by SiteID, date_trunc(''day'',DateTimeUTC),OffsetTypeID) as MAX_Offset '
            'on MAX_Offset.SiteID=WT.SiteID and MAX_Offset.DateTimeUTC=date_trunc(''day'',wt.DateTimeUTC) and MAX_Offset.max_OffsetValue=WT.OffsetValue and MAX_Offset.max_OffsetTypeID=WT.OffsetTypeID '
            'WHERE WT.SiteID = $1 and OriginalVariableid=$2 group by date_trunc(''day'',wt.DateTimeUTC),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID;') USING site_id, var_id;
        loop
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
	INSERT INTO tables.daily_watertempdatavalues(datavalue, utcdatetime,siteid,originalvariableid, insertdate) 
	       VALUES (value, dateTimeUTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailywatertemp(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgetdailywinddirection(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailywinddirection(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
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
    WHEN $2 = 430 THEN wsid = 429; -- RAWS
    WHEN $2 = 528 THEN wsid = 529; -- ARM
    WHEN $2 = 290 THEN wsid = 292; -- LPeters
    WHEN $2 = 512 THEN wsid = 511; -- NOAA
    WHEN $2 = 568 THEN wsid = 566; -- RWIS
    WHEN $2 = 616 THEN wsid = 618; -- SNOTEL
    WHEN $2 = 669 THEN wsid = 671; -- SNOTEL
    WHEN $2 = 1135 THEN wsid = 1133; -- CALON
    ELSE
	wsid = -1;
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
--   RAWS: WindDirection 
--   SourceID = 211, VariableID = 430 
--   WS VariableID = 429
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
--   SNOTEL: WindDirection 
--   SourceID = 212, VariableID = 616 
--   WS VariableID = 618
-- OR 
--   SNOTEL: WindDirection 
--   SourceID = 212, VariableID = 669 
--   WS VariableID = 671
-- OR 
--   CALON 263
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
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 616) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 669) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID= $1 AND $2 = 1135)
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',WD.datetimeutc) as DateTimeUTC, AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID FROM tables.ODMDataValues_metric AS WD '
		               'inner join '
                                 '(select SiteID,DateTimeUTC,DataValue as M from tables.ODMDataValues_metric WS where WS.SiteID=$1 and WS.OriginalVariableID=$3) as WS '
		                 'on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC '
		                 'WHERE WD.SiteID = $1 and WD.OriginalVariableid=$2 GROUP BY date_trunc(''day'',WD.datetimeutc),OffsetValue,OffsetTypeID;') using site_id, var_id, wsID;
        loop
          fetch maxCursor into dateTimeUTC, y, x, offsetValue, offsetType;
          if not found then
            exit;
          end if;
          --SELECT into avgvalue tables.calcwinddirection(CAST(x as real), CAST(y as real));
          INSERT INTO tables.daily_winddirectiondatavalues(datavalue, utcdatetime, siteid, originalvariableid, offsetvalue, offsettypeid, insertdate)
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
    for execute format('SELECT date_trunc(''day'',WD.datetimeutc) as DateTimeUTC, AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)), WS.max_OffsetValue,WS.max_OffsetTypeID FROM tables.ODMDataValues_metric AS WD '
		               'inner join '
		               '(select WS.SiteID,WS.DateTimeUTC,DataValue as M,MAX_Offset.max_OffsetValue as max_OffsetValue,MAX_Offset.max_OffsetTypeID from tables.ODMDataValues_metric WS '
                                        'inner join '
                                        '(select SiteID,DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID from tables.ODMDataValues_metric '
                                             'where SiteID= $1 and OriginalVariableID=$3 group by SiteID,DateTimeUTC,OffsetTypeID) as MAX_Offset '
                                        'on MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC '
                                        'WHERE WS.SiteID = $1 and WS.OriginalVariableid=$3 and WS.OffsetValue=MAX_Offset.max_OffsetValue) as WS '
                               'on WD.SiteID=WS.SiteID and WS.DateTimeUTC=WD.DateTimeUTC '	
                               'WHERE WD.SiteID = $1 and WD.OriginalVariableid=$2 and WD.OffsetValue=WS.max_OffsetValue  GROUP BY date_trunc(''day'',WD.datetimeutc),WS.max_OffsetValue,WS.max_OffsetTypeID;') using site_id, var_id, wsID;
        loop
          fetch maxCursor into dateTimeUTC, y, x, offsetValue, offsetType;
          if not found then
            exit;
          end if;
          --SELECT into avgvalue tables.calcwinddirection(CAST(x as real), CAST(y as real));
          INSERT INTO tables.daily_winddirectiondatavalues(datavalue, utcdatetime, siteid, originalvariableid, offsetvalue, offsettypeid, insertdate)
                 VALUES(tables.calcwinddirection(CAST(x as real), CAST(y as real)), dateTimeUTC, $1, $2, offsetValue, offsetType, NOW());
        end loop; 
  CLOSE maxCursor;
  END IF;
END;
$_$;


ALTER FUNCTION tables.uspgetdailywinddirection(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgetdailywindspeed(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgetdailywindspeed(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
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
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 335) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 743) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 815) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 313) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 645) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 429) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 529) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 541) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 535) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 292) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 511) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 566) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 1133)
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.datetimeutc) as dateTimeUTC, AVG(dv.DataValue), offsetValue, offsetTypeID FROM tables.odmdatavalues_metric AS dv ' -- start of fomart
                         'WHERE dv.siteid = $1 and dv.originalvariableid=$2 '
                         'GROUP BY date_trunc(''day'',dv.datetimeutc), OffsetValue, OffsetTypeID;') USING site_id,var_id; -- end of format
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
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 82)  OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 469) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 827)
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',ws.datetimeutc ) AS dateTimeUTC, AVG(DataValue), MAX_Offset.max_OffsetValue, MAX_Offset.max_OffsetTypeID FROM tables.odmdatavalues_metric WS
                         inner join
                           (select siteid, DateTimeUTC,MAX(OffsetValue) AS max_OffsetValue, OffsetTypeID AS max_OffsetTypeID FROM tables.odmdatavalues_metric 
                              where siteid = 2128 AND OriginalVariableID = 469 
                              GROUP by siteid, dateTimeUTC, offsetTypeID) AS MAX_Offset 
                           ON MAX_Offset.siteid=WS.SiteID AND MAX_Offset.DateTimeUTC=WS.DateTimeUTC  
                             WHERE WS.SiteID = 2128 AND OriginalVariableid = 469 AND WS.OffsetValue = MAX_Offset.max_OffsetValue 
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
$_$;


ALTER FUNCTION tables.uspgetdailywindspeed(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: FUNCTION uspgetdailywindspeed(site_id integer, var_id integer); Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON FUNCTION uspgetdailywindspeed(site_id integer, var_id integer) IS 'used to populate ''daily_windspeeddatavalues''  table';


--
-- Name: uspgethourlyairtemp(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgethourlyairtemp(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
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
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=1136)
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
$_$;


ALTER FUNCTION tables.uspgethourlyairtemp(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgethourlyprecip(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgethourlyprecip(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE DateTimeUTC timestamp without time zone;
	maxValue float;
	max_cursor refcursor;
BEGIN
  -- ISH
  -- VariableID = 340 is ISH Precip/UTC hourly/mm.  SourceID = 209
  -- Taking the highest precip recorded in the hour
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 340) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
   
  -- UAF/WERC:  Precip/mm, AST
  -- VariableID = 84. SourceID = 29, 30, 31, 34
  -- Taking the MAX precip in the hour
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 84) 
  THEN
    OPEN max_cursor 
    FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
 -- USGS:  Precip/hourly/mm, AST
 -- VariableID = 319. SourceID = 39
 -- Taking the MAX precip in the hour
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 319) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
 -- Toolik  Precip/hourly/mm, AST
 -- VariableID = 461, SourceID = 145
 -- loading pluvio, which is year round precip
 -- Taking the MAX precip in the hour
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 461) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- ARC LTER /hourly/mm, AST
-- VariableID = 823, SourceID = 144
-- Taking the MAX precip in the hour
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 823) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
 -- AON /hourly/mm, AST
 -- VariableID = 811, SourceID = 222
 -- Taking the SUM precip for the hour
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 811) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- BLM/Kemenitz. Precip/mm/Hourly  SourceID = 199
-- VariableID = 496 
-- Taking the MAX precip in the hour
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 496 ) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
 -- BLM/Kemenitz. Precip/inches/every 15 minutes  SourceID = 199
 -- VariableID = 458 
 -- SUM, not max, since the DataValue is not accumulating over the hour.
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 458  ) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- BLM/Kemenitz. Precip/inches/Minute  SourceID = 139
-- VariableID = 336
-- SUM over hour
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 336  ) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- NOAA. Precip/mm/Minute  SourceID = 35
-- VariableID = 522 
-- Taking the MAX precip in the hour
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 522 ) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- ARM TPS. Precip/mm/Minute  SourceID = 1,203
-- VariableID = 539 Precip Rate/hour
-- Need to compute daily average
-- SUM, not max, since the DataValue is not accumulating over the hour.
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 539 ) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- ARM. Precip/mm/Minute  SourceID = 202
-- VariableID = 526
-- SUM, not max, since the DataValue is not accumulating over the hour.
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 526 ) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,SUM(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- LPeters. Precip/Hourly  SourceID = 182
-- VariableID = 294 Avg AT
-- MAX precip for the hour
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 294 ) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- CALON. Precip/Hourly  SourceID = 263
-- VariableID = 1139 
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1139 ) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',datetimeutc) as DateTimeUTC,MAX(dv.DataValue) FROM tables.odmdatavalues_metric AS dv WHERE dv.siteid = $1 and dv.originalvariableid=$2 GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
-- RWIS. Precip/Mintues  SourceID = 213
-- VariableID = 575
-- Taking the value on the hour, since it is the accumulated value for the hour
 ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 575) 
 THEN
 OPEN max_cursor 
 FOR execute format('SELECT date_trunc(''hour'',dv.datetimeutc) as DateTimeUTC,dv.DataValue FROM tables.odmdatavalues_metric AS dv 
   INNER JOIN (
	SELECT date_trunc(''hour'',datetimeutc) as HourTimeUTC,MIN(dv2.DateTimeUTC) as DateTimeUTC
	FROM tables.odmdatavalues_metric dv2
	WHERE dv2.SiteID = $1 and dv2.OriginalVariableID=$2
	GROUP BY date_trunc(''hour'',datetimeutc)) dv3
   ON dv3.DateTimeUTC = dv.DateTimeUTC
   WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2
   order by DateTimeUTC;') USING site_id,var_id;
	loop
	 fetch max_cursor into DateTimeUTC,maxValue;
	  if not found then
	   exit;
         end if;
  	 INSERT INTO tables.hourly_precipdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate) VALUES(maxValue,DateTimeUTC, $1, $2,NOW());
  	 -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,maxValue;
	end loop;
	close max_cursor;
END IF;
END;
$_$;


ALTER FUNCTION tables.uspgethourlyprecip(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: FUNCTION uspgethourlyprecip(site_id integer, var_id integer); Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON FUNCTION uspgethourlyprecip(site_id integer, var_id integer) IS 'Used to populate the ''hourly_precipdatavalues'' table.';


--
-- Name: uspgethourlysnowdepth(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgethourlysnowdepth(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE dateTimeUTC timestamp without time zone;
        avgValue float;
        loopCursor refcursor;

BEGIN
-- convert cm -> meters for:
--   ISH. snowdepth. 
--   SourceID = 209, VariableID = 370
-- OR 
--   UAF/WERC: snow Depth
--   SourceID = 29, 30, 34, 223, VariableID = 74
-- OR
--   USGS: Snow Depth/hourly/cm
--   SourceID = 39. VariableID = 230
  IF EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 370) OR
     EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 74) OR
     EXISTS (SELECT * FROM tables.odmdatadatavalues_metric WHERE siteid = $1 and $2 = 230) 
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
$_$;


ALTER FUNCTION tables.uspgethourlysnowdepth(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgethourlyswe(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgethourlyswe(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER FUNCTION tables.uspgethourlyswe(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgethourlywinddirection(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgethourlywinddirection(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER FUNCTION tables.uspgethourlywinddirection(site_id integer, var_id integer) OWNER TO imiq;

--
-- Name: uspgethourlywindspeed(integer, integer); Type: FUNCTION; Schema: tables; Owner: imiq
--

CREATE FUNCTION uspgethourlywindspeed(site_id integer, var_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
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
--   SourceID = 213, VariableID = 1133
  IF EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 335) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 529) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 541) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 535) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 292) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 511) OR
     EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 566) OR
     EXISTS(SELECT *imiqdb_staging.FUNCTIONS.imiqdb-staging.gina.alaska.edu.postgres.-s-.2015-09-10_130634.pg_dump FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 1133)
  THEN
    OPEN loopCursor
    for execute format('SELECT  date_trunc(''hour'',dv.datetimeutc) as dateTimeUTC, dv.datavalue FROM tables.odmdatavalues_metric AS dv 
                          WHERE dv.siteid = 15769 AND dv.originalvariableid = 1133 ;')using site_id, var_id;
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
  ELSIF EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 82) OR
        EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 469) OR
        EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 827)
  THEN
    OPEN loopCursor
    for execute format('select date_trunc(''hour'', ws.datetimeUTC) as DateTimeUTC,DataValue,MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID from tables.ODMDataValues_metric WS
          inner join
           (select SiteID,DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID from tables.ODMDataValues_metric 
            where SiteID=$1 and OriginalVariableID=$2 group by SiteID,DateTimeUTC,OffsetTypeID) as MAX_Offset
          on MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC 
          WHERE WS.SiteID = $1 and OriginalVariableid=$2 and WS.OffsetValue=MAX_Offset.max_OffsetValue')using site_id, var_id;
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
    for execute format('SELECT date_trunc(''hour'', dv.datetimeutc) as dateTimeUTC, AVG(dv.datavalue), offsetvalue, offsetType FROM tables.odmdatavalues_metric AS dv '
                          'WHERE dv.siteid = $1 AND dv.originalsiteid = $2 GROUP BY date_trunc(''Hour'', dv.datetimeutc), offsetValue, offsetTypeID;')using site_id, var_id;
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
$_$;


ALTER FUNCTION tables.uspgethourlywindspeed(site_id integer, var_id integer) OWNER TO imiq;

SET default_tablespace = '';

SET default_with_oids = false;



ALTER TABLE tables._15min_watertemp OWNER TO imiq;

--
-- Name: TABLE _15min_watertemp; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE _15min_watertemp IS 'This table creates "_15min_watertemp" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid';


--
-- Name: _sites_summary; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables._sites_summary OWNER TO imiq;

--
-- Name: _siteswithelevations; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables._siteswithelevations OWNER TO imiq;

--
-- Name: annual_avgairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgairtemp OWNER TO imiq;

--
-- Name: TABLE annual_avgairtemp; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgairtemp IS 'This table is  annual air temperature averages using "monthly_airtemp_all".  Requires all 12 months to create annual air temperature average and the monthly average cannot be null.  Sets originalvariableid=697 and variableid=699.';


--
-- Name: annual_avgdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgdischarge OWNER TO imiq;

--
-- Name: TABLE annual_avgdischarge; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgdischarge IS 'This creates annual discharge averages using "monthly_discharge_all".  Requires all 12 months to create annual discharge averages and the monthly average cannot be null.  Sets originalvariableid=700 and variableid=710.';


--
-- Name: annual_avgfallairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgfallairtemp OWNER TO imiq;

--
-- Name: TABLE annual_avgfallairtemp; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgfallairtemp IS 'This view creates "annual_avgfallairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=722.';


--
-- Name: annual_avgfallairtemp_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgfallairtemp_all OWNER TO imiq;

--
-- Name: TABLE annual_avgfallairtemp_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgfallairtemp_all IS 'This creates annual fall air temperature averages using "monthly_airtemp_all".  Requires all three months; September, October and November; to create annual fall average.  ';


--
-- Name: annual_avgfallprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgfallprecip OWNER TO imiq;

--
-- Name: TABLE annual_avgfallprecip; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgfallprecip IS 'This view creates "annual_avgfallprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=729';


--
-- Name: annual_avgfallprecip_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

C

ALTER TABLE tables.annual_avgfallprecip_all OWNER TO imiq;

--
-- Name: TABLE annual_avgfallprecip_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgfallprecip_all IS 'This view creates annual average fall precipitation total using "monthly_precip_all".  Requires all three months; September, October and November; to create annual average total.';


--
-- Name: annual_avgrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--




ALTER TABLE tables.annual_avgrh OWNER TO imiq;

--
-- Name: TABLE annual_avgrh; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgrh IS 'This view creates "annual_avgrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets variableid=708 and originalvariableid=707';


--
-- Name: annual_avgrh_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgrh_all OWNER TO imiq;

--
-- Name: annual_avgspringairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--




ALTER TABLE tables.annual_avgspringairtemp OWNER TO imiq;

--
-- Name: TABLE annual_avgspringairtemp; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgspringairtemp IS 'This view creates "annual_avgspringairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=724';


--
-- Name: annual_avgspringairtemp_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgspringairtemp_all OWNER TO imiq;

--
-- Name: TABLE annual_avgspringairtemp_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgspringairtemp_all IS 'This view creates annual spring air temperature averages using "monthly_airtemp_all".  Requires all three months; March, April and May; to create annual spring air temperature average.';


--
-- Name: annual_avgspringprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.annual_avgspringprecip OWNER TO imiq;

--
-- Name: TABLE annual_avgspringprecip; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgspringprecip IS 'This view creates "annual_avgspringprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=733';


--
-- Name: annual_avgspringprecip_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgspringprecip_all OWNER TO imiq;

--
-- Name: TABLE annual_avgspringprecip_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgspringprecip_all IS 'This view creates annual spring precipitation total averages using "monthly_precip_all".  Requires all three months: March, April and May; to create annual spring precipitation total average.';


--
-- Name: annual_avgsummerairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgsummerairtemp OWNER TO imiq;

--
-- Name: TABLE annual_avgsummerairtemp; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgsummerairtemp IS 'This table creates "annual_avgsummerairtemp_2" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=726';


--
-- Name: annual_avgsummerairtemp_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.annual_avgsummerairtemp_all OWNER TO imiq;

--
-- Name: TABLE annual_avgsummerairtemp_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgsummerairtemp_all IS 'This view creates annual summer air temperature averages using "monthly_airtemp_all".  Requires all three months; June, July and August; to create annual summer air temperature average';


--
-- Name: annual_avgsummerdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgsummerdischarge OWNER TO imiq;

--
-- Name: TABLE annual_avgsummerdischarge; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgsummerdischarge IS 'This view creates "annual_avgsummerdischarge" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=700 and variableid=737';


--
-- Name: annual_avgsummerdischarge_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgsummerdischarge_all OWNER TO imiq;

--
-- Name: TABLE annual_avgsummerdischarge_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgsummerdischarge_all IS 'This view creates annual average summer discharge using "monthly_discharge_all".  Requires all three months; June, July, August; to create annual average summer discharge.';


--
-- Name: annual_avgsummerprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgsummerprecip OWNER TO imiq;

--
-- Name: TABLE annual_avgsummerprecip; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgsummerprecip IS 'This view creates "annual_avgsummerprecip_2" with the fields: valueid, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=735';


--
-- Name: annual_avgsummerprecip_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgsummerprecip_all OWNER TO imiq;

--
-- Name: TABLE annual_avgsummerprecip_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgsummerprecip_all IS 'This view creates annual average summer precipitation totals using "monthly_precip_all".  Requires all three months; June, July, August; to create annual average summer precipitation totals.';


--
-- Name: annual_avgsummerrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.annual_avgsummerrh OWNER TO imiq;

--
-- Name: TABLE annual_avgsummerrh; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgsummerrh IS 'This view creates "annual_avgsummerrh_2" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=707 and variableid=739.';


--
-- Name: annual_avgsummerrh_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.annual_avgsummerrh_all OWNER TO imiq;

--
-- Name: TABLE annual_avgsummerrh_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgsummerrh_all IS 'This view creates annual average summer relative humidity by calculating the seasonal relative humdity using the monthly air temperature and monthly relative humidity averages.   Requires all three months; June, July, August; to create annual average summer relative humidity';


--
-- Name: annual_avgwinterairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgwinterairtemp OWNER TO imiq;

--
-- Name: TABLE annual_avgwinterairtemp; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgwinterairtemp IS 'This view creates "annual_avgwinterairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=719';


--
-- Name: annual_avgwinterairtemp_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgwinterairtemp_all OWNER TO imiq;

--
-- Name: annual_avgwinterprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgwinterprecip OWNER TO imiq;

--
-- Name: TABLE annual_avgwinterprecip; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgwinterprecip IS 'This view creates "annual_avgwinterprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=731';


--
-- Name: annual_avgwinterprecip_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgwinterprecip_all OWNER TO imiq;

--
-- Name: annual_avgwinterrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_avgwinterrh OWNER TO imiq;

--
-- Name: TABLE annual_avgwinterrh; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_avgwinterrh IS 'This view creates "annual_avgwinterrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=707 and vairableid=741';


--
-- Name: annual_avgwinterrh_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.annual_avgwinterrh_all OWNER TO imiq;

--
-- Name: annual_peakdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.annual_peakdischarge OWNER TO imiq;

--
-- Name: TABLE annual_peakdischarge; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_peakdischarge IS 'This view creates "annual_peakdischarge" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=689 and variableid=712';


--
-- Name: annual_peakdischarge_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_peakdischarge_all OWNER TO imiq;

--
-- Name: annual_peaksnowdepth; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_peaksnowdepth OWNER TO imiq;

--
-- Name: TABLE annual_peaksnowdepth; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_peaksnowdepth IS 'This view creates "annual_peaksnowdepth" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=705';


--
-- Name: annual_peaksnowdepth_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_peaksnowdepth_all OWNER TO imiq;

--
-- Name: annual_peakswe; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_peakswe OWNER TO imiq;

--
-- Name: TABLE annual_peakswe; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_peakswe IS 'This view creates "annual_peakswe" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=717';


--
-- Name: annual_peakswe_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_peakswe_all OWNER TO imiq;

--
-- Name: annual_totalprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_totalprecip OWNER TO imiq;

--
-- Name: TABLE annual_totalprecip; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE annual_totalprecip IS 'This view creates "annual_totalprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid= and variableid=';


--
-- Name: annual_totalprecip_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.annual_totalprecip_all OWNER TO imiq;

--
-- Name: attributes; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.attributes OWNER TO imiq;

--
-- Name: TABLE attributes; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE attributes IS 'Describes non-numeric data values for a Site.';


--
-- Name: COLUMN attributes.attributeid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN attributes.attributeid IS 'Unique integer ID for each attribute.';


--
-- Name: COLUMN attributes.attributename; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN attributes.attributename IS 'The name of the attribute.';


--
-- Name: attributes_attributeid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE attributes_attributeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.attributes_attributeid_seq OWNER TO imiq;

--
-- Name: attributes_attributeid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE attributes_attributeid_seq OWNED BY attributes.attributeid;


--
-- Name: boundarycatalog; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.boundarycatalog OWNER TO imiq;

--
-- Name: categories; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.categories OWNER TO imiq;

--
-- Name: COLUMN categories.categoryid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN categories.categoryid IS 'Primary key for Categories.';


--
-- Name: COLUMN categories.variableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN categories.variableid IS 'Integer identifier that references the record in the Variables table.';


--
-- Name: COLUMN categories.categoryname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN categories.categoryname IS 'Category name that is used to describe the category.';


--
-- Name: COLUMN categories.categorydescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN categories.categorydescription IS 'Category definition.';


--
-- Name: categories_categoryid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE categories_categoryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.categories_categoryid_seq OWNER TO imiq;

--
-- Name: categories_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE categories_categoryid_seq OWNED BY categories.categoryid;


--
-- Name: censorcodecv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.censorcodecv OWNER TO imiq;

--
-- Name: TABLE censorcodecv; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE censorcodecv IS 'The CensorCodeCV table contains the controlled vocabulary for censor codes. Only values from the Term field in this table can be used to populate the CensorCode field of the DataValues table.';


--
-- Name: COLUMN censorcodecv.term; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN censorcodecv.term IS 'Controlled vocabulary for CensorCode.';


--
-- Name: COLUMN censorcodecv.definition; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN censorcodecv.definition IS 'Definition of CensorCode controlled vocabulary term. The definition is optional if the term is self explanatory.';


--
-- Name: daily_airtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.daily_airtemp OWNER TO imiq;

--
-- Name: TABLE daily_airtemp; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE daily_airtemp IS 'This view restricts data values to the range: -80F <= DataValue < 115F.  Sets the daily air temperature variableid = 686';


--
-- Name: daily_airtempdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.daily_airtempdatavalues OWNER TO imiq;

--
-- Name: daily_airtempdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_airtempdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_airtempdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_airtempdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_airtempdatavalues_valueid_seq OWNED BY daily_airtempdatavalues.valueid;


--
-- Name: daily_airtempmax; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_airtempmax OWNER TO imiq;

--
-- Name: TABLE daily_airtempmax; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE daily_airtempmax IS 'This view restricts data values to the range: -80F <= datavalue < 115F.  Sets the daily max air temperature variableid = 687';


--
-- Name: daily_airtempmaxdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.daily_airtempmaxdatavalues OWNER TO imiq;

--
-- Name: daily_airtempmaxdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_airtempmaxdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_airtempmaxdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_airtempmaxdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_airtempmaxdatavalues_valueid_seq OWNED BY daily_airtempmaxdatavalues.valueid;


--
-- Name: daily_airtempmin; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_airtempmin OWNER TO imiq;

--
-- Name: TABLE daily_airtempmin; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE daily_airtempmin IS 'This view restricts data values to the range: -80F <= datavalue < 115F.  Sets the daily min air temperature variableid = 688';


--
-- Name: daily_airtempmindatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_airtempmindatavalues OWNER TO imiq;

--
-- Name: daily_airtempmindatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_airtempmindatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_airtempmindatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_airtempmindatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_airtempmindatavalues_valueid_seq OWNED BY daily_airtempmindatavalues.valueid;


--
-- Name: daily_discharge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_discharge OWNER TO imiq;

--
-- Name: TABLE daily_discharge; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE daily_discharge IS 'This view restricts data values to the range: datavalue >=0.  Sets the daily discharge variableid=689.';


--
-- Name: daily_dischargedatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.daily_dischargedatavalues OWNER TO imiq;

--
-- Name: daily_dischargedatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_dischargedatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_dischargedatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_dischargedatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_dischargedatavalues_valueid_seq OWNED BY daily_dischargedatavalues.valueid;


--
-- Name: daily_precip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_precip OWNER TO imiq;

--
-- Name: daily_precip_thresholds; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.daily_precip_thresholds OWNER TO imiq;

--
-- Name: daily_precipdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_precipdatavalues OWNER TO imiq;

--
-- Name: daily_precipdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_precipdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_precipdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_precipdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_precipdatavalues_valueid_seq OWNED BY daily_precipdatavalues.valueid;


--
-- Name: daily_rh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_rh OWNER TO imiq;

--
-- Name: TABLE daily_rh; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE daily_rh IS 'This view restricts data values to the range: datavalue > 0 and datadalue <= 100.  Sets the daily relative humidity variableid=691';


--
-- Name: daily_rhdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.daily_rhdatavalues OWNER TO imiq;

--
-- Name: daily_rhdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_rhdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_rhdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_rhdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_rhdatavalues_valueid_seq OWNED BY daily_rhdatavalues.valueid;


--
-- Name: daily_snowdepth; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_snowdepth OWNER TO imiq;

--
-- Name: daily_snowdepthdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_snowdepthdatavalues OWNER TO imiq;

--
-- Name: daily_snowdepthdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_snowdepthdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_snowdepthdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_snowdepthdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_snowdepthdatavalues_valueid_seq OWNED BY daily_snowdepthdatavalues.valueid;


--
-- Name: daily_swe; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_swe OWNER TO imiq;

--
-- Name: daily_swedatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.daily_swedatavalues OWNER TO imiq;

--
-- Name: daily_swedatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_swedatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_swedatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_swedatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_swedatavalues_valueid_seq OWNED BY daily_swedatavalues.valueid;


--
-- Name: daily_watertemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_watertemp OWNER TO imiq;

--
-- Name: TABLE daily_watertemp; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE daily_watertemp IS 'This view restricts data values to those which are not null.  Sets the daily water temperature variableid=694.';


--
-- Name: daily_watertempdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_watertempdatavalues OWNER TO imiq;

--
-- Name: daily_watertempdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_watertempdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_watertempdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_watertempdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_watertempdatavalues_valueid_seq OWNED BY daily_watertempdatavalues.valueid;


--
-- Name: daily_winddirection; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_winddirection OWNER TO imiq;

--
-- Name: TABLE daily_winddirection; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE daily_winddirection IS 'This view restricts data values to the range: datavalue >= 0 and datavalue <= 360.  Sets the daily wind direction variableid=695.';


--
-- Name: daily_winddirectiondatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.daily_winddirectiondatavalues OWNER TO imiq;

--
-- Name: daily_winddirectiondatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_winddirectiondatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_winddirectiondatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_winddirectiondatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_winddirectiondatavalues_valueid_seq OWNED BY daily_winddirectiondatavalues.valueid;


--
-- Name: daily_windspeed; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.daily_windspeed OWNER TO imiq;

--
-- Name: TABLE daily_windspeed; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE daily_windspeed IS 'This view restricts the data values to the range: datavalue >= 0 and datavalue < 50.  Sets the daily wind speed variableid=696';


--
-- Name: daily_windspeeddatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.daily_windspeeddatavalues OWNER TO imiq;

--
-- Name: daily_windspeeddatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_windspeeddatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_windspeeddatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_windspeeddatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_windspeeddatavalues_valueid_seq OWNED BY daily_windspeeddatavalues.valueid;


--
-- Name: datastreams; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.datastreams OWNER TO imiq;

--
-- Name: TABLE datastreams; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE datastreams IS 'The datasteam assigns a variable to a station.  It also includes additional information that can be used for QA/QC on the data values for this station.';


--
-- Name: COLUMN datastreams.datastreamid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.datastreamid IS 'Primary key for Datastreams.';


--
-- Name: COLUMN datastreams.datastreamname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.datastreamname IS 'Name of the datastream.  Example: SiteName_VariableName';


--
-- Name: COLUMN datastreams.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.siteid IS 'Integer identifier that references the record in the Sites table.';


--
-- Name: COLUMN datastreams.variableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.variableid IS 'Integer identifier that references the record in the Variables table.';


--
-- Name: COLUMN datastreams.fieldname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.fieldname IS 'Name of the fieldname that is used in the data file.';


--
-- Name: COLUMN datastreams.deviceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.deviceid IS 'Integer identifier that references the record in the Devices table.';


--
-- Name: COLUMN datastreams.methodid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.methodid IS 'Integer identifier that references the record in the Methods table.';


--
-- Name: COLUMN datastreams.comments; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.comments IS 'Notes concerning datastream, such as flag or notes from data logger files.';


--
-- Name: COLUMN datastreams.qualitycontrollevelid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.qualitycontrollevelid IS 'Integer identifier that references the record in the QualityControlLevels table.';


--
-- Name: COLUMN datastreams.rangemin; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.rangemin IS 'The acceptable range minimum for the sensor. ';


--
-- Name: COLUMN datastreams.rangemax; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.rangemax IS 'The acceptable range maximum for the sensor';


--
-- Name: COLUMN datastreams.annualtiming; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.annualtiming IS 'Known range';


--
-- Name: COLUMN datastreams.downloaddate; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.downloaddate IS 'Date the dataset was downloaded or acquired';


--
-- Name: datastreams_datastreamid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE datastreams_datastreamid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.datastreams_datastreamid_seq OWNER TO imiq;

--
-- Name: datastreams_datastreamid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE datastreams_datastreamid_seq OWNED BY datastreams.datastreamid;


--
-- Name: datatypecv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.datatypecv OWNER TO imiq;

--
-- Name: TABLE datatypecv; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE datatypecv IS 'The DataTypeCV table contains the controlled vocabulary for data types. Only values from the Term field in this table can be used to populate the DataType field in the Variables table.';


--
-- Name: COLUMN datatypecv.term; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datatypecv.term IS 'Controlled vocabulary for DataType.';


--
-- Name: COLUMN datatypecv.definition; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datatypecv.definition IS 'Definition of DataType controlled vocabulary term. The definition is optional if the term is self explanatory.';


--
-- Name: datavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.datavalues OWNER TO imiq;

--
-- Name: TABLE datavalues; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE datavalues IS 'The DataValues table contains the actual data values.';


--
-- Name: COLUMN datavalues.valueid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.valueid IS 'Unique integer identifier for each data value.';


--
-- Name: COLUMN datavalues.datavalue; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.datavalue IS 'The numeric value of the observation. For Categorical variables, a number is stored here. The Variables table has DataType as Categorical and the Categories table maps from the DataValue onto Category Description.';


--
-- Name: COLUMN datavalues.valueaccuracy; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.valueaccuracy IS 'Numeric value that describes the measurement accuracy of the data value. If not given, it is interpreted as unknown.';


--
-- Name: COLUMN datavalues.localdatetime; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.localdatetime IS 'Local date and time at which the data value was observed. Represented in an implementation specific format.';


--
-- Name: COLUMN datavalues.utcoffset; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.utcoffset IS 'Offset in hours from UTC time of the corresponding LocalDateTime value.';


--
-- Name: COLUMN datavalues.qualifierid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.qualifierid IS 'Integer identifier that references the quality of the data in the Qualifiers table.';


--
-- Name: COLUMN datavalues.derivedfromid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.derivedfromid IS 'Integer identifier that references the derived data in the DerivedFrom table.';


--
-- Name: COLUMN datavalues.datastreamid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.datastreamid IS 'Integer identifier that references the datastream in the Datastreams table.';


--
-- Name: COLUMN datavalues.censorcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.censorcode IS 'Text indication of whether the data value is censored from the CensorCodeCV controlled vocabulary.';


--
-- Name: COLUMN datavalues.offsettypeid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.offsettypeid IS 'Foreign key OffsetTypes.  The reference point from which the offset to the measurement location was measured (e.g. water surface, stream bank, snow surface)';


--
-- Name: COLUMN datavalues.offsetvalue; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.offsetvalue IS 'Distance from a reference point to the location at which the observation was made (e.g. 5 meters below water surface)';


--
-- Name: COLUMN datavalues.categoryid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.categoryid IS 'FK to the Category table.  This field will contain a value if there is categorical data.';


--
-- Name: datavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE datavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.datavalues_valueid_seq OWNER TO imiq;

--
-- Name: datavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE datavalues_valueid_seq OWNED BY datavalues.valueid;


--
-- Name: datavaluesaggregate; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.datavaluesaggregate OWNER TO imiq;

--
-- Name: datavaluesraw; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.datavaluesraw OWNER TO imiq;

--
-- Name: datavaluesraw_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE datavaluesraw_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.datavaluesraw_valueid_seq OWNER TO imiq;

--
-- Name: datavaluesraw_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE datavaluesraw_valueid_seq OWNED BY datavaluesraw.valueid;


--
-- Name: derivedfrom; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.derivedfrom OWNER TO imiq;

--
-- Name: TABLE derivedfrom; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE derivedfrom IS 'The DerivedFrom table contains the linkage between derived data values and the data values that they were derived from.';


--
-- Name: COLUMN derivedfrom.derivedfromid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN derivedfrom.derivedfromid IS 'Integer identifying the group of data values from which a quantity is derived.';


--
-- Name: COLUMN derivedfrom.valueid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN derivedfrom.valueid IS 'Integer identifier referencing data values that comprise a group from which a quantity is derived. This corresponds to ValueID in the DataValues table.';


--
-- Name: devices; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.devices OWNER TO imiq;

--
-- Name: devices_deviceid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE devices_deviceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.devices_deviceid_seq OWNER TO imiq;

--
-- Name: devices_deviceid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE devices_deviceid_seq OWNED BY devices.deviceid;


--
-- Name: ext_arc_arc; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.ext_arc_arc OWNER TO imiq;

--
-- Name: ext_arc_arc_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_arc_arc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_arc_arc_id_seq OWNER TO imiq;

--
-- Name: ext_arc_arc_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_arc_arc_id_seq OWNED BY ext_arc_arc.id;


--
-- Name: ext_arc_point; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.ext_arc_point OWNER TO imiq;

--
-- Name: ext_arc_point_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_arc_point_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_arc_point_id_seq OWNER TO imiq;

--
-- Name: ext_arc_point_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_arc_point_id_seq OWNED BY ext_arc_point.id;


--
-- Name: ext_fws_fishsample; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.ext_fws_fishsample OWNER TO imiq;

--
-- Name: ext_fws_fishsample_fishsampleid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_fws_fishsample_fishsampleid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_fws_fishsample_fishsampleid_seq OWNER TO imiq;

--
-- Name: ext_fws_fishsample_fishsampleid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_fws_fishsample_fishsampleid_seq OWNED BY ext_fws_fishsample.fishsampleid;


--
-- Name: ext_reference; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.ext_reference OWNER TO imiq;

--
-- Name: ext_reference_referenceid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_reference_referenceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_reference_referenceid_seq OWNER TO imiq;

--
-- Name: ext_reference_referenceid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_reference_referenceid_seq OWNED BY ext_reference.referenceid;


--
-- Name: ext_referencetowaterbody; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.ext_referencetowaterbody OWNER TO imiq;

--
-- Name: ext_referencetowaterbody_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_referencetowaterbody_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_referencetowaterbody_id_seq OWNER TO imiq;

--
-- Name: ext_referencetowaterbody_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_referencetowaterbody_id_seq OWNED BY ext_referencetowaterbody.id;


--
-- Name: ext_waterbody; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.ext_waterbody OWNER TO imiq;

--
-- Name: ext_waterbody_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_waterbody_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_waterbody_id_seq OWNER TO imiq;

--
-- Name: ext_waterbody_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_waterbody_id_seq OWNED BY ext_waterbody.id;


--
-- Name: generalcategorycv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.generalcategorycv OWNER TO imiq;

--
-- Name: groupdescriptions; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.groupdescriptions OWNER TO imiq;

--
-- Name: TABLE groupdescriptions; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE groupdescriptions IS 'The GroupDescriptions table lists the descriptions for each of the groups of data values that have been formed.';


--
-- Name: COLUMN groupdescriptions.groupid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN groupdescriptions.groupid IS 'Unique integer identifier for each group of data values that has been formed. This also references to GroupID in the Groups table.';


--
-- Name: COLUMN groupdescriptions.groupdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN groupdescriptions.groupdescription IS 'Text description of the group.';


--
-- Name: groupdescriptions_groupid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE groupdescriptions_groupid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.groupdescriptions_groupid_seq OWNER TO imiq;

--
-- Name: groupdescriptions_groupid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE groupdescriptions_groupid_seq OWNED BY groupdescriptions.groupid;


--
-- Name: groups; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.groups OWNER TO imiq;

--
-- Name: TABLE groups; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE groups IS 'The Groups table lists the groups of data values that have been created and the data values that are within each group.';


--
-- Name: COLUMN groups.groupid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN groups.groupid IS 'Integer ID for each group of data values that has been formed.';


--
-- Name: COLUMN groups.valueid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN groups.valueid IS 'Integer identifier for each data value that belongs to a group. This corresponds to ValueID in the DataValues table';


--
-- Name: hourly_airtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_airtemp OWNER TO imiq;

--
-- Name: hourly_airtempdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_airtempdatavalues OWNER TO imiq;

--
-- Name: hourly_airtempdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_airtempdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_airtempdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_airtempdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_airtempdatavalues_valueid_seq OWNED BY hourly_airtempdatavalues.valueid;


--
-- Name: hourly_precip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.hourly_precip OWNER TO imiq;

--
-- Name: hourly_precipdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_precipdatavalues OWNER TO imiq;

--
-- Name: hourly_precipdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_precipdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_precipdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_precipdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_precipdatavalues_valueid_seq OWNED BY hourly_precipdatavalues.valueid;


--
-- Name: hourly_rh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.hourly_rh OWNER TO imiq;

--
-- Name: TABLE hourly_rh; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE hourly_rh IS 'This view restricts data values to the range: datavalue > 0 and datavalue <= 100.  Sets the hourly relative humidity variableid=679';


--
-- Name: hourly_rhdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_rhdatavalues OWNER TO imiq;

--
-- Name: hourly_rhdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_rhdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_rhdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_rhdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_rhdatavalues_valueid_seq OWNED BY hourly_rhdatavalues.valueid;


--
-- Name: hourly_snowdepth; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.hourly_snowdepth OWNER TO imiq;

--
-- Name: hourly_snowdepthdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_snowdepthdatavalues OWNER TO imiq;

--
-- Name: hourly_snowdepthdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_snowdepthdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_snowdepthdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_snowdepthdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_snowdepthdatavalues_valueid_seq OWNED BY hourly_snowdepthdatavalues.valueid;


--
-- Name: hourly_swe; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_swe OWNER TO imiq;

--
-- Name: hourly_swedatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_swedatavalues OWNER TO imiq;

--
-- Name: hourly_swedatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_swedatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_swedatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_swedatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_swedatavalues_valueid_seq OWNED BY hourly_swedatavalues.valueid;


--
-- Name: hourly_winddirection; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_winddirection OWNER TO imiq;

--
-- Name: TABLE hourly_winddirection; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE hourly_winddirection IS 'This view restricts data values to the range: datavalue >= 0 and datavalue <= 360.  Sets the hourly wind direction variableid=682';


--
-- Name: hourly_winddirectiondatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_winddirectiondatavalues OWNER TO imiq;

--
-- Name: hourly_winddirectiondatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_winddirectiondatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_winddirectiondatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_winddirectiondatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_winddirectiondatavalues_valueid_seq OWNED BY hourly_winddirectiondatavalues.valueid;


--
-- Name: hourly_windspeed; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.hourly_windspeed OWNER TO imiq;

--
-- Name: TABLE hourly_windspeed; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE hourly_windspeed IS 'This view restricts data values to the range: datavalue >= 0 and datavalue < 50.  Sets the hourly wind speed variableid=685';


--
-- Name: hourly_windspeeddatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.hourly_windspeeddatavalues OWNER TO imiq;

--
-- Name: hourly_windspeeddatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_windspeeddatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_windspeeddatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_windspeeddatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_windspeeddatavalues_valueid_seq OWNED BY hourly_windspeeddatavalues.valueid;


--
-- Name: imiqversion; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.imiqversion OWNER TO imiq;

--
-- Name: incidents; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.incidents OWNER TO imiq;

--
-- Name: TABLE incidents; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE incidents IS 'Lists natural or anthropogenic incidents, that may have affected a site, data values or an instruments ability to collect data.';


--
-- Name: COLUMN incidents.incidentid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.incidentid IS 'Unique integer ID for each incident.';


--
-- Name: COLUMN incidents.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.siteid IS 'Integer identifier that references the record in the Sites table.  Enter a SiteID only when incident is relevant to the site.';


--
-- Name: COLUMN incidents.datastreamid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.datastreamid IS 'Integer identifier that references the record in the Datastreams table.  Enter a DatastreamID only when the incident is relevant to a particular sensor.';


--
-- Name: COLUMN incidents.starttime; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.starttime IS 'When incident started -- note this does not refer to the measurement start time. ';


--
-- Name: COLUMN incidents.startprecision; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.startprecision IS 'Notes on how precise recorded incident start time is.';


--
-- Name: COLUMN incidents.endtime; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.endtime IS 'When incident ended -- note this does not necessarily refer to the measurement end time. ';


--
-- Name: COLUMN incidents.endprecision; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.endprecision IS 'Notes on how precise recorded incident start time is.';


--
-- Name: COLUMN incidents.type; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.type IS 'Type of incident that affected data collection or values. ';


--
-- Name: COLUMN incidents.description; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.description IS 'Detailed description of what happened (or what state equipment was found in" and what measurements may have been affected';


--
-- Name: COLUMN incidents.reportedby; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.reportedby IS 'Person who reported incident.';


--
-- Name: COLUMN incidents.comments; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.comments IS 'Comments on incident that are not covered elsewhere in the table. ';


--
-- Name: incidents_incidentid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE incidents_incidentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.incidents_incidentid_seq OWNER TO imiq;

--
-- Name: incidents_incidentid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE incidents_incidentid_seq OWNED BY incidents.incidentid;


--
-- Name: isometadata; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.isometadata OWNER TO imiq;

--
-- Name: TABLE isometadata; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE isometadata IS 'The ISOMetadata table contains dataset and project level metadata required by the CUAHSI HIS metadata system (http://www.cuahsi.org/his/documentation.html) for compliance with standards such as the draft ISO 19115 or ISO 8601. The mandatory fields in this table must be populated to provide a complete set of ISO compliant metadata in the database.';


--
-- Name: COLUMN isometadata.metadataid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.metadataid IS 'Unique integer ID for each metadata record.';


--
-- Name: COLUMN isometadata.topiccategory; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.topiccategory IS 'Topic category keyword that gives the broad ISO19115 metadata topic category for data from this source. The controlled vocabulary of topic category keywords is given in the TopicCategoryCV table.';


--
-- Name: COLUMN isometadata.title; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.title IS 'Title of data from a specific data source.';


--
-- Name: COLUMN isometadata.abstract; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.abstract IS 'Abstract of data from a specific data source.';


--
-- Name: COLUMN isometadata.profileversion; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.profileversion IS 'Name of metadata profile used by the data source';


--
-- Name: COLUMN isometadata.metadatalink; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.metadatalink IS 'Link to additional metadata reference material.';


--
-- Name: isometadata_metadataid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE isometadata_metadataid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.isometadata_metadataid_seq OWNER TO imiq;

--
-- Name: isometadata_metadataid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE isometadata_metadataid_seq OWNED BY isometadata.metadataid;


--
-- Name: methods; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.methods OWNER TO imiq;

--
-- Name: TABLE methods; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE methods IS 'The Methods table lists the methods used to collect the data and any additional information about the method.';


--
-- Name: COLUMN methods.methodid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN methods.methodid IS 'Unique integer ID for each method.';


--
-- Name: COLUMN methods.methodname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN methods.methodname IS 'Name of method used.';


--
-- Name: COLUMN methods.methoddescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN methods.methoddescription IS 'Description of each method.';


--
-- Name: COLUMN methods.methodlink; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN methods.methodlink IS 'Link to additional reference material on method.';


--
-- Name: methods_methodid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE methods_methodid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.methods_methodid_seq OWNER TO imiq;

--
-- Name: methods_methodid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE methods_methodid_seq OWNED BY methods.methodid;


--
-- Name: monthly_airtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.monthly_airtemp OWNER TO imiq;

--
-- Name: TABLE monthly_airtemp; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_airtemp IS 'This view creates "monthly_air temp" with the fields: valueid, datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets the monthly air temperature variableid=697 and originalvariableid=686.  ';


--
-- Name: monthly_airtemp_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.monthly_airtemp_all OWNER TO imiq;

--
-- Name: TABLE monthly_airtemp_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_airtemp_all IS 'This view creates monthly averages using "daily_airtemp".  Restricted to months with at least 10 days of data.';


--
-- Name: monthly_discharge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.monthly_discharge OWNER TO imiq;

--
-- Name: TABLE monthly_discharge; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_discharge IS 'This view creates "monthly_discharge" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=689 and variableid=700.';


--
-- Name: monthly_discharge_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.monthly_discharge_all OWNER TO imiq;

--
-- Name: TABLE monthly_discharge_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_discharge_all IS 'This view creates monthly averages using "daily_discharge".  Restricted to months with at least 10 days of data.';


--
-- Name: monthly_precip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.monthly_precip OWNER TO imiq;

--
-- Name: TABLE monthly_precip; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_precip IS 'This view creates "monthly_precip" with the fields: valueid, datavalue,siteid,utcdatetime,originalvariableid,variableid.  Sets the originalvariableid=690 and variableid=701';


--
-- Name: monthly_precip_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.monthly_precip_all OWNER TO imiq;

--
-- Name: TABLE monthly_precip_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_precip_all IS 'This view creates monthly totals using "daily_precip".  Restricted to months with at least 10 days of data.';


--
-- Name: monthly_rh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.monthly_rh OWNER TO imiq;

--
-- Name: TABLE monthly_rh; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_rh IS 'This view creates "monthly_rh" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=691 and variableid=707.';


--
-- Name: monthly_rh_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.monthly_rh_all OWNER TO imiq;

--
-- Name: monthly_snowdepthavg; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.monthly_snowdepthavg OWNER TO imiq;

--
-- Name: TABLE monthly_snowdepthavg; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_snowdepthavg IS 'This view creates "monthly_snowdepthavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=702';


--
-- Name: monthly_snowdepthavg_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.monthly_snowdepthavg_all OWNER TO imiq;

--
-- Name: TABLE monthly_snowdepthavg_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_snowdepthavg_all IS 'This view creates monthly averages using "daily_snowdepth".  Restricted to months with at least 1 day of data.';


--
-- Name: monthly_sweavg; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.monthly_sweavg OWNER TO imiq;

--
-- Name: TABLE monthly_sweavg; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_sweavg IS 'This view creates "monthly_sweavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=721';


--
-- Name: monthly_sweavg_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.monthly_sweavg_all OWNER TO imiq;

--
-- Name: TABLE monthly_sweavg_all; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE monthly_sweavg_all IS 'This view creates monthly averages using "daily_swe".  Restricted to months with at least 1 day or data.';


--
-- Name: multiyear_annual_all_avgairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgfallairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgfallairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgfallprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.multiyear_annual_all_avgfallprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgpeakdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgpeakdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgpeaksnowdepth; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgpeaksnowdepth OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgpeakswe; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgpeakswe OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.multiyear_annual_all_avgprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgrh OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgspringairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgspringairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgspringprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.multiyear_annual_all_avgspringprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgsummerairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgsummerairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgsummerdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.multiyear_annual_all_avgsummerdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgsummerprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgsummerprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgsummerrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.multiyear_annual_all_avgsummerrh OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgwinterairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.multiyear_annual_all_avgwinterairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgwinterprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.multiyear_annual_all_avgwinterprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgwinterrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_all_avgwinterrh OWNER TO imiq;

--
-- Name: multiyear_annual_avgairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_avgfallairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgfallairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgfallprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgfallprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgpeakdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.multiyear_annual_avgpeakdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_avgpeaksnowdepth; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgpeaksnowdepth OWNER TO imiq;

--
-- Name: multiyear_annual_avgpeakswe; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgpeakswe OWNER TO imiq;

--
-- Name: multiyear_annual_avgprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.multiyear_annual_avgprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgrh OWNER TO imiq;

--
-- Name: multiyear_annual_avgspringairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.multiyear_annual_avgspringairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgspringprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgspringprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgsummerairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgsummerairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgsummerdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgsummerdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_avgsummerprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgsummerprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgsummerrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.multiyear_annual_avgsummerrh OWNER TO imiq;

--
-- Name: multiyear_annual_avgwinterairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgwinterairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgwinterprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.multiyear_annual_avgwinterprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgwinterrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.multiyear_annual_avgwinterrh OWNER TO imiq;

--
-- Name: networkdescriptions; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.networkdescriptions OWNER TO imiq;

--
-- Name: COLUMN networkdescriptions.networkid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN networkdescriptions.networkid IS 'Unique integer identifier that identifies a network.';


--
-- Name: COLUMN networkdescriptions.networkcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN networkdescriptions.networkcode IS 'Network code used by organization that collects the data.';


--
-- Name: COLUMN networkdescriptions.networkdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN networkdescriptions.networkdescription IS 'Full text description of the network.';


--
-- Name: nhd_huc8; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.nhd_huc8 OWNER TO imiq;

--
-- Name: nhd_huc8_id_seq1; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE nhd_huc8_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.nhd_huc8_id_seq1 OWNER TO imiq;

--
-- Name: nhd_huc8_id_seq1; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE nhd_huc8_id_seq1 OWNED BY nhd_huc8.id;


--
-- Name: sites; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.sites OWNER TO imiq;

--
-- Name: TABLE sites; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE sites IS 'The Sites table provides information giving the spatial location at which data values have been collected.';


--
-- Name: COLUMN sites.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.siteid IS 'Unique identifier for each sampling location.';


--
-- Name: COLUMN sites.sitecode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.sitecode IS 'Code used by organization that collects the data to identify the site';


--
-- Name: COLUMN sites.sitename; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.sitename IS 'Full name of the sampling site.';


--
-- Name: COLUMN sites.spatialcharacteristics; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.spatialcharacteristics IS 'Indicates whether site is a point, polygon, linestring.';


--
-- Name: COLUMN sites.sourceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.sourceid IS 'Integer identifier that references the record in the Sources table giving the source of the data value.';


--
-- Name: COLUMN sites.verticaldatum; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.verticaldatum IS 'Vertical datum of the elevation. Controlled Vocabulary from V erticalDatumCV .';


--
-- Name: COLUMN sites.localprojectionid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.localprojectionid IS 'Identifier that references the Spatial Reference System of the local coordinates in the SpatialReferences table. This field is required if local coordinates are given.';


--
-- Name: COLUMN sites.posaccuracy_m; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.posaccuracy_m IS 'Value giving the accuracy with which the positional information is specified in meters.';


--
-- Name: COLUMN sites.state; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.state IS 'Name of state in which the monitoring site is located.';


--
-- Name: COLUMN sites.county; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.county IS 'Name of county in which the monitoring site is located.';


--
-- Name: COLUMN sites.comments; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.comments IS 'Comments related to the site.';


--
-- Name: COLUMN sites.latlongdatumid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.latlongdatumid IS 'Identifier that references the Spatial Reference System of the latitude and longitude coordinates in the SpatialReferences table.';


--
-- Name: COLUMN sites.geolocation; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.geolocation IS 'Coordinates and elevation given in a specific format for points and polygons.  Latitude and Longitude should be in decimal degrees. Elevation is in meters. If elevation is not provided it can be obtained programmatically from a DEM based on location information. Point locations are stored as "Point (long lat elevation)".  The following is an example for a polygon: 
POLYGON (-146.34425083697045 69.688296227508985, -146.34308827446938 69.688355477509049,...) 
';


--
-- Name: COLUMN sites.locationdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.locationdescription IS 'Description of site location';


--
-- Name: COLUMN sites.updated_at; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.updated_at IS 'The timestamp that the record was last updated.';


--
-- Name: variables; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.variables OWNER TO imiq;

--
-- Name: TABLE variables; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE variables IS 'The Variables table lists the full descriptive information about what variables have been measured.';


--
-- Name: COLUMN variables.variableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variableid IS 'Unique integer identifier for each variable.';


--
-- Name: COLUMN variables.variablecode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variablecode IS 'Text code used by the organization that collects the data to identify the variable.';


--
-- Name: COLUMN variables.variablename; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variablename IS 'Full text name of the variable that was measured, observed, modeled, etc. This should be from the VariableNameCV controlled vocabulary table.';


--
-- Name: COLUMN variables.variabledescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variabledescription IS 'A description of the variable';


--
-- Name: COLUMN variables.speciation; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.speciation IS 'Text code used to identify how the data value is expressed (i.e., total phosphorus concentration expressed as P). This should be from the SpeciationCV controlled vocabulary table.';


--
-- Name: COLUMN variables.variableunitsid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variableunitsid IS 'Integer identifier that references the record in the Units table giving the units of the data values associated with the variable.';


--
-- Name: COLUMN variables.samplemedium; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.samplemedium IS 'The medium in which the sample or observation was taken or made. This should be from the SampleMediumCV controlled vocabulary table.';


--
-- Name: COLUMN variables.valuetype; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.valuetype IS 'Text value indicating what type of data value is being recorded. This should be from the ValueTypeCV controlled vocabulary table.';


--
-- Name: COLUMN variables.isregular; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.isregular IS 'Value that indicates whether the data values are from a regularly sampled time series.';


--
-- Name: COLUMN variables.timesupport; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.timesupport IS 'Numerical value that indicates the time support (or temporal footprint) of the data values. 0 is used to indicate data values that are instantaneous. Other values indicate the time over which the data values are implicitly or explicitly averaged or aggregated.';


--
-- Name: COLUMN variables.timeunitsid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.timeunitsid IS 'Integer identifier that references the record in the Units table giving the Units of the time support. If TimeSupport is 0, indicating an instantaneous observation, a unit needs to still be given for completeness, although it is somewhat arbitrary.';


--
-- Name: COLUMN variables.datatype; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.datatype IS 'Text value that identifies the data values as one of several types from the DataTypeCV controlled vocabulary table.';


--
-- Name: COLUMN variables.generalcategory; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.generalcategory IS 'General category of the data values from the GeneralCategoryCV controlled vocabulary table.';


--
-- Name: COLUMN variables.nodatavalue; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.nodatavalue IS 'Numeric value used to encode no data values for this variable.';


--
-- Name: odmdatavalues_metric; Type: VIEW; Schema: tables; Owner: imiq
--

CREATE VIEW odmdatavalues_metric AS
 SELECT v.valueid,
    v.datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    va.variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE (va.variableunitsid = ANY (ARRAY[1, 2, 33, 36, 39, 47, 52, 54, 80, 86, 90, 96, 116, 119, 121, 137, 143, 168, 170, 181, 188, 192, 198, 199, 205, 221, 254, 258, 304, 309, 310, 331, 332, 333, 335, 336]))
UNION ALL
 SELECT v.valueid,
    ((v.datavalue - (32)::double precision) * (0.555555556)::double precision) AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    96 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE (va.variableunitsid = 97)
UNION ALL
 SELECT v.valueid,
    (v.datavalue * (25.4)::double precision) AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    54 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE ((va.variableunitsid = 49) AND (((lower((va.variablename)::text) ~~ '%precipitation%'::text) OR (lower((va.variablename)::text) ~~ '%snow water equivalent%'::text)) OR (lower((va.variablename)::text) ~~ '%snowfall%'::text)))
UNION ALL
 SELECT v.valueid,
    (v.datavalue * (0.0254)::double precision) AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    52 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE ((va.variableunitsid = 49) AND (lower((va.variablename)::text) ~~ '%snow depth%'::text))
UNION ALL
 SELECT v.valueid,
    (v.datavalue * (0.02832)::double precision) AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    36 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE ((va.variableunitsid = 35) AND (lower((va.variablename)::text) ~~ '%discharge%'::text))
UNION ALL
 SELECT v.valueid,
    (v.datavalue * (0.44704)::double precision) AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    119 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE ((va.variableunitsid = 120) AND (lower((va.variablename)::text) ~~ '%wind speed%'::text))
UNION ALL
 SELECT v.valueid,
    (v.datavalue * (697.8)::double precision) AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    33 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE ((va.variableunitsid = 29) AND (lower((va.variablename)::text) ~~ '%radiation%'::text))
UNION ALL
 SELECT v.valueid,
    (v.datavalue * (0.3048)::double precision) AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    52 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE ((va.variableunitsid = 48) AND (((((((lower((va.variablename)::text) ~~ '%gage height%'::text) OR (lower((va.variablename)::text) ~~ '%water depth%'::text)) OR (lower((va.variablename)::text) ~~ '%distance%'::text)) OR (lower((va.variablename)::text) ~~ '%ice thickness%'::text)) OR (lower((va.variablename)::text) ~~ '%free board%'::text)) OR (lower((va.variablename)::text) ~~ '%luminescent dissolved oxygen%'::text)) OR (lower((va.variablename)::text) ~~ '%snow depth%'::text)))
UNION ALL
 SELECT v.valueid,
    (v.datavalue * (1233.48183754752)::double precision) AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    126 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE ((va.variableunitsid = 48) AND (lower((va.variablename)::text) ~~ '%volume%'::text))
UNION ALL
 SELECT v.valueid,
    v.datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    (v.localdatetime + '-09:00:00'::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    90 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    public.st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM (((datavalues v
     JOIN datastreams d ON ((d.datastreamid = v.datastreamid)))
     JOIN sites s ON ((d.siteid = s.siteid)))
     JOIN variables va ON ((d.variableid = va.variableid)))
  WHERE ((va.variableunitsid = 315) AND (((lower((va.variablename)::text) ~~ '%sea level pressure%'::text) OR (lower((va.variablename)::text) ~~ '%altimeter setting rate%'::text)) OR (lower((va.variablename)::text) ~~ '%barometric pressure%'::text)))
  GROUP BY v.valueid, v.datavalue, v.valueaccuracy, v.localdatetime, v.utcoffset, d.siteid, va.variableid, va.variablename, va.samplemedium, va.variableunitsid, va.timeunitsid, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, s.geolocation, s.spatialcharacteristics;


ALTER TABLE tables.odmdatavalues_metric OWNER TO imiq;

--
-- Name: VIEW odmdatavalues_metric; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON VIEW odmdatavalues_metric IS 'This view creates recreates the odm version of the datavalues table with all metric units.';


--
-- Name: offsettypes; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.offsettypes OWNER TO imiq;

--
-- Name: TABLE offsettypes; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE offsettypes IS 'The OffsetTypes table lists full descriptive information for each of the measurement offsets.';


--
-- Name: COLUMN offsettypes.offsettypeid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN offsettypes.offsettypeid IS 'Unique integer identifier that identifies the type of measurement offset.';


--
-- Name: COLUMN offsettypes.offsetunitsid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN offsettypes.offsetunitsid IS 'Integer identifier that references the record in the Units table giving the Units of the OffsetValue.';


--
-- Name: COLUMN offsettypes.offsetdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN offsettypes.offsetdescription IS 'Full text description of the offset type.';


--
-- Name: offsettypes_offsettypeid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE offsettypes_offsettypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.offsettypes_offsettypeid_seq OWNER TO imiq;

--
-- Name: offsettypes_offsettypeid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE offsettypes_offsettypeid_seq OWNED BY offsettypes.offsettypeid;


--
-- Name: organizationdescriptions; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.organizationdescriptions OWNER TO imiq;

--
-- Name: TABLE organizationdescriptions; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE organizationdescriptions IS 'Organizations, which are associated with Sources.';


--
-- Name: COLUMN organizationdescriptions.organizationid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizationdescriptions.organizationid IS 'Unique integer identifier that identifies an organization.';


--
-- Name: COLUMN organizationdescriptions.organizationcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizationdescriptions.organizationcode IS 'Organization code used by organization that collects the data.';


--
-- Name: COLUMN organizationdescriptions.organizationdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizationdescriptions.organizationdescription IS 'Full text description of the organization.';


--
-- Name: organizations; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.organizations OWNER TO imiq;

--
-- Name: TABLE organizations; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE organizations IS 'Shows associations of a data source with multiple organizations. ';


--
-- Name: COLUMN organizations.organizationid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizations.organizationid IS 'Integer identifier that references the record in the OrganizationDescriptions table.';


--
-- Name: COLUMN organizations.sourceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizations.sourceid IS 'Integer identifier that references the record in the Sources table.';


--
-- Name: processing; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.processing OWNER TO imiq;

--
-- Name: TABLE processing; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE processing IS 'The Processing table lists Qa/Qc that was done to the Sources, ISOMetadata and Sites tables.  It also lists any known data restrictions, priority of data entry and processing needs that need to be done.';


--
-- Name: COLUMN processing.processingid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.processingid IS 'Unique integer ID for each processing event.';


--
-- Name: COLUMN processing.sourceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.sourceid IS 'Integer identifier that references the record in the Sources table.';


--
-- Name: COLUMN processing.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.siteid IS 'Integer identifier that references the record in the Sites table.';


--
-- Name: COLUMN processing.metadataid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.metadataid IS 'Integer identifier that references the record in the ISOMetadata table.';


--
-- Name: COLUMN processing.datarestrictions; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.datarestrictions IS 'Any known restrictions on data ';


--
-- Name: COLUMN processing.datapriority; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.datapriority IS 'Priority level for data entry.';


--
-- Name: COLUMN processing.processingneeds; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.processingneeds IS 'What needs to be done to get the data entered';


--
-- Name: COLUMN processing.qaqcperson; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.qaqcperson IS 'Name of database team member who has performed the QaQc on a Sources, ISOMetadata or Sites record.';


--
-- Name: COLUMN processing.qaqccomments; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.qaqccomments IS 'Processing comments for QaQc data.  ';


--
-- Name: COLUMN processing.qaqcdate; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.qaqcdate IS 'Date that QaQc was performed.';


--
-- Name: processing_processingid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE processing_processingid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.processing_processingid_seq OWNER TO imiq;

--
-- Name: processing_processingid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE processing_processingid_seq OWNED BY processing.processingid;


--
-- Name: qualifiers; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.qualifiers OWNER TO imiq;

--
-- Name: TABLE qualifiers; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE qualifiers IS 'The Qualifiers table contains data qualifying comments that accompany the data.';


--
-- Name: COLUMN qualifiers.qualifierid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualifiers.qualifierid IS 'Unique integer identifying the data qualifier.';


--
-- Name: COLUMN qualifiers.qualifiercode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualifiers.qualifiercode IS 'Text code used by organization that collects the data.';


--
-- Name: COLUMN qualifiers.qualifierdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualifiers.qualifierdescription IS 'Text of the data qualifying comment.';


--
-- Name: qualifiers_qualifierid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE qualifiers_qualifierid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.qualifiers_qualifierid_seq OWNER TO imiq;

--
-- Name: qualifiers_qualifierid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE qualifiers_qualifierid_seq OWNED BY qualifiers.qualifierid;


--
-- Name: qualitycontrollevels; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.qualitycontrollevels OWNER TO imiq;

--
-- Name: TABLE qualitycontrollevels; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE qualitycontrollevels IS 'The QualityControlLevels table contains the quality control levels that are used for versioning data within the database.';


--
-- Name: COLUMN qualitycontrollevels.qualitycontrollevelid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualitycontrollevels.qualitycontrollevelid IS 'Unique integer identifying the quality control level.';


--
-- Name: COLUMN qualitycontrollevels.qualitycontrollevelcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualitycontrollevels.qualitycontrollevelcode IS 'Code used to identify the level of quality control to which data values have been subjected.';


--
-- Name: COLUMN qualitycontrollevels.definition; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualitycontrollevels.definition IS 'Definition of Quality Control Level.';


--
-- Name: COLUMN qualitycontrollevels.explanation; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualitycontrollevels.explanation IS 'Explanation of Quality Control Level';


--
-- Name: qualitycontrollevels_qualitycontrollevelid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE qualitycontrollevels_qualitycontrollevelid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.qualitycontrollevels_qualitycontrollevelid_seq OWNER TO imiq;

--
-- Name: qualitycontrollevels_qualitycontrollevelid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE qualitycontrollevels_qualitycontrollevelid_seq OWNED BY qualitycontrollevels.qualitycontrollevelid;


--
-- Name: rasterdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.rasterdatavalues OWNER TO imiq;

--
-- Name: rasterdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE rasterdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.rasterdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: rasterdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE rasterdatavalues_valueid_seq OWNED BY rasterdatavalues.valueid;


--
-- Name: samplemediumcv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.samplemediumcv OWNER TO imiq;

--
-- Name: seriescatalog; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.seriescatalog OWNER TO imiq;

--
-- Name: siteattributes; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.siteattributes OWNER TO imiq;

--
-- Name: TABLE siteattributes; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE siteattributes IS 'Lists site data values that are non-numeric.';


--
-- Name: COLUMN siteattributes.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN siteattributes.siteid IS 'Integer identifier that references the record in the Sites table.';


--
-- Name: COLUMN siteattributes.attributeid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN siteattributes.attributeid IS 'Integer identifier that references the record in the Attributes table.';


--
-- Name: COLUMN siteattributes.attributevalue; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN siteattributes.attributevalue IS 'The non-numeric data value';


--
-- Name: COLUMN siteattributes.attributecomment; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN siteattributes.attributecomment IS 'Attribute comment.';


--
-- Name: sites_siteid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE sites_siteid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.sites_siteid_seq OWNER TO imiq;

--
-- Name: sites_siteid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE sites_siteid_seq OWNED BY sites.siteid;


--
-- Name: sources; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--



ALTER TABLE tables.sources OWNER TO imiq;

--
-- Name: TABLE sources; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE sources IS 'The Sources table lists the original sources of the data, providing information sufficient to retrieve and reconstruct the data value from the original data files if necessary.';


--
-- Name: COLUMN sources.sourceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.sourceid IS 'Unique integer identifier that identifies each data source.';


--
-- Name: COLUMN sources.organization; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.organization IS 'Name of the organization that collected the data. This should be the agency or organization that collected the data, even if it came out of a database consolidated from many sources such as STORET.';


--
-- Name: COLUMN sources.sourcedescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.sourcedescription IS 'Full text description of the source of the data.';


--
-- Name: COLUMN sources.sourcerole; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.sourcerole IS 'If the source is an originator or publisher of data';


--
-- Name: COLUMN sources.sourcelink; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.sourcelink IS 'Link that can be pointed at the original data file and/or associated metadata stored in the digital library or URL of data source.';


--
-- Name: COLUMN sources.contactname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.contactname IS 'Name of the contact person for the data source.';


--
-- Name: COLUMN sources.phone; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.phone IS 'Phone number for the contact person.';


--
-- Name: COLUMN sources.email; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.email IS 'Email address for the contact person.';


--
-- Name: COLUMN sources.address; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.address IS 'Street address for the contact person.';


--
-- Name: COLUMN sources.city; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.city IS 'City in which the contact person is located.';


--
-- Name: COLUMN sources.state; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.state IS 'State in which the contact person is located. Use two letter abbreviations for US. For other countries give the full country name.';


--
-- Name: COLUMN sources.zipcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.zipcode IS 'US Zip Code or country postal code.';


--
-- Name: COLUMN sources.citation; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.citation IS 'Text string that give the citation to be used when the data from each source are referenced.';


--
-- Name: COLUMN sources.metadataid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.metadataid IS 'Integer identifier referencing the record in the ISOMetadata table for this source.';


--
-- Name: COLUMN sources.updated_at; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.updated_at IS 'The timestamp the source was last updated';


--
-- Name: sources_sourceid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE sources_sourceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.sources_sourceid_seq OWNER TO imiq;

--
-- Name: sources_sourceid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE sources_sourceid_seq OWNED BY sources.sourceid;


--
-- Name: spatialreferences; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.spatialreferences OWNER TO imiq;

--
-- Name: spatialreferences_spatialreferenceid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE spatialreferences_spatialreferenceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.spatialreferences_spatialreferenceid_seq OWNER TO imiq;

--
-- Name: spatialreferences_spatialreferenceid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE spatialreferences_spatialreferenceid_seq OWNED BY spatialreferences.spatialreferenceid;


--
-- Name: speciationcv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.speciationcv OWNER TO imiq;

--
-- Name: sysdiagrams; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.sysdiagrams OWNER TO imiq;

--
-- Name: sysdiagrams_diagram_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE sysdiagrams_diagram_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.sysdiagrams_diagram_id_seq OWNER TO imiq;

--
-- Name: sysdiagrams_diagram_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE sysdiagrams_diagram_id_seq OWNED BY sysdiagrams.diagram_id;


--
-- Name: topiccategorycv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.topiccategorycv OWNER TO imiq;

--
-- Name: units; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.units OWNER TO imiq;

--
-- Name: units_unitsid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE units_unitsid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.units_unitsid_seq OWNER TO imiq;

--
-- Name: units_unitsid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE units_unitsid_seq OWNED BY units.unitsid;


--
-- Name: valuetypecv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.valuetypecv OWNER TO imiq;

--
-- Name: variablenamecv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE tables.variablenamecv OWNER TO imiq;

--
-- Name: variables_variableid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE variables_variableid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.variables_variableid_seq OWNER TO imiq;

--
-- Name: variables_variableid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE variables_variableid_seq OWNED BY variables.variableid;


--
-- Name: verticaldatumcv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--


ALTER TABLE tables.verticaldatumcv OWNER TO imiq;

SET search_path = views, pg_catalog;

--
-- Name: odmdatavalues; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--



ALTER TABLE views.odmdatavalues OWNER TO imiq;

SET search_path = tables, pg_catalog;

--
-- Name: attributeid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY attributes ALTER COLUMN attributeid SET DEFAULT nextval('attributes_attributeid_seq'::regclass);


--
-- Name: categoryid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY categories ALTER COLUMN categoryid SET DEFAULT nextval('categories_categoryid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_airtempdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_airtempdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_airtempmaxdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_airtempmaxdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_airtempmindatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_airtempmindatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_dischargedatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_dischargedatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_precipdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_precipdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_rhdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_rhdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_snowdepthdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_snowdepthdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_swedatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_swedatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_watertempdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_watertempdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_winddirectiondatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_winddirectiondatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_windspeeddatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_windspeeddatavalues_valueid_seq'::regclass);


--
-- Name: datastreamid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datastreams ALTER COLUMN datastreamid SET DEFAULT nextval('datastreams_datastreamid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavalues ALTER COLUMN valueid SET DEFAULT nextval('datavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavaluesraw ALTER COLUMN valueid SET DEFAULT nextval('datavaluesraw_valueid_seq'::regclass);


--
-- Name: deviceid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY devices ALTER COLUMN deviceid SET DEFAULT nextval('devices_deviceid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_arc_arc ALTER COLUMN id SET DEFAULT nextval('ext_arc_arc_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_arc_point ALTER COLUMN id SET DEFAULT nextval('ext_arc_point_id_seq'::regclass);


--
-- Name: fishsampleid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_fws_fishsample ALTER COLUMN fishsampleid SET DEFAULT nextval('ext_fws_fishsample_fishsampleid_seq'::regclass);


--
-- Name: referenceid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_reference ALTER COLUMN referenceid SET DEFAULT nextval('ext_reference_referenceid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_referencetowaterbody ALTER COLUMN id SET DEFAULT nextval('ext_referencetowaterbody_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_waterbody ALTER COLUMN id SET DEFAULT nextval('ext_waterbody_id_seq'::regclass);


--
-- Name: groupid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY groupdescriptions ALTER COLUMN groupid SET DEFAULT nextval('groupdescriptions_groupid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_airtempdatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_airtempdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_precipdatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_precipdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_rhdatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_rhdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_snowdepthdatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_snowdepthdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_swedatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_swedatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_winddirectiondatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_winddirectiondatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_windspeeddatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_windspeeddatavalues_valueid_seq'::regclass);


--
-- Name: incidentid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY incidents ALTER COLUMN incidentid SET DEFAULT nextval('incidents_incidentid_seq'::regclass);


--
-- Name: metadataid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY isometadata ALTER COLUMN metadataid SET DEFAULT nextval('isometadata_metadataid_seq'::regclass);


--
-- Name: methodid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY methods ALTER COLUMN methodid SET DEFAULT nextval('methods_methodid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY nhd_huc8 ALTER COLUMN id SET DEFAULT nextval('nhd_huc8_id_seq1'::regclass);


--
-- Name: offsettypeid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY offsettypes ALTER COLUMN offsettypeid SET DEFAULT nextval('offsettypes_offsettypeid_seq'::regclass);


--
-- Name: processingid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY processing ALTER COLUMN processingid SET DEFAULT nextval('processing_processingid_seq'::regclass);


--
-- Name: qualifierid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY qualifiers ALTER COLUMN qualifierid SET DEFAULT nextval('qualifiers_qualifierid_seq'::regclass);


--
-- Name: qualitycontrollevelid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY qualitycontrollevels ALTER COLUMN qualitycontrollevelid SET DEFAULT nextval('qualitycontrollevels_qualitycontrollevelid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY rasterdatavalues ALTER COLUMN valueid SET DEFAULT nextval('rasterdatavalues_valueid_seq'::regclass);


--
-- Name: siteid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sites ALTER COLUMN siteid SET DEFAULT nextval('sites_siteid_seq'::regclass);


--
-- Name: sourceid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sources ALTER COLUMN sourceid SET DEFAULT nextval('sources_sourceid_seq'::regclass);


--
-- Name: spatialreferenceid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY spatialreferences ALTER COLUMN spatialreferenceid SET DEFAULT nextval('spatialreferences_spatialreferenceid_seq'::regclass);


--
-- Name: diagram_id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sysdiagrams ALTER COLUMN diagram_id SET DEFAULT nextval('sysdiagrams_diagram_id_seq'::regclass);


--
-- Name: unitsid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY units ALTER COLUMN unitsid SET DEFAULT nextval('units_unitsid_seq'::regclass);


--
-- Name: variableid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables ALTER COLUMN variableid SET DEFAULT nextval('variables_variableid_seq'::regclass);


--
-- Name: _15min_watertemp_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY _15min_watertemp
    ADD CONSTRAINT _15min_watertemp_valueid PRIMARY KEY (valueid);


--
-- Name: adaily_rh_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_rh
    ADD CONSTRAINT adaily_rh_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgairtemptwo_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgairtemp
    ADD CONSTRAINT annual_avgairtemptwo_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgdischarge_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgdischarge
    ADD CONSTRAINT annual_avgdischarge_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgfallairtemp_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgfallairtemp
    ADD CONSTRAINT annual_avgfallairtemp_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgfallprecip_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgfallprecip
    ADD CONSTRAINT annual_avgfallprecip_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgrh_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgrh
    ADD CONSTRAINT annual_avgrh_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgspringairtemp_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgspringairtemp
    ADD CONSTRAINT annual_avgspringairtemp_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgspringprecip_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgspringprecip
    ADD CONSTRAINT annual_avgspringprecip_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgsummerairtemp_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgsummerairtemp
    ADD CONSTRAINT annual_avgsummerairtemp_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgsummerdischarge_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgsummerdischarge
    ADD CONSTRAINT annual_avgsummerdischarge_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgsummerprecip_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgsummerprecip
    ADD CONSTRAINT annual_avgsummerprecip_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgsummerrh_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgsummerrh
    ADD CONSTRAINT annual_avgsummerrh_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgwinterairtemp_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgwinterairtemp
    ADD CONSTRAINT annual_avgwinterairtemp_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgwinterprecip_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgwinterprecip
    ADD CONSTRAINT annual_avgwinterprecip_valueid PRIMARY KEY (valueid);


--
-- Name: annual_avgwinterrh_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgwinterrh
    ADD CONSTRAINT annual_avgwinterrh_valueid PRIMARY KEY (valueid);


--
-- Name: annual_peakdischarge_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_peakdischarge
    ADD CONSTRAINT annual_peakdischarge_valueid PRIMARY KEY (valueid);


--
-- Name: annual_peaksnowdepth_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_peaksnowdepth
    ADD CONSTRAINT annual_peaksnowdepth_valueid PRIMARY KEY (valueid);


--
-- Name: annual_peakswe_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_peakswe
    ADD CONSTRAINT annual_peakswe_valueid PRIMARY KEY (valueid);


--
-- Name: annual_totalprecip_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_totalprecip
    ADD CONSTRAINT annual_totalprecip_valueid PRIMARY KEY (valueid);


--
-- Name: attributes_attributeid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY attributes
    ADD CONSTRAINT attributes_attributeid PRIMARY KEY (attributeid);


--
-- Name: categories_categoryid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_categoryid PRIMARY KEY (categoryid);


--
-- Name: censorcodecv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY censorcodecv
    ADD CONSTRAINT censorcodecv_term PRIMARY KEY (term);


--
-- Name: daily_airtemp_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtemp
    ADD CONSTRAINT daily_airtemp_valueid PRIMARY KEY (valueid);


--
-- Name: daily_airtempdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempdatavalues
    ADD CONSTRAINT daily_airtempdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_airtempmax_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempmax
    ADD CONSTRAINT daily_airtempmax_valueid PRIMARY KEY (valueid);


--
-- Name: daily_airtempmaxdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempmaxdatavalues
    ADD CONSTRAINT daily_airtempmaxdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_airtempmin_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempmin
    ADD CONSTRAINT daily_airtempmin_valueid PRIMARY KEY (valueid);


--
-- Name: daily_airtempmindatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempmindatavalues
    ADD CONSTRAINT daily_airtempmindatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_discharge_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_discharge
    ADD CONSTRAINT daily_discharge_valueid PRIMARY KEY (valueid);


--
-- Name: daily_dischargedatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_dischargedatavalues
    ADD CONSTRAINT daily_dischargedatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_precip_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_precip
    ADD CONSTRAINT daily_precip_pkey PRIMARY KEY (valueid);


--
-- Name: daily_precipdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_precipdatavalues
    ADD CONSTRAINT daily_precipdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_rhdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_rhdatavalues
    ADD CONSTRAINT daily_rhdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_snowdepth_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_snowdepth
    ADD CONSTRAINT daily_snowdepth_pkey PRIMARY KEY (valueid);


--
-- Name: daily_snowdepthdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_snowdepthdatavalues
    ADD CONSTRAINT daily_snowdepthdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_swe_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_swe
    ADD CONSTRAINT daily_swe_pkey PRIMARY KEY (valueid);


--
-- Name: daily_swedatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_swedatavalues
    ADD CONSTRAINT daily_swedatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_watertemp_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_watertemp
    ADD CONSTRAINT daily_watertemp_valueid PRIMARY KEY (valueid);


--
-- Name: daily_watertempdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_watertempdatavalues
    ADD CONSTRAINT daily_watertempdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_winddirection_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_winddirection
    ADD CONSTRAINT daily_winddirection_valueid PRIMARY KEY (valueid);


--
-- Name: daily_winddirectiondatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_winddirectiondatavalues
    ADD CONSTRAINT daily_winddirectiondatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_windspeed_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_windspeed
    ADD CONSTRAINT daily_windspeed_valueid PRIMARY KEY (valueid);


--
-- Name: daily_windspeeddatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_windspeeddatavalues
    ADD CONSTRAINT daily_windspeeddatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: datastreams_datastreamid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY datastreams
    ADD CONSTRAINT datastreams_datastreamid PRIMARY KEY (datastreamid);


--
-- Name: datatypecv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY datatypecv
    ADD CONSTRAINT datatypecv_term PRIMARY KEY (term);


--
-- Name: datavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY datavalues
    ADD CONSTRAINT datavalues_valueid PRIMARY KEY (valueid);


--
-- Name: datavaluesraw_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY datavaluesraw
    ADD CONSTRAINT datavaluesraw_valueid PRIMARY KEY (valueid);


--
-- Name: derivedfrom_derivedfromid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY derivedfrom
    ADD CONSTRAINT derivedfrom_derivedfromid PRIMARY KEY (derivedfromid);


--
-- Name: devices_deviceid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_deviceid PRIMARY KEY (deviceid);


--
-- Name: ext_arc_arc_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_arc_arc
    ADD CONSTRAINT ext_arc_arc_id PRIMARY KEY (id);


--
-- Name: ext_arc_point_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_arc_point
    ADD CONSTRAINT ext_arc_point_id PRIMARY KEY (id);


--
-- Name: ext_fws_fishsample_fishsampleid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_fws_fishsample
    ADD CONSTRAINT ext_fws_fishsample_fishsampleid PRIMARY KEY (fishsampleid);


--
-- Name: ext_reference_referenceid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_reference
    ADD CONSTRAINT ext_reference_referenceid PRIMARY KEY (referenceid);


--
-- Name: ext_referencetowaterbody_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_referencetowaterbody
    ADD CONSTRAINT ext_referencetowaterbody_id PRIMARY KEY (id);


--
-- Name: ext_waterbody_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_waterbody
    ADD CONSTRAINT ext_waterbody_id PRIMARY KEY (id);


--
-- Name: generalcategorycv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY generalcategorycv
    ADD CONSTRAINT generalcategorycv_term PRIMARY KEY (term);


--
-- Name: groupdescriptions_groupid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY groupdescriptions
    ADD CONSTRAINT groupdescriptions_groupid PRIMARY KEY (groupid);


--
-- Name: hourly_airtemp_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_airtemp
    ADD CONSTRAINT hourly_airtemp_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_airtempdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_airtempdatavalues
    ADD CONSTRAINT hourly_airtempdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_precip_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_precip
    ADD CONSTRAINT hourly_precip_pkey PRIMARY KEY (valueid);


--
-- Name: hourly_precipdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_precipdatavalues
    ADD CONSTRAINT hourly_precipdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_rh_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_rh
    ADD CONSTRAINT hourly_rh_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_rhdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_rhdatavalues
    ADD CONSTRAINT hourly_rhdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_snowdepth_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_snowdepth
    ADD CONSTRAINT hourly_snowdepth_pkey PRIMARY KEY (valueid);


--
-- Name: hourly_snowdepthdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_snowdepthdatavalues
    ADD CONSTRAINT hourly_snowdepthdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_swe_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_swe
    ADD CONSTRAINT hourly_swe_pkey PRIMARY KEY (valueid);


--
-- Name: hourly_swedatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_swedatavalues
    ADD CONSTRAINT hourly_swedatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_winddirection_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_winddirection
    ADD CONSTRAINT hourly_winddirection_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_winddirectiondatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_winddirectiondatavalues
    ADD CONSTRAINT hourly_winddirectiondatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_windspeed_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_windspeed
    ADD CONSTRAINT hourly_windspeed_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_windspeeddatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_windspeeddatavalues
    ADD CONSTRAINT hourly_windspeeddatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: incidents_incidentid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_incidentid PRIMARY KEY (incidentid);


--
-- Name: isometadata_metadataid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY isometadata
    ADD CONSTRAINT isometadata_metadataid PRIMARY KEY (metadataid);


--
-- Name: methods_methodid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY methods
    ADD CONSTRAINT methods_methodid PRIMARY KEY (methodid);


--
-- Name: monthly_airtemp_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_airtemp
    ADD CONSTRAINT monthly_airtemp_valueid PRIMARY KEY (valueid);


--
-- Name: monthly_discharge_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_discharge
    ADD CONSTRAINT monthly_discharge_valueid PRIMARY KEY (valueid);


--
-- Name: monthly_precip_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_precip
    ADD CONSTRAINT monthly_precip_valueid PRIMARY KEY (valueid);


--
-- Name: monthly_rh_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_rh
    ADD CONSTRAINT monthly_rh_valueid PRIMARY KEY (valueid);


--
-- Name: monthly_snowdepthavg_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_snowdepthavg
    ADD CONSTRAINT monthly_snowdepthavg_valueid PRIMARY KEY (valueid);


--
-- Name: monthly_sweavg_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_sweavg
    ADD CONSTRAINT monthly_sweavg_valueid PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgairtemp_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgairtemp
    ADD CONSTRAINT multiyear_annual_avgairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgdischarge_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgdischarge
    ADD CONSTRAINT multiyear_annual_avgdischarge_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgfallairtemp_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgfallairtemp
    ADD CONSTRAINT multiyear_annual_avgfallairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgfallprecip_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgfallprecip
    ADD CONSTRAINT multiyear_annual_avgfallprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgpeakdischarge_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgpeakdischarge
    ADD CONSTRAINT multiyear_annual_avgpeakdischarge_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgpeaksnowdepth_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgpeaksnowdepth
    ADD CONSTRAINT multiyear_annual_avgpeaksnowdepth_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgpeakswe_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgpeakswe
    ADD CONSTRAINT multiyear_annual_avgpeakswe_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgprecip_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgprecip
    ADD CONSTRAINT multiyear_annual_avgprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgrh_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgrh
    ADD CONSTRAINT multiyear_annual_avgrh_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgspringairtemp_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgspringairtemp
    ADD CONSTRAINT multiyear_annual_avgspringairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgspringprecip_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgspringprecip
    ADD CONSTRAINT multiyear_annual_avgspringprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgsummerairtemp_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgsummerairtemp
    ADD CONSTRAINT multiyear_annual_avgsummerairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgsummerdischarge_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgsummerdischarge
    ADD CONSTRAINT multiyear_annual_avgsummerdischarge_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgsummerprecip_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgsummerprecip
    ADD CONSTRAINT multiyear_annual_avgsummerprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgsummerrh_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgsummerrh
    ADD CONSTRAINT multiyear_annual_avgsummerrh_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgwinterairtemp_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgwinterairtemp
    ADD CONSTRAINT multiyear_annual_avgwinterairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgwinterprecip_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgwinterprecip
    ADD CONSTRAINT multiyear_annual_avgwinterprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgwinterrh_pkey; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgwinterrh
    ADD CONSTRAINT multiyear_annual_avgwinterrh_pkey PRIMARY KEY (valueid);


--
-- Name: networkdescriptions_networkid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY networkdescriptions
    ADD CONSTRAINT networkdescriptions_networkid PRIMARY KEY (networkid);


--
-- Name: nhd_huc8_id_; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY nhd_huc8
    ADD CONSTRAINT nhd_huc8_id_ PRIMARY KEY (id);


--
-- Name: offsettypes_offsettypeid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY offsettypes
    ADD CONSTRAINT offsettypes_offsettypeid PRIMARY KEY (offsettypeid);


--
-- Name: organizationdescriptions_organizationid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY organizationdescriptions
    ADD CONSTRAINT organizationdescriptions_organizationid PRIMARY KEY (organizationid);


--
-- Name: processing_processingid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY processing
    ADD CONSTRAINT processing_processingid PRIMARY KEY (processingid);


--
-- Name: qualifiers_qualifierid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY qualifiers
    ADD CONSTRAINT qualifiers_qualifierid PRIMARY KEY (qualifierid);


--
-- Name: qualitycontrollevels_qualitycontrollevelid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY qualitycontrollevels
    ADD CONSTRAINT qualitycontrollevels_qualitycontrollevelid PRIMARY KEY (qualitycontrollevelid);


--
-- Name: rasterdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY rasterdatavalues
    ADD CONSTRAINT rasterdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: samplemediumcv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY samplemediumcv
    ADD CONSTRAINT samplemediumcv_term PRIMARY KEY (term);


--
-- Name: sites_siteid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY sites
    ADD CONSTRAINT sites_siteid PRIMARY KEY (siteid);


--
-- Name: sources_sourceid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_sourceid PRIMARY KEY (sourceid);


--
-- Name: spatialreferences_spatialreferenceid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY spatialreferences
    ADD CONSTRAINT spatialreferences_spatialreferenceid PRIMARY KEY (spatialreferenceid);


--
-- Name: speciationcv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY speciationcv
    ADD CONSTRAINT speciationcv_term PRIMARY KEY (term);


--
-- Name: sysdiagrams_diagram_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY sysdiagrams
    ADD CONSTRAINT sysdiagrams_diagram_id PRIMARY KEY (diagram_id);


--
-- Name: topiccategorycv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY topiccategorycv
    ADD CONSTRAINT topiccategorycv_term PRIMARY KEY (term);


--
-- Name: units_unitsid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY units
    ADD CONSTRAINT units_unitsid PRIMARY KEY (unitsid);


--
-- Name: valuetypecv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY valuetypecv
    ADD CONSTRAINT valuetypecv_term PRIMARY KEY (term);


--
-- Name: variablenamecv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY variablenamecv
    ADD CONSTRAINT variablenamecv_term PRIMARY KEY (term);


--
-- Name: variables_variableid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT variables_variableid PRIMARY KEY (variableid);


--
-- Name: verticaldatumcv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY verticaldatumcv
    ADD CONSTRAINT verticaldatumcv_term PRIMARY KEY (term);


SET search_path = views, pg_catalog;

--
-- Name: odmdatavalues_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY odmdatavalues
    ADD CONSTRAINT odmdatavalues_pkey PRIMARY KEY (valueid);


SET search_path = tables, pg_catalog;

--
-- Name: _15min_watertemp_test_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX _15min_watertemp_test_siteid_idx ON _15min_watertemp USING btree (siteid);


--
-- Name: annual_avgairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgairtemp_siteid_idx ON annual_avgairtemp USING btree (siteid);


--
-- Name: annual_avgdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgdischarge_siteid_idx ON annual_avgdischarge USING btree (siteid);


--
-- Name: annual_avgfallairtemp_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgfallairtemp_all_siteid_idx ON annual_avgfallairtemp_all USING btree (siteid);


--
-- Name: annual_avgfallairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgfallairtemp_siteid_idx ON annual_avgfallairtemp USING btree (siteid);


--
-- Name: annual_avgfallprecip_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgfallprecip_all_siteid_idx ON annual_avgfallprecip_all USING btree (siteid);


--
-- Name: annual_avgfallprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgfallprecip_siteid_idx ON annual_avgfallprecip USING btree (siteid);


--
-- Name: annual_avgrh_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgrh_all_siteid_idx ON annual_avgrh_all USING btree (siteid);


--
-- Name: annual_avgrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgrh_siteid_idx ON annual_avgrh USING btree (siteid);


--
-- Name: annual_avgspringairtemp_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgspringairtemp_all_siteid_idx ON annual_avgspringairtemp_all USING btree (siteid);


--
-- Name: annual_avgspringairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgspringairtemp_siteid_idx ON annual_avgspringairtemp USING btree (siteid);


--
-- Name: annual_avgspringprecip_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgspringprecip_all_siteid_idx ON annual_avgspringprecip_all USING btree (siteid);


--
-- Name: annual_avgspringprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgspringprecip_siteid_idx ON annual_avgspringprecip USING btree (siteid);


--
-- Name: annual_avgsummerairtemp_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerairtemp_all_siteid_idx ON annual_avgsummerairtemp_all USING btree (siteid);


--
-- Name: annual_avgsummerairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerairtemp_siteid_idx ON annual_avgsummerairtemp USING btree (siteid);


--
-- Name: annual_avgsummerdischarge_all_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerdischarge_all_idx ON annual_avgsummerdischarge_all USING btree (siteid);


--
-- Name: annual_avgsummerdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerdischarge_siteid_idx ON annual_avgsummerdischarge USING btree (siteid);


--
-- Name: annual_avgsummerprecip_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerprecip_all_siteid_idx ON annual_avgsummerprecip_all USING btree (siteid);


--
-- Name: annual_avgsummerprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerprecip_siteid_idx ON annual_avgsummerprecip USING btree (siteid);


--
-- Name: annual_avgsummerrh_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerrh_all_siteid_idx ON annual_avgsummerrh_all USING btree (siteid);


--
-- Name: annual_avgsummerrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerrh_siteid_idx ON annual_avgsummerrh USING btree (siteid);


--
-- Name: annual_avgwinterairtemp_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterairtemp_all_siteid_idx ON annual_avgwinterairtemp_all USING btree (siteid);


--
-- Name: annual_avgwinterairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterairtemp_siteid_idx ON annual_avgwinterairtemp USING btree (siteid);


--
-- Name: annual_avgwinterprecip_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterprecip_all_siteid_idx ON annual_avgwinterprecip_all USING btree (siteid);


--
-- Name: annual_avgwinterprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterprecip_siteid_idx ON annual_avgwinterprecip USING btree (siteid);


--
-- Name: annual_avgwinterrh_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterrh_all_siteid_idx ON annual_avgwinterrh_all USING btree (siteid);


--
-- Name: annual_avgwinterrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterrh_siteid_idx ON annual_avgwinterrh USING btree (siteid);


--
-- Name: annual_peakdischarge_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peakdischarge_all_siteid_idx ON annual_peakdischarge_all USING btree (siteid);


--
-- Name: annual_peakdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peakdischarge_siteid_idx ON annual_peakdischarge USING btree (siteid);


--
-- Name: annual_peaksnowdepth_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peaksnowdepth_all_siteid_idx ON annual_peaksnowdepth_all USING btree (siteid);


--
-- Name: annual_peaksnowdepth_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peaksnowdepth_siteid_idx ON annual_peaksnowdepth USING btree (siteid);


--
-- Name: annual_peakswe_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peakswe_all_siteid_idx ON annual_peakswe_all USING btree (siteid);


--
-- Name: annual_peakswe_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peakswe_siteid_idx ON annual_peakswe USING btree (siteid);


--
-- Name: annual_totalprecip_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_totalprecip_all_siteid_idx ON annual_totalprecip_all USING btree (siteid);


--
-- Name: annual_totalprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_totalprecip_siteid_idx ON annual_totalprecip USING btree (siteid);


--
-- Name: boundarycatalog_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX boundarycatalog_siteid_idx ON boundarycatalog USING btree (siteid);


--
-- Name: daily_airtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtemp_siteid_idx ON daily_airtemp USING btree (siteid);


--
-- Name: daily_airtempdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempdatavalues_siteid_idx ON daily_airtempdatavalues USING btree (siteid);


--
-- Name: daily_airtempdatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_airtempdatavalues_utcdatetime_siteid_orignalvariableid ON daily_airtempdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX daily_airtempdatavalues_utcdatetime_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX daily_airtempdatavalues_utcdatetime_siteid_orignalvariableid IS 'added unique index';


--
-- Name: daily_airtempmax_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempmax_siteid_idx ON daily_airtempmax USING btree (siteid);


--
-- Name: daily_airtempmaxdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempmaxdatavalues_siteid_idx ON daily_airtempmaxdatavalues USING btree (siteid);


--
-- Name: daily_airtempmaxdatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_airtempmaxdatavalues_utcdatetime_siteid_orignalvariableid ON daily_airtempmaxdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX daily_airtempmaxdatavalues_utcdatetime_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX daily_airtempmaxdatavalues_utcdatetime_siteid_orignalvariableid IS 'added unique index';


--
-- Name: daily_airtempmin_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempmin_siteid_idx ON daily_airtempmin USING btree (siteid);


--
-- Name: daily_airtempmindatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempmindatavalues_siteid_idx ON daily_airtempmindatavalues USING btree (siteid);


--
-- Name: daily_airtempmindatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_airtempmindatavalues_utcdatetime_siteid_orignalvariableid ON daily_airtempmindatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX daily_airtempmindatavalues_utcdatetime_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX daily_airtempmindatavalues_utcdatetime_siteid_orignalvariableid IS 'added unique index';


--
-- Name: daily_discharge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_discharge_siteid_idx ON daily_discharge USING btree (siteid);


--
-- Name: daily_dischargedatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_dischargedatavalues_siteid_idx ON daily_dischargedatavalues USING btree (siteid);


--
-- Name: daily_dischargedatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_dischargedatavalues_utcdatetime_siteid_orignalvariableid ON daily_dischargedatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: daily_precip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_precip_siteid_idx ON daily_precip USING btree (siteid);


--
-- Name: daily_precip_thresholds_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_precip_thresholds_siteid_idx ON daily_precip_thresholds USING btree (siteid);


--
-- Name: daily_precipdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_precipdatavalues_siteid_idx ON daily_precipdatavalues USING btree (siteid);


--
-- Name: daily_precipdatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_precipdatavalues_utcdatetime_siteid_orignalvariableid ON daily_precipdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX daily_precipdatavalues_utcdatetime_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX daily_precipdatavalues_utcdatetime_siteid_orignalvariableid IS 'added unique index';


--
-- Name: daily_rh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_rh_siteid_idx ON daily_rh USING btree (siteid);


--
-- Name: daily_rhdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_rhdatavalues_siteid_idx ON daily_rhdatavalues USING btree (siteid);


--
-- Name: daily_rhdatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_rhdatavalues_utcdatetime_siteid_orignalvariableid ON daily_rhdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX daily_rhdatavalues_utcdatetime_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX daily_rhdatavalues_utcdatetime_siteid_orignalvariableid IS 'added unique idx';


--
-- Name: daily_snowdepth_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_snowdepth_siteid_idx ON daily_snowdepth USING btree (siteid);


--
-- Name: daily_snowdepthdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_snowdepthdatavalues_siteid_idx ON daily_snowdepthdatavalues USING btree (siteid);


--
-- Name: daily_snowdepthdatavalues_utcdatetime_siteid_orignalvarialeid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_snowdepthdatavalues_utcdatetime_siteid_orignalvarialeid ON daily_snowdepthdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX daily_snowdepthdatavalues_utcdatetime_siteid_orignalvarialeid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX daily_snowdepthdatavalues_utcdatetime_siteid_orignalvarialeid IS 'added unique index';


--
-- Name: daily_swe_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_swe_siteid_idx ON daily_swe USING btree (siteid);


--
-- Name: daily_swedatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_swedatavalues_siteid_idx ON daily_swedatavalues USING btree (siteid);


--
-- Name: daily_swedatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_swedatavalues_utcdatetime_siteid_orignalvariableid ON daily_swedatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX daily_swedatavalues_utcdatetime_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX daily_swedatavalues_utcdatetime_siteid_orignalvariableid IS 'creating unique index';


--
-- Name: daily_watertemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_watertemp_siteid_idx ON daily_watertemp USING btree (siteid);


--
-- Name: daily_watertempdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_watertempdatavalues_siteid_idx ON daily_watertempdatavalues USING btree (siteid);


--
-- Name: daily_watertempdatavalues_utcdatetime_siteid_orignalvaribleid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_watertempdatavalues_utcdatetime_siteid_orignalvaribleid ON daily_watertempdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX daily_watertempdatavalues_utcdatetime_siteid_orignalvaribleid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX daily_watertempdatavalues_utcdatetime_siteid_orignalvaribleid IS 'added unique index';


--
-- Name: daily_winddirection_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_winddirection_siteid_idx ON daily_winddirection USING btree (siteid);


--
-- Name: daily_winddirectiondatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_winddirectiondatavalues_siteid_idx ON daily_winddirectiondatavalues USING btree (siteid);


--
-- Name: daily_winddirectiondatavalues_utcdatetime_siteid_orignalvariabl; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_winddirectiondatavalues_utcdatetime_siteid_orignalvariabl ON daily_winddirectiondatavalues USING btree (utcdatetime, siteid, originalvariableid, offsetvalue);


--
-- Name: INDEX daily_winddirectiondatavalues_utcdatetime_siteid_orignalvariabl; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX daily_winddirectiondatavalues_utcdatetime_siteid_orignalvariabl IS 'added unique index';


--
-- Name: daily_windspeed_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_windspeed_siteid_idx ON daily_windspeed USING btree (siteid);


--
-- Name: daily_windspeeddatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_windspeeddatavalues_siteid_idx ON daily_windspeeddatavalues USING btree (siteid);


--
-- Name: daily_windspeeddatavalues_utctimestamp_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX daily_windspeeddatavalues_utctimestamp_siteid_orignalvariableid ON daily_windspeeddatavalues USING btree (utcdatetime, siteid, originalvariableid, offsetvalue);


--
-- Name: datastreams_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX datastreams_siteid_idx ON datastreams USING btree (siteid);


--
-- Name: datavalues_datastreamid_localdatetime; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX datavalues_datastreamid_localdatetime ON datavalues USING btree (datastreamid, localdatetime) WHERE (offsettypeid IS NULL);


--
-- Name: INDEX datavalues_datastreamid_localdatetime; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX datavalues_datastreamid_localdatetime IS 'added unique index';


--
-- Name: datavalues_datastreamid_localdatetime_offsetvalue; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX datavalues_datastreamid_localdatetime_offsetvalue ON datavalues USING btree (datastreamid, localdatetime, offsetvalue);


--
-- Name: datavaluesraw_datastreamid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX datavaluesraw_datastreamid ON datavaluesraw USING btree (datastreamid);


--
-- Name: datavaluesraw_localdatetime; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX datavaluesraw_localdatetime ON datavaluesraw USING btree (localdatetime);


--
-- Name: hourly_airtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_airtemp_siteid_idx ON hourly_airtemp USING btree (siteid);


--
-- Name: hourly_airtempdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_airtempdatavalues_siteid_idx ON hourly_airtempdatavalues USING btree (siteid);


--
-- Name: hourly_airtempdatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX hourly_airtempdatavalues_utcdatetime_siteid_orignalvariableid ON hourly_airtempdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX hourly_airtempdatavalues_utcdatetime_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX hourly_airtempdatavalues_utcdatetime_siteid_orignalvariableid IS 'added unique index';


--
-- Name: hourly_precip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_precip_siteid_idx ON hourly_precip USING btree (siteid);


--
-- Name: hourly_precip_siteid_idx_2; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_precip_siteid_idx_2 ON hourly_precip USING btree (siteid);


--
-- Name: hourly_precipdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_precipdatavalues_siteid_idx ON hourly_precipdatavalues USING btree (siteid);


--
-- Name: hourly_precipdatavalues_utctimestamps_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX hourly_precipdatavalues_utctimestamps_siteid_orignalvariableid ON hourly_precipdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX hourly_precipdatavalues_utctimestamps_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX hourly_precipdatavalues_utctimestamps_siteid_orignalvariableid IS 'added unique id';


--
-- Name: hourly_rh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_rh_siteid_idx ON hourly_rh USING btree (siteid);


--
-- Name: hourly_rhdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_rhdatavalues_siteid_idx ON hourly_rhdatavalues USING btree (siteid);


--
-- Name: hourly_rhdatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX hourly_rhdatavalues_utcdatetime_siteid_orignalvariableid ON hourly_rhdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX hourly_rhdatavalues_utcdatetime_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX hourly_rhdatavalues_utcdatetime_siteid_orignalvariableid IS 'added new index';


--
-- Name: hourly_snowdepth_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_snowdepth_siteid_idx ON hourly_snowdepth USING btree (siteid);


--
-- Name: hourly_snowdepthdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_snowdepthdatavalues_siteid_idx ON hourly_snowdepthdatavalues USING btree (siteid);


--
-- Name: hourly_snowdepthdatavalues_utcdatetime_siteid_orignalvaribleid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX hourly_snowdepthdatavalues_utcdatetime_siteid_orignalvaribleid ON hourly_snowdepthdatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX hourly_snowdepthdatavalues_utcdatetime_siteid_orignalvaribleid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX hourly_snowdepthdatavalues_utcdatetime_siteid_orignalvaribleid IS 'added unique idx';


--
-- Name: hourly_swe_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_swe_siteid_idx ON hourly_swe USING btree (siteid);


--
-- Name: hourly_swedatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_swedatavalues_siteid_idx ON hourly_swedatavalues USING btree (siteid);


--
-- Name: hourly_swedatavalues_utctimestamp_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX hourly_swedatavalues_utctimestamp_siteid_orignalvariableid ON hourly_swedatavalues USING btree (utcdatetime, siteid, originalvariableid);


--
-- Name: INDEX hourly_swedatavalues_utctimestamp_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX hourly_swedatavalues_utctimestamp_siteid_orignalvariableid IS 'added unique idx';


--
-- Name: hourly_winddirection_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_winddirection_siteid_idx ON hourly_winddirection USING btree (siteid);


--
-- Name: hourly_winddirectiondatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_winddirectiondatavalues_siteid_idx ON hourly_winddirectiondatavalues USING btree (siteid);


--
-- Name: hourly_winddirectiondatavalues_utctimestamp_siteid_orignalvaria; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX hourly_winddirectiondatavalues_utctimestamp_siteid_orignalvaria ON hourly_winddirectiondatavalues USING btree (utcdatetime, siteid, originalvariableid, offsetvalue);


--
-- Name: INDEX hourly_winddirectiondatavalues_utctimestamp_siteid_orignalvaria; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX hourly_winddirectiondatavalues_utctimestamp_siteid_orignalvaria IS 'added uniuque id';


--
-- Name: hourly_windspeed_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_windspeed_siteid_idx ON hourly_windspeed USING btree (siteid);


--
-- Name: hourly_windspeeddatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_windspeeddatavalues_siteid_idx ON hourly_windspeeddatavalues USING btree (siteid);


--
-- Name: hourly_windspeeddatavalues_utcdatetime_siteid_orignalvariableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX hourly_windspeeddatavalues_utcdatetime_siteid_orignalvariableid ON hourly_windspeeddatavalues USING btree (utcdatetime, siteid, originalvariableid, offsetvalue);


--
-- Name: INDEX hourly_windspeeddatavalues_utcdatetime_siteid_orignalvariableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON INDEX hourly_windspeeddatavalues_utcdatetime_siteid_orignalvariableid IS 'added unique index';


--
-- Name: methods_methodname; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX methods_methodname ON methods USING btree (methodname);


--
-- Name: monthly_airtemp_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_airtemp_all_siteid_idx ON monthly_airtemp_all USING btree (siteid);


--
-- Name: monthly_airtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_airtemp_siteid_idx ON monthly_airtemp USING btree (siteid);


--
-- Name: monthly_discharge_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_discharge_all_siteid_idx ON monthly_discharge_all USING btree (siteid);


--
-- Name: monthly_discharge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_discharge_siteid_idx ON monthly_discharge USING btree (siteid);


--
-- Name: monthly_precip_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_precip_all_siteid_idx ON monthly_precip_all USING btree (siteid);


--
-- Name: monthly_precip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_precip_siteid_idx ON monthly_precip USING btree (siteid);


--
-- Name: monthly_rh_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_rh_all_siteid_idx ON monthly_rh_all USING btree (siteid);


--
-- Name: monthly_rh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_rh_siteid_idx ON monthly_rh USING btree (siteid);


--
-- Name: monthly_snowdepthavg_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_snowdepthavg_all_siteid_idx ON monthly_snowdepthavg_all USING btree (siteid);


--
-- Name: monthly_snowdepthavg_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_snowdepthavg_siteid_idx ON monthly_snowdepthavg USING btree (siteid);


--
-- Name: monthly_sweavg_all_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_sweavg_all_idx ON monthly_sweavg_all USING btree (siteid);


--
-- Name: monthly_sweavg_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_sweavg_siteid_idx ON monthly_sweavg USING btree (siteid);


--
-- Name: multiyear_annual_all_avgairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgairtemp_siteid_idx ON multiyear_annual_all_avgairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgairtemp_siteid_idx2; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgairtemp_siteid_idx2 ON multiyear_annual_all_avgairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgdischarge_siteid_idx ON multiyear_annual_all_avgdischarge USING btree (siteid);


--
-- Name: multiyear_annual_all_avgdischarge_siteid_idx2; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgdischarge_siteid_idx2 ON multiyear_annual_all_avgdischarge USING btree (siteid);


--
-- Name: multiyear_annual_all_avgfallairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgfallairtemp_siteid_idx ON multiyear_annual_all_avgfallairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgfallprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgfallprecip_siteid_idx ON multiyear_annual_all_avgfallprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgpeakdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgpeakdischarge_siteid_idx ON multiyear_annual_all_avgpeakdischarge USING btree (siteid);


--
-- Name: multiyear_annual_all_avgpeaksnowdepth_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgpeaksnowdepth_siteid_idx ON multiyear_annual_all_avgpeaksnowdepth USING btree (siteid);


--
-- Name: multiyear_annual_all_avgpeakswe_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgpeakswe_siteid_idx ON multiyear_annual_all_avgpeakswe USING btree (siteid);


--
-- Name: multiyear_annual_all_avgprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgprecip_siteid_idx ON multiyear_annual_all_avgprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgrh_siteid_idx ON multiyear_annual_all_avgrh USING btree (siteid);


--
-- Name: multiyear_annual_all_avgspringairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgspringairtemp_siteid_idx ON multiyear_annual_all_avgspringairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgspringairtemp_siteid_idx2; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgspringairtemp_siteid_idx2 ON multiyear_annual_all_avgspringairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgspringprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgspringprecip_siteid_idx ON multiyear_annual_all_avgspringprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgsummerairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgsummerairtemp_siteid_idx ON multiyear_annual_all_avgsummerairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgsummerairtemp_siteid_idx2; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgsummerairtemp_siteid_idx2 ON multiyear_annual_all_avgsummerairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgsummerdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgsummerdischarge_siteid_idx ON multiyear_annual_all_avgsummerdischarge USING btree (siteid);


--
-- Name: multiyear_annual_all_avgsummerprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgsummerprecip_siteid_idx ON multiyear_annual_all_avgsummerprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgsummerrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgsummerrh_siteid_idx ON multiyear_annual_all_avgsummerrh USING btree (siteid);


--
-- Name: multiyear_annual_all_avgwinterairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgwinterairtemp_siteid_idx ON multiyear_annual_all_avgwinterairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgwinterairtemp_siteid_idx2; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgwinterairtemp_siteid_idx2 ON multiyear_annual_all_avgwinterairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgwinterprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgwinterprecip_siteid_idx ON multiyear_annual_all_avgwinterprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgwinterrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgwinterrh_siteid_idx ON multiyear_annual_all_avgwinterrh USING btree (siteid);


--
-- Name: multiyear_annual_avgairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgairtemp_siteid_idx ON multiyear_annual_avgairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgdischarge_siteid_idx ON multiyear_annual_avgdischarge USING btree (siteid);


--
-- Name: multiyear_annual_avgfallairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgfallairtemp_siteid_idx ON multiyear_annual_avgfallairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgfallprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgfallprecip_siteid_idx ON multiyear_annual_avgfallprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgpeakdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgpeakdischarge_siteid_idx ON multiyear_annual_avgpeakdischarge USING btree (siteid);


--
-- Name: multiyear_annual_avgpeaksnowdepth_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgpeaksnowdepth_siteid_idx ON multiyear_annual_avgpeaksnowdepth USING btree (siteid);


--
-- Name: multiyear_annual_avgpeakswe_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgpeakswe_siteid_idx ON multiyear_annual_avgpeakswe USING btree (siteid);


--
-- Name: multiyear_annual_avgprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgprecip_siteid_idx ON multiyear_annual_avgprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgrh_siteid_idx ON multiyear_annual_avgrh USING btree (siteid);


--
-- Name: multiyear_annual_avgspringairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgspringairtemp_siteid_idx ON multiyear_annual_avgspringairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgspringprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgspringprecip_siteid_idx ON multiyear_annual_avgspringprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgsummerairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgsummerairtemp_siteid_idx ON multiyear_annual_avgsummerairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgsummerdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgsummerdischarge_siteid_idx ON multiyear_annual_avgsummerdischarge USING btree (siteid);


--
-- Name: multiyear_annual_avgsummerprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgsummerprecip_siteid_idx ON multiyear_annual_avgsummerprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgsummerrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgsummerrh_siteid_idx ON multiyear_annual_avgsummerrh USING btree (siteid);


--
-- Name: multiyear_annual_avgwinterairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgwinterairtemp_siteid_idx ON multiyear_annual_avgwinterairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgwinterprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgwinterprecip_siteid_idx ON multiyear_annual_avgwinterprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgwinterrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgwinterrh_siteid_idx ON multiyear_annual_avgwinterrh USING btree (siteid);


--
-- Name: pk_sites_siteid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX pk_sites_siteid ON sites USING btree (siteid);

ALTER TABLE sites CLUSTER ON pk_sites_siteid;


--
-- Name: pk_units_unitsid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX pk_units_unitsid ON units USING btree (unitsid);

ALTER TABLE units CLUSTER ON pk_units_unitsid;


--
-- Name: pk_variables_variableid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX pk_variables_variableid ON variables USING btree (variableid);

ALTER TABLE variables CLUSTER ON pk_variables_variableid;


--
-- Name: sysdiagrams_name; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX sysdiagrams_name ON sysdiagrams USING btree (name);


--
-- Name: sysdiagrams_principal_id; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX sysdiagrams_principal_id ON sysdiagrams USING btree (principal_id);


--
-- Name: variables_variablecode; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX variables_variablecode ON variables USING btree (variablecode);


SET search_path = views, pg_catalog;

--
-- Name: odmdatavalues_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX odmdatavalues_siteid_idx ON odmdatavalues USING btree (siteid);


SET search_path = tables, pg_catalog;

--
-- Name: fk_datavalues_categoryid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_categoryid FOREIGN KEY (categoryid) REFERENCES categories(categoryid);


--
-- Name: fk_datavalues_censorcodecv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_censorcodecv FOREIGN KEY (censorcode) REFERENCES censorcodecv(term);


--
-- Name: fk_datavalues_datastreamid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_datastreamid FOREIGN KEY (datastreamid) REFERENCES datastreams(datastreamid);


--
-- Name: fk_derivedfrom_datavaluesraw; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY derivedfrom
    ADD CONSTRAINT fk_derivedfrom_datavaluesraw FOREIGN KEY (valueid) REFERENCES datavaluesraw(valueid);


--
-- Name: fk_groups_groupdescriptions; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT fk_groups_groupdescriptions FOREIGN KEY (groupid) REFERENCES groupdescriptions(groupid);


--
-- Name: fk_incidents_datastreams; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT fk_incidents_datastreams FOREIGN KEY (datastreamid) REFERENCES datastreams(datastreamid);


--
-- Name: fk_organizations_organizationid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT fk_organizations_organizationid FOREIGN KEY (organizationid) REFERENCES organizationdescriptions(organizationid);


--
-- Name: fk_rasterdatavalues_qualifierid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY rasterdatavalues
    ADD CONSTRAINT fk_rasterdatavalues_qualifierid FOREIGN KEY (qualifierid) REFERENCES qualifiers(qualifierid);


--
-- Name: fk_siteattributes_attributeid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY siteattributes
    ADD CONSTRAINT fk_siteattributes_attributeid FOREIGN KEY (attributeid) REFERENCES attributes(attributeid);


--
-- Name: fk_variables_datatypecv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_datatypecv FOREIGN KEY (datatype) REFERENCES datatypecv(term);


--
-- Name: fk_variables_samplemediumcv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_samplemediumcv FOREIGN KEY (samplemedium) REFERENCES samplemediumcv(term);


--
-- Name: fk_variables_speciationcv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_speciationcv FOREIGN KEY (speciation) REFERENCES speciationcv(term);


--
-- Name: fk_variables_timeunitsid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_timeunitsid FOREIGN KEY (timeunitsid) REFERENCES units(unitsid);


--
-- Name: fk_variables_valuetypecv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_valuetypecv FOREIGN KEY (valuetype) REFERENCES valuetypecv(term);


--
-- Name: fk_variables_variablenamecv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_variablenamecv FOREIGN KEY (variablename) REFERENCES variablenamecv(term);


--
-- Name: fk_variables_variableunitsid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_variableunitsid FOREIGN KEY (variableunitsid) REFERENCES units(unitsid);


--
-- Name: public; Type: ACL; Schema: -; Owner: imiq
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM imiq;
GRANT ALL ON SCHEMA public TO imiq;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT USAGE ON SCHEMA public TO asjacobs;
GRANT USAGE ON SCHEMA public TO rwspicer;
GRANT USAGE ON SCHEMA public TO imiq_reader;
GRANT ALL ON SCHEMA public TO chaase;


--
-- Name: tables; Type: ACL; Schema: -; Owner: imiq
--

REVOKE ALL ON SCHEMA tables FROM PUBLIC;
REVOKE ALL ON SCHEMA tables FROM imiq;
GRANT ALL ON SCHEMA tables TO imiq;
GRANT USAGE ON SCHEMA tables TO asjacobs;
GRANT ALL ON SCHEMA tables TO rwspicer;
GRANT USAGE ON SCHEMA tables TO imiq_reader;
GRANT ALL ON SCHEMA tables TO chaase;


--
-- Name: topology; Type: ACL; Schema: -; Owner: imiq
--

REVOKE ALL ON SCHEMA topology FROM PUBLIC;
REVOKE ALL ON SCHEMA topology FROM imiq;
GRANT ALL ON SCHEMA topology TO imiq;
GRANT USAGE ON SCHEMA topology TO asjacobs;
GRANT USAGE ON SCHEMA topology TO rwspicer;
GRANT USAGE ON SCHEMA topology TO imiq_reader;
GRANT ALL ON SCHEMA topology TO chaase;


--
-- Name: views; Type: ACL; Schema: -; Owner: imiq
--

REVOKE ALL ON SCHEMA views FROM PUBLIC;
REVOKE ALL ON SCHEMA views FROM imiq;
GRANT ALL ON SCHEMA views TO imiq;
GRANT USAGE ON SCHEMA views TO asjacobs;
GRANT USAGE ON SCHEMA views TO rwspicer;
GRANT USAGE ON SCHEMA views TO imiq_reader;
GRANT ALL ON SCHEMA views TO chaase;


--
-- Name: calcwinddirection(real, real); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION calcwinddirection(x real, y real) FROM PUBLIC;
REVOKE ALL ON FUNCTION calcwinddirection(x real, y real) FROM imiq;
GRANT ALL ON FUNCTION calcwinddirection(x real, y real) TO imiq;
GRANT ALL ON FUNCTION calcwinddirection(x real, y real) TO PUBLIC;
GRANT ALL ON FUNCTION calcwinddirection(x real, y real) TO asjacobs;
GRANT ALL ON FUNCTION calcwinddirection(x real, y real) TO rwspicer;
GRANT ALL ON FUNCTION calcwinddirection(x real, y real) TO chaase;


--
-- Name: getmaxdailyprecip(timestamp without time zone, integer, integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION getmaxdailyprecip(currentdatetime timestamp without time zone, siteid integer, mindatavalue integer, maxdatavalue integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION getmaxdailyprecip(currentdatetime timestamp without time zone, siteid integer, mindatavalue integer, maxdatavalue integer) FROM imiq;
GRANT ALL ON FUNCTION getmaxdailyprecip(currentdatetime timestamp without time zone, siteid integer, mindatavalue integer, maxdatavalue integer) TO imiq;
GRANT ALL ON FUNCTION getmaxdailyprecip(currentdatetime timestamp without time zone, siteid integer, mindatavalue integer, maxdatavalue integer) TO PUBLIC;
GRANT ALL ON FUNCTION getmaxdailyprecip(currentdatetime timestamp without time zone, siteid integer, mindatavalue integer, maxdatavalue integer) TO asjacobs;
GRANT ALL ON FUNCTION getmaxdailyprecip(currentdatetime timestamp without time zone, siteid integer, mindatavalue integer, maxdatavalue integer) TO rwspicer;
GRANT ALL ON FUNCTION getmaxdailyprecip(currentdatetime timestamp without time zone, siteid integer, mindatavalue integer, maxdatavalue integer) TO chaase;


--
-- Name: uspgetdailyairtemp(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailyairtemp(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailyairtemp(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailyairtemp(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailyairtemp(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailyairtemp(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailyairtemp(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailyairtemp(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailyairtempmax(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailyairtempmax(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailyairtempmin(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailyairtempmin(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailyavgsoilmoisture_anaktuvikpass(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailyavgsoilmoisture_anaktuvikpass(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailyavgsoilmoisture_anaktuvikpass(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailyavgsoilmoisture_anaktuvikpass(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailyavgsoilmoisture_anaktuvikpass(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailyavgsoilmoisture_anaktuvikpass(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailyavgsoilmoisture_anaktuvikpass(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailydischarge(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailydischarge(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailydischarge(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailydischarge(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailydischarge(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailydischarge(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailydischarge(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailydischarge(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailyprecip(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailyprecip(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailyprecip(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailyprecip(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailyprecip(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailyprecip(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailyprecip(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailyprecip(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailysnowdepth(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailysnowdepth(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailysnowdepth(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailysnowdepth(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailysnowdepth(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailysnowdepth(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailysnowdepth(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailysnowdepth(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailysnowdepthmax(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailysnowdepthmax(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailysnowdepthmax(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmax(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmax(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmax(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmax(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmax(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailysnowdepthmin(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailysnowdepthmin(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailysnowdepthmin(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmin(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmin(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmin(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmin(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailysnowdepthmin(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailysoiltemp(integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailysoiltemp(site_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailysoiltemp(site_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailysoiltemp(site_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailysoiltemp(site_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailysoiltemp(site_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailysoiltemp(site_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailysoiltemp(site_id integer) TO chaase;


--
-- Name: uspgetdailysoiltempmax(integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailysoiltempmax(site_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailysoiltempmax(site_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailysoiltempmax(site_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailysoiltempmax(site_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailysoiltempmax(site_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailysoiltempmax(site_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailysoiltempmax(site_id integer) TO chaase;


--
-- Name: uspgetdailysoiltempmin(integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailysoiltempmin(site_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailysoiltempmin(site_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailysoiltempmin(site_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailysoiltempmin(site_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailysoiltempmin(site_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailysoiltempmin(site_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailysoiltempmin(site_id integer) TO chaase;


--
-- Name: uspgetdailyswe(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailyswe(siteid integer, varid integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailyswe(siteid integer, varid integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailyswe(siteid integer, varid integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailyswe(siteid integer, varid integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailyswe(siteid integer, varid integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailyswe(siteid integer, varid integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailyswe(siteid integer, varid integer) TO chaase;


--
-- Name: uspgetdailywatertemp(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailywatertemp(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailywatertemp(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailywatertemp(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailywatertemp(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailywatertemp(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailywatertemp(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailywatertemp(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailywinddirection(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailywinddirection(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailywinddirection(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailywinddirection(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailywinddirection(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailywinddirection(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailywinddirection(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailywinddirection(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgetdailywindspeed(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgetdailywindspeed(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgetdailywindspeed(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgetdailywindspeed(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgetdailywindspeed(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgetdailywindspeed(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgetdailywindspeed(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgetdailywindspeed(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgethourlyairtemp(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgethourlyairtemp(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgethourlyairtemp(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgethourlyairtemp(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgethourlyairtemp(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgethourlyairtemp(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgethourlyairtemp(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgethourlyairtemp(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgethourlyprecip(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgethourlyprecip(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgethourlyprecip(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgethourlyprecip(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgethourlyprecip(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgethourlyprecip(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgethourlyprecip(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgethourlyprecip(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgethourlysnowdepth(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgethourlysnowdepth(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgethourlysnowdepth(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgethourlysnowdepth(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgethourlysnowdepth(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgethourlysnowdepth(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgethourlysnowdepth(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgethourlysnowdepth(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgethourlyswe(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgethourlyswe(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgethourlyswe(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgethourlyswe(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgethourlyswe(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgethourlyswe(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgethourlyswe(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgethourlyswe(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgethourlywinddirection(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgethourlywinddirection(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgethourlywinddirection(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgethourlywinddirection(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgethourlywinddirection(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgethourlywinddirection(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgethourlywinddirection(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgethourlywinddirection(site_id integer, var_id integer) TO chaase;


--
-- Name: uspgethourlywindspeed(integer, integer); Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON FUNCTION uspgethourlywindspeed(site_id integer, var_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION uspgethourlywindspeed(site_id integer, var_id integer) FROM imiq;
GRANT ALL ON FUNCTION uspgethourlywindspeed(site_id integer, var_id integer) TO imiq;
GRANT ALL ON FUNCTION uspgethourlywindspeed(site_id integer, var_id integer) TO PUBLIC;
GRANT ALL ON FUNCTION uspgethourlywindspeed(site_id integer, var_id integer) TO asjacobs;
GRANT ALL ON FUNCTION uspgethourlywindspeed(site_id integer, var_id integer) TO rwspicer;
GRANT ALL ON FUNCTION uspgethourlywindspeed(site_id integer, var_id integer) TO chaase;


--
-- Name: _15min_watertemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE _15min_watertemp FROM PUBLIC;
REVOKE ALL ON TABLE _15min_watertemp FROM imiq;
GRANT ALL ON TABLE _15min_watertemp TO imiq;
GRANT ALL ON TABLE _15min_watertemp TO asjacobs;
GRANT SELECT ON TABLE _15min_watertemp TO imiq_reader;
GRANT ALL ON TABLE _15min_watertemp TO rwspicer;
GRANT ALL ON TABLE _15min_watertemp TO chaase;


--
-- Name: _sites_summary; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE _sites_summary FROM PUBLIC;
REVOKE ALL ON TABLE _sites_summary FROM imiq;
GRANT ALL ON TABLE _sites_summary TO imiq;
GRANT ALL ON TABLE _sites_summary TO asjacobs;
GRANT ALL ON TABLE _sites_summary TO chaase;
GRANT ALL ON TABLE _sites_summary TO rwspicer;
GRANT SELECT ON TABLE _sites_summary TO imiq_reader;


--
-- Name: _siteswithelevations; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE _siteswithelevations FROM PUBLIC;
REVOKE ALL ON TABLE _siteswithelevations FROM imiq;
GRANT ALL ON TABLE _siteswithelevations TO imiq;
GRANT ALL ON TABLE _siteswithelevations TO asjacobs;
GRANT ALL ON TABLE _siteswithelevations TO chaase;
GRANT ALL ON TABLE _siteswithelevations TO rwspicer;
GRANT SELECT ON TABLE _siteswithelevations TO imiq_reader;


--
-- Name: annual_avgairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgairtemp TO imiq;
GRANT ALL ON TABLE annual_avgairtemp TO asjacobs;
GRANT SELECT ON TABLE annual_avgairtemp TO imiq_reader;
GRANT ALL ON TABLE annual_avgairtemp TO rwspicer;
GRANT ALL ON TABLE annual_avgairtemp TO chaase;


--
-- Name: annual_avgdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgdischarge FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgdischarge FROM imiq;
GRANT ALL ON TABLE annual_avgdischarge TO imiq;
GRANT ALL ON TABLE annual_avgdischarge TO asjacobs;
GRANT SELECT ON TABLE annual_avgdischarge TO imiq_reader;
GRANT ALL ON TABLE annual_avgdischarge TO rwspicer;
GRANT ALL ON TABLE annual_avgdischarge TO chaase;


--
-- Name: annual_avgfallairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgfallairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgfallairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgfallairtemp TO imiq;
GRANT ALL ON TABLE annual_avgfallairtemp TO asjacobs;
GRANT SELECT ON TABLE annual_avgfallairtemp TO imiq_reader;
GRANT ALL ON TABLE annual_avgfallairtemp TO rwspicer;
GRANT ALL ON TABLE annual_avgfallairtemp TO chaase;


--
-- Name: annual_avgfallairtemp_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgfallairtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgfallairtemp_all FROM imiq;
GRANT ALL ON TABLE annual_avgfallairtemp_all TO imiq;
GRANT ALL ON TABLE annual_avgfallairtemp_all TO asjacobs;
GRANT SELECT ON TABLE annual_avgfallairtemp_all TO imiq_reader;
GRANT ALL ON TABLE annual_avgfallairtemp_all TO rwspicer;
GRANT ALL ON TABLE annual_avgfallairtemp_all TO chaase;


--
-- Name: annual_avgfallprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgfallprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgfallprecip FROM imiq;
GRANT ALL ON TABLE annual_avgfallprecip TO imiq;
GRANT ALL ON TABLE annual_avgfallprecip TO asjacobs;
GRANT SELECT ON TABLE annual_avgfallprecip TO imiq_reader;
GRANT ALL ON TABLE annual_avgfallprecip TO rwspicer;
GRANT ALL ON TABLE annual_avgfallprecip TO chaase;


--
-- Name: annual_avgfallprecip_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgfallprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgfallprecip_all FROM imiq;
GRANT ALL ON TABLE annual_avgfallprecip_all TO imiq;
GRANT ALL ON TABLE annual_avgfallprecip_all TO asjacobs;
GRANT SELECT ON TABLE annual_avgfallprecip_all TO imiq_reader;
GRANT ALL ON TABLE annual_avgfallprecip_all TO rwspicer;
GRANT ALL ON TABLE annual_avgfallprecip_all TO chaase;


--
-- Name: annual_avgrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgrh FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgrh FROM imiq;
GRANT ALL ON TABLE annual_avgrh TO imiq;
GRANT ALL ON TABLE annual_avgrh TO asjacobs;
GRANT SELECT ON TABLE annual_avgrh TO imiq_reader;
GRANT ALL ON TABLE annual_avgrh TO rwspicer;
GRANT ALL ON TABLE annual_avgrh TO chaase;


--
-- Name: annual_avgrh_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgrh_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgrh_all FROM imiq;
GRANT ALL ON TABLE annual_avgrh_all TO imiq;
GRANT ALL ON TABLE annual_avgrh_all TO asjacobs;
GRANT ALL ON TABLE annual_avgrh_all TO chaase;
GRANT ALL ON TABLE annual_avgrh_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgrh_all TO imiq_reader;


--
-- Name: annual_avgspringairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgspringairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgspringairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgspringairtemp TO imiq;
GRANT ALL ON TABLE annual_avgspringairtemp TO asjacobs;
GRANT SELECT ON TABLE annual_avgspringairtemp TO imiq_reader;
GRANT ALL ON TABLE annual_avgspringairtemp TO rwspicer;
GRANT ALL ON TABLE annual_avgspringairtemp TO chaase;


--
-- Name: annual_avgspringairtemp_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgspringairtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgspringairtemp_all FROM imiq;
GRANT ALL ON TABLE annual_avgspringairtemp_all TO imiq;
GRANT ALL ON TABLE annual_avgspringairtemp_all TO asjacobs;
GRANT SELECT ON TABLE annual_avgspringairtemp_all TO imiq_reader;
GRANT ALL ON TABLE annual_avgspringairtemp_all TO rwspicer;
GRANT ALL ON TABLE annual_avgspringairtemp_all TO chaase;


--
-- Name: annual_avgspringprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgspringprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgspringprecip FROM imiq;
GRANT ALL ON TABLE annual_avgspringprecip TO imiq;
GRANT ALL ON TABLE annual_avgspringprecip TO asjacobs;
GRANT SELECT ON TABLE annual_avgspringprecip TO imiq_reader;
GRANT ALL ON TABLE annual_avgspringprecip TO rwspicer;
GRANT ALL ON TABLE annual_avgspringprecip TO chaase;


--
-- Name: annual_avgspringprecip_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgspringprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgspringprecip_all FROM imiq;
GRANT ALL ON TABLE annual_avgspringprecip_all TO imiq;
GRANT ALL ON TABLE annual_avgspringprecip_all TO asjacobs;
GRANT SELECT ON TABLE annual_avgspringprecip_all TO imiq_reader;
GRANT ALL ON TABLE annual_avgspringprecip_all TO rwspicer;
GRANT ALL ON TABLE annual_avgspringprecip_all TO chaase;


--
-- Name: annual_avgsummerairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgsummerairtemp TO imiq;
GRANT ALL ON TABLE annual_avgsummerairtemp TO asjacobs;
GRANT SELECT ON TABLE annual_avgsummerairtemp TO imiq_reader;
GRANT ALL ON TABLE annual_avgsummerairtemp TO rwspicer;
GRANT ALL ON TABLE annual_avgsummerairtemp TO chaase;


--
-- Name: annual_avgsummerairtemp_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerairtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerairtemp_all FROM imiq;
GRANT ALL ON TABLE annual_avgsummerairtemp_all TO imiq;
GRANT ALL ON TABLE annual_avgsummerairtemp_all TO asjacobs;
GRANT SELECT ON TABLE annual_avgsummerairtemp_all TO imiq_reader;
GRANT ALL ON TABLE annual_avgsummerairtemp_all TO rwspicer;
GRANT ALL ON TABLE annual_avgsummerairtemp_all TO chaase;


--
-- Name: annual_avgsummerdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerdischarge FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerdischarge FROM imiq;
GRANT ALL ON TABLE annual_avgsummerdischarge TO imiq;
GRANT ALL ON TABLE annual_avgsummerdischarge TO asjacobs;
GRANT SELECT ON TABLE annual_avgsummerdischarge TO imiq_reader;
GRANT ALL ON TABLE annual_avgsummerdischarge TO rwspicer;
GRANT ALL ON TABLE annual_avgsummerdischarge TO chaase;


--
-- Name: annual_avgsummerdischarge_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerdischarge_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerdischarge_all FROM imiq;
GRANT ALL ON TABLE annual_avgsummerdischarge_all TO imiq;
GRANT ALL ON TABLE annual_avgsummerdischarge_all TO asjacobs;
GRANT SELECT ON TABLE annual_avgsummerdischarge_all TO imiq_reader;
GRANT ALL ON TABLE annual_avgsummerdischarge_all TO rwspicer;
GRANT ALL ON TABLE annual_avgsummerdischarge_all TO chaase;


--
-- Name: annual_avgsummerprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerprecip FROM imiq;
GRANT ALL ON TABLE annual_avgsummerprecip TO imiq;
GRANT ALL ON TABLE annual_avgsummerprecip TO asjacobs;
GRANT SELECT ON TABLE annual_avgsummerprecip TO imiq_reader;
GRANT ALL ON TABLE annual_avgsummerprecip TO rwspicer;
GRANT ALL ON TABLE annual_avgsummerprecip TO chaase;


--
-- Name: annual_avgsummerprecip_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerprecip_all FROM imiq;
GRANT ALL ON TABLE annual_avgsummerprecip_all TO imiq;
GRANT ALL ON TABLE annual_avgsummerprecip_all TO asjacobs;
GRANT SELECT ON TABLE annual_avgsummerprecip_all TO imiq_reader;
GRANT ALL ON TABLE annual_avgsummerprecip_all TO rwspicer;
GRANT ALL ON TABLE annual_avgsummerprecip_all TO chaase;


--
-- Name: annual_avgsummerrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerrh FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerrh FROM imiq;
GRANT ALL ON TABLE annual_avgsummerrh TO imiq;
GRANT ALL ON TABLE annual_avgsummerrh TO asjacobs;
GRANT SELECT ON TABLE annual_avgsummerrh TO imiq_reader;
GRANT ALL ON TABLE annual_avgsummerrh TO rwspicer;
GRANT ALL ON TABLE annual_avgsummerrh TO chaase;


--
-- Name: annual_avgsummerrh_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerrh_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerrh_all FROM imiq;
GRANT ALL ON TABLE annual_avgsummerrh_all TO imiq;
GRANT ALL ON TABLE annual_avgsummerrh_all TO asjacobs;
GRANT SELECT ON TABLE annual_avgsummerrh_all TO imiq_reader;
GRANT ALL ON TABLE annual_avgsummerrh_all TO rwspicer;
GRANT ALL ON TABLE annual_avgsummerrh_all TO chaase;


--
-- Name: annual_avgwinterairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgwinterairtemp TO imiq;
GRANT ALL ON TABLE annual_avgwinterairtemp TO asjacobs;
GRANT SELECT ON TABLE annual_avgwinterairtemp TO imiq_reader;
GRANT ALL ON TABLE annual_avgwinterairtemp TO rwspicer;
GRANT ALL ON TABLE annual_avgwinterairtemp TO chaase;


--
-- Name: annual_avgwinterairtemp_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterairtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterairtemp_all FROM imiq;
GRANT ALL ON TABLE annual_avgwinterairtemp_all TO imiq;
GRANT ALL ON TABLE annual_avgwinterairtemp_all TO asjacobs;
GRANT ALL ON TABLE annual_avgwinterairtemp_all TO chaase;
GRANT ALL ON TABLE annual_avgwinterairtemp_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgwinterairtemp_all TO imiq_reader;


--
-- Name: annual_avgwinterprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterprecip FROM imiq;
GRANT ALL ON TABLE annual_avgwinterprecip TO imiq;
GRANT ALL ON TABLE annual_avgwinterprecip TO asjacobs;
GRANT SELECT ON TABLE annual_avgwinterprecip TO imiq_reader;
GRANT ALL ON TABLE annual_avgwinterprecip TO rwspicer;
GRANT ALL ON TABLE annual_avgwinterprecip TO chaase;


--
-- Name: annual_avgwinterprecip_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterprecip_all FROM imiq;
GRANT ALL ON TABLE annual_avgwinterprecip_all TO imiq;
GRANT ALL ON TABLE annual_avgwinterprecip_all TO asjacobs;
GRANT ALL ON TABLE annual_avgwinterprecip_all TO chaase;
GRANT ALL ON TABLE annual_avgwinterprecip_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgwinterprecip_all TO imiq_reader;


--
-- Name: annual_avgwinterrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterrh FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterrh FROM imiq;
GRANT ALL ON TABLE annual_avgwinterrh TO imiq;
GRANT ALL ON TABLE annual_avgwinterrh TO asjacobs;
GRANT SELECT ON TABLE annual_avgwinterrh TO imiq_reader;
GRANT ALL ON TABLE annual_avgwinterrh TO rwspicer;
GRANT ALL ON TABLE annual_avgwinterrh TO chaase;


--
-- Name: annual_avgwinterrh_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterrh_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterrh_all FROM imiq;
GRANT ALL ON TABLE annual_avgwinterrh_all TO imiq;
GRANT ALL ON TABLE annual_avgwinterrh_all TO asjacobs;
GRANT ALL ON TABLE annual_avgwinterrh_all TO chaase;
GRANT ALL ON TABLE annual_avgwinterrh_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgwinterrh_all TO imiq_reader;


--
-- Name: annual_peakdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_peakdischarge FROM PUBLIC;
REVOKE ALL ON TABLE annual_peakdischarge FROM imiq;
GRANT ALL ON TABLE annual_peakdischarge TO imiq;
GRANT ALL ON TABLE annual_peakdischarge TO asjacobs;
GRANT SELECT ON TABLE annual_peakdischarge TO imiq_reader;
GRANT ALL ON TABLE annual_peakdischarge TO rwspicer;
GRANT ALL ON TABLE annual_peakdischarge TO chaase;


--
-- Name: annual_peakdischarge_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_peakdischarge_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_peakdischarge_all FROM imiq;
GRANT ALL ON TABLE annual_peakdischarge_all TO imiq;
GRANT ALL ON TABLE annual_peakdischarge_all TO asjacobs;
GRANT ALL ON TABLE annual_peakdischarge_all TO chaase;
GRANT ALL ON TABLE annual_peakdischarge_all TO rwspicer;
GRANT SELECT ON TABLE annual_peakdischarge_all TO imiq_reader;


--
-- Name: annual_peaksnowdepth; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_peaksnowdepth FROM PUBLIC;
REVOKE ALL ON TABLE annual_peaksnowdepth FROM imiq;
GRANT ALL ON TABLE annual_peaksnowdepth TO imiq;
GRANT ALL ON TABLE annual_peaksnowdepth TO asjacobs;
GRANT SELECT ON TABLE annual_peaksnowdepth TO imiq_reader;
GRANT ALL ON TABLE annual_peaksnowdepth TO rwspicer;
GRANT ALL ON TABLE annual_peaksnowdepth TO chaase;


--
-- Name: annual_peaksnowdepth_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_peaksnowdepth_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_peaksnowdepth_all FROM imiq;
GRANT ALL ON TABLE annual_peaksnowdepth_all TO imiq;
GRANT ALL ON TABLE annual_peaksnowdepth_all TO asjacobs;
GRANT ALL ON TABLE annual_peaksnowdepth_all TO chaase;
GRANT ALL ON TABLE annual_peaksnowdepth_all TO rwspicer;
GRANT SELECT ON TABLE annual_peaksnowdepth_all TO imiq_reader;


--
-- Name: annual_peakswe; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_peakswe FROM PUBLIC;
REVOKE ALL ON TABLE annual_peakswe FROM imiq;
GRANT ALL ON TABLE annual_peakswe TO imiq;
GRANT ALL ON TABLE annual_peakswe TO asjacobs;
GRANT SELECT ON TABLE annual_peakswe TO imiq_reader;
GRANT ALL ON TABLE annual_peakswe TO rwspicer;
GRANT ALL ON TABLE annual_peakswe TO chaase;


--
-- Name: annual_peakswe_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_peakswe_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_peakswe_all FROM imiq;
GRANT ALL ON TABLE annual_peakswe_all TO imiq;
GRANT ALL ON TABLE annual_peakswe_all TO asjacobs;
GRANT ALL ON TABLE annual_peakswe_all TO chaase;
GRANT ALL ON TABLE annual_peakswe_all TO rwspicer;
GRANT SELECT ON TABLE annual_peakswe_all TO imiq_reader;


--
-- Name: annual_totalprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_totalprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_totalprecip FROM imiq;
GRANT ALL ON TABLE annual_totalprecip TO imiq;
GRANT ALL ON TABLE annual_totalprecip TO asjacobs;
GRANT SELECT ON TABLE annual_totalprecip TO imiq_reader;
GRANT ALL ON TABLE annual_totalprecip TO rwspicer;
GRANT ALL ON TABLE annual_totalprecip TO chaase;


--
-- Name: annual_totalprecip_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_totalprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_totalprecip_all FROM imiq;
GRANT ALL ON TABLE annual_totalprecip_all TO imiq;
GRANT ALL ON TABLE annual_totalprecip_all TO asjacobs;
GRANT ALL ON TABLE annual_totalprecip_all TO chaase;
GRANT ALL ON TABLE annual_totalprecip_all TO rwspicer;
GRANT SELECT ON TABLE annual_totalprecip_all TO imiq_reader;


--
-- Name: attributes; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE attributes FROM PUBLIC;
REVOKE ALL ON TABLE attributes FROM imiq;
GRANT ALL ON TABLE attributes TO imiq;
GRANT ALL ON TABLE attributes TO asjacobs;
GRANT ALL ON TABLE attributes TO chaase;
GRANT ALL ON TABLE attributes TO rwspicer;
GRANT SELECT ON TABLE attributes TO imiq_reader;


--
-- Name: boundarycatalog; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE boundarycatalog FROM PUBLIC;
REVOKE ALL ON TABLE boundarycatalog FROM imiq;
GRANT ALL ON TABLE boundarycatalog TO imiq;
GRANT ALL ON TABLE boundarycatalog TO asjacobs;
GRANT ALL ON TABLE boundarycatalog TO chaase;
GRANT SELECT ON TABLE boundarycatalog TO imiq_reader;
GRANT ALL ON TABLE boundarycatalog TO rwspicer;


--
-- Name: categories; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE categories FROM PUBLIC;
REVOKE ALL ON TABLE categories FROM imiq;
GRANT ALL ON TABLE categories TO imiq;
GRANT ALL ON TABLE categories TO asjacobs;
GRANT ALL ON TABLE categories TO chaase;
GRANT ALL ON TABLE categories TO rwspicer;
GRANT SELECT ON TABLE categories TO imiq_reader;


--
-- Name: censorcodecv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE censorcodecv FROM PUBLIC;
REVOKE ALL ON TABLE censorcodecv FROM imiq;
GRANT ALL ON TABLE censorcodecv TO imiq;
GRANT ALL ON TABLE censorcodecv TO asjacobs;
GRANT ALL ON TABLE censorcodecv TO chaase;
GRANT ALL ON TABLE censorcodecv TO rwspicer;
GRANT SELECT ON TABLE censorcodecv TO imiq_reader;


--
-- Name: daily_airtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtemp FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtemp FROM imiq;
GRANT ALL ON TABLE daily_airtemp TO imiq;
GRANT ALL ON TABLE daily_airtemp TO asjacobs;
GRANT SELECT ON TABLE daily_airtemp TO imiq_reader;
GRANT ALL ON TABLE daily_airtemp TO rwspicer;
GRANT ALL ON TABLE daily_airtemp TO chaase;


--
-- Name: daily_airtempdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempdatavalues FROM imiq;
GRANT ALL ON TABLE daily_airtempdatavalues TO imiq;
GRANT ALL ON TABLE daily_airtempdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_airtempdatavalues TO chaase;
GRANT ALL ON TABLE daily_airtempdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_airtempdatavalues TO imiq_reader;


--
-- Name: daily_airtempmax; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempmax FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempmax FROM imiq;
GRANT ALL ON TABLE daily_airtempmax TO imiq;
GRANT ALL ON TABLE daily_airtempmax TO asjacobs;
GRANT SELECT ON TABLE daily_airtempmax TO imiq_reader;
GRANT ALL ON TABLE daily_airtempmax TO rwspicer;
GRANT ALL ON TABLE daily_airtempmax TO chaase;


--
-- Name: daily_airtempmaxdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempmaxdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempmaxdatavalues FROM imiq;
GRANT ALL ON TABLE daily_airtempmaxdatavalues TO imiq;
GRANT ALL ON TABLE daily_airtempmaxdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_airtempmaxdatavalues TO chaase;
GRANT ALL ON TABLE daily_airtempmaxdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_airtempmaxdatavalues TO imiq_reader;


--
-- Name: daily_airtempmin; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempmin FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempmin FROM imiq;
GRANT ALL ON TABLE daily_airtempmin TO imiq;
GRANT ALL ON TABLE daily_airtempmin TO asjacobs;
GRANT SELECT ON TABLE daily_airtempmin TO imiq_reader;
GRANT ALL ON TABLE daily_airtempmin TO rwspicer;
GRANT ALL ON TABLE daily_airtempmin TO chaase;


--
-- Name: daily_airtempmindatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempmindatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempmindatavalues FROM imiq;
GRANT ALL ON TABLE daily_airtempmindatavalues TO imiq;
GRANT ALL ON TABLE daily_airtempmindatavalues TO asjacobs;
GRANT ALL ON TABLE daily_airtempmindatavalues TO chaase;
GRANT ALL ON TABLE daily_airtempmindatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_airtempmindatavalues TO imiq_reader;


--
-- Name: daily_discharge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_discharge FROM PUBLIC;
REVOKE ALL ON TABLE daily_discharge FROM imiq;
GRANT ALL ON TABLE daily_discharge TO imiq;
GRANT ALL ON TABLE daily_discharge TO asjacobs;
GRANT SELECT ON TABLE daily_discharge TO imiq_reader;
GRANT ALL ON TABLE daily_discharge TO rwspicer;
GRANT ALL ON TABLE daily_discharge TO chaase;


--
-- Name: daily_dischargedatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_dischargedatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_dischargedatavalues FROM imiq;
GRANT ALL ON TABLE daily_dischargedatavalues TO imiq;
GRANT ALL ON TABLE daily_dischargedatavalues TO asjacobs;
GRANT ALL ON TABLE daily_dischargedatavalues TO chaase;
GRANT ALL ON TABLE daily_dischargedatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_dischargedatavalues TO imiq_reader;


--
-- Name: daily_precip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_precip FROM PUBLIC;
REVOKE ALL ON TABLE daily_precip FROM imiq;
GRANT ALL ON TABLE daily_precip TO imiq;
GRANT ALL ON TABLE daily_precip TO asjacobs;
GRANT ALL ON TABLE daily_precip TO chaase;
GRANT SELECT ON TABLE daily_precip TO imiq_reader;
GRANT ALL ON TABLE daily_precip TO rwspicer;


--
-- Name: daily_precip_thresholds; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_precip_thresholds FROM PUBLIC;
REVOKE ALL ON TABLE daily_precip_thresholds FROM imiq;
GRANT ALL ON TABLE daily_precip_thresholds TO imiq;
GRANT ALL ON TABLE daily_precip_thresholds TO asjacobs;
GRANT ALL ON TABLE daily_precip_thresholds TO chaase;
GRANT SELECT ON TABLE daily_precip_thresholds TO imiq_reader;
GRANT ALL ON TABLE daily_precip_thresholds TO rwspicer;


--
-- Name: daily_precipdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_precipdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_precipdatavalues FROM imiq;
GRANT ALL ON TABLE daily_precipdatavalues TO imiq;
GRANT ALL ON TABLE daily_precipdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_precipdatavalues TO chaase;
GRANT ALL ON TABLE daily_precipdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_precipdatavalues TO imiq_reader;


--
-- Name: daily_rh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_rh FROM PUBLIC;
REVOKE ALL ON TABLE daily_rh FROM imiq;
GRANT ALL ON TABLE daily_rh TO imiq;
GRANT ALL ON TABLE daily_rh TO asjacobs;
GRANT SELECT ON TABLE daily_rh TO imiq_reader;
GRANT ALL ON TABLE daily_rh TO rwspicer;
GRANT ALL ON TABLE daily_rh TO chaase;


--
-- Name: daily_rhdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_rhdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_rhdatavalues FROM imiq;
GRANT ALL ON TABLE daily_rhdatavalues TO imiq;
GRANT ALL ON TABLE daily_rhdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_rhdatavalues TO chaase;
GRANT ALL ON TABLE daily_rhdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_rhdatavalues TO imiq_reader;


--
-- Name: daily_snowdepth; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_snowdepth FROM PUBLIC;
REVOKE ALL ON TABLE daily_snowdepth FROM imiq;
GRANT ALL ON TABLE daily_snowdepth TO imiq;
GRANT ALL ON TABLE daily_snowdepth TO asjacobs;
GRANT ALL ON TABLE daily_snowdepth TO chaase;
GRANT ALL ON TABLE daily_snowdepth TO rwspicer;
GRANT SELECT ON TABLE daily_snowdepth TO imiq_reader;


--
-- Name: daily_snowdepthdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_snowdepthdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_snowdepthdatavalues FROM imiq;
GRANT ALL ON TABLE daily_snowdepthdatavalues TO imiq;
GRANT ALL ON TABLE daily_snowdepthdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_snowdepthdatavalues TO chaase;
GRANT ALL ON TABLE daily_snowdepthdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_snowdepthdatavalues TO imiq_reader;


--
-- Name: daily_swe; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_swe FROM PUBLIC;
REVOKE ALL ON TABLE daily_swe FROM imiq;
GRANT ALL ON TABLE daily_swe TO imiq;
GRANT ALL ON TABLE daily_swe TO asjacobs;
GRANT ALL ON TABLE daily_swe TO chaase;
GRANT ALL ON TABLE daily_swe TO rwspicer;
GRANT SELECT ON TABLE daily_swe TO imiq_reader;


--
-- Name: daily_swedatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_swedatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_swedatavalues FROM imiq;
GRANT ALL ON TABLE daily_swedatavalues TO imiq;
GRANT ALL ON TABLE daily_swedatavalues TO asjacobs;
GRANT ALL ON TABLE daily_swedatavalues TO chaase;
GRANT ALL ON TABLE daily_swedatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_swedatavalues TO imiq_reader;


--
-- Name: daily_watertemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_watertemp FROM PUBLIC;
REVOKE ALL ON TABLE daily_watertemp FROM imiq;
GRANT ALL ON TABLE daily_watertemp TO imiq;
GRANT ALL ON TABLE daily_watertemp TO asjacobs;
GRANT SELECT ON TABLE daily_watertemp TO imiq_reader;
GRANT ALL ON TABLE daily_watertemp TO rwspicer;
GRANT ALL ON TABLE daily_watertemp TO chaase;


--
-- Name: daily_watertempdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_watertempdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_watertempdatavalues FROM imiq;
GRANT ALL ON TABLE daily_watertempdatavalues TO imiq;
GRANT ALL ON TABLE daily_watertempdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_watertempdatavalues TO chaase;
GRANT ALL ON TABLE daily_watertempdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_watertempdatavalues TO imiq_reader;


--
-- Name: daily_winddirection; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_winddirection FROM PUBLIC;
REVOKE ALL ON TABLE daily_winddirection FROM imiq;
GRANT ALL ON TABLE daily_winddirection TO imiq;
GRANT ALL ON TABLE daily_winddirection TO asjacobs;
GRANT SELECT ON TABLE daily_winddirection TO imiq_reader;
GRANT ALL ON TABLE daily_winddirection TO rwspicer;
GRANT ALL ON TABLE daily_winddirection TO chaase;


--
-- Name: daily_winddirectiondatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_winddirectiondatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_winddirectiondatavalues FROM imiq;
GRANT ALL ON TABLE daily_winddirectiondatavalues TO imiq;
GRANT ALL ON TABLE daily_winddirectiondatavalues TO asjacobs;
GRANT ALL ON TABLE daily_winddirectiondatavalues TO chaase;
GRANT ALL ON TABLE daily_winddirectiondatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_winddirectiondatavalues TO imiq_reader;


--
-- Name: daily_windspeed; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_windspeed FROM PUBLIC;
REVOKE ALL ON TABLE daily_windspeed FROM imiq;
GRANT ALL ON TABLE daily_windspeed TO imiq;
GRANT ALL ON TABLE daily_windspeed TO asjacobs;
GRANT SELECT ON TABLE daily_windspeed TO imiq_reader;
GRANT ALL ON TABLE daily_windspeed TO rwspicer;
GRANT ALL ON TABLE daily_windspeed TO chaase;


--
-- Name: daily_windspeeddatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_windspeeddatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_windspeeddatavalues FROM imiq;
GRANT ALL ON TABLE daily_windspeeddatavalues TO imiq;
GRANT ALL ON TABLE daily_windspeeddatavalues TO asjacobs;
GRANT ALL ON TABLE daily_windspeeddatavalues TO chaase;
GRANT ALL ON TABLE daily_windspeeddatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_windspeeddatavalues TO imiq_reader;


--
-- Name: datastreams; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE datastreams FROM PUBLIC;
REVOKE ALL ON TABLE datastreams FROM imiq;
GRANT ALL ON TABLE datastreams TO imiq;
GRANT ALL ON TABLE datastreams TO asjacobs;
GRANT ALL ON TABLE datastreams TO chaase;
GRANT ALL ON TABLE datastreams TO rwspicer;
GRANT SELECT ON TABLE datastreams TO imiq_reader;


--
-- Name: datatypecv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE datatypecv FROM PUBLIC;
REVOKE ALL ON TABLE datatypecv FROM imiq;
GRANT ALL ON TABLE datatypecv TO imiq;
GRANT ALL ON TABLE datatypecv TO asjacobs;
GRANT ALL ON TABLE datatypecv TO chaase;
GRANT ALL ON TABLE datatypecv TO rwspicer;
GRANT SELECT ON TABLE datatypecv TO imiq_reader;


--
-- Name: datavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE datavalues FROM PUBLIC;
REVOKE ALL ON TABLE datavalues FROM imiq;
GRANT ALL ON TABLE datavalues TO imiq;
GRANT ALL ON TABLE datavalues TO asjacobs;
GRANT ALL ON TABLE datavalues TO chaase;
GRANT ALL ON TABLE datavalues TO rwspicer;
GRANT SELECT ON TABLE datavalues TO imiq_reader;


--
-- Name: datavaluesaggregate; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE datavaluesaggregate FROM PUBLIC;
REVOKE ALL ON TABLE datavaluesaggregate FROM imiq;
GRANT ALL ON TABLE datavaluesaggregate TO imiq;
GRANT ALL ON TABLE datavaluesaggregate TO asjacobs;
GRANT ALL ON TABLE datavaluesaggregate TO chaase;
GRANT SELECT ON TABLE datavaluesaggregate TO imiq_reader;
GRANT ALL ON TABLE datavaluesaggregate TO rwspicer;


--
-- Name: datavaluesraw; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE datavaluesraw FROM PUBLIC;
REVOKE ALL ON TABLE datavaluesraw FROM imiq;
GRANT ALL ON TABLE datavaluesraw TO imiq;
GRANT ALL ON TABLE datavaluesraw TO asjacobs;
GRANT ALL ON TABLE datavaluesraw TO chaase;
GRANT ALL ON TABLE datavaluesraw TO rwspicer;
GRANT SELECT ON TABLE datavaluesraw TO imiq_reader;


--
-- Name: derivedfrom; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE derivedfrom FROM PUBLIC;
REVOKE ALL ON TABLE derivedfrom FROM imiq;
GRANT ALL ON TABLE derivedfrom TO imiq;
GRANT ALL ON TABLE derivedfrom TO asjacobs;
GRANT ALL ON TABLE derivedfrom TO chaase;
GRANT ALL ON TABLE derivedfrom TO rwspicer;
GRANT SELECT ON TABLE derivedfrom TO imiq_reader;


--
-- Name: devices; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE devices FROM PUBLIC;
REVOKE ALL ON TABLE devices FROM imiq;
GRANT ALL ON TABLE devices TO imiq;
GRANT ALL ON TABLE devices TO asjacobs;
GRANT ALL ON TABLE devices TO chaase;
GRANT ALL ON TABLE devices TO rwspicer;
GRANT SELECT ON TABLE devices TO imiq_reader;


--
-- Name: ext_arc_arc; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_arc_arc FROM PUBLIC;
REVOKE ALL ON TABLE ext_arc_arc FROM imiq;
GRANT ALL ON TABLE ext_arc_arc TO imiq;
GRANT ALL ON TABLE ext_arc_arc TO asjacobs;
GRANT ALL ON TABLE ext_arc_arc TO chaase;
GRANT ALL ON TABLE ext_arc_arc TO rwspicer;
GRANT SELECT ON TABLE ext_arc_arc TO imiq_reader;


--
-- Name: ext_arc_point; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_arc_point FROM PUBLIC;
REVOKE ALL ON TABLE ext_arc_point FROM imiq;
GRANT ALL ON TABLE ext_arc_point TO imiq;
GRANT ALL ON TABLE ext_arc_point TO asjacobs;
GRANT ALL ON TABLE ext_arc_point TO chaase;
GRANT ALL ON TABLE ext_arc_point TO rwspicer;
GRANT SELECT ON TABLE ext_arc_point TO imiq_reader;


--
-- Name: ext_fws_fishsample; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_fws_fishsample FROM PUBLIC;
REVOKE ALL ON TABLE ext_fws_fishsample FROM imiq;
GRANT ALL ON TABLE ext_fws_fishsample TO imiq;
GRANT ALL ON TABLE ext_fws_fishsample TO asjacobs;
GRANT ALL ON TABLE ext_fws_fishsample TO chaase;
GRANT ALL ON TABLE ext_fws_fishsample TO rwspicer;
GRANT SELECT ON TABLE ext_fws_fishsample TO imiq_reader;


--
-- Name: ext_reference; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_reference FROM PUBLIC;
REVOKE ALL ON TABLE ext_reference FROM imiq;
GRANT ALL ON TABLE ext_reference TO imiq;
GRANT ALL ON TABLE ext_reference TO asjacobs;
GRANT ALL ON TABLE ext_reference TO chaase;
GRANT ALL ON TABLE ext_reference TO rwspicer;
GRANT SELECT ON TABLE ext_reference TO imiq_reader;


--
-- Name: ext_referencetowaterbody; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_referencetowaterbody FROM PUBLIC;
REVOKE ALL ON TABLE ext_referencetowaterbody FROM imiq;
GRANT ALL ON TABLE ext_referencetowaterbody TO imiq;
GRANT ALL ON TABLE ext_referencetowaterbody TO asjacobs;
GRANT ALL ON TABLE ext_referencetowaterbody TO chaase;
GRANT ALL ON TABLE ext_referencetowaterbody TO rwspicer;
GRANT SELECT ON TABLE ext_referencetowaterbody TO imiq_reader;


--
-- Name: ext_waterbody; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_waterbody FROM PUBLIC;
REVOKE ALL ON TABLE ext_waterbody FROM imiq;
GRANT ALL ON TABLE ext_waterbody TO imiq;
GRANT ALL ON TABLE ext_waterbody TO asjacobs;
GRANT ALL ON TABLE ext_waterbody TO chaase;
GRANT ALL ON TABLE ext_waterbody TO rwspicer;
GRANT SELECT ON TABLE ext_waterbody TO imiq_reader;


--
-- Name: generalcategorycv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE generalcategorycv FROM PUBLIC;
REVOKE ALL ON TABLE generalcategorycv FROM imiq;
GRANT ALL ON TABLE generalcategorycv TO imiq;
GRANT ALL ON TABLE generalcategorycv TO asjacobs;
GRANT ALL ON TABLE generalcategorycv TO chaase;
GRANT ALL ON TABLE generalcategorycv TO rwspicer;
GRANT SELECT ON TABLE generalcategorycv TO imiq_reader;


--
-- Name: groupdescriptions; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE groupdescriptions FROM PUBLIC;
REVOKE ALL ON TABLE groupdescriptions FROM imiq;
GRANT ALL ON TABLE groupdescriptions TO imiq;
GRANT ALL ON TABLE groupdescriptions TO asjacobs;
GRANT ALL ON TABLE groupdescriptions TO chaase;
GRANT ALL ON TABLE groupdescriptions TO rwspicer;
GRANT SELECT ON TABLE groupdescriptions TO imiq_reader;


--
-- Name: groups; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE groups FROM PUBLIC;
REVOKE ALL ON TABLE groups FROM imiq;
GRANT ALL ON TABLE groups TO imiq;
GRANT ALL ON TABLE groups TO asjacobs;
GRANT ALL ON TABLE groups TO chaase;
GRANT ALL ON TABLE groups TO rwspicer;
GRANT SELECT ON TABLE groups TO imiq_reader;


--
-- Name: hourly_airtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_airtemp FROM PUBLIC;
REVOKE ALL ON TABLE hourly_airtemp FROM imiq;
GRANT ALL ON TABLE hourly_airtemp TO imiq;
GRANT ALL ON TABLE hourly_airtemp TO asjacobs;
GRANT ALL ON TABLE hourly_airtemp TO chaase;
GRANT SELECT ON TABLE hourly_airtemp TO imiq_reader;
GRANT ALL ON TABLE hourly_airtemp TO rwspicer;


--
-- Name: hourly_airtempdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_airtempdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_airtempdatavalues FROM imiq;
GRANT ALL ON TABLE hourly_airtempdatavalues TO imiq;
GRANT ALL ON TABLE hourly_airtempdatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_airtempdatavalues TO chaase;
GRANT ALL ON TABLE hourly_airtempdatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_airtempdatavalues TO imiq_reader;


--
-- Name: hourly_precip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_precip FROM PUBLIC;
REVOKE ALL ON TABLE hourly_precip FROM imiq;
GRANT ALL ON TABLE hourly_precip TO imiq;
GRANT ALL ON TABLE hourly_precip TO asjacobs;
GRANT ALL ON TABLE hourly_precip TO chaase;
GRANT SELECT ON TABLE hourly_precip TO imiq_reader;
GRANT ALL ON TABLE hourly_precip TO rwspicer;


--
-- Name: hourly_precipdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_precipdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_precipdatavalues FROM imiq;
GRANT ALL ON TABLE hourly_precipdatavalues TO imiq;
GRANT ALL ON TABLE hourly_precipdatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_precipdatavalues TO chaase;
GRANT ALL ON TABLE hourly_precipdatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_precipdatavalues TO imiq_reader;


--
-- Name: hourly_rh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_rh FROM PUBLIC;
REVOKE ALL ON TABLE hourly_rh FROM imiq;
GRANT ALL ON TABLE hourly_rh TO imiq;
GRANT ALL ON TABLE hourly_rh TO asjacobs;
GRANT ALL ON TABLE hourly_rh TO chaase;
GRANT SELECT ON TABLE hourly_rh TO imiq_reader;
GRANT ALL ON TABLE hourly_rh TO rwspicer;


--
-- Name: hourly_rhdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_rhdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_rhdatavalues FROM imiq;
GRANT ALL ON TABLE hourly_rhdatavalues TO imiq;
GRANT ALL ON TABLE hourly_rhdatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_rhdatavalues TO chaase;
GRANT ALL ON TABLE hourly_rhdatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_rhdatavalues TO imiq_reader;


--
-- Name: hourly_snowdepth; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_snowdepth FROM PUBLIC;
REVOKE ALL ON TABLE hourly_snowdepth FROM imiq;
GRANT ALL ON TABLE hourly_snowdepth TO imiq;
GRANT ALL ON TABLE hourly_snowdepth TO asjacobs;
GRANT ALL ON TABLE hourly_snowdepth TO chaase;
GRANT ALL ON TABLE hourly_snowdepth TO rwspicer;
GRANT SELECT ON TABLE hourly_snowdepth TO imiq_reader;


--
-- Name: hourly_snowdepthdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_snowdepthdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_snowdepthdatavalues FROM imiq;
GRANT ALL ON TABLE hourly_snowdepthdatavalues TO imiq;
GRANT ALL ON TABLE hourly_snowdepthdatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_snowdepthdatavalues TO chaase;
GRANT ALL ON TABLE hourly_snowdepthdatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_snowdepthdatavalues TO imiq_reader;


--
-- Name: hourly_swe; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_swe FROM PUBLIC;
REVOKE ALL ON TABLE hourly_swe FROM imiq;
GRANT ALL ON TABLE hourly_swe TO imiq;
GRANT ALL ON TABLE hourly_swe TO asjacobs;
GRANT ALL ON TABLE hourly_swe TO chaase;
GRANT ALL ON TABLE hourly_swe TO rwspicer;
GRANT SELECT ON TABLE hourly_swe TO imiq_reader;


--
-- Name: hourly_swedatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_swedatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_swedatavalues FROM imiq;
GRANT ALL ON TABLE hourly_swedatavalues TO imiq;
GRANT ALL ON TABLE hourly_swedatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_swedatavalues TO chaase;
GRANT ALL ON TABLE hourly_swedatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_swedatavalues TO imiq_reader;


--
-- Name: hourly_winddirection; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_winddirection FROM PUBLIC;
REVOKE ALL ON TABLE hourly_winddirection FROM imiq;
GRANT ALL ON TABLE hourly_winddirection TO imiq;
GRANT ALL ON TABLE hourly_winddirection TO asjacobs;
GRANT ALL ON TABLE hourly_winddirection TO chaase;
GRANT SELECT ON TABLE hourly_winddirection TO imiq_reader;
GRANT ALL ON TABLE hourly_winddirection TO rwspicer;


--
-- Name: hourly_winddirectiondatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_winddirectiondatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_winddirectiondatavalues FROM imiq;
GRANT ALL ON TABLE hourly_winddirectiondatavalues TO imiq;
GRANT ALL ON TABLE hourly_winddirectiondatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_winddirectiondatavalues TO chaase;
GRANT ALL ON TABLE hourly_winddirectiondatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_winddirectiondatavalues TO imiq_reader;


--
-- Name: hourly_windspeed; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_windspeed FROM PUBLIC;
REVOKE ALL ON TABLE hourly_windspeed FROM imiq;
GRANT ALL ON TABLE hourly_windspeed TO imiq;
GRANT ALL ON TABLE hourly_windspeed TO asjacobs;
GRANT ALL ON TABLE hourly_windspeed TO chaase;
GRANT SELECT ON TABLE hourly_windspeed TO imiq_reader;
GRANT ALL ON TABLE hourly_windspeed TO rwspicer;


--
-- Name: hourly_windspeeddatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_windspeeddatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_windspeeddatavalues FROM imiq;
GRANT ALL ON TABLE hourly_windspeeddatavalues TO imiq;
GRANT ALL ON TABLE hourly_windspeeddatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_windspeeddatavalues TO chaase;
GRANT ALL ON TABLE hourly_windspeeddatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_windspeeddatavalues TO imiq_reader;


--
-- Name: imiqversion; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE imiqversion FROM PUBLIC;
REVOKE ALL ON TABLE imiqversion FROM imiq;
GRANT ALL ON TABLE imiqversion TO imiq;
GRANT ALL ON TABLE imiqversion TO asjacobs;
GRANT ALL ON TABLE imiqversion TO chaase;
GRANT ALL ON TABLE imiqversion TO rwspicer;
GRANT SELECT ON TABLE imiqversion TO imiq_reader;


--
-- Name: incidents; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE incidents FROM PUBLIC;
REVOKE ALL ON TABLE incidents FROM imiq;
GRANT ALL ON TABLE incidents TO imiq;
GRANT ALL ON TABLE incidents TO asjacobs;
GRANT ALL ON TABLE incidents TO chaase;
GRANT ALL ON TABLE incidents TO rwspicer;
GRANT SELECT ON TABLE incidents TO imiq_reader;


--
-- Name: isometadata; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE isometadata FROM PUBLIC;
REVOKE ALL ON TABLE isometadata FROM imiq;
GRANT ALL ON TABLE isometadata TO imiq;
GRANT ALL ON TABLE isometadata TO asjacobs;
GRANT ALL ON TABLE isometadata TO chaase;
GRANT ALL ON TABLE isometadata TO rwspicer;
GRANT SELECT ON TABLE isometadata TO imiq_reader;


--
-- Name: methods; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE methods FROM PUBLIC;
REVOKE ALL ON TABLE methods FROM imiq;
GRANT ALL ON TABLE methods TO imiq;
GRANT ALL ON TABLE methods TO asjacobs;
GRANT ALL ON TABLE methods TO chaase;
GRANT ALL ON TABLE methods TO rwspicer;
GRANT SELECT ON TABLE methods TO imiq_reader;


--
-- Name: monthly_airtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_airtemp FROM PUBLIC;
REVOKE ALL ON TABLE monthly_airtemp FROM imiq;
GRANT ALL ON TABLE monthly_airtemp TO imiq;
GRANT ALL ON TABLE monthly_airtemp TO asjacobs;
GRANT ALL ON TABLE monthly_airtemp TO chaase;
GRANT SELECT ON TABLE monthly_airtemp TO imiq_reader;
GRANT ALL ON TABLE monthly_airtemp TO rwspicer;


--
-- Name: monthly_airtemp_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_airtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_airtemp_all FROM imiq;
GRANT ALL ON TABLE monthly_airtemp_all TO imiq;
GRANT ALL ON TABLE monthly_airtemp_all TO asjacobs;
GRANT ALL ON TABLE monthly_airtemp_all TO chaase;
GRANT SELECT ON TABLE monthly_airtemp_all TO imiq_reader;
GRANT ALL ON TABLE monthly_airtemp_all TO rwspicer;


--
-- Name: monthly_discharge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_discharge FROM PUBLIC;
REVOKE ALL ON TABLE monthly_discharge FROM imiq;
GRANT ALL ON TABLE monthly_discharge TO imiq;
GRANT ALL ON TABLE monthly_discharge TO asjacobs;
GRANT ALL ON TABLE monthly_discharge TO chaase;
GRANT SELECT ON TABLE monthly_discharge TO imiq_reader;
GRANT ALL ON TABLE monthly_discharge TO rwspicer;


--
-- Name: monthly_discharge_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_discharge_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_discharge_all FROM imiq;
GRANT ALL ON TABLE monthly_discharge_all TO imiq;
GRANT ALL ON TABLE monthly_discharge_all TO asjacobs;
GRANT ALL ON TABLE monthly_discharge_all TO chaase;
GRANT SELECT ON TABLE monthly_discharge_all TO imiq_reader;
GRANT ALL ON TABLE monthly_discharge_all TO rwspicer;


--
-- Name: monthly_precip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_precip FROM PUBLIC;
REVOKE ALL ON TABLE monthly_precip FROM imiq;
GRANT ALL ON TABLE monthly_precip TO imiq;
GRANT ALL ON TABLE monthly_precip TO asjacobs;
GRANT ALL ON TABLE monthly_precip TO chaase;
GRANT SELECT ON TABLE monthly_precip TO imiq_reader;
GRANT ALL ON TABLE monthly_precip TO rwspicer;


--
-- Name: monthly_precip_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_precip_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_precip_all FROM imiq;
GRANT ALL ON TABLE monthly_precip_all TO imiq;
GRANT ALL ON TABLE monthly_precip_all TO asjacobs;
GRANT ALL ON TABLE monthly_precip_all TO chaase;
GRANT SELECT ON TABLE monthly_precip_all TO imiq_reader;
GRANT ALL ON TABLE monthly_precip_all TO rwspicer;


--
-- Name: monthly_rh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_rh FROM PUBLIC;
REVOKE ALL ON TABLE monthly_rh FROM imiq;
GRANT ALL ON TABLE monthly_rh TO imiq;
GRANT ALL ON TABLE monthly_rh TO asjacobs;
GRANT ALL ON TABLE monthly_rh TO chaase;
GRANT SELECT ON TABLE monthly_rh TO imiq_reader;
GRANT ALL ON TABLE monthly_rh TO rwspicer;


--
-- Name: monthly_rh_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_rh_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_rh_all FROM imiq;
GRANT ALL ON TABLE monthly_rh_all TO imiq;
GRANT ALL ON TABLE monthly_rh_all TO asjacobs;
GRANT ALL ON TABLE monthly_rh_all TO chaase;
GRANT ALL ON TABLE monthly_rh_all TO rwspicer;
GRANT SELECT ON TABLE monthly_rh_all TO imiq_reader;


--
-- Name: monthly_snowdepthavg; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_snowdepthavg FROM PUBLIC;
REVOKE ALL ON TABLE monthly_snowdepthavg FROM imiq;
GRANT ALL ON TABLE monthly_snowdepthavg TO imiq;
GRANT ALL ON TABLE monthly_snowdepthavg TO asjacobs;
GRANT ALL ON TABLE monthly_snowdepthavg TO chaase;
GRANT SELECT ON TABLE monthly_snowdepthavg TO imiq_reader;
GRANT ALL ON TABLE monthly_snowdepthavg TO rwspicer;


--
-- Name: monthly_snowdepthavg_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_snowdepthavg_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_snowdepthavg_all FROM imiq;
GRANT ALL ON TABLE monthly_snowdepthavg_all TO imiq;
GRANT ALL ON TABLE monthly_snowdepthavg_all TO asjacobs;
GRANT SELECT ON TABLE monthly_snowdepthavg_all TO imiq_reader;
GRANT ALL ON TABLE monthly_snowdepthavg_all TO rwspicer;


--
-- Name: monthly_sweavg; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_sweavg FROM PUBLIC;
REVOKE ALL ON TABLE monthly_sweavg FROM imiq;
GRANT ALL ON TABLE monthly_sweavg TO imiq;
GRANT ALL ON TABLE monthly_sweavg TO asjacobs;
GRANT ALL ON TABLE monthly_sweavg TO chaase;
GRANT SELECT ON TABLE monthly_sweavg TO imiq_reader;
GRANT ALL ON TABLE monthly_sweavg TO rwspicer;


--
-- Name: monthly_sweavg_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_sweavg_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_sweavg_all FROM imiq;
GRANT ALL ON TABLE monthly_sweavg_all TO imiq;
GRANT ALL ON TABLE monthly_sweavg_all TO asjacobs;
GRANT SELECT ON TABLE monthly_sweavg_all TO imiq_reader;
GRANT ALL ON TABLE monthly_sweavg_all TO rwspicer;


--
-- Name: multiyear_annual_all_avgairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgdischarge TO imiq_reader;


--
-- Name: multiyear_annual_all_avgfallairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgfallairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgfallairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgfallairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgfallairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgfallairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgfallairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgfallairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgfallprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgfallprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgfallprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgfallprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgfallprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgfallprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgfallprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgfallprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgpeakdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgpeakdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgpeakdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgpeakdischarge TO imiq_reader;


--
-- Name: multiyear_annual_all_avgpeaksnowdepth; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgpeaksnowdepth TO imiq_reader;


--
-- Name: multiyear_annual_all_avgpeakswe; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgpeakswe FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgpeakswe FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakswe TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakswe TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakswe TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakswe TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgpeakswe TO imiq_reader;


--
-- Name: multiyear_annual_all_avgprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgrh TO imiq_reader;


--
-- Name: multiyear_annual_all_avgspringairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgspringairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgspringairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgspringairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgspringairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgspringairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgspringairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgspringairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgspringprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgspringprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgspringprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgspringprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgspringprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgspringprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgspringprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgspringprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgsummerairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgsummerairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgsummerairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgsummerairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgsummerdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgsummerdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgsummerdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgsummerdischarge TO imiq_reader;


--
-- Name: multiyear_annual_all_avgsummerprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgsummerprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgsummerprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgsummerprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgsummerrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgsummerrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgsummerrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgsummerrh TO imiq_reader;


--
-- Name: multiyear_annual_all_avgwinterairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgwinterairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgwinterairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgwinterairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgwinterprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgwinterprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgwinterprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgwinterprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgwinterrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgwinterrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgwinterrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgwinterrh TO imiq_reader;


--
-- Name: multiyear_annual_avgairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgdischarge TO imiq_reader;


--
-- Name: multiyear_annual_avgfallairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgfallairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgfallairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgfallairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgfallairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgfallairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgfallairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgfallairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgfallprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgfallprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgfallprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgfallprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgfallprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgfallprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgfallprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgfallprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgpeakdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgpeakdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgpeakdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeakdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeakdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgpeakdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgpeakdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgpeakdischarge TO imiq_reader;


--
-- Name: multiyear_annual_avgpeaksnowdepth; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgpeaksnowdepth FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgpeaksnowdepth FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeaksnowdepth TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeaksnowdepth TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgpeaksnowdepth TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgpeaksnowdepth TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgpeaksnowdepth TO imiq_reader;


--
-- Name: multiyear_annual_avgpeakswe; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgpeakswe FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgpeakswe FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeakswe TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeakswe TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgpeakswe TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgpeakswe TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgpeakswe TO imiq_reader;


--
-- Name: multiyear_annual_avgprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgrh TO imiq_reader;


--
-- Name: multiyear_annual_avgspringairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgspringairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgspringairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgspringairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgspringairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgspringairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgspringairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgspringairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgspringprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgspringprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgspringprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgspringprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgspringprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgspringprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgspringprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgspringprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgsummerairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgsummerairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgsummerairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgsummerairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgsummerairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgsummerairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgsummerdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgsummerdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgsummerdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgsummerdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgsummerdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgsummerdischarge TO imiq_reader;


--
-- Name: multiyear_annual_avgsummerprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgsummerprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgsummerprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgsummerprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgsummerprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgsummerprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgsummerrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgsummerrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgsummerrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgsummerrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgsummerrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgsummerrh TO imiq_reader;


--
-- Name: multiyear_annual_avgwinterairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgwinterairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgwinterairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgwinterairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgwinterairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgwinterairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgwinterprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgwinterprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgwinterprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgwinterprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgwinterprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgwinterprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgwinterrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgwinterrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgwinterrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgwinterrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgwinterrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgwinterrh TO imiq_reader;


--
-- Name: networkdescriptions; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE networkdescriptions FROM PUBLIC;
REVOKE ALL ON TABLE networkdescriptions FROM imiq;
GRANT ALL ON TABLE networkdescriptions TO imiq;
GRANT ALL ON TABLE networkdescriptions TO asjacobs;
GRANT ALL ON TABLE networkdescriptions TO chaase;
GRANT ALL ON TABLE networkdescriptions TO rwspicer;
GRANT SELECT ON TABLE networkdescriptions TO imiq_reader;


--
-- Name: nhd_huc8; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE nhd_huc8 FROM PUBLIC;
REVOKE ALL ON TABLE nhd_huc8 FROM imiq;
GRANT ALL ON TABLE nhd_huc8 TO imiq;
GRANT ALL ON TABLE nhd_huc8 TO asjacobs;
GRANT ALL ON TABLE nhd_huc8 TO chaase;
GRANT ALL ON TABLE nhd_huc8 TO rwspicer;
GRANT SELECT ON TABLE nhd_huc8 TO imiq_reader;


--
-- Name: sites; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE sites FROM PUBLIC;
REVOKE ALL ON TABLE sites FROM imiq;
GRANT ALL ON TABLE sites TO imiq;
GRANT ALL ON TABLE sites TO asjacobs;
GRANT ALL ON TABLE sites TO chaase;
GRANT ALL ON TABLE sites TO rwspicer;
GRANT SELECT ON TABLE sites TO imiq_reader;


--
-- Name: variables; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE variables FROM PUBLIC;
REVOKE ALL ON TABLE variables FROM imiq;
GRANT ALL ON TABLE variables TO imiq;
GRANT ALL ON TABLE variables TO asjacobs;
GRANT ALL ON TABLE variables TO chaase;
GRANT ALL ON TABLE variables TO rwspicer;
GRANT SELECT ON TABLE variables TO imiq_reader;


--
-- Name: odmdatavalues_metric; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE odmdatavalues_metric FROM PUBLIC;
REVOKE ALL ON TABLE odmdatavalues_metric FROM imiq;
GRANT ALL ON TABLE odmdatavalues_metric TO imiq;
GRANT ALL ON TABLE odmdatavalues_metric TO asjacobs;
GRANT SELECT ON TABLE odmdatavalues_metric TO imiq_reader;
GRANT ALL ON TABLE odmdatavalues_metric TO rwspicer;


--
-- Name: offsettypes; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE offsettypes FROM PUBLIC;
REVOKE ALL ON TABLE offsettypes FROM imiq;
GRANT ALL ON TABLE offsettypes TO imiq;
GRANT ALL ON TABLE offsettypes TO asjacobs;
GRANT ALL ON TABLE offsettypes TO chaase;
GRANT ALL ON TABLE offsettypes TO rwspicer;
GRANT SELECT ON TABLE offsettypes TO imiq_reader;


--
-- Name: organizationdescriptions; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE organizationdescriptions FROM PUBLIC;
REVOKE ALL ON TABLE organizationdescriptions FROM imiq;
GRANT ALL ON TABLE organizationdescriptions TO imiq;
GRANT ALL ON TABLE organizationdescriptions TO asjacobs;
GRANT ALL ON TABLE organizationdescriptions TO chaase;
GRANT ALL ON TABLE organizationdescriptions TO rwspicer;
GRANT SELECT ON TABLE organizationdescriptions TO imiq_reader;


--
-- Name: organizations; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE organizations FROM PUBLIC;
REVOKE ALL ON TABLE organizations FROM imiq;
GRANT ALL ON TABLE organizations TO imiq;
GRANT ALL ON TABLE organizations TO asjacobs;
GRANT ALL ON TABLE organizations TO chaase;
GRANT ALL ON TABLE organizations TO rwspicer;
GRANT SELECT ON TABLE organizations TO imiq_reader;


--
-- Name: processing; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE processing FROM PUBLIC;
REVOKE ALL ON TABLE processing FROM imiq;
GRANT ALL ON TABLE processing TO imiq;
GRANT ALL ON TABLE processing TO asjacobs;
GRANT ALL ON TABLE processing TO chaase;
GRANT ALL ON TABLE processing TO rwspicer;
GRANT SELECT ON TABLE processing TO imiq_reader;


--
-- Name: qualifiers; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE qualifiers FROM PUBLIC;
REVOKE ALL ON TABLE qualifiers FROM imiq;
GRANT ALL ON TABLE qualifiers TO imiq;
GRANT ALL ON TABLE qualifiers TO asjacobs;
GRANT ALL ON TABLE qualifiers TO chaase;
GRANT ALL ON TABLE qualifiers TO rwspicer;
GRANT SELECT ON TABLE qualifiers TO imiq_reader;


--
-- Name: qualitycontrollevels; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE qualitycontrollevels FROM PUBLIC;
REVOKE ALL ON TABLE qualitycontrollevels FROM imiq;
GRANT ALL ON TABLE qualitycontrollevels TO imiq;
GRANT ALL ON TABLE qualitycontrollevels TO asjacobs;
GRANT ALL ON TABLE qualitycontrollevels TO chaase;
GRANT ALL ON TABLE qualitycontrollevels TO rwspicer;
GRANT SELECT ON TABLE qualitycontrollevels TO imiq_reader;


--
-- Name: rasterdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE rasterdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE rasterdatavalues FROM imiq;
GRANT ALL ON TABLE rasterdatavalues TO imiq;
GRANT ALL ON TABLE rasterdatavalues TO asjacobs;
GRANT ALL ON TABLE rasterdatavalues TO chaase;
GRANT ALL ON TABLE rasterdatavalues TO rwspicer;
GRANT SELECT ON TABLE rasterdatavalues TO imiq_reader;


--
-- Name: samplemediumcv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE samplemediumcv FROM PUBLIC;
REVOKE ALL ON TABLE samplemediumcv FROM imiq;
GRANT ALL ON TABLE samplemediumcv TO imiq;
GRANT ALL ON TABLE samplemediumcv TO asjacobs;
GRANT ALL ON TABLE samplemediumcv TO chaase;
GRANT ALL ON TABLE samplemediumcv TO rwspicer;
GRANT SELECT ON TABLE samplemediumcv TO imiq_reader;


--
-- Name: seriescatalog; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE seriescatalog FROM PUBLIC;
REVOKE ALL ON TABLE seriescatalog FROM imiq;
GRANT ALL ON TABLE seriescatalog TO imiq;
GRANT ALL ON TABLE seriescatalog TO asjacobs;
GRANT ALL ON TABLE seriescatalog TO chaase;
GRANT SELECT ON TABLE seriescatalog TO imiq_reader;
GRANT ALL ON TABLE seriescatalog TO rwspicer;


--
-- Name: siteattributes; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE siteattributes FROM PUBLIC;
REVOKE ALL ON TABLE siteattributes FROM imiq;
GRANT ALL ON TABLE siteattributes TO imiq;
GRANT ALL ON TABLE siteattributes TO asjacobs;
GRANT ALL ON TABLE siteattributes TO chaase;
GRANT ALL ON TABLE siteattributes TO rwspicer;
GRANT SELECT ON TABLE siteattributes TO imiq_reader;


--
-- Name: sources; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE sources FROM PUBLIC;
REVOKE ALL ON TABLE sources FROM imiq;
GRANT ALL ON TABLE sources TO imiq;
GRANT ALL ON TABLE sources TO asjacobs;
GRANT ALL ON TABLE sources TO chaase;
GRANT ALL ON TABLE sources TO rwspicer;
GRANT SELECT ON TABLE sources TO imiq_reader;


--
-- Name: spatialreferences; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE spatialreferences FROM PUBLIC;
REVOKE ALL ON TABLE spatialreferences FROM imiq;
GRANT ALL ON TABLE spatialreferences TO imiq;
GRANT ALL ON TABLE spatialreferences TO asjacobs;
GRANT ALL ON TABLE spatialreferences TO chaase;
GRANT ALL ON TABLE spatialreferences TO rwspicer;
GRANT SELECT ON TABLE spatialreferences TO imiq_reader;


--
-- Name: speciationcv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE speciationcv FROM PUBLIC;
REVOKE ALL ON TABLE speciationcv FROM imiq;
GRANT ALL ON TABLE speciationcv TO imiq;
GRANT ALL ON TABLE speciationcv TO asjacobs;
GRANT ALL ON TABLE speciationcv TO chaase;
GRANT ALL ON TABLE speciationcv TO rwspicer;
GRANT SELECT ON TABLE speciationcv TO imiq_reader;


--
-- Name: sysdiagrams; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE sysdiagrams FROM PUBLIC;
REVOKE ALL ON TABLE sysdiagrams FROM imiq;
GRANT ALL ON TABLE sysdiagrams TO imiq;
GRANT ALL ON TABLE sysdiagrams TO asjacobs;
GRANT ALL ON TABLE sysdiagrams TO chaase;
GRANT ALL ON TABLE sysdiagrams TO rwspicer;
GRANT SELECT ON TABLE sysdiagrams TO imiq_reader;


--
-- Name: topiccategorycv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE topiccategorycv FROM PUBLIC;
REVOKE ALL ON TABLE topiccategorycv FROM imiq;
GRANT ALL ON TABLE topiccategorycv TO imiq;
GRANT ALL ON TABLE topiccategorycv TO asjacobs;
GRANT ALL ON TABLE topiccategorycv TO chaase;
GRANT ALL ON TABLE topiccategorycv TO rwspicer;
GRANT SELECT ON TABLE topiccategorycv TO imiq_reader;


--
-- Name: units; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE units FROM PUBLIC;
REVOKE ALL ON TABLE units FROM imiq;
GRANT ALL ON TABLE units TO imiq;
GRANT ALL ON TABLE units TO asjacobs;
GRANT ALL ON TABLE units TO chaase;
GRANT ALL ON TABLE units TO rwspicer;
GRANT SELECT ON TABLE units TO imiq_reader;


--
-- Name: valuetypecv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE valuetypecv FROM PUBLIC;
REVOKE ALL ON TABLE valuetypecv FROM imiq;
GRANT ALL ON TABLE valuetypecv TO imiq;
GRANT ALL ON TABLE valuetypecv TO asjacobs;
GRANT ALL ON TABLE valuetypecv TO chaase;
GRANT ALL ON TABLE valuetypecv TO rwspicer;
GRANT SELECT ON TABLE valuetypecv TO imiq_reader;


--
-- Name: variablenamecv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE variablenamecv FROM PUBLIC;
REVOKE ALL ON TABLE variablenamecv FROM imiq;
GRANT ALL ON TABLE variablenamecv TO imiq;
GRANT ALL ON TABLE variablenamecv TO asjacobs;
GRANT ALL ON TABLE variablenamecv TO chaase;
GRANT ALL ON TABLE variablenamecv TO rwspicer;
GRANT SELECT ON TABLE variablenamecv TO imiq_reader;


--
-- Name: verticaldatumcv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE verticaldatumcv FROM PUBLIC;
REVOKE ALL ON TABLE verticaldatumcv FROM imiq;
GRANT ALL ON TABLE verticaldatumcv TO imiq;
GRANT ALL ON TABLE verticaldatumcv TO asjacobs;
GRANT ALL ON TABLE verticaldatumcv TO chaase;
GRANT ALL ON TABLE verticaldatumcv TO rwspicer;
GRANT SELECT ON TABLE verticaldatumcv TO imiq_reader;


SET search_path = views, pg_catalog;

--
-- Name: odmdatavalues; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE odmdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE odmdatavalues FROM imiq;
GRANT ALL ON TABLE odmdatavalues TO imiq;
GRANT ALL ON TABLE odmdatavalues TO asjacobs;
GRANT ALL ON TABLE odmdatavalues TO chaase;
GRANT ALL ON TABLE odmdatavalues TO rwspicer;
GRANT SELECT ON TABLE odmdatavalues TO imiq_reader;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

