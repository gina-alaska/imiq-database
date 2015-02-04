-- View: tables.monthly_airtemp

-- DROP VIEW tables.monthly_airtemp;

CREATE OR REPLACE VIEW tables.monthly_airtemp AS 
 SELECT row_number() OVER (ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.monthlyavg) AS valueid, monthly_airtemp_all.monthlyavg AS datavalue, monthly_airtemp_all.siteid, (((monthly_airtemp_all.year::character varying::text || '-'::text) || monthly_airtemp_all.month::character varying::text) || '-01'::text)::timestamp without time zone AS utcdatetime, 686 AS originalvariableid, 697 AS variableid
   FROM tables.monthly_airtemp_all;

ALTER TABLE tables.monthly_airtemp
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_airtemp
  IS 'This view creates "monthly_air temp" with the fields: valueid, datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets the monthly air temperature variableid=697 and originalvariableid=686.  ';
