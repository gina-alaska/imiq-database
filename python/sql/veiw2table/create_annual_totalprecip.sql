
CREATE TABLE tables.annual_totalprecip_2 AS 
 SELECT row_number() OVER (ORDER BY annual_totalprecip_all.siteid, annual_totalprecip_all.year) AS valueid,
    annual_totalprecip_all.datavalue,
    annual_totalprecip_all.siteid,
    (annual_totalprecip_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    701 AS originalvariableid,
    703 AS variableid
   FROM tables.annual_totalprecip_all;

 ALTER TABLE tables.annual_totalprecip_2
  ADD CONSTRAINT annual_totalprecip_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_totalprecip_siteid_idx
  ON tables.annual_totalprecip_2
  USING btree
  (siteid);


ALTER TABLE tables.annual_totalprecip_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_totalprecip_2 TO imiq;
GRANT ALL ON TABLE tables.annual_totalprecip_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_totalprecip_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_totalprecip_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_totalprecip_2 TO rwspicer;
COMMENT ON TABLE tables.annual_totalprecip_2
  IS 'This view creates "annual_totalprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid= and variableid=';
