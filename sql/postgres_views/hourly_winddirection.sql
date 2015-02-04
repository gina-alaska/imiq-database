-- View: tables.hourly_winddirection

-- DROP VIEW tables.hourly_winddirection;

CREATE OR REPLACE VIEW tables.hourly_winddirection AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 682 AS variableid
   FROM tables.hourly_winddirectiondatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision AND v.datavalue <= 360::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.hourly_winddirection
  OWNER TO asjacobs;
COMMENT ON VIEW tables.hourly_winddirection
  IS 'This view restricts data values to the range: datavalue >= 0 and datavalue <= 360.  Sets the hourly wind direction variableid=682';
