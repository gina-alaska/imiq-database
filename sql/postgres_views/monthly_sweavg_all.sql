-- View: tables.monthly_sweavg_all

-- DROP VIEW tables.monthly_sweavg_all;

CREATE OR REPLACE VIEW tables.monthly_sweavg_all AS 
 SELECT p.siteid, date_part('year'::text, p.utcdatetime) AS year, date_part('month'::text, p.utcdatetime) AS month, avg(p.datavalue) AS monthlyavg, count(*) AS total
   FROM tables.daily_swe p
  GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime)
 HAVING count(*) >= 1;

ALTER TABLE tables.monthly_sweavg_all
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_sweavg_all
  IS 'This view creates monthly averages using "daily_swe".  Restricted to months with at least 1 day or data.';
