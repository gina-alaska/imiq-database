-- View: tables.daily_airtempmax

-- DROP VIEW tables.daily_airtempmax;

CREATE OR REPLACE VIEW tables.daily_airtempmax AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 687 AS variableid
   FROM tables.daily_airtempmaxdatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= (-62.22)::double precision AND v.datavalue <= 46.11::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_airtempmax
  OWNER TO asjacobs;
COMMENT ON VIEW tables.daily_airtempmax
  IS 'This view restricts data values to the range: -80F <= datavalue < 115F.  Sets the daily max air temperature variableid = 687';
