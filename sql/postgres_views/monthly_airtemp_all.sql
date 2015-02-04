-- View: tables.monthly_airtemp_all

-- DROP VIEW tables.monthly_airtemp_all;

CREATE OR REPLACE VIEW tables.monthly_airtemp_all AS 
 SELECT d.siteid, date_part('year'::text, d.utcdatetime) AS year, date_part('month'::text, d.utcdatetime) AS month, avg(d.datavalue) AS monthlyavg, count(*) AS total
   FROM tables.daily_airtemp d
  GROUP BY d.siteid, date_part('year'::text, d.utcdatetime), date_part('month'::text, d.utcdatetime)
 HAVING count(*) >= 10;

ALTER TABLE tables.monthly_airtemp_all
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_airtemp_all
  IS 'This view creates monthly averages using "daily_airtemp".  Restricted to months with at least 10 days of data.';
