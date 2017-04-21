-- create_monthly_sweavg.sql
--      creates monthly_sweavg table
--
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
--      2.0.0 changed to MATERIALIZED VIEW and intergrated create_monthly_sweavg_all
--      1.0.0: initial version
CREATE MATERIALIZED VIEW tables.monthly_sweavg AS 
SELECT row_number() OVER (ORDER BY siteid, monthlyavg) AS valueid,
    monthlyavg AS datavalue,
    siteid,
    (((monthly_all.year || '-'::text) || monthly_all.month) || '-01'::text)::timestamp without time zone AS utcdatetime,
    693 AS originalvariableid,
    721 AS variableid
FROM (SELECT 
        p.siteid,
        date_part('year'::text, p.utcdatetime) AS year,
        date_part('month'::text, p.utcdatetime) AS month,
        avg(p.datavalue) AS monthlyavg,
        count(*) AS total
      FROM tables.daily_swe p
      GROUP BY p.siteid, year, month
      HAVING count(*) >= 1) as monthly_all;



CREATE INDEX monthly_sweavg_siteid_idx_mv
  ON tables.monthly_sweavg
  USING btree
  (siteid);

ALTER MATERIALIZED VIEW tables.monthly_sweavg
  OWNER TO imiq;

COMMENT ON MATERIALIZED VIEW tables.monthly_sweavg
  IS 'This view creates "monthly_sweavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=721';
