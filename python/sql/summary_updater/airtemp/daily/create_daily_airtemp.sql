-- create_daily_airtemp.sql
--
--
-- version 2.0.0
-- updated 2017-04-21
--
-- changelog:
-- 2.0.0: changed to MATERIALIZED VIEW 
-- 1.0.0: added comments
CREATE MATERIALIZED VIEW tables.daily_airtemp AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    686 AS variableid
   FROM tables.daily_airtempdatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= (-62.22)::double precision AND v.datavalue <= 46.11::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

CREATE INDEX daily_airtemp_siteid_idx_mv
  ON tables.daily_airtemp
  USING btree
  (siteid);

ALTER MATERIALIZED VIEW tables.daily_airtemp
  OWNER TO imiq;
COMMENT ON MATERIALIZED VIEW tables.daily_airtemp
  IS 'This view restricts data values to the range: -80F <= DataValue < 115F.  Sets the daily air temperature variableid = 686';
