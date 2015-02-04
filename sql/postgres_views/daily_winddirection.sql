-- View: tables.daily_winddirection

-- DROP VIEW tables.daily_winddirection;

CREATE OR REPLACE VIEW tables.daily_winddirection AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 695 AS variableid
   FROM tables.daily_winddirectiondatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision AND v.datavalue <= 360::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_winddirection
  OWNER TO asjacobs;
COMMENT ON VIEW tables.daily_winddirection
  IS 'This view restricts data values to the range: datavalue >= 0 and datavalue <= 360.  Sets the daily wind direction variableid=695.';
