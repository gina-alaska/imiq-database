-- create_hourly_snowdepth_materialized_view.sql
--
--
-- version 1.0.0
-- updated 2017-04-06
--
-- changelog:
-- 1.0.0: created from create_hourly_snowdepth.sql
CREATE MATERIALIZED VIEW tables.hourly_snowdepth AS 
(
    SELECT
        valueid AS valueid, 
        datavalue AS datavalue,  
        utcdatetime AS utcdatetime, 
        siteid AS siteid, 
        originalvariableid AS originalvariableid, 
        680 AS variableid
    FROM tables.hourly_snowdepthdatavalues
  WHERE datavalue >= 0::double precision AND datavalue <= 12::double precision
);

CREATE INDEX hourly_snowdepth_mv_siteid_idx
  ON tables.hourly_snowdepth
  USING btree
  (siteid);

ALTER MATERIALIZED VIEW tables.hourly_snowdepth
  OWNER TO imiq;

COMMENT ON MATERIALIZED VIEW tables.hourly_snowdepth
  IS 'This view restricts data values to the range: 0m <= DataValue <= 12m.  Sets the hourly snowdepth variableid = 680';
