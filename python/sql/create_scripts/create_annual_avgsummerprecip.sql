-- View: tables.annual_avgsummerprecip

-- DROP VIEW tables.annual_avgsummerprecip;

CREATE OR REPLACE VIEW tables.annual_avgsummerprecip AS 
 SELECT row_number() OVER (ORDER BY annual_avgsummerprecip_all.siteid, annual_avgsummerprecip_all.year) AS valueid,
    annual_avgsummerprecip_all.seasonalavg AS datavalue,
    annual_avgsummerprecip_all.siteid,
    (annual_avgsummerprecip_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    701 AS originalvariableid,
    735 AS variableid
   FROM tables.annual_avgsummerprecip_all;

ALTER TABLE tables.annual_avgsummerprecip
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerprecip TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerprecip TO asjacobs;
GRANT SELECT ON TABLE tables.annual_avgsummerprecip TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerprecip TO rwspicer;
COMMENT ON VIEW tables.annual_avgsummerprecip
  IS 'This view creates "annual_avgsummerprecip" with the fields: valueid, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=735';
