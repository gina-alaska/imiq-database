-- View: tables.annual_avgfallprecip_all

-- DROP VIEW tables.annual_avgfallprecip_all;

CREATE OR REPLACE VIEW tables.annual_avgfallprecip_all AS 
 SELECT p.siteid, p.year, avg(p.monthlytotal) AS seasonalavg
   FROM tables.monthly_precip_all p
  WHERE p.month >= 9::double precision AND p.month <= 11::double precision AND p.monthlytotal IS NOT NULL
  GROUP BY p.siteid, p.year
 HAVING count(*) = 3;

ALTER TABLE tables.annual_avgfallprecip_all
  OWNER TO asjacobs;
COMMENT ON VIEW tables.annual_avgfallprecip_all
  IS 'This view creates annual average fall precipitation totals using "monthly_avgfallprecip_all".  Requires all three months: September, October and November; to create annual average total.';
