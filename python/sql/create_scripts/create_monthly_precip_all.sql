-- View: tables.monthly_precip_all

-- DROP VIEW tables.monthly_precip_all;

CREATE OR REPLACE VIEW tables.monthly_precip_all AS 
 SELECT p.siteid,
    date_part('year'::text, p.utcdatetime) AS year,
    date_part('month'::text, p.utcdatetime) AS month,
    sum(p.datavalue) AS monthlytotal,
    count(*) AS total
   FROM tables.daily_precip p
  GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime)
 HAVING count(*) >= 10;

ALTER TABLE tables.monthly_precip_all
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_precip_all TO imiq;
GRANT ALL ON TABLE tables.monthly_precip_all TO asjacobs;
GRANT SELECT ON TABLE tables.monthly_precip_all TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_precip_all TO rwspicer;
COMMENT ON VIEW tables.monthly_precip_all
  IS 'This view creates monthly totals using "daily_precip".  Restricted to months with at least 10 days of data.';
