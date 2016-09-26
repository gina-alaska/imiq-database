-- View: tables._15min_watertemp

-- DROP VIEW tables._15min_watertemp;

CREATE Table tables._15min_watertemp_test AS 
 SELECT dv.valueid,
    dv.datavalue,
    dv.localdatetime + dv.utcoffset * '01:00:00'::interval AS utcdatetime,
    ds.siteid,
    ds.variableid AS originalvariableid,
    1143 AS variableid
   FROM tables.datavalues dv
     JOIN tables.datastreams ds ON ds.datastreamid = dv.datastreamid
     JOIN tables.variables v ON v.variableid = ds.variableid
  WHERE lower(v.samplemedium::text) ~~ '%surface water%'::text AND lower(v.variablename::text) ~~ 'temperature'::text AND v.timesupport = 15::double precision;

ALTER TABLE tables._15min_watertemp_test
  ADD CONSTRAINT _15min_watertemp_valueid PRIMARY KEY (valueid);

CREATE INDEX _15min_watertemp_test_siteid_idx
  ON tables._15min_watertemp_test
  USING btree
  (siteid);

ALTER TABLE tables._15min_watertemp_test
  OWNER TO imiq;
GRANT ALL ON TABLE tables._15min_watertemp_test TO imiq;
GRANT ALL ON TABLE tables._15min_watertemp_test TO asjacobs;
GRANT ALL ON TABLE tables._15min_watertemp_test TO chaase;
GRANT SELECT ON TABLE tables._15min_watertemp_test TO imiq_reader;
GRANT ALL ON TABLE tables._15min_watertemp_test TO rwspicer;
COMMENT ON table tables._15min_watertemp_test
  IS 'This table creates "_15min_watertemp" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid';
