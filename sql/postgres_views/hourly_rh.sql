-- View: tables.hourly_rh

-- DROP VIEW tables.hourly_rh;

CREATE OR REPLACE VIEW tables.hourly_rh AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 679 AS variableid
   FROM tables.hourly_rhdatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue > 0::double precision AND v.datavalue <= 100::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.hourly_rh
  OWNER TO asjacobs;
COMMENT ON VIEW tables.hourly_rh
  IS 'This view restricts data values to the range: datavalue > 0 and datavalue <= 100.  Sets the hourly relative humidity variableid=679';
