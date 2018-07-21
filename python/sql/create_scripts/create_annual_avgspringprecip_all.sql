-- View: tables.annual_avgspringprecip_all

-- DROP VIEW tables.annual_avgspringprecip_all;

CREATE OR REPLACE VIEW tables.annual_avgspringprecip_all AS 
 SELECT p.siteid,
    p.year,
    avg(p.monthlytotal) AS seasonalavg
   FROM tables.monthly_precip_all p
  WHERE (p.month = ANY (ARRAY[3::double precision, 4::double precision, 5::double precision])) AND p.monthlytotal IS NOT NULL
  GROUP BY p.siteid, p.year
 HAVING count(*) = 3;

ALTER TABLE tables.annual_avgspringprecip_all
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringprecip_all TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringprecip_all TO asjacobs;
GRANT SELECT ON TABLE tables.annual_avgspringprecip_all TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgspringprecip_all TO rwspicer;
COMMENT ON VIEW tables.annual_avgspringprecip_all
  IS 'This view creates annual spring precipitation total averages using "monthly_precip_all".  Requires all three months: March, April and May; to create annual spring precipitation total average.';
