
CREATE TABLE tables.annual_avgwinterrh_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgwinterrh_all.siteid, annual_avgwinterrh_all.year) AS valueid,
    annual_avgwinterrh_all.seasonalavgrh AS datavalue,
    annual_avgwinterrh_all.siteid,
    (annual_avgwinterrh_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    707 AS originalvariableid,
    741 AS variableid
   FROM tables.annual_avgwinterrh_all;

ALTER TABLE tables.annual_avgwinterrh_2
  ADD CONSTRAINT annual_avgwinterrh_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgwinterrh_siteid_idx
  ON tables.annual_avgwinterrh_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgwinterrh_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgwinterrh_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgwinterrh_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgwinterrh_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgwinterrh_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgwinterrh_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgwinterrh_2
  IS 'This view creates "annual_avgwinterrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=707 and vairableid=741';
