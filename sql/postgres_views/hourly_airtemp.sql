-- View: tables.hourly_airtemp

-- DROP VIEW tables.hourly_airtemp;

CREATE OR REPLACE VIEW tables.hourly_airtemp AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 677 AS variableid
   FROM tables.hourly_airtempdatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= (-62.22)::double precision AND v.datavalue <= 46.11::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.hourly_airtemp
  OWNER TO asjacobs;
COMMENT ON VIEW tables.hourly_airtemp
  IS 'This view restricts data values to the range: -80F <= DataValue < 115F.  Sets the hourly air temperature variableid=677';
