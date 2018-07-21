
CREATE TABLE tables.daily_discharge_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    689 AS variableid
   FROM tables.daily_dischargedatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_discharge_2
  ADD CONSTRAINT daily_discharge_valueid PRIMARY KEY (valueid);

CREATE INDEX daily_discharge_siteid_idx
  ON tables.daily_discharge_2
  USING btree
  (siteid);

ALTER TABLE tables.daily_discharge_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.daily_discharge_2 TO imiq;
GRANT ALL ON TABLE tables.daily_discharge_2 TO asjacobs;
GRANT ALL ON TABLE tables.daily_discharge_2 TO chaase;
GRANT SELECT ON TABLE tables.daily_discharge_2 TO imiq_reader;
GRANT ALL ON TABLE tables.daily_discharge_2 TO rwspicer;
COMMENT ON TABLE tables.daily_discharge_2
  IS 'This view restricts data values to the range: datavalue >=0.  Sets the daily discharge variableid=689.';
