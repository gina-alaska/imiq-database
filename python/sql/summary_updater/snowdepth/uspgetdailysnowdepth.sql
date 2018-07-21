-- uspgetdailysnowdepth.sql
-- 
-- version 1.1.1
-- updated 2017-04-06
-- 
-- changelog:
-- 1.1.1: removed grant statments
-- 1.1.0: added BOEM
-- 1.0.0: initial version
-- Function: tables.uspgetdailysnowdepth(integer, integer)

-- DROP FUNCTION tables.uspgetdailysnowdepth(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailysnowdepth(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
        avgValue float;
        maxCursor refcursor;

BEGIN
-- UTC time & convert mm to Meteres for:
--   GHCN 
--   SourceI 210, VariableID = 402, daily raw data
-- OR
--   RAWS Snow Depth mm
--   SourceID = 211,214,215,216,217,218,219, VariableID = 440, daily raw data
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 402) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 440)
  THEN
    OPEN maxCursor
    for execute format ('SELECT dv.DateTimeUTC as DateTimeUTC,dv.DataValue FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2;') using site_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          -- ~ SELECT avgValue = avgValue / 1000.0; -- convert to meters
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue/ 1000.0 , DateTimeUTC, $1, $2,NOW()); 
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
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',DateTimeUTC);') using site_id, var_id;
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
--   SourceID = 29,30,34,223, VariableID = 75 
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
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',DateTimeUTC);') using site_id, var_id;
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
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 320) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 612) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 396) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 193) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 543) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 584) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 835)
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'',DateTimeUTC) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',DateTimeUTC);') using site_id, var_id;
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
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') using site_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue, DateTimeUTC, $1, $2,NOW()); 
        end loop;
    CLOSE maxCursor;
-- avg of ulocal: cm to m 
-- Local dateTime Average (convert cm to meters) for:
--   UAF/WERC Snow Depth meters/daily
--   SourceID = 3,193, VariableID = 142
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 142)
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'',localdatetime) as DateTimeUTC,AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',localdatetime);') using site_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue/ 100.0, DateTimeUTC, $1 , $2,NOW()); 
        end loop;
    CLOSE maxCursor;
-- avg of utcday cm to m 
--   BOEM avg of minute data, convert from cm to m
--   sourceIDs: 248 to 258, VariableID: 1045
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE SiteID = $1 AND $2 = 1045)   
  THEN
    OPEN maxCursor
    for execute format ('SELECT date_trunc(''day'',DateTimeUTC) as DateTimeUTC,AVG(dv.DataValue) as avgValue FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2 GROUP BY date_trunc(''day'',DateTimeUTC);') using site_id, var_id;
        loop
	  fetch maxCursor into dateTimeUTC, avgValue;
          if not found then
            exit;
          end if;
          INSERT INTO tables.daily_snowdepthdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate)
                 VALUES(avgValue/ 100.0, DateTimeUTC, $1 , $2 ,NOW()); 
        end loop;
    CLOSE maxCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailysnowdepth(integer, integer)
  OWNER TO imiq;

