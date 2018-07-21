-- create_monthly_airtemp.sql
--
--
-- version 1.0.0
-- updated 2017-01-12
--
-- changelog:
-- 1.0.0: added comments
-- View: tables.monthly_airtemp

-- DROP VIEW tables.monthly_airtemp;

CREATE TABLE tables.monthly_airtemp_2 AS 
 SELECT row_number() OVER (ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.monthlyavg) AS valueid,
    monthly_airtemp_all.monthlyavg AS datavalue,
    monthly_airtemp_all.siteid,
    (((monthly_airtemp_all.year::character varying::text || '-'::text) || monthly_airtemp_all.month::character varying::text) || '-01'::text)::timestamp without time zone AS utcdatetime,
    686 AS originalvariableid,
    697 AS variableid
   FROM tables.monthly_airtemp_all;

ALTER TABLE tables.monthly_airtemp_2
  ADD CONSTRAINT monthly_airtemp_valueid PRIMARY KEY (valueid);

CREATE INDEX monthly_airtemp_siteid_idx_2
  ON tables.monthly_airtemp_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_airtemp_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_airtemp_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_airtemp_2 TO asjacobs;
GRANT ALL ON TABLE tables.monthly_airtemp_2 TO chaase;
GRANT SELECT ON TABLE tables.monthly_airtemp_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_airtemp_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_airtemp_2
  IS 'This view creates "monthly_air temp" with the fields: valueid, datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets the monthly air temperature variableid=697 and originalvariableid=686.  ';
