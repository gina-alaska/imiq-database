-- View: tables.annual_avgsummerprecip_all

-- DROP VIEW tables.annual_avgsummerprecip_all;

CREATE OR REPLACE VIEW tables.annual_avgsummerprecip_all AS 
 SELECT p.siteid,
    p.year,
    avg(p.monthlytotal) AS seasonalavg
   FROM tables.monthly_precip_all p
  WHERE (p.month = ANY (ARRAY[6::double precision, 7::double precision, 8::double precision])) AND p.monthlytotal IS NOT NULL
  GROUP BY p.siteid, p.year
 HAVING count(*) = 3;

ALTER TABLE tables.annual_avgsummerprecip_all
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_all TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_all TO asjacobs;
GRANT SELECT ON TABLE tables.annual_avgsummerprecip_all TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_all TO rwspicer;
COMMENT ON VIEW tables.annual_avgsummerprecip_all
  IS 'This view creates annual average summer precipitation totals using "monthly_precip_all".  Requires all three months; June, July, August; to create annual average summer precipitation totals.';
