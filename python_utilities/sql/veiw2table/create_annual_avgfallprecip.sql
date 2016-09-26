
CREATE TABLE tables.annual_avgfallprecip_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgfallprecip_all.siteid, annual_avgfallprecip_all.year) AS valueid,
    annual_avgfallprecip_all.seasonalavg AS datavalue,
    annual_avgfallprecip_all.siteid,
    (annual_avgfallprecip_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    701 AS originalvariableid,
    729 AS variableid
   FROM tables.annual_avgfallprecip_all;

ALTER TABLE tables.annual_avgfallprecip_2
  ADD CONSTRAINT annual_avgfallprecip_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgfallprecip_siteid_idx
  ON tables.annual_avgfallprecip_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgfallprecip_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgfallprecip_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgfallprecip_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgfallprecip_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgfallprecip_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgfallprecip_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgfallprecip_2
  IS 'This view creates "annual_avgfallprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=729';
