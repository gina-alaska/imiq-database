-- uspgethourlyprecip.sql
--
--
-- version 1.0.0
-- updated 2017-02-24
--
-- changelog:
-- 1.0.0: created from old uspgerhourlyprecip.sql

CREATE OR REPLACE FUNCTION tables.uspgethourlyprecip(
    site_id INTEGER,
    var_id INTEGER)
RETURNS void AS
$BODY$
DECLARE datetimeutc TIMESTAMP WITHOUT TIME ZONE;
	summaryvalue FLOAT;
	max_cursor refcursor;
BEGIN
    -- Taking the highest precip recorded in the hour
    -- for: 
    --   ISH: VariableID = 340 is ISH Precip/UTC hourly/mm.  SourceID = 209
    --   UAF/WERC: VariableID = 84 Precip/mm AST. SourceID = 29, 30, 31, 34
    --   USGS: VariableID = 319 Precip/hourly/mm, AST. SourceID = 39
    --   Toolik: VariableID = 461 Precip/hourly/mm, AST. SourceID = 145 loading pluvio, which is year round precip
    --   ARC LTER: VariableID = 823  /hourly/mm, AST. SourceID = 144
    --   BLM/Kemenitz: VariableID = 496 Precip/mm/Hourly. SourceID = 199
    --   NOAA: VariableID = 522 Precip/mm/Minute.  SourceID = 35
    --   LPeters:  VariableID = 294 Precip/Hourly.  SourceID = 182
    --   CALON: VariableID = 1139  Precip/Hourly.  SourceID = 263
    --   NPS: VariableID = 1170, Prechp/hourly. Sourceid = 136
    IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 340) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 84) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 319) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 461) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 823) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 496) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 522) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 294) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1139) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1170)
    THEN
        OPEN max_cursor 
        FOR EXECUTE format(
            'SELECT date_trunc(''hour'',datetimeutc) AS datetimeutc,
                    MAX(dv.datavalue) 
             FROM tables.odmdatavalues_metric AS dv 
             WHERE dv.siteid = $1 and dv.originalvariableid=$2 
             GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
        LOOP
            FETCH max_cursor INTO datetimeutc, summaryvalue;
            IF NOT FOUND THEN
                EXIT;
            END IF;
            INSERT INTO tables.hourly_precipdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate) 
                VALUES(summaryvalue, datetimeutc, $1, $2, NOW());
         -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,summaryvalue;
        END LOOP;
        CLOSE max_cursor;
    -- Taking the SUM precip for the hour 
    -- for:
    --   AON: VariableID = 811 /hourly/mm, AST. SourceID = 222
    --   BLM/Kemenitz: VariableID = 458 Precip/inches/every 15 minutes  SourceID = 199. SUM, not max, since the DataValue is not accumulating over the hour.
    --   BLM/Kemenitz: VariableID = 336 Precip/inches/Minute  SourceID = 139
    --   ARM TPS: VariableID = 539 Precip Rate/hour Precip/mm/Minute  SourceID = 1, 203. SUM, not max, since the DataValue is not accumulating over the hour.
    --   ARM. VariableID = 526 Precip/mm/Minute  SourceID = 202. SUM, not max, since the DataValue is not accumulating over the hour. 
    ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 811) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 458) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 336) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 539) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 526)
    THEN
        OPEN max_cursor 
        FOR EXECUTE format(
            'SELECT date_trunc(''hour'',datetimeutc) AS DateTimeUTC,
                    SUM(dv.DataValue) 
             FROM tables.odmdatavalues_metric AS dv 
             WHERE dv.siteid = $1 AND dv.originalvariableid=$2 
             GROUP BY date_trunc(''hour'',datetimeutc);') USING site_id,var_id;
        LOOP
            FETCH max_cursor INTO datetimeutc, summaryvalue;
            IF NOT FOUND THEN
                EXIT;
            END IF;
            INSERT INTO tables.hourly_precipdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate) 
                VALUES(summaryvalue, datetimeutc, $1, $2, NOW());
         -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,summaryvalue;
        END LOOP;
        CLOSE max_cursor;
    -- Taking the value on the hour, since it is the accumulated value for the hour
    -- RWIS: VariableID = 575 Precip/Mintues  SourceID = 213
    -- BOEM: VariableID = 1042 Precip acumulated 1hr. SourceIDs = 248 through 258
    ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 575) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1042) 
    THEN
        OPEN max_cursor 
        FOR execute format(
            'SELECT date_trunc(''hour'',dv.datetimeutc) AS datetiemutc, 
                    dv.datavalue 
             FROM tables.odmdatavalues_metric AS dv 
             INNER JOIN (
                SELECT date_trunc(''hour'',datetimeutc) as hourtimeutc,
                       MIN(dv2.datetimeutc) as datetimeutc
                FROM tables.odmdatavalues_metric dv2
                WHERE dv2.siteid = $1 and dv2.originalvariableid=$2
                GROUP BY date_trunc(''hour'',datetimeutc)) dv3
            ON dv3.DateTimeUTC = dv.DateTimeUTC
            WHERE dv.SiteID = $1 and dv.OriginalVariableid=$2
            order by dv.DateTimeUTC;') USING site_id,var_id;
        LOOP
            FETCH max_cursor INTO datetimeutc, summaryvalue;
            IF NOT FOUND THEN
                EXIT;
            END IF;
            INSERT INTO tables.hourly_precipdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate) 
                VALUES(summaryvalue, datetimeutc, $1, $2, NOW());
         -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,summaryvalue;
        END LOOP;
        CLOSE max_cursor;
    END IF;
END;
$BODY$

LANGUAGE plpgsql VOLATILE
    COST 100;
ALTER FUNCTION tables.uspgethourlyprecip(integer, integer)
  OWNER TO imiq;
  
COMMENT ON FUNCTION tables.uspgethourlyprecip(integer, integer) IS 'Used to populate the ''hourly_precipdatavalues'' table.';
    
