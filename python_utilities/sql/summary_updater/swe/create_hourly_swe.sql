-- create_hourly_swe.sql
--
-- version 2.0.0
-- updated 2017-04-18
-- 
-- changelog:
-- 2.0.0: changed to MATERIALIZED VIEW
-- 1.0.0: recreated from create_hourly_watertemp.sql

CREATE MATERIALIZED VIEW tables.hourly_swe AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    681 AS variableid
   FROM tables.hourly_swedatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue IS NOT NULL
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

CREATE INDEX hourly_swe_siteid_idx_mv
  ON tables.hourly_swe
  USING btree
  (siteid);

ALTER MATERIALIZED VIEW tables.hourly_swe
  OWNER TO imiq;

COMMENT ON MATERIALIZED VIEW tables.hourly_swe
  IS 'This view restricts data values to those which are not null.  Sets the hourly swe variableid=681.';
