-- View: tables.monthly_discharge_all

-- DROP VIEW tables.monthly_discharge_all;

CREATE TABLE tables.monthly_discharge_all_2 AS 
 SELECT p.siteid,
    date_part('year'::text, p.utcdatetime) AS year,
    date_part('month'::text, p.utcdatetime) AS month,
    avg(p.datavalue) AS monthlyavg,
    count(*) AS total
   FROM tables.daily_discharge p
  GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime)
 HAVING count(*) >= 10;

 CREATE INDEX monthly_discharge_all_siteid_idx
  ON tables.monthly_discharge_all_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_discharge_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_discharge_all_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_discharge_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.monthly_discharge_all_2 TO chaase;
GRANT SELECT ON TABLE tables.monthly_discharge_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_discharge_all_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_discharge_all_2
  IS 'This view creates monthly averages using "daily_discharge".  Restricted to months with at least 10 days of data.';
