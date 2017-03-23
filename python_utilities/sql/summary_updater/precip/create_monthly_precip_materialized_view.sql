-- create_monthly_precip_materialized_view.sql
--
--
-- version 1.0.0
-- updated 2017-02-24
--
-- changelog:
-- 1.0.0: created from old files for creating tables.monthly_precip and 
--        tables.monthly_precip_all




CREATE MATERIALIZED VIEW tables.monthly_precip as
SELECT ROW_NUMBER() OVER (ORDER BY SiteID,Monthlytotal) AS ValueID, 
       MonthlyTotal as DataValue,
       SiteID, 
        (((monthly_all.year::character varying::text || '-'::text) || monthly_all.month::character varying::text) || '-01'::text)::timestamp without time zone AS utcdatetime,
       690 as OriginalVariableID,
       701 as VariableID
from (SELECT p.SiteID,
             date_part('year'::text, utcdatetime) AS YEAR,
             date_part('month'::text, utcdatetime) AS MONTH,
             SUM(datavalue) as MonthlyTotal, 
             COUNT(*) as total
      from tables.daily_precip p
      GROUP BY p.SiteID, YEAR, MONTH
      having COUNT(*) >= 10) AS monthly_all;
      
      
CREATE INDEX monthly_precip_mv_idx
  ON tables.monthly_precip
  USING btree
  (siteid);


ALTER MATERIALIZED VIEW tables.monthly_precip
  OWNER TO imiq;

COMMENT ON MATERIALIZED VIEW tables.monthly_precip
  IS 'This view creates monthly sum using "daily_precip".  Restricted to months with at least 10 days of data.';
