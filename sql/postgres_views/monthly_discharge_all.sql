-- View: tables.monthly_discharge_all

-- DROP VIEW tables.monthly_discharge_all;

CREATE OR REPLACE VIEW tables.monthly_discharge_all AS 
 SELECT p.siteid, date_part('year'::text, p.utcdatetime) AS year, date_part('month'::text, p.utcdatetime) AS month, avg(p.datavalue) AS monthlyavg, count(*) AS total
   FROM tables.daily_discharge p
  GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime)
 HAVING count(*) >= 10;

ALTER TABLE tables.monthly_discharge_all
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_discharge_all
  IS 'This view creates monthly averages using "daily_discharge".  Restricted to months with at least 10 days of data.';
