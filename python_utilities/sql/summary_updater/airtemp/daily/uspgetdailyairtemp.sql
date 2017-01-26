-- uspgetdailyairtemp.sql
--
--
-- version 1.0.0
-- updated 2017-01-12
--
-- changelog:
-- 1.0.0: added comments, added BOEM

-- Function: tables.uspgetdailyairtemp(integer, integer)

-- DROP FUNCTION tables.uspgetdailyairtemp(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailyairtemp(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
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
-- OR
--   BOEM: Temp/hourly/C, AKST
--   SourceID = 248,249,250,251,252,253,254,255,256,257,258, VariableID = 1032
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
        EXISTS( SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1136) OR
        EXISTS(SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2=1032)
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailyairtemp(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtemp(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtemp(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtemp(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtemp(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyairtemp(integer, integer) TO chaase;
