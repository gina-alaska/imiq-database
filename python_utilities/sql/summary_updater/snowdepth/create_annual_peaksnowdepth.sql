-- create_annual_snowdepth.sql
-- 
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
-- 1.0.0: initial version


CREATE TABLE tables.annual_peaksnowdepth_2 AS 
 SELECT row_number() OVER (ORDER BY annual_peaksnowdepth_all.siteid, annual_peaksnowdepth_all.year) AS valueid,
    annual_peaksnowdepth_all.datavalue,
    annual_peaksnowdepth_all.siteid,
    (annual_peaksnowdepth_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    692 AS originalvariableid,
    705 AS variableid
   FROM tables.annual_peaksnowdepth_all
  WHERE annual_peaksnowdepth_all.datavalue > 0::double precision;

ALTER TABLE tables.annual_peaksnowdepth_2
  ADD CONSTRAINT annual_peaksnowdepth_valueid_2 PRIMARY KEY (valueid);

CREATE INDEX annual_peaksnowdepth_siteid_idx_2
  ON tables.annual_peaksnowdepth_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_peaksnowdepth_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_peaksnowdepth_2 TO imiq;
GRANT ALL ON TABLE tables.annual_peaksnowdepth_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_peaksnowdepth_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_peaksnowdepth_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_peaksnowdepth_2 TO rwspicer;
COMMENT ON TABLE tables.annual_peaksnowdepth_2
  IS 'This view creates "annual_peaksnowdepth" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=705';
