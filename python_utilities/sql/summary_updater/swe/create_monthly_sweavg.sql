-- create_monthly_sweavg.sql
--      creates monthly_sweavg table
--
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
--      1.0.0: initial version
CREATE TABLE tables.monthly_sweavg_2 AS 
 SELECT row_number() OVER (ORDER BY monthly_sweavg_all.siteid, monthly_sweavg_all.monthlyavg) AS valueid,
    monthly_sweavg_all.monthlyavg AS datavalue,
    monthly_sweavg_all.siteid,
    (((monthly_sweavg_all.year || '-'::text) || monthly_sweavg_all.month) || '-01'::text)::timestamp without time zone AS utcdatetime,
    693 AS originalvariableid,
    721 AS variableid
   FROM tables.monthly_sweavg_all;

ALTER TABLE tables.monthly_sweavg_2
  ADD CONSTRAINT monthly_sweavg_valueid PRIMARY KEY (valueid);

CREATE INDEX monthly_sweavg_siteid_idx
  ON tables.monthly_sweavg_2
  USING btree
  (siteid);

ALTER TABLE tables.monthly_sweavg_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.monthly_sweavg_2 TO imiq;
GRANT ALL ON TABLE tables.monthly_sweavg_2 TO asjacobs;
GRANT ALL ON TABLE tables.monthly_sweavg_2 TO chaase;
GRANT SELECT ON TABLE tables.monthly_sweavg_2 TO imiq_reader;
GRANT ALL ON TABLE tables.monthly_sweavg_2 TO rwspicer;
COMMENT ON TABLE tables.monthly_sweavg_2
  IS 'This view creates "monthly_sweavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=721';
