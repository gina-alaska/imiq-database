-- View: tables.monthly_snowdepthavg

-- DROP VIEW tables.monthly_snowdepthavg;

CREATE OR REPLACE VIEW tables.monthly_snowdepthavg AS 
 SELECT row_number() OVER (ORDER BY monthly_snowdepthavg_all.siteid, monthly_snowdepthavg_all.monthlyavg) AS valueid, monthly_snowdepthavg_all.monthlyavg AS datavalue, monthly_snowdepthavg_all.siteid, (((monthly_snowdepthavg_all.year || '-'::text) || monthly_snowdepthavg_all.month) || '-01'::text)::timestamp without time zone AS utcdatetime, 692 AS originalvariableid, 702 AS variableid
   FROM tables.monthly_snowdepthavg_all;

ALTER TABLE tables.monthly_snowdepthavg
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_snowdepthavg
  IS 'This view creates "monthly_snowdepthavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=702';
