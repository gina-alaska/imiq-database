-- create_daily_snowdepth_materialized_view.sql
--
-- Rawser Spicer
-- version 1.0.0
-- updated 2017-04-06
--
-- changelog:
-- 1.0.0: created from create_daily_snowdepth.sql
CREATE MATERIALIZED VIEW tables.daily_snowdepth AS 
(
    SELECT
        valueid AS valueid, 
        datavalue AS datavalue,  
        utcdatetime AS utcdatetime, 
        siteid AS siteid, 
        originalvariableid AS originalvariableid, 
        692 AS variableid
     FROM tables.daily_snowdepthdatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision AND v.datavalue <= 12::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;
) as summary;



CREATE INDEX daily_snowdepth_mv_siteid_idx
  ON tables.daily_snowdepth
  USING btree
  (siteid);

ALTER MATERIALIZED VIEW tables.daily_snowdepth
  OWNER TO imiq;

COMMENT ON MATERIALIZED VIEW tables.daily_snowdepth
  IS 'This view restricts data values to the range: 0m <= DataValue <= 12m.  Sets the daily snow depth variableid = 692';
