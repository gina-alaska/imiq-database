
CREATE TABLE tables.annual_avgsummerrh_all_2 AS 
 SELECT monthly_rh_all.siteid,
    monthly_rh_all.year,
    0.611::double precision * exp(17.3::double precision * avg((ln(0.611::double precision * exp(17.3::double precision * monthly_rh_all.at / (monthly_rh_all.at + 237.3::double precision)) * monthly_rh_all.rh / 100.0::double precision) + 0.4926::double precision) / (0.0708::double precision - 0.00421::double precision * ln(0.611::double precision * exp(17.3::double precision * monthly_rh_all.at / (monthly_rh_all.at + 237.3::double precision)) * monthly_rh_all.rh / 100.0::double precision))) / (avg((ln(0.611::double precision * exp(17.3::double precision * monthly_rh_all.at / (monthly_rh_all.at + 237.3::double precision)) * monthly_rh_all.rh / 100.0::double precision) + 0.4926::double precision) / (0.0708::double precision - 0.00421::double precision * ln(0.611::double precision * exp(17.3::double precision * monthly_rh_all.at / (monthly_rh_all.at + 237.3::double precision)) * monthly_rh_all.rh / 100.0::double precision))) + 237.3::double precision)) / (0.611::double precision * exp(17.3::double precision * avg(monthly_rh_all.at) / (avg(monthly_rh_all.at) + 237.3::double precision))) * 100.0::double precision AS seasonalavgrh,
    avg(monthly_rh_all.at) AS seasonalavgat
   FROM tables.monthly_rh_all
  WHERE monthly_rh_all.month = ANY (ARRAY[6, 7, 8])
  GROUP BY monthly_rh_all.siteid, monthly_rh_all.year
 HAVING count(*) = 3;

CREATE INDEX annual_avgsummerrh_all_siteid_idx
  ON tables.annual_avgsummerrh_all_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgsummerrh_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerrh_all_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerrh_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgsummerrh_all_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgsummerrh_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerrh_all_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgsummerrh_all_2
  IS 'This view creates annual average summer relative humidity by calculating the seasonal relative humdity using the monthly air temperature and monthly relative humidity averages.   Requires all three months; June, July, August; to create annual average summer relative humidity';
