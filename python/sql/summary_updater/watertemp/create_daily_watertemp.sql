-- create_daily_watertemp.sql
--     creates tables.daily_watertemp_test, 
--      Note: to finish update drop tables.daily_watertemp, and rename this 
-- table to tables.daily_watertemp.
--
-- version 1.0.0
-- updated 2017-01-10
-- 
-- changelog:
-- 1.0.0: added metadata comments.

CREATE TABLE tables.daily_watertemp_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    694 AS variableid
   FROM tables.daily_watertempdatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue IS NOT NULL
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_watertemp_2
  ADD CONSTRAINT daily_watertemp_valueid PRIMARY KEY (valueid);

CREATE INDEX daily_watertemp_siteid_idx
  ON tables.daily_watertemp_2
  USING btree
  (siteid);

ALTER TABLE tables.daily_watertemp_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.daily_watertemp_2 TO imiq;
GRANT ALL ON TABLE tables.daily_watertemp_2 TO asjacobs;
GRANT ALL ON TABLE tables.daily_watertemp_2 TO chaase;
GRANT SELECT ON TABLE tables.daily_watertemp_2 TO imiq_reader;
GRANT ALL ON TABLE tables.daily_watertemp_2 TO rwspicer;
COMMENT ON TABLE tables.daily_watertemp_2
  IS 'This view restricts data values to those which are not null.  Sets the daily water temperature variableid=694.';
