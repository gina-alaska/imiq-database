-- View: tables.monthly_discharge

-- DROP VIEW tables.monthly_discharge;

CREATE OR REPLACE VIEW tables.monthly_discharge AS 
 SELECT row_number() OVER (ORDER BY monthly_discharge_all.siteid, monthly_discharge_all.monthlyavg) AS valueid, monthly_discharge_all.monthlyavg AS datavalue, monthly_discharge_all.siteid, (((monthly_discharge_all.year::character varying::text || '-'::text) || monthly_discharge_all.month::character varying::text) || '-01'::text)::timestamp without time zone AS utcdatetime, 689 AS originalvariableid, 700 AS variableid
   FROM tables.monthly_discharge_all;

ALTER TABLE tables.monthly_discharge
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_discharge
  IS 'This view creates "monthly_discharge" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=689 and variableid=700.';
