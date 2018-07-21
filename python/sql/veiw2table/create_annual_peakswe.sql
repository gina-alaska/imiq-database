
CREATE TABLE tables.annual_peakswe_2 AS 
 SELECT row_number() OVER (ORDER BY annual_peakswe_all.siteid, annual_peakswe_all.year) AS valueid,
    annual_peakswe_all.datavalue,
    annual_peakswe_all.siteid,
    (annual_peakswe_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    693 AS originalvariableid,
    717 AS variableid
   FROM tables.annual_peakswe_all
  WHERE annual_peakswe_all.datavalue > 0::double precision;

ALTER TABLE tables.annual_peakswe_2
  ADD CONSTRAINT annual_peakswe_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_peakswe_siteid_idx
  ON tables.annual_peakswe_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_peakswe_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_peakswe_2 TO imiq;
GRANT ALL ON TABLE tables.annual_peakswe_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_peakswe_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_peakswe_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_peakswe_2 TO rwspicer;
COMMENT ON TABLE tables.annual_peakswe_2
  IS 'This view creates "annual_peakswe" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=717';
