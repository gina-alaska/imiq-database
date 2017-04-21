-- create_monthly_airtemp_materialized_view.sql
--
--
-- version 1.0.0
-- updated 2017-04-22
--
-- changelog
-- 1.1.0: removed the VIEW_TEST part of name
-- 1.0.0: created from old files for creating tables.monthly_airtemp_all and 
--        tables.monthly_airtemp_all


-- MATERIALIZED  View: tables.monthly_airtemp

-- DROP MATERIALIZED  VIEW tables.monthly_airtemp;

CREATE MATERIALIZED VIEW  tables.monthly_airtemp AS 
 SELECT row_number() OVER (ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.monthlyavg) AS valueid,
    monthly_airtemp_all.monthlyavg AS datavalue,
    monthly_airtemp_all.siteid,
    (((monthly_airtemp_all.year::character varying::text || '-'::text) || monthly_airtemp_all.month::character varying::text) || '-01'::text)::timestamp without time zone AS utcdatetime,
    686 AS originalvariableid,
    697 AS variableid
   FROM 
        (SELECT d.siteid,
                date_part('year'::text, d.utcdatetime) AS year,
                date_part('month'::text, d.utcdatetime) AS month,
                avg(d.datavalue) AS monthlyavg,
                count(*) AS total
        FROM tables.daily_airtemp d
        GROUP BY d.siteid, date_part('year'::text, d.utcdatetime), date_part('month'::text, d.utcdatetime)
        HAVING count(*) >= 10) 
        as monthly_airtemp_all;

CREATE INDEX monthly_airtemp_siteid_idx_mv
  ON tables.monthly_airtemp
  USING btree
  (siteid);

ALTER MATERIALIZED VIEW tables.monthly_airtemp
  OWNER TO imiq;
COMMENT ON MATERIALIZED VIEW tables.monthly_airtemp
  IS 'This view creates monthly averages using "daily_airtemp".  Restricted to months with at least 10 days of data.';
