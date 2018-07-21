
CREATE TABLE tables.monthly_precip_all_2 AS 
 SELECT p.siteid,
    date_part('year'::text, p.utcdatetime) AS year,
    date_part('month'::text, p.utcdatetime) AS month,
    sum(p.datavalue) AS monthlytotal,
    count(*) AS total
   FROM tables.daily_precip p
  GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime)
 HAVING count(*) >= 10;

 CREATE INDEX monthly_precip_all_siteid_idx
  ON tables.monthly_precip_all_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_precip_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_precip_all_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_precip_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.monthly_precip_all_2 TO chaase;
GRANT SELECT ON TABLE tables.monthly_precip_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_precip_all_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_precip_all_2
  IS 'This view creates monthly totals using "daily_precip".  Restricted to months with at least 10 days of data.';
