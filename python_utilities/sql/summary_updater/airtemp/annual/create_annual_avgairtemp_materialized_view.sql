-- create_annual_avgairtemp_materialized_view.sql
--
--
-- version 1.0.1
-- updated 2017-04-21
--
-- changelog:
-- 1.0.1: changed original variable id from monthly to daily
-- 1.0.0: created from old files for creating tables.annual_airtemp and 
--        tables.monthly_airtemp_all

-- View: tables.annual_avgairtemp

-- DROP MATERIALIZED VIEW tables.annual_avgairtemp;

CREATE MATERIALIZED VIEW tables.annual_avgairtemp AS 
 SELECT row_number() OVER (ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.year) AS valueid,
    avg(monthly_airtemp_all.monthlyavg) AS datavalue,
    monthly_airtemp_all.siteid,
    (monthly_airtemp_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    686 AS originalvariableid,
    699 AS variableid
   FROM (SELECT d.siteid,
                date_part('year'::text, d.utcdatetime) AS year,
                date_part('month'::text, d.utcdatetime) AS month,
                avg(d.datavalue) AS monthlyavg,
                count(*) AS total
        FROM tables.daily_airtemp d
        GROUP BY d.siteid, date_part('year'::text, d.utcdatetime), date_part('month'::text, d.utcdatetime)
        HAVING count(*) >= 10) as monthly_airtemp_all
  WHERE monthly_airtemp_all.monthlyavg IS NOT NULL
  GROUP BY monthly_airtemp_all.siteid, monthly_airtemp_all.year
 HAVING count(*) = 12;

--ALTER TABLE tables.annual_avgairtemp
--  ADD CONSTRAINT annual_avgfallairtemp_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgairtemp_siteid_idx_mv
  ON tables.annual_avgairtemp
  USING btree
  (siteid);


ALTER MATERIALIZED VIEW tables.annual_avgairtemp
  OWNER TO imiq;
COMMENT ON MATERIALIZED VIEW tables.annual_avgairtemp
  IS 'This creates annual air temperature averages using "daily_airtemp". ';
