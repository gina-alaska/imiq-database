-- create_monthly_airtemp.sql
--
--
-- version 1.0.0
-- updated 2017-01-12
--
-- changelog:
-- 1.0.0: added comments
-- View: tables.monthly_airtemp_all

-- DROP VIEW tables.monthly_airtemp_all;

CREATE TABLE tables.monthly_airtemp_all_2 AS 
 SELECT d.siteid,
    date_part('year'::text, d.utcdatetime) AS year,
    date_part('month'::text, d.utcdatetime) AS month,
    avg(d.datavalue) AS monthlyavg,
    count(*) AS total
   FROM tables.daily_airtemp d
  GROUP BY d.siteid, date_part('year'::text, d.utcdatetime), date_part('month'::text, d.utcdatetime)
 HAVING count(*) >= 10;

CREATE INDEX monthly_airtemp_all_siteid_idx
  ON tables.monthly_airtemp_all_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_airtemp_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_airtemp_all_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_airtemp_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.monthly_airtemp_all_2 TO chaase;
GRANT SELECT ON TABLE tables.monthly_airtemp_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_airtemp_all_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_airtemp_all_2
  IS 'This view creates monthly averages using "daily_airtemp".  Restricted to months with at least 10 days of data.';
