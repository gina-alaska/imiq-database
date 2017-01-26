-- View: tables.annual_avgrh

-- DROP VIEW tables.annual_avgrh;

CREATE table tables.annual_avgrh_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgrh_all.siteid, annual_avgrh_all.year) AS valueid,
    annual_avgrh_all.rh AS datavalue,
    annual_avgrh_all.siteid,
    (annual_avgrh_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    707 AS originalvariableid,
    708 AS variableid
   FROM tables.annual_avgrh_all;

ALTER TABLE tables.annual_avgrh_2
  ADD CONSTRAINT annual_avgrh_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgrh_siteid_idx
  ON tables.annual_avgrh_2
  USING btree
  (siteid);


ALTER TABLE tables.annual_avgrh_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgrh_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgrh_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgrh_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgrh_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgrh_2 TO rwspicer;
COMMENT ON table tables.annual_avgrh_2
  IS 'This view creates "annual_avgrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets variableid=708 and originalvariableid=707';
