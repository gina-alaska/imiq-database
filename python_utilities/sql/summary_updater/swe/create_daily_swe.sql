-- create_daily_swe.sql
--
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
-- 1.0.0: recreated from create_daily_watertemp.sql

CREATE TABLE tables.daily_swe_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    693 AS variableid
   FROM tables.daily_swedatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue IS NOT NULL
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_swe_2
  ADD CONSTRAINT daily_swe_valueid PRIMARY KEY (valueid);

CREATE INDEX daily_swe_siteid_idx_2
  ON tables.daily_swe_2
  USING btree
  (siteid);

ALTER TABLE tables.daily_swe_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.daily_swe_2 TO imiq;
GRANT ALL ON TABLE tables.daily_swe_2 TO asjacobs;
GRANT ALL ON TABLE tables.daily_swe_2 TO chaase;
GRANT SELECT ON TABLE tables.daily_swe_2 TO imiq_reader;
GRANT ALL ON TABLE tables.daily_swe_2 TO rwspicer;
COMMENT ON TABLE tables.daily_swe_2
  IS 'This view restricts data values to those which are not null.  Sets the daily swe variableid=693.';
