-- create_daily_swe.sql
--
-- version 2.0.0
-- updated 2017-04-18
-- 
-- changelog:
-- 2.0.0: changed to materialized view
-- 1.0.0: recreated from create_daily_watertemp.sql

CREATE materialized view tables.daily_swe AS 
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

CREATE INDEX daily_swe_siteid_idx_mv
  ON tables.daily_swe
  USING btree
  (siteid);

ALTER MATERIALIZED VIEW tables.daily_swe
  OWNER TO imiq;
COMMENT ON MATERIALIZED VIEW tables.daily_swe
  IS 'This view restricts data values to those which are not null.  Sets the daily swe variableid=693.';
