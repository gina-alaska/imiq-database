
CREATE TABLE tables.annual_avgwinterprecip_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgwinterprecip_all.siteid, annual_avgwinterprecip_all.year) AS valueid,
    annual_avgwinterprecip_all.seasonalavg AS datavalue,
    annual_avgwinterprecip_all.siteid,
    (annual_avgwinterprecip_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    701 AS originalvariableid,
    731 AS variableid
   FROM tables.annual_avgwinterprecip_all;

ALTER TABLE tables.annual_avgwinterprecip_2
  ADD CONSTRAINT annual_avgwinterprecip_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgwinterprecip_siteid_idx
  ON tables.annual_avgwinterprecip_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgwinterprecip_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgwinterprecip_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgwinterprecip_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgwinterprecip_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgwinterprecip_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgwinterprecip_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgwinterprecip_2
  IS 'This view creates "annual_avgwinterprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=731';
