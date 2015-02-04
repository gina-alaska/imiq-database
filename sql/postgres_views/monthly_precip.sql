-- View: tables.monthly_precip

-- DROP VIEW tables.monthly_precip;

CREATE OR REPLACE VIEW tables.monthly_precip AS 
 SELECT row_number() OVER (ORDER BY monthly_precip_all.siteid, monthly_precip_all.monthlytotal) AS valueid, monthly_precip_all.monthlytotal AS datavalue, monthly_precip_all.siteid, (((monthly_precip_all.year::character varying::text || '-'::text) || monthly_precip_all.month::character varying::text) || '-01'::text)::timestamp without time zone AS utcdatetime, 690 AS originalvariableid, 701 AS variableid
   FROM tables.monthly_precip_all;

ALTER TABLE tables.monthly_precip
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_precip
  IS 'This view creates "monthly_precip" with the fields: valueid, datavalue,siteid,utcdatetime,originalvariableid,variableid.  Sets the originalvariableid=690 and variableid=701';
