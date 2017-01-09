-- create_daily_windspeed.sql
--     creates tables.daily_windspeed_2.
--  Note: to finish update drop tables.daily_windspeed, and rename this table
--  to tables.daily_windspeed
--
-- version 1.0.0
-- updated 2017-01-09
-- 
-- changelog:
-- 1.0.0: added metadata comments.
CREATE TABLE tables.daily_windspeed_2 AS 
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

ALTER TABLE tables.daily_windspeed_2
  ADD CONSTRAINT daily_windspeed_valueid_2 PRIMARY KEY (valueid);

CREATE INDEX daily_windspeed_siteid_idx_2
  ON tables.daily_windspeed_2
  USING btree
  (siteid);


ALTER TABLE tables.daily_windspeed_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.daily_windspeed_2 TO imiq;
GRANT ALL ON TABLE tables.daily_windspeed_2 TO asjacobs;
GRANT ALL ON TABLE tables.daily_windspeed_2 TO chaase;
GRANT SELECT ON TABLE tables.daily_windspeed_2 TO imiq_reader;
GRANT ALL ON TABLE tables.daily_windspeed_2 TO rwspicer;
COMMENT ON TABLE tables.daily_windspeed_2
  IS 'This view restricts the data values to the range: datavalue >= 0 and datavalue < 50.  Sets the daily wind speed variableid=696';
