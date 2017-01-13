-- View: tables.annual_peakdischarge

-- DROP VIEW tables.annual_peakdischarge;

CREATE TABLE tables.annual_peakdischarge_2 AS 
 SELECT row_number() OVER (ORDER BY annual_peakdischarge_all.siteid, annual_peakdischarge_all.year) AS valueid,
    annual_peakdischarge_all.datavalue,
    annual_peakdischarge_all.siteid,
    (annual_peakdischarge_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    689 AS originalvariableid,
    712 AS variableid
   FROM tables.annual_peakdischarge_all;

ALTER TABLE tables.annual_peakdischarge_2
  ADD CONSTRAINT annual_peakdischarge_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_peakdischarge_siteid_idx
  ON tables.annual_peakdischarge_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_peakdischarge_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_peakdischarge_2 TO imiq;
GRANT ALL ON TABLE tables.annual_peakdischarge_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_peakdischarge_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_peakdischarge_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_peakdischarge_2 TO rwspicer;
COMMENT ON TABLE tables.annual_peakdischarge_2
  IS 'This view creates "annual_peakdischarge" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=689 and variableid=712';
