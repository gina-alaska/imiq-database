-- create_annual_avgairtemp_materialized_view.sql
--
--
-- version 1.0.0
-- updated 2017-02-20
--
-- changelog:
-- 1.0.0: created from old files for creating tables.create_annual_airfalltemp_all and 
--        tables.monthly_airtemp_all

-- View: tables.annual_avgfallairtemp_2

-- DROP MATERIALIZED VIEW tables.annual_avgfallairtemp_2;

CREATE MATERIALIZED VIEW tables.annual_avgfallairtemp_2 AS 
 SELECT row_number() OVER (ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.year) AS valueid,
    avg(monthly_airtemp_all.monthlyavg) AS datavalue,
    monthly_airtemp_all.siteid,
    (monthly_airtemp_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    697 AS originalvariableid,
    699 AS variableid
   FROM (SELECT d.siteid,
                date_part('year'::text, d.utcdatetime) AS year,
                date_part('month'::text, d.utcdatetime) AS month,
                avg(d.datavalue) AS monthlyavg,
                count(*) AS total
        FROM tables.daily_airtemp d
        GROUP BY d.siteid, date_part('year'::text, d.utcdatetime), date_part('month'::text, d.utcdatetime)
        HAVING count(*) >= 10) 
        as monthly_airtemp_all
  WHERE (monthly_airtemp_all.month >= 9::double precision AND monthly_airtemp_all.month <= 11::double precision) AND monthly_airtemp_all.monthlyavg IS NOT NULL
  GROUP BY monthly_airtemp_all.siteid, monthly_airtemp_all.year
 HAVING count(*) = 3;

--ALTER TABLE tables.annual_avgfallairtemp_2
--  ADD CONSTRAINT annual_avgfallairtemp_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgfallairtemp_2_siteid_idx
  ON tables.annual_avgfallairtemp_2
  USING btree
  (siteid);


ALTER TABLE tables.annual_avgfallairtemp_2
  OWNER TO imiq;
COMMENT ON MATERIALIZED VIEW tables.annual_avgfallairtemp_2
  IS 'This view creates annual spring air temperature averages using "monthly_airtemp_all".  Requires all three months; March, April and May; to create annual spring air temperature average.';
