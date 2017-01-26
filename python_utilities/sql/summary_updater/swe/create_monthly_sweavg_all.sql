-- create_monthly_sweavg_all.sql
--      creates monthly_sweavg_all table
--
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
--      1.0.0: initial version

-- View: tables.monthly_sweavg_all

-- DROP VIEW tables.monthly_sweavg_all;

CREATE TABLE tables.monthly_sweavg_all_2 AS 
 SELECT p.siteid,
    date_part('year'::text, p.utcdatetime) AS year,
    date_part('month'::text, p.utcdatetime) AS month,
    avg(p.datavalue) AS monthlyavg,
    count(*) AS total
   FROM tables.daily_swe p
  GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime)
 HAVING count(*) >= 1;

CREATE INDEX monthly_sweavg_all_idx
  ON tables.monthly_sweavg_all_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_sweavg_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_sweavg_all_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_sweavg_all_2 TO asjacobs;
GRANT SELECT ON TABLE tables.monthly_sweavg_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_sweavg_all_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_sweavg_all_2
  IS 'This view creates monthly averages using "daily_swe".  Restricted to months with at least 1 day or data.';
