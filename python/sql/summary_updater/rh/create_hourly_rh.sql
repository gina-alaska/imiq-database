
CREATE TABLE tables.hourly_rh_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    679 AS variableid
   FROM tables.hourly_rhdatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue > 0::double precision AND v.datavalue <= 100::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.hourly_rh_2
  ADD CONSTRAINT hourly_rh_valueid PRIMARY KEY (valueid);

CREATE INDEX hourly_rh_siteid_idx
  ON tables.hourly_rh_2
  USING btree
  (siteid);

ALTER TABLE tables.hourly_rh_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.hourly_rh_2 TO imiq;
GRANT ALL ON TABLE tables.hourly_rh_2 TO asjacobs;
GRANT ALL ON TABLE tables.hourly_rh_2 TO chaase;
GRANT SELECT ON TABLE tables.hourly_rh_2 TO imiq_reader;
GRANT ALL ON TABLE tables.hourly_rh_2 TO rwspicer;
COMMENT ON TABLE tables.hourly_rh_2
  IS 'This view restricts data values to the range: datavalue > 0 and datavalue <= 100.  Sets the hourly relative humidity variableid=679';
