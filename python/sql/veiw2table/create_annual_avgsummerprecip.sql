
CREATE TABLE tables.annual_avgsummerprecip_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgsummerprecip_all.siteid, annual_avgsummerprecip_all.year) AS valueid,
    annual_avgsummerprecip_all.seasonalavg AS datavalue,
    annual_avgsummerprecip_all.siteid,
    (annual_avgsummerprecip_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    701 AS originalvariableid,
    735 AS variableid
   FROM tables.annual_avgsummerprecip_all;

ALTER TABLE tables.annual_avgsummerprecip_2
  ADD CONSTRAINT annual_avgsummerprecip_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgsummerprecip_siteid_idx
  ON tables.annual_avgsummerprecip_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgsummerprecip_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgsummerprecip_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgsummerprecip_2
  IS 'This view creates "annual_avgsummerprecip_2" with the fields: valueid, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=735';
