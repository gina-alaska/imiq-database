-- create_annual_avgspringairtemp_all.sql
--
--
-- version 1.0.0
-- updated 2017-01-12
--
-- changelog:
-- 1.0.0: added comments

-- View: tables.annual_avgspringairtemp_all

-- DROP VIEW tables.annual_avgspringairtemp_all;

CREATE table tables.annual_avgspringairtemp_all_2 AS 
 SELECT a.siteid,
    a.year,
    avg(a.monthlyavg) AS seasonalavg
   FROM tables.monthly_airtemp_all a
  WHERE (a.month = ANY (ARRAY[3::double precision, 4::double precision, 5::double precision])) AND a.monthlyavg IS NOT NULL
  GROUP BY a.siteid, a.year
 HAVING count(*) = 3;

CREATE INDEX annual_avgspringairtemp_all_siteid_idx_2
  ON tables.annual_avgspringairtemp_all_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgspringairtemp_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringairtemp_all_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringairtemp_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgspringairtemp_all_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgspringairtemp_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgspringairtemp_all_2 TO rwspicer;
COMMENT ON table tables.annual_avgspringairtemp_all_2
  IS 'This view creates annual spring air temperature averages using "monthly_airtemp_all".  Requires all three months; March, April and May; to create annual spring air temperature average.';
