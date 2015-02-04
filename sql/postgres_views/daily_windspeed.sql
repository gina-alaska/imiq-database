-- View: tables.daily_windspeed

-- DROP VIEW tables.daily_windspeed;

CREATE OR REPLACE VIEW tables.daily_windspeed AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 696 AS variableid
   FROM tables.daily_windspeeddatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision AND v.datavalue < 50::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_windspeed
  OWNER TO asjacobs;
COMMENT ON VIEW tables.daily_windspeed
  IS 'This view restricts the data values to the range: datavalue >= 0 and datavalue < 50.  Sets the daily wind speed variableid=696';
