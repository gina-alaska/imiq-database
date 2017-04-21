-- create_daily_windspeed.sql
--     creates tables.daily_windspeed.
--  Note: to finish update drop tables.daily_windspeed, and rename this table
--  to tables.daily_windspeed
--
-- version 2.0.1
-- updated 2017-04-21
-- 
-- changelog:
-- 2.0.1: removed _2 from name
-- 2.0.0: changed to MATERIALIZED VIEW
-- 1.0.0: added metadata comments.
CREATE MATERIALIZED VIEW tables.daily_windspeed AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    696 AS variableid
   FROM tables.daily_windspeeddatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision AND v.datavalue < 50::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

-- ~ ALTER  MATERIALIZED VIEW tables.daily_windspeed
  -- ~ ADD CONSTRAINT daily_windspeed_valueid_2 PRIMARY KEY (valueid);

CREATE INDEX daily_windspeed_siteid_idx_mv
  ON tables.daily_windspeed
  USING btree
  (siteid);


ALTER MATERIALIZED VIEW tables.daily_windspeed
  OWNER TO imiq;
-- ~ GRANT ALL ON VIEW tables.daily_windspeed TO imiq;
-- ~ GRANT ALL ON VIEW tables.daily_windspeed TO asjacobs;
-- ~ GRANT ALL ON VIEW tables.daily_windspeed TO chaase;
-- ~ GRANT SELECT ON VIEW tables.daily_windspeed TO imiq_reader;
-- ~ GRANT ALL ON VIEW tables.daily_windspeed TO rwspicer;
COMMENT ON MATERIALIZED VIEW tables.daily_windspeed
  IS 'This view restricts the data values to the range: datavalue >= 0 and datavalue < 50.  Sets the daily wind speed variableid=696';
