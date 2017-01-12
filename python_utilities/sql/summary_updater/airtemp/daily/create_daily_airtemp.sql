-- create_daily_airtemp.sql
--
--
-- version 1.0.0
-- updated 2017-01-12
--
-- changelog:
-- 1.0.0: added comments
CREATE TABLE tables.daily_airtemp_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    686 AS variableid
   FROM tables.daily_airtempdatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= (-62.22)::double precision AND v.datavalue <= 46.11::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_airtemp_2
  ADD CONSTRAINT daily_airtemp_valueid PRIMARY KEY (valueid);

CREATE INDEX daily_airtemp_siteid_idx
  ON tables.daily_airtemp_2
  USING btree
  (siteid);

ALTER TABLE tables.daily_airtemp_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.daily_airtemp_2 TO imiq;
GRANT ALL ON TABLE tables.daily_airtemp_2 TO asjacobs;
GRANT ALL ON TABLE tables.daily_airtemp_2 TO chaase;
GRANT SELECT ON TABLE tables.daily_airtemp_2 TO imiq_reader;
GRANT ALL ON TABLE tables.daily_airtemp_2 TO rwspicer;
COMMENT ON TABLE tables.daily_airtemp_2
  IS 'This view restricts data values to the range: -80F <= DataValue < 115F.  Sets the daily air temperature variableid = 686';
