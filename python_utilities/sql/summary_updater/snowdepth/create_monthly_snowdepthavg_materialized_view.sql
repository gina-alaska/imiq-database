-- create_monthly_snowdepthavg_materialized_view.sql
-- 
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
-- 1.0.0: initial version

CREATE MATERIALIZED VIEW tables.monthly_snowdepthavg as
SELECT row_number() OVER (ORDER BY siteid, monthlyavg) AS valueid,
    monthlyavg AS datavalue,
    siteid,
    (((monthly_all.year::character varying::text || '-'::text) || monthly_all.month::character varying::text) || '-01'::text)::timestamp without time zone AS utcdatetime,
    692 AS originalvariableid,
    702 AS variableid
FROM ( SELECT p.siteid,
              date_part('year'::text, p.utcdatetime) AS year,
              date_part('month'::text, p.utcdatetime) AS month,
              avg(p.datavalue) AS monthlyavg,
              count(*) AS total
       FROM tables.daily_snowdepth p
       GROUP BY p.siteid, year, month
       HAVING count(*) >= 1) as monthly_all;



CREATE INDEX monthly_snowdepthavg_mv_siteid_idx
  ON tables.monthly_snowdepthavg
  USING btree
  (siteid);

ALTER MATERIALIZED VIEW tables.monthly_snowdepthavg
  OWNER TO imiq;

COMMENT ON MATERIALIZED VIEW tables.monthly_snowdepthavg
  IS 'This view creates "monthly_snowdepthavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=702';
