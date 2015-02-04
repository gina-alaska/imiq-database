-- View: tables.hourly_windspeed

-- DROP VIEW tables.hourly_windspeed;

CREATE OR REPLACE VIEW tables.hourly_windspeed AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 685 AS variableid
   FROM tables.hourly_windspeeddatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision AND v.datavalue < 50::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.hourly_windspeed
  OWNER TO asjacobs;
COMMENT ON VIEW tables.hourly_windspeed
  IS 'This view restricts data values to the range: datavalue >= 0 and datavalue < 50.  Sets the hourly wind speed variableid=685';
