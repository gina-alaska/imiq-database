-- View: tables.annual_avgsummerdischarge_all

-- DROP VIEW tables.annual_avgsummerdischarge_all;

CREATE TABLE tables.annual_avgsummerdischarge_all_2 AS 
 SELECT monthly_discharge_all.siteid,
    monthly_discharge_all.year,
    avg(monthly_discharge_all.monthlyavg) AS seasonalavg
   FROM tables.monthly_discharge_all
  WHERE monthly_discharge_all.month >= 6::double precision AND monthly_discharge_all.month <= 8::double precision AND monthly_discharge_all.monthlyavg IS NOT NULL
  GROUP BY monthly_discharge_all.siteid, monthly_discharge_all.year
 HAVING count(*) = 3;
 
CREATE INDEX annual_avgsummerdischarge_all_idx
  ON tables.annual_avgsummerdischarge_all_2
  USING btree
  (siteid);
  
ALTER TABLE tables.annual_avgsummerdischarge_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerdischarge_all_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerdischarge_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgsummerdischarge_all_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgsummerdischarge_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerdischarge_all_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgsummerdischarge_all_2
  IS 'This view creates annual average summer discharge using "monthly_discharge_all".  Requires all three months; June, July, August; to create annual average summer discharge.';
