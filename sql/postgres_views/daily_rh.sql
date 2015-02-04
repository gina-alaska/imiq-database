-- View: tables.daily_rh

-- DROP VIEW tables.daily_rh;

CREATE OR REPLACE VIEW tables.daily_rh AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 691 AS variableid
   FROM tables.daily_rhdatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue > 0::double precision AND v.datavalue <= 100::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_rh
  OWNER TO asjacobs;
COMMENT ON VIEW tables.daily_rh
  IS 'This view restricts data values to the range: datavalue > 0 and datadalue <= 100.  Sets the daily relative humidity variableid=691';
