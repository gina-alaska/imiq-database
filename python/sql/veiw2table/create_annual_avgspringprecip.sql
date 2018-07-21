
CREATE table tables.annual_avgspringprecip_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgspringprecip_all.siteid, annual_avgspringprecip_all.year) AS valueid,
    annual_avgspringprecip_all.seasonalavg AS datavalue,
    annual_avgspringprecip_all.siteid,
    (annual_avgspringprecip_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    701 AS originalvariableid,
    733 AS variableid
   FROM tables.annual_avgspringprecip_all;


ALTER TABLE tables.annual_avgspringprecip_2
  ADD CONSTRAINT annual_avgspringprecip_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgspringprecip_siteid_idx
  ON tables.annual_avgspringprecip_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgspringprecip_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringprecip_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringprecip_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgspringprecip_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgspringprecip_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgspringprecip_2 TO rwspicer;
COMMENT ON table tables.annual_avgspringprecip_2
  IS 'This view creates "annual_avgspringprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=733';
