-- View: tables.daily_discharge

-- DROP VIEW tables.daily_discharge;

CREATE OR REPLACE VIEW tables.daily_discharge AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 689 AS variableid
   FROM tables.daily_dischargedatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_discharge
  OWNER TO asjacobs;
COMMENT ON VIEW tables.daily_discharge
  IS 'This view restricts data values to the range: datavalue >=0.  Sets the daily discharge variableid=689.';
