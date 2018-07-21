-- View: tables.monthly_snowdepthavg_all

-- DROP VIEW tables.monthly_snowdepthavg_all;

CREATE TABLE tables.monthly_snowdepthavg_all_2 AS 
 SELECT p.siteid,
    date_part('year'::text, p.utcdatetime) AS year,
    date_part('month'::text, p.utcdatetime) AS month,
    avg(p.datavalue) AS monthlyavg,
    count(*) AS total
   FROM tables.daily_snowdepth p
  GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime)
 HAVING count(*) >= 1;

CREATE INDEX monthly_snowdepthavg_all_siteid_idx
  ON tables.monthly_snowdepthavg_all_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_snowdepthavg_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_snowdepthavg_all_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_snowdepthavg_all_2 TO asjacobs;
GRANT SELECT ON TABLE tables.monthly_snowdepthavg_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_snowdepthavg_all_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_snowdepthavg_all_2
  IS 'This view creates monthly averages using "daily_snowdepth".  Restricted to months with at least 1 day of data.';
