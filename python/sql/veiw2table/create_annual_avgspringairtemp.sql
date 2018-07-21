

CREATE Table tables.annual_avgspringairtemp_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgspringairtemp_all.siteid, annual_avgspringairtemp_all.year) AS valueid,
    annual_avgspringairtemp_all.seasonalavg AS datavalue,
    annual_avgspringairtemp_all.siteid,
    (annual_avgspringairtemp_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    697 AS originalvariableid,
    724 AS variableid
   FROM tables.annual_avgspringairtemp_all;

ALTER TABLE tables.annual_avgspringairtemp_2
  ADD CONSTRAINT annual_avgspringairtemp_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgspringairtemp_siteid_idx
  ON tables.annual_avgspringairtemp_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgspringairtemp_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringairtemp_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgspringairtemp_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgspringairtemp_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgspringairtemp_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgspringairtemp_2 TO rwspicer;
COMMENT ON  table tables.annual_avgspringairtemp_2
  IS 'This view creates "annual_avgspringairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=724';
