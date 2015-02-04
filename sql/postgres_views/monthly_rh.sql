-- View: tables.monthly_rh

-- DROP VIEW tables.monthly_rh;

CREATE OR REPLACE VIEW tables.monthly_rh AS 
 SELECT row_number() OVER (ORDER BY monthly_rh_all.siteid, monthly_rh_all.rh) AS valueid, monthly_rh_all.rh AS datavalue, monthly_rh_all.siteid, (((monthly_rh_all.year || '-'::text) || monthly_rh_all.month) || '-01'::text)::timestamp without time zone AS utcdatetime, 691 AS originalvariableid, 707 AS variableid
   FROM tables.monthly_rh_all;

ALTER TABLE tables.monthly_rh
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_rh
  IS 'This view creates "monthly_rh" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=691 and variableid=707.';
