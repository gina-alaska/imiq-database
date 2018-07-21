-- View: tables.annual_avgfallprecip_all

-- DROP VIEW tables.annual_avgfallprecip_all;

CREATE table tables.annual_avgfallprecip_all_2 AS 
 SELECT p.siteid,
    p.year,
    avg(p.monthlytotal) AS seasonalavg
   FROM tables.monthly_precip_all p
  WHERE p.month >= 9::double precision AND p.month <= 11::double precision AND p.monthlytotal IS NOT NULL
  GROUP BY p.siteid, p.year
 HAVING count(*) = 3;


CREATE INDEX annual_avgfallprecip_all_siteid_idx
  ON tables.annual_avgfallprecip_all_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgfallprecip_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgfallprecip_all_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgfallprecip_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgfallprecip_all_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgfallprecip_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgfallprecip_all_2 TO rwspicer;
COMMENT ON table tables.annual_avgfallprecip_all_2
  IS 'This view creates annual average fall precipitation total using "monthly_precip_all".  Requires all three months; September, October and November; to create annual average total.';
