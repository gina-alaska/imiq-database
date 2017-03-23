-- create_annual_totalprecip_materialized_view.sql
--
-- Rawser Spicer
-- version 1.0.0
-- updated 2017-03-23
--
-- changelog:
-- 1.0.0: created 

CREATE MATERIALIZED VIEW tables.annual_totalprecip as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID, 
       SUM(MonthlyTotal) as DataValue,
       SiteID, 
       (monthly_all.year::character varying::text ||  '-01-01'::text)::timestamp without time zone AS utcdatetime,
       701 as OriginalVariableID, 
       703 as VariableID
from (SELECT p.SiteID,
             date_part('year'::text, utcdatetime) AS YEAR,
             date_part('month'::text, utcdatetime) AS MONTH,
             SUM(datavalue) as MonthlyTotal, 
             COUNT(*) as total
      from tables.daily_precip p
      GROUP BY p.SiteID, YEAR, MONTH
      having COUNT(*) >= 10) AS monthly_all
where month in (12,1,2,3,4,5,6,7,8,9,10,11) and MonthlyTotal is not null
group by SiteID,year
having COUNT(*) = 12;


CREATE INDEX annual_totalprecip_mv_siteid_idx
  ON tables.annual_totalprecip
  USING btree
  (siteid);



ALTER MATERIALIZED VIEW tables.annual_totalprecip
  OWNER TO imiq;

COMMENT ON MATERIALIZED VIEW tables.annual_totalprecip
  IS 'This view creates annual total using "daily_precip".  Restricted to months with at least 10 days of data, and years with 12 months of data';
