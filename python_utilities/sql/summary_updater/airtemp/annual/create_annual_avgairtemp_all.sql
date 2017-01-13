-- create_annual_avgairtemp_all.sql
--
--
-- version 1.0.0
-- updated 2017-01-13
--
-- changelog:
-- 1.0.0: created from create_annual_avgfallairtemp_all.sql

-- View: tables.annual_avgfallairtemp_all

-- DROP VIEW tables.annual_avgfallairtemp_all;

CREATE Table tables.annual_avgairtemp_all_2 AS 
 SELECT a.siteid,
    a.year,
    avg(a.monthlyavg) AS seasonalavg
   FROM tables.monthly_airtemp_all a
  WHERE a.monthlyavg IS NOT NULL
  GROUP BY a.siteid, a.year
 HAVING count(*) = 12;

--ALTER TABLE tables.annual_avgairtemp_all_2
--  ADD CONSTRAINT annual_avgfallairtemp_all_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgfallairtemp_all_siteid_idx_2
  ON tables.annual_avgairtemp_all_2
  USING btree
  (siteid);


ALTER TABLE tables.annual_avgairtemp_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgairtemp_all_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgairtemp_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgairtemp_all_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgairtemp_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgairtemp_all_2 TO rwspicer;
COMMENT ON table tables.annual_avgairtemp_all_2
  IS 'This creates annual air temperature averages using "monthly_airtemp_all". ';
