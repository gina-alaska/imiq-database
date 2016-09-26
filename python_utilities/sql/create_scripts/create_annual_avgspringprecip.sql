-- View: tables.annual_avgspringprecip

-- DROP VIEW tables.annual_avgspringprecip;

CREATE OR REPLACE VIEW tables.annual_avgspringprecip AS 
 SELECT row_number() OVER (ORDER BY annual_avgspringprecip_all.siteid, annual_avgspringprecip_all.year) AS valueid,
    annual_avgspringprecip_all.seasonalavg AS datavalue,
    annual_avgspringprecip_all.siteid,
    (annual_avgspringprecip_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    701 AS originalvariableid,
    733 AS variableid
   FROM tables.annual_avgspringprecip_all;

ALTER TABLE tables.annual_avgspringprecip
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringprecip TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringprecip TO asjacobs;
GRANT SELECT ON TABLE tables.annual_avgspringprecip TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgspringprecip TO rwspicer;
COMMENT ON VIEW tables.annual_avgspringprecip
  IS 'This view creates "annual_avgspringprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=733';
