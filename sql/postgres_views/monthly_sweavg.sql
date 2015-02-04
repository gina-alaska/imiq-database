-- View: tables.monthly_sweavg

-- DROP VIEW tables.monthly_sweavg;

CREATE OR REPLACE VIEW tables.monthly_sweavg AS 
 SELECT row_number() OVER (ORDER BY monthly_sweavg_all.siteid, monthly_sweavg_all.monthlyavg) AS valueid, monthly_sweavg_all.monthlyavg AS datavalue, monthly_sweavg_all.siteid, (((monthly_sweavg_all.year || '-'::text) || monthly_sweavg_all.month) || '-01'::text)::timestamp without time zone AS utcdatetime, 693 AS originalvariableid, 721 AS variableid
   FROM tables.monthly_sweavg_all;

ALTER TABLE tables.monthly_sweavg
  OWNER TO asjacobs;
COMMENT ON VIEW tables.monthly_sweavg
  IS 'This view creates "monthly_sweavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=721';
