-- View: tables.daily_watertemp

-- DROP VIEW tables.daily_watertemp;

CREATE OR REPLACE VIEW tables.daily_watertemp AS 
 SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 694 AS variableid
   FROM tables.daily_watertempdatavalues v
   JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue IS NOT NULL
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_watertemp
  OWNER TO asjacobs;
COMMENT ON VIEW tables.daily_watertemp
  IS 'This view restricts data values to those which are not null.  Sets the daily water temperature variableid=694.';
