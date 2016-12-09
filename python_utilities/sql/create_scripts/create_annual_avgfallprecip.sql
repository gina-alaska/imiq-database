-- View: tables.annual_avgfallprecip

-- DROP VIEW tables.annual_avgfallprecip;

CREATE OR REPLACE VIEW tables.annual_avgfallprecip AS 
 SELECT row_number() OVER (ORDER BY annual_avgfallprecip_all.siteid, annual_avgfallprecip_all.year) AS valueid,
    annual_avgfallprecip_all.seasonalavg AS datavalue,
    annual_avgfallprecip_all.siteid,
    (annual_avgfallprecip_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    701 AS originalvariableid,
    729 AS variableid
   FROM tables.annual_avgfallprecip_all;

ALTER TABLE tables.annual_avgfallprecip
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgfallprecip TO imiq;
GRANT ALL ON TABLE tables.annual_avgfallprecip TO asjacobs;
GRANT SELECT ON TABLE tables.annual_avgfallprecip TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgfallprecip TO rwspicer;
COMMENT ON VIEW tables.annual_avgfallprecip
  IS 'This view creates "annual_avgfallprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=729';
