-- create_monthly_snowdepthavg.sql
-- 
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
-- 1.0.0: initial version


CREATE TABLE tables.monthly_snowdepthavg_2 AS 
 SELECT row_number() OVER (ORDER BY monthly_snowdepthavg_all.siteid, monthly_snowdepthavg_all.monthlyavg) AS valueid,
    monthly_snowdepthavg_all.monthlyavg AS datavalue,
    monthly_snowdepthavg_all.siteid,
    (((monthly_snowdepthavg_all.year || '-'::text) || monthly_snowdepthavg_all.month) || '-01'::text)::timestamp without time zone AS utcdatetime,
    692 AS originalvariableid,
    702 AS variableid
   FROM tables.monthly_snowdepthavg_all;

ALTER TABLE tables.monthly_snowdepthavg_2
  ADD CONSTRAINT monthly_snowdepthavg_valueid PRIMARY KEY (valueid);

CREATE INDEX monthly_snowdepthavg_siteid_idx
  ON tables.monthly_snowdepthavg_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_snowdepthavg_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_snowdepthavg_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_snowdepthavg_2 TO asjacobs;
GRANT ALL ON TABLE tables.monthly_snowdepthavg_2 TO chaase;
GRANT SELECT ON TABLE tables.monthly_snowdepthavg_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_snowdepthavg_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_snowdepthavg_2
  IS 'This view creates "monthly_snowdepthavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=702';
