-- View: tables.daily_airtempmin

-- DROP VIEW tables.daily_airtempmin;

CREATE OR REPLACE VIEW tables.daily_airtempmin AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 688 AS variableid
   FROM tables.daily_airtempmindatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= (-62.22)::double precision AND v.datavalue <= 46.11::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_airtempmin
  OWNER TO asjacobs;
COMMENT ON VIEW tables.daily_airtempmin
  IS 'This view restricts data values to the range: -80F <= datavalue < 115F.  Sets the daily min air temperature variableid = 688';
