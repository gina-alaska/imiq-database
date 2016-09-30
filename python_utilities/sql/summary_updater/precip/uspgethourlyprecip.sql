-- Function: tables.uspgethourlyprecip(integer, integer)

-- DROP FUNCTION tables.uspgethourlyprecip(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgethourlyprecip(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgethourlyprecip(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyprecip(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyprecip(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyprecip(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyprecip(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgethourlyprecip(integer, integer) TO chaase;
COMMENT ON FUNCTION tables.uspgethourlyprecip(integer, integer) IS 'Used to populate the ''hourly_precipdatavalues'' table.';
