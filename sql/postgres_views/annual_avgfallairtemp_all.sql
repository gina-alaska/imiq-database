-- View: tables.annual_avgfallairtemp_all

-- DROP VIEW tables.annual_avgfallairtemp_all;

CREATE OR REPLACE VIEW tables.annual_avgfallairtemp_all AS 
 SELECT a.siteid, a.year, avg(a.monthlyavg) AS seasonalavg
   FROM tables.monthly_airtemp_all a
  WHERE a.month >= 9::double precision AND a.month <= 11::double precision AND a.monthlyavg IS NOT NULL
  GROUP BY a.siteid, a.year
 HAVING count(*) = 3;

ALTER TABLE tables.annual_avgfallairtemp_all
  OWNER TO asjacobs;
COMMENT ON VIEW tables.annual_avgfallairtemp_all
  IS 'This view creates annual fall air temperature averages using "monthly_airtemp_all".  Requires all three months; September, October and November; to create annual fall average.  ';
