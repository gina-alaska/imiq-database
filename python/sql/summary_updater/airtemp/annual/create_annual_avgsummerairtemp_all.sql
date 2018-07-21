-- create_annual_avgsummerairtemp_all.sql
--
--
-- version 1.0.0
-- updated 2017-01-12
--
-- changelog:
-- 1.0.0: added comments
CREATE TABLE tables.annual_avgsummerairtemp_all_2 AS 
 SELECT a.siteid,
    a.year,
    avg(a.monthlyavg) AS seasonalavg
   FROM tables.monthly_airtemp_all a
  WHERE a.month = ANY (ARRAY[6::double precision, 7::double precision, 8::double precision])
  GROUP BY a.siteid, a.year
 HAVING count(*) = 3;

CREATE INDEX annual_avgsummerairtemp_all_siteid_idx_2
  ON tables.annual_avgsummerairtemp_all_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgsummerairtemp_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerairtemp_all_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerairtemp_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgsummerairtemp_all_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgsummerairtemp_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerairtemp_all_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgsummerairtemp_all_2
  IS 'This view creates annual summer air temperature averages using "monthly_airtemp_all".  Requires all three months; June, July and August; to create annual summer air temperature average';
