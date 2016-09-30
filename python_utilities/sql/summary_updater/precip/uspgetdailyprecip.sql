-- Function: tables.uspgetdailyprecip(integer, integer)

-- DROP FUNCTION tables.uspgetdailyprecip(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailyprecip(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailyprecip(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyprecip(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyprecip(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyprecip(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyprecip(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyprecip(integer, integer) TO chaase;
COMMENT ON FUNCTION tables.uspgetdailyprecip(integer, integer) IS 'Used to populate the ''daily_precipdatavalues'' table.

If there is are hourly data values for a site, those values are used to compute the daily data value.  This is because the hourly precip has already undergone a threshold test.';
