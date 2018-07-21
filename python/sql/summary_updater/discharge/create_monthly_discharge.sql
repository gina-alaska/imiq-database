-- View: tables.monthly_discharge

-- DROP VIEW tables.monthly_discharge;

CREATE TABLE tables.monthly_discharge_2 AS 
 SELECT row_number() OVER (ORDER BY monthly_discharge_all.siteid, monthly_discharge_all.monthlyavg) AS valueid,
    monthly_discharge_all.monthlyavg AS datavalue,
    monthly_discharge_all.siteid,
    (((monthly_discharge_all.year::character varying::text || '-'::text) || monthly_discharge_all.month::character varying::text) || '-01'::text)::timestamp without time zone AS utcdatetime,
    689 AS originalvariableid,
    700 AS variableid
   FROM tables.monthly_discharge_all;

ALTER TABLE tables.monthly_discharge_2
  ADD CONSTRAINT monthly_discharge_valueid PRIMARY KEY (valueid);

CREATE INDEX monthly_discharge_siteid_idx
  ON tables.monthly_discharge_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_discharge_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_discharge_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_discharge_2 TO asjacobs;
GRANT ALL ON TABLE tables.monthly_discharge_2 TO chaase;
GRANT SELECT ON TABLE tables.monthly_discharge_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_discharge_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_discharge_2
  IS 'This view creates "monthly_discharge" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=689 and variableid=700.';
