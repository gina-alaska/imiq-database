
CREATE TABLE tables.hourly_airtemp_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    677 AS variableid
   FROM tables.hourly_airtempdatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= (-62.22)::double precision AND v.datavalue <= 46.11::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.hourly_airtemp_2
  ADD CONSTRAINT hourly_airtemp_valueid PRIMARY KEY (valueid);

CREATE INDEX hourly_airtemp_siteid_idx
  ON tables.hourly_airtemp_2
  USING btree
  (siteid);

ALTER TABLE tables.hourly_airtemp_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.hourly_airtemp_2 TO imiq;
GRANT ALL ON TABLE tables.hourly_airtemp_2 TO asjacobs;
GRANT ALL ON TABLE tables.hourly_airtemp_2 TO chaase;
GRANT SELECT ON TABLE tables.hourly_airtemp_2 TO imiq_reader;
GRANT ALL ON TABLE tables.hourly_airtemp_2 TO rwspicer;
