CREATE TABLE tables.monthly_rh_2 AS 
 SELECT row_number() OVER (ORDER BY monthly_rh_all.siteid, monthly_rh_all.rh) AS valueid,
    monthly_rh_all.rh AS datavalue,
    monthly_rh_all.siteid,
    (((monthly_rh_all.year || '-'::text) || monthly_rh_all.month) || '-01'::text)::timestamp without time zone AS utcdatetime,
    691 AS originalvariableid,
    707 AS variableid
   FROM tables.monthly_rh_all;

ALTER TABLE tables.monthly_rh_2
  ADD CONSTRAINT monthly_rh_valueid PRIMARY KEY (valueid);

CREATE INDEX monthly_rh_siteid_idx
  ON tables.monthly_rh_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_rh_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_rh_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_rh_2 TO asjacobs;
GRANT ALL ON TABLE tables.monthly_rh_2 TO chaase;
GRANT SELECT ON TABLE tables.monthly_rh_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_rh_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_rh_2
  IS 'This view creates "monthly_rh" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=691 and variableid=707.';
