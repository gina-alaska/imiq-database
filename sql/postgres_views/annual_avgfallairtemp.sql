-- View: tables.annual_avgfallairtemp

-- DROP VIEW tables.annual_avgfallairtemp;

CREATE OR REPLACE VIEW tables.annual_avgfallairtemp AS 
 SELECT row_number() OVER (ORDER BY annual_avgfallairtemp_all.siteid, annual_avgfallairtemp_all.year) AS valueid, annual_avgfallairtemp_all.seasonalavg AS datavalue, annual_avgfallairtemp_all.siteid, (annual_avgfallairtemp_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 722 AS variableid
   FROM tables.annual_avgfallairtemp_all;

ALTER TABLE tables.annual_avgfallairtemp
  OWNER TO asjacobs;
COMMENT ON VIEW tables.annual_avgfallairtemp
  IS 'This view creates "annual_avgfallairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=722.';
