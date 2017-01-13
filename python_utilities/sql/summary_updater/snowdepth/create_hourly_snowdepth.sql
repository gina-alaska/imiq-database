-- create_daily_snowdepth.sql
--
--
-- version 1.0.0
-- updated 2017-01-13
--
-- changelog:
-- 1.0.0: recreated from create_daily_snowdepth.sql
CREATE TABLE tables.daily_snowdepth_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    680 AS variableid
   FROM tables.daily_snowdepthdatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision AND v.datavalue <= 12::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_snowdepth_2
  ADD CONSTRAINT daily_snowdepth_valueid PRIMARY KEY (valueid);

CREATE INDEX daily_snowdepth_siteid_idx
  ON tables.daily_snowdepth_2
  USING btree
  (siteid);

ALTER TABLE tables.daily_snowdepth_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.daily_snowdepth_2 TO imiq;
GRANT ALL ON TABLE tables.daily_snowdepth_2 TO asjacobs;
GRANT ALL ON TABLE tables.daily_snowdepth_2 TO chaase;
GRANT SELECT ON TABLE tables.daily_snowdepth_2 TO imiq_reader;
GRANT ALL ON TABLE tables.daily_snowdepth_2 TO rwspicer;
COMMENT ON TABLE tables.daily_snowdepth_2
  IS 'This view restricts data values to the range: 0m <= DataValue <= 12mF.  Sets the daily air temperature variableid = 692';
