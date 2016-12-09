
CREATE TABLE tables.daily_rh_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    691 AS variableid
   FROM tables.daily_rhdatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue > 0::double precision AND v.datavalue <= 100::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_rh_2
  ADD CONSTRAINT adaily_rh_valueid PRIMARY KEY (valueid);

CREATE INDEX daily_rh_siteid_idx
  ON tables.daily_rh_2
  USING btree
  (siteid);
  
ALTER TABLE tables.daily_rh_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.daily_rh_2 TO imiq;
GRANT ALL ON TABLE tables.daily_rh_2 TO asjacobs;
GRANT ALL ON TABLE tables.daily_rh_2 TO chaase;
GRANT SELECT ON TABLE tables.daily_rh_2 TO imiq_reader;
GRANT ALL ON TABLE tables.daily_rh_2 TO rwspicer;
COMMENT ON TABLE tables.daily_rh_2
  IS 'This view restricts data values to the range: datavalue > 0 and datadalue <= 100.  Sets the daily relative humidity variableid=691';
