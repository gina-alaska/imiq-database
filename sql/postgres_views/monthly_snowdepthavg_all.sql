-- View: tables.monthly_snowdepthavg_all

-- DROP VIEW tables.monthly_snowdepthavg_all;

CREATE OR REPLACE VIEW tables.monthly_snowdepthavg_all AS 
 SELECT p.siteid, date_part('year'::text, p.utcdatetime) AS year, date_part('month'::text, p.utcdatetime) AS month, avg(p.datavalue) AS monthlyavg, count(*) AS total
   FROM tables.daily_snowdepth p
  GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime)
 HAVING count(*) >= 1;

ALTER TABLE tables.monthly_snowdepthavg_all
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_snowdepthavg_all
  IS 'This view creates monthly averages using "daily_snowdepth".  Restricted to months with at least 1 day of data.';
