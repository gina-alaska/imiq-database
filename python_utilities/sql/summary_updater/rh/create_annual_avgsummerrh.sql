
CREATE TABLE tables.annual_avgsummerrh_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgsummerrh_all.siteid, annual_avgsummerrh_all.year) AS valueid,
    annual_avgsummerrh_all.seasonalavgrh AS datavalue,
    annual_avgsummerrh_all.siteid,
    (annual_avgsummerrh_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    707 AS originalvariableid,
    739 AS variableid
   FROM tables.annual_avgsummerrh_all;

ALTER TABLE tables.annual_avgsummerrh_2
  ADD CONSTRAINT annual_avgsummerrh_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgsummerrh_siteid_idx
  ON tables.annual_avgsummerrh_2
  USING btree
  (siteid);


ALTER TABLE tables.annual_avgsummerrh_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerrh_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerrh_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgsummerrh_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgsummerrh_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerrh_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgsummerrh_2
  IS 'This view creates "annual_avgsummerrh_2" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=707 and variableid=739.';
