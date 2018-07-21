-- create_hourly_airtemp.sql
--
--
-- version 2.0.0
-- updated 2017-01-12
--
-- changelog:
-- 2.0.0: change to MATERIALIZED VIEW
-- 1.0.0: added comments
CREATE MATERIALIZED VIEW tables.hourly_airtemp AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    677 AS variableid
   FROM tables.hourly_airtempdatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= (-62.22)::double precision AND v.datavalue <= 46.11::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

CREATE INDEX hourly_airtemp_siteid_idx_mv
  ON tables.hourly_airtemp
  USING btree
  (siteid);

ALTER MATERIALIZED VIEW tables.hourly_airtemp
  OWNER TO imiq;
COMMENT ON MATERIALIZED VIEW tables.hourly_airtemp
  IS 'This view restricts data values to the range: -80F <= DataValue < 115F.  Sets the daily air temperature variableid = 677';

