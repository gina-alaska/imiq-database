-- create_annual_avgwinterairtemp.sql
--
--
-- version 1.0.0
-- updated 2017-01-12
--
-- changelog:
-- 1.0.0: added comments
CREATE TABLE tables.annual_avgwinterairtemp_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgwinterairtemp_all.siteid, annual_avgwinterairtemp_all.year) AS valueid,
    annual_avgwinterairtemp_all.seasonalavg AS datavalue,
    annual_avgwinterairtemp_all.siteid,
    (annual_avgwinterairtemp_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    697 AS originalvariableid,
    719 AS variableid
   FROM tables.annual_avgwinterairtemp_all;

ALTER TABLE tables.annual_avgwinterairtemp_2
  ADD CONSTRAINT annual_avgwinterairtemp_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgwinterairtemp_siteid_idx_2
  ON tables.annual_avgwinterairtemp_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgwinterairtemp_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgwinterairtemp_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgwinterairtemp_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgwinterairtemp_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgwinterairtemp_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgwinterairtemp_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgwinterairtemp_2
  IS 'This view creates "annual_avgwinterairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=719';
