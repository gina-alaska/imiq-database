-- uspgetdailyprecip.sql
--
--
-- version 1.0.0
-- updated 2017-02-24
--
-- changelog:
-- 1.0.0: created from old uspgerdailyprecip.sql


CREATE OR REPLACE FUNCTION tables.uspgetdailyprecip(
    site_id INTEGER,
    var_id INTEGER)
RETURNS void AS
$BODY$
DECLARE datetimeutc TIMESTAMP WITHOUT TIME ZONE;
	summaryvalue FLOAT;
	max_cursor refcursor;
BEGIN
    -- Taking the MAX precip recorded in the day (USING UTC DAY)
    -- for:
    --   NCDC GHCN: VariableID = 398, SourceID = 210
    --   RAWS: VariableID = 441. SourceID = 211,214,215,216,217,218,219
    IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 398) OR
       EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 441)
    THEN
        OPEN max_cursor 
        FOR execute format(
            'SELECT date_trunc(''day'',localdatetime) as datetimeutc,
                    MAX(dv.datavalue) FROM tables.odmdatavalues_metric AS dv
             WHERE dv.siteid = $1 AND dv.originalvariableid=$2 
             GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
        LOOP
            FETCH max_cursor INTO datetimeutc, summaryvalue;
            IF NOT FOUND THEN
                EXIT;
            END IF;
            INSERT INTO tables.daily_precipdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate) 
                VALUES(summaryvalue, datetimeutc, $1, $2, NOW());
         -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,summaryvalue;
        END LOOP;
        CLOSE max_cursor;
    -- Taking the MAX precip recorded in the day (AKST, need to use localdatetime to stay on same day)
    -- No grouping necessary, just one value per day
    -- for:
    --   SNOTEL: VariableID = 394. SourceID = 212
    ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 394) 
    THEN
        OPEN max_cursor 
        FOR execute format(
            'SELECT date_trunc(''day'',localdatetime) as datetimeutc,
                    dv.datavalue 
             FROM tables.odmdatavalues_metric AS dv 
             WHERE dv.siteid = $1 AND dv.originalvariableid=$2;') USING site_id,var_id;
        LOOP
            FETCH max_cursor INTO datetimeutc, summaryvalue;
            IF NOT FOUND THEN
                EXIT;
            END IF;
            INSERT INTO tables.daily_precipdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate) 
                VALUES(summaryvalue, datetimeutc, $1, $2, NOW());
         -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,summaryvalue;
        END LOOP;
        CLOSE max_cursor;
    -- AKST need to use localdatetime to stay on same day, grouping
    -- for: 
    --   SNOTEL: VariableID = 610. SourceID = 212 
    --   SNOTEL: VariableID = 634. SourceID = 212 
    ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 610) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 610)
    THEN
        OPEN max_cursor 
        FOR execute format(
            'SELECT dv3.LocalDateTime,
                    CASE 
                        WHEN dv3.DataValue >= dv3.PrevDataValue THEN dv3.DataValue - dv3.PrevDataValue
                        WHEN PrevDataValue > dv3.DataValue THEN 0
                        ELSE dv3.DataValue END as CurrentDataValue 
             FROM
                (SELECT  dv.LocalDateTime, dv.DataValue, 
                    (SELECT dv2.DataValue as PrevDataValue 
                     FROM tables.ODMDataValues_metric dv2
                     WHERE dv2.SiteID = $1 
                        AND dv2.OriginalVariableID=$2 
                        AND dv2.LocalDateTime < dv.LocalDateTime 
                        AND dv2.DataValue >= 0 ORDER BY 
                    dv2.LocalDateTime DESC LIMIT 1) as PrevDataValue
                 FROM tables.ODMDataValues_metric AS dv
                 WHERE dv.SiteID = $1 
                    AND dv.OriginalVariableID=$2 
                    AND dv.DataValue >= 0) AS dv3') USING site_id,var_id;
        LOOP
            FETCH max_cursor INTO datetimeutc, summaryvalue;
            IF NOT FOUND THEN
                EXIT;
            END IF;
            INSERT INTO tables.daily_precipdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate) 
                VALUES(summaryvalue, datetimeutc, $1, $2, NOW());
         -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,summaryvalue;
        END LOOP;
        CLOSE max_cursor;
    -- Taking the SUM for the day
    -- for:
    --   GHCN Original Station Observation scans: VariableID = 839. SourceID = 225
    --   McCall: VariableID = 199. SourceID = 178,182
    --   UAF: VariableID = 274. SourceID = 180
    --   Chamberlin: VariableID = 301. SourceID = 183
    --   BLM: VariableID = 62 SourceID = 199
    --   UAF-BLM: VariableID = 646. SourceID = 164
    ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 839) 
    THEN
        OPEN max_cursor 
        FOR execute format(
            'SELECT date_trunc(''day'',localdatetime) as datetimeutc,
                    SUM(dv.datavalue) 
             FROM tables.odmdatavalues_metric AS dv 
             WHERE dv.siteid = $1 and dv.originalvariableid=$2 
             GROUP BY date_trunc(''day'',localdatetime);') USING site_id,var_id;
        LOOP
            FETCH max_cursor INTO datetimeutc, summaryvalue;
            IF NOT FOUND THEN
                EXIT;
            END IF;
            INSERT INTO tables.daily_precipdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate) 
                VALUES(summaryvalue, datetimeutc, $1, $2, NOW());
         -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,summaryvalue;
        END LOOP;
        CLOSE max_cursor;
    
    -- SUM of data values from 'hourly_precip'
    --  If there is are hourly data values for a site, those values are used to compute the daily data value.
    --  This is because the hourly precip has already undergone a threshold test
    -- for:
    --   ISH: VariableID = 340 is ISH Precip/UTC hourly/mm.  SourceID = 209
	--   UAF/WERC: VariableID = 84 Precip/mm, AST SourceID = 29, 30, 31, 34,223
    --   USGS: VariableID = 319. Precip/hourly/mm, AST. SourceID = 39
    --   ARC LTER: VariableID = 823, Precip/hourly/mm, AST. SourceID = 144
    --   AON: VariableID = 811 Precip/hourly/mm, AST. SourceID = 222
    --   Toolik: VariableID = 461 Precip/hourly/mm, AST. SourceID = 145
    --   BLM/Kemenitz: VariableID = 496 Precip/mm/Hourly  SourceID = 199. NOTE: 8/28/2014-All data values pulled, too many errors
    --   BLM/Kemenitz: VariableID = 458 Precip/mm/Hourly  SourceID = 199. NOTE: 8/28/2014-All data values pulled, too many errors
    --   BLM/Kemenitz: VariableID = 336 Precip/mm/Hourly  SourceID = 199. 
    --   NOAA: VariableID = 522 Precip/mm/Minute SourceID = 35
    --   ARM TPS: VariableID=539 Precip/mm/Minute SourceID = 1, 203. 8/28/2014:  Currently no data values loaded in hourly or daily 
    --   LPeters: VariableID = 294 Precip/Hourly SourceID = 182 
    --   RWIS: VariableID = 575 Precip/Mintues  SourceID = 213
    --   CALON VariableID = 1139  SourceID = 263.
    --   NPS: VariableID = 1170, Prechp/hourly. Sourceid = 136
    --   BOEM: VariableID = 1042 Precip acumulated 1hr. SourceIDs = 248 through 258
    ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 340) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 84) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 319) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 823) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 811) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 461) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 496) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 458) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 336) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 522) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 539) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 294) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 575) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1139) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1170) OR
          EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1042)
    THEN
        OPEN max_cursor 
        FOR execute format(
            'SELECT date_trunc(''day'',utcdatetime) as datetimeutc,
                    SUM(dv.datavalue)
             FROM tables.hourly_precip AS dv 
             WHERE dv.siteid = $1 AND dv.originalvariableid=$2 
             GROUP BY date_trunc(''day'',utcdatetime);') USING site_id,var_id;
        LOOP
            FETCH max_cursor INTO datetimeutc, summaryvalue;
            IF NOT FOUND THEN
                EXIT;
            END IF;
            INSERT INTO tables.daily_precipdatavalues (datavalue, utcdatetime, siteid, originalvariableid, insertdate) 
                VALUES(summaryvalue, datetimeutc, $1, $2, NOW());
         -- RAISE NOTICE 'Inserted % with value %',DateTimeUTC,summaryvalue;
        END LOOP;
        CLOSE max_cursor;
    END IF;
END;
$BODY$

LANGUAGE plpgsql VOLATILE
    COST 100;
ALTER FUNCTION tables.uspgetdailyprecip(integer, integer)
  OWNER TO imiq;
  
COMMENT ON FUNCTION tables.uspgetdailyprecip(integer, integer) IS 'Used to populate the ''daily_precipdatavalues'' table.';
    
