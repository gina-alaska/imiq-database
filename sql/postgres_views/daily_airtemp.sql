-- View: tables.daily_airtemp

-- DROP VIEW tables.daily_airtemp;

CREATE OR REPLACE VIEW tables.daily_airtemp AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 686 AS variableid
   FROM tables.daily_airtempdatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= (-62.22)::double precision AND v.datavalue <= 46.11::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_airtemp
  OWNER TO asjacobs;
COMMENT ON VIEW tables.daily_airtemp
  IS 'This view restricts data values to the range: -80F <= DataValue < 115F.  Sets the daily air temperature variableid = 686';
