CREATE TABLE tables.annual_avgsummerdischarge_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgsummerdischarge_all.siteid, annual_avgsummerdischarge_all.year) AS valueid,
    annual_avgsummerdischarge_all.seasonalavg AS datavalue,
    annual_avgsummerdischarge_all.siteid,
    (annual_avgsummerdischarge_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    700 AS originalvariableid,
    737 AS variableid
   FROM tables.annual_avgsummerdischarge_all;


ALTER TABLE tables.annual_avgsummerdischarge_2
  ADD CONSTRAINT annual_avgsummerdischarge_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgsummerdischarge_siteid_idx
  ON tables.annual_avgsummerdischarge_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgsummerdischarge_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerdischarge_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerdischarge_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgsummerdischarge_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgsummerdischarge_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerdischarge_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgsummerdischarge_2
  IS 'This view creates "annual_avgsummerdischarge" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=700 and variableid=737';
