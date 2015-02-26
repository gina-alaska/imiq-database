-- SQL Manager for PostgreSQL 5.5.1.45206
-- ---------------------------------------
-- Host      : imiqdb.gina.alaska.edu
-- Database  : imiq_staging
-- Version   : PostgreSQL 9.1.7 on x86_64-unknown-linux-gnu, compiled by gcc (GCC) 4.4.6 20120305 (Red Hat 4.4.6-4), 64-bit



SET search_path = tables, pg_catalog;
DROP VIEW tables.odmdatavalues_metric;
DROP VIEW tables.annual_totalprecip;
DROP VIEW tables.annual_peakswe;
DROP VIEW tables.annual_peaksnowdepth;
DROP VIEW tables.annual_peakdischarge;
DROP VIEW tables.annual_avgwinterrh;
DROP VIEW tables.annual_avgwinterprecip;
DROP VIEW tables.annual_avgwinterairtemp;
DROP VIEW tables.annual_avgsummerrh;
DROP VIEW tables.annual_avgsummerrh_all;
DROP VIEW tables.annual_avgsummerprecip;
DROP VIEW tables.annual_avgsummerprecip_all;
DROP VIEW tables.annual_avgsummerdischarge;
DROP VIEW tables.annual_avgsummerdischarge_all;
DROP VIEW tables.annual_avgsummerairtemp;
DROP VIEW tables.annual_avgsummerairtemp_all;
DROP VIEW tables.annual_avgspringprecip;
DROP VIEW tables.annual_avgspringprecip_all;
DROP VIEW tables.annual_avgspringairtemp;
DROP VIEW tables.annual_avgspringairtemp_all;
DROP VIEW tables.annual_avgrh;
DROP VIEW tables.annual_avgfallprecip;
DROP VIEW tables.annual_avgfallprecip_all;
DROP VIEW tables.annual_avgfallairtemp;
DROP VIEW tables.annual_avgfallairtemp_all;
DROP VIEW tables.annual_avgdischarge;
DROP VIEW tables.annual_avgairtemp;
DROP VIEW tables.monthly_sweavg;
DROP VIEW tables.monthly_sweavg_all;
DROP VIEW tables.monthly_snowdepthavg;
DROP VIEW tables.monthly_snowdepthavg_all;
DROP VIEW tables.monthly_rh;
DROP VIEW tables.monthly_precip;
DROP VIEW tables.monthly_precip_all;
DROP VIEW tables.monthly_discharge;
DROP VIEW tables.monthly_discharge_all;
DROP VIEW tables.monthly_airtemp;
DROP VIEW tables.monthly_airtemp_all;
DROP VIEW tables.hourly_windspeed;
DROP VIEW tables.hourly_winddirection;
DROP VIEW tables.hourly_rh;
DROP VIEW tables.hourly_airtemp;
DROP VIEW tables.daily_windspeed;
DROP VIEW tables.daily_winddirection;
DROP VIEW tables.daily_watertemp;
DROP VIEW tables.daily_rh;
DROP VIEW tables.daily_discharge;
DROP VIEW tables.daily_airtempmin;
DROP VIEW tables.daily_airtempmax;
DROP VIEW tables.daily_airtemp;
SET search_path = public, pg_catalog;
DROP VIEW public.pg_stat_statements;
DROP VIEW public.geography_columns;
SET check_function_bodies = false;
--
-- Definition for view geography_columns (OID = 17214) : 
--
CREATE VIEW public.geography_columns
AS
SELECT current_database() AS f_table_catalog, n.nspname AS f_table_schema,
    c.relname AS f_table_name, a.attname AS f_geography_column, geography_typmod_dims(a.atttypmod) AS coord_dimension, geography_typmod_srid(a.atttypmod) AS srid, geography_typmod_type(a.atttypmod) AS type
FROM pg_class c, pg_attribute a, pg_type t, pg_namespace n
WHERE ((((((t.typname = 'geography'::name) AND (a.attisdropped = false))
    AND (a.atttypid = t.oid)) AND (a.attrelid = c.oid)) AND (c.relnamespace = n.oid)) AND (NOT pg_is_other_temp_schema(c.relnamespace)));

--
-- Definition for view pg_stat_statements (OID = 391155) : 
--
CREATE VIEW public.pg_stat_statements
AS
SELECT pg_stat_statements.userid, pg_stat_statements.dbid,
    pg_stat_statements.query, pg_stat_statements.calls, pg_stat_statements.total_time, pg_stat_statements.rows, pg_stat_statements.shared_blks_hit, pg_stat_statements.shared_blks_read, pg_stat_statements.shared_blks_written, pg_stat_statements.local_blks_hit, pg_stat_statements.local_blks_read, pg_stat_statements.local_blks_written, pg_stat_statements.temp_blks_read, pg_stat_statements.temp_blks_written
FROM pg_stat_statements() pg_stat_statements(userid, dbid, query, calls,
    total_time, rows, shared_blks_hit, shared_blks_read, shared_blks_written, local_blks_hit, local_blks_read, local_blks_written, temp_blks_read, temp_blks_written);

--
-- Definition for view daily_airtemp (OID = 457204) : 
--
SET search_path = tables, pg_catalog;
CREATE VIEW tables.daily_airtemp
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 686 AS variableid
FROM (daily_airtempdatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue >= ((-62.22))::double precision) AND (v.datavalue <=
    (46.11)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view daily_airtempmax (OID = 457209) : 
--
CREATE VIEW tables.daily_airtempmax
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 687 AS variableid
FROM (daily_airtempmaxdatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue >= ((-62.22))::double precision) AND (v.datavalue <=
    (46.11)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view daily_airtempmin (OID = 457216) : 
--
CREATE VIEW tables.daily_airtempmin
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 688 AS variableid
FROM (daily_airtempmindatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue >= ((-62.22))::double precision) AND (v.datavalue <=
    (46.11)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view daily_discharge (OID = 457221) : 
--
CREATE VIEW tables.daily_discharge
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 689 AS variableid
FROM (daily_dischargedatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE (v.datavalue >= (0)::double precision)
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view daily_rh (OID = 457226) : 
--
CREATE VIEW tables.daily_rh
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 691 AS variableid
FROM (daily_rhdatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue > (0)::double precision) AND (v.datavalue <=
    (100)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view daily_watertemp (OID = 457231) : 
--
CREATE VIEW tables.daily_watertemp
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 694 AS variableid
FROM (daily_watertempdatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE (v.datavalue IS NOT NULL)
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view daily_winddirection (OID = 457235) : 
--
CREATE VIEW tables.daily_winddirection
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 695 AS variableid
FROM (daily_winddirectiondatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue >= (0)::double precision) AND (v.datavalue <=
    (360)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view daily_windspeed (OID = 457240) : 
--
CREATE VIEW tables.daily_windspeed
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 696 AS variableid
FROM (daily_windspeeddatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue >= (0)::double precision) AND (v.datavalue <
    (50)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view hourly_airtemp (OID = 457245) : 
--
CREATE VIEW tables.hourly_airtemp
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 677 AS variableid
FROM (hourly_airtempdatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue >= ((-62.22))::double precision) AND (v.datavalue <=
    (46.11)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view hourly_rh (OID = 457250) : 
--
CREATE VIEW tables.hourly_rh
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 679 AS variableid
FROM (hourly_rhdatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue > (0)::double precision) AND (v.datavalue <=
    (100)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view hourly_winddirection (OID = 457255) : 
--
CREATE VIEW tables.hourly_winddirection
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 682 AS variableid
FROM (hourly_winddirectiondatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue >= (0)::double precision) AND (v.datavalue <=
    (360)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view hourly_windspeed (OID = 457260) : 
--
CREATE VIEW tables.hourly_windspeed
AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, 685 AS variableid
FROM (hourly_windspeeddatavalues v JOIN sites s ON ((v.siteid = s.siteid)))
WHERE ((v.datavalue >= (0)::double precision) AND (v.datavalue <
    (50)::double precision))
GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid,
    v.originalvariableid, s.sourceid;

--
-- Definition for view monthly_airtemp_all (OID = 457265) : 
--
CREATE VIEW tables.monthly_airtemp_all
AS
SELECT d.siteid, date_part('year'::text, d.utcdatetime) AS year,
    date_part('month'::text, d.utcdatetime) AS month, avg(d.datavalue) AS monthlyavg, count(*) AS total
FROM daily_airtemp d
GROUP BY d.siteid, date_part('year'::text, d.utcdatetime),
    date_part('month'::text, d.utcdatetime)
HAVING (count(*) >= 10);

--
-- Definition for view monthly_airtemp (OID = 457269) : 
--
CREATE VIEW tables.monthly_airtemp
AS
SELECT row_number() OVER (
ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.monthlyavg) AS
    valueid, monthly_airtemp_all.monthlyavg AS datavalue, monthly_airtemp_all.siteid, ((((((monthly_airtemp_all.year)::character varying)::text || '-'::text) || ((monthly_airtemp_all.month)::character varying)::text) || '-01'::text))::timestamp without time zone AS utcdatetime, 686 AS originalvariableid, 697 AS variableid
FROM monthly_airtemp_all;

--
-- Definition for view monthly_discharge_all (OID = 457273) : 
--
CREATE VIEW tables.monthly_discharge_all
AS
SELECT p.siteid, date_part('year'::text, p.utcdatetime) AS year,
    date_part('month'::text, p.utcdatetime) AS month, avg(p.datavalue) AS monthlyavg, count(*) AS total
FROM daily_discharge p
GROUP BY p.siteid, date_part('year'::text, p.utcdatetime),
    date_part('month'::text, p.utcdatetime)
HAVING (count(*) >= 10);

--
-- Definition for view monthly_discharge (OID = 457277) : 
--
CREATE VIEW tables.monthly_discharge
AS
SELECT row_number() OVER (
ORDER BY monthly_discharge_all.siteid, monthly_discharge_all.monthlyavg) AS
    valueid, monthly_discharge_all.monthlyavg AS datavalue, monthly_discharge_all.siteid, ((((((monthly_discharge_all.year)::character varying)::text || '-'::text) || ((monthly_discharge_all.month)::character varying)::text) || '-01'::text))::timestamp without time zone AS utcdatetime, 689 AS originalvariableid, 700 AS variableid
FROM monthly_discharge_all;

--
-- Definition for view monthly_precip_all (OID = 457281) : 
--
CREATE VIEW tables.monthly_precip_all
AS
SELECT p.siteid, date_part('year'::text, p.utcdatetime) AS year,
    date_part('month'::text, p.utcdatetime) AS month, sum(p.datavalue) AS monthlytotal, count(*) AS total
FROM daily_precip p
GROUP BY p.siteid, date_part('year'::text, p.utcdatetime),
    date_part('month'::text, p.utcdatetime)
HAVING (count(*) >= 10);

--
-- Definition for view monthly_precip (OID = 457285) : 
--
CREATE VIEW tables.monthly_precip
AS
SELECT row_number() OVER (
ORDER BY monthly_precip_all.siteid, monthly_precip_all.monthlytotal) AS
    valueid, monthly_precip_all.monthlytotal AS datavalue, monthly_precip_all.siteid, ((((((monthly_precip_all.year)::character varying)::text || '-'::text) || ((monthly_precip_all.month)::character varying)::text) || '-01'::text))::timestamp without time zone AS utcdatetime, 690 AS originalvariableid, 701 AS variableid
FROM monthly_precip_all;

--
-- Definition for view monthly_rh (OID = 457289) : 
--
CREATE VIEW tables.monthly_rh
AS
SELECT row_number() OVER (
ORDER BY monthly_rh_all.siteid, monthly_rh_all.rh) AS valueid,
    monthly_rh_all.rh AS datavalue, monthly_rh_all.siteid, ((((monthly_rh_all.year || '-'::text) || monthly_rh_all.month) || '-01'::text))::timestamp without time zone AS utcdatetime, 691 AS originalvariableid, 707 AS variableid
FROM monthly_rh_all;

--
-- Definition for view monthly_snowdepthavg_all (OID = 457293) : 
--
CREATE VIEW tables.monthly_snowdepthavg_all
AS
SELECT p.siteid, date_part('year'::text, p.utcdatetime) AS year,
    date_part('month'::text, p.utcdatetime) AS month, avg(p.datavalue) AS monthlyavg, count(*) AS total
FROM daily_snowdepth p
GROUP BY p.siteid, date_part('year'::text, p.utcdatetime),
    date_part('month'::text, p.utcdatetime)
HAVING (count(*) >= 1);

--
-- Definition for view monthly_snowdepthavg (OID = 457297) : 
--
CREATE VIEW tables.monthly_snowdepthavg
AS
SELECT row_number() OVER (
ORDER BY monthly_snowdepthavg_all.siteid,
    monthly_snowdepthavg_all.monthlyavg) AS valueid, monthly_snowdepthavg_all.monthlyavg AS datavalue, monthly_snowdepthavg_all.siteid, ((((monthly_snowdepthavg_all.year || '-'::text) || monthly_snowdepthavg_all.month) || '-01'::text))::timestamp without time zone AS utcdatetime, 692 AS originalvariableid, 702 AS variableid
FROM monthly_snowdepthavg_all;

--
-- Definition for view monthly_sweavg_all (OID = 457301) : 
--
CREATE VIEW tables.monthly_sweavg_all
AS
SELECT p.siteid, date_part('year'::text, p.utcdatetime) AS year,
    date_part('month'::text, p.utcdatetime) AS month, avg(p.datavalue) AS monthlyavg, count(*) AS total
FROM daily_swe p
GROUP BY p.siteid, date_part('year'::text, p.utcdatetime),
    date_part('month'::text, p.utcdatetime)
HAVING (count(*) >= 1);

--
-- Definition for view monthly_sweavg (OID = 457305) : 
--
CREATE VIEW tables.monthly_sweavg
AS
SELECT row_number() OVER (
ORDER BY monthly_sweavg_all.siteid, monthly_sweavg_all.monthlyavg) AS
    valueid, monthly_sweavg_all.monthlyavg AS datavalue, monthly_sweavg_all.siteid, ((((monthly_sweavg_all.year || '-'::text) || monthly_sweavg_all.month) || '-01'::text))::timestamp without time zone AS utcdatetime, 693 AS originalvariableid, 721 AS variableid
FROM monthly_sweavg_all;

--
-- Definition for view annual_avgairtemp (OID = 457309) : 
--
CREATE VIEW tables.annual_avgairtemp
AS
SELECT row_number() OVER (
ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.year) AS valueid,
    avg(monthly_airtemp_all.monthlyavg) AS datavalue, monthly_airtemp_all.siteid, ((monthly_airtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 699 AS variableid
FROM monthly_airtemp_all
WHERE ((monthly_airtemp_all.month = ANY (ARRAY[(12)::double precision,
    (1)::double precision, (2)::double precision, (3)::double precision, (4)::double precision, (5)::double precision, (6)::double precision, (7)::double precision, (8)::double precision, (9)::double precision, (10)::double precision, (11)::double precision])) AND (monthly_airtemp_all.monthlyavg IS NOT NULL))
GROUP BY monthly_airtemp_all.siteid, monthly_airtemp_all.year
HAVING (count(*) = 12);

--
-- Definition for view annual_avgdischarge (OID = 457314) : 
--
CREATE VIEW tables.annual_avgdischarge
AS
SELECT row_number() OVER (
ORDER BY monthly_discharge_all.siteid, monthly_discharge_all.year) AS
    valueid, avg(monthly_discharge_all.monthlyavg) AS datavalue, monthly_discharge_all.siteid, ((monthly_discharge_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 700 AS originalvariableid, 710 AS variableid
FROM monthly_discharge_all
WHERE ((monthly_discharge_all.month = ANY (ARRAY[(12)::double precision,
    (1)::double precision, (2)::double precision, (3)::double precision, (4)::double precision, (5)::double precision, (6)::double precision, (7)::double precision, (8)::double precision, (9)::double precision, (10)::double precision, (11)::double precision])) AND (monthly_discharge_all.monthlyavg IS NOT NULL))
GROUP BY monthly_discharge_all.siteid, monthly_discharge_all.year
HAVING (count(*) = 12);

--
-- Definition for view annual_avgfallairtemp_all (OID = 457319) : 
--
CREATE VIEW tables.annual_avgfallairtemp_all
AS
SELECT a.siteid, a.year, avg(a.monthlyavg) AS seasonalavg
FROM monthly_airtemp_all a
WHERE (((a.month >= (9)::double precision) AND (a.month <= (11)::double
    precision)) AND (a.monthlyavg IS NOT NULL))
GROUP BY a.siteid, a.year
HAVING (count(*) = 3);

--
-- Definition for view annual_avgfallairtemp (OID = 457323) : 
--
CREATE VIEW tables.annual_avgfallairtemp
AS
SELECT row_number() OVER (
ORDER BY annual_avgfallairtemp_all.siteid, annual_avgfallairtemp_all.year)
    AS valueid, annual_avgfallairtemp_all.seasonalavg AS datavalue, annual_avgfallairtemp_all.siteid, ((annual_avgfallairtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 722 AS variableid
FROM annual_avgfallairtemp_all;

--
-- Definition for view annual_avgfallprecip_all (OID = 457327) : 
--
CREATE VIEW tables.annual_avgfallprecip_all
AS
SELECT p.siteid, p.year, avg(p.monthlytotal) AS seasonalavg
FROM monthly_precip_all p
WHERE (((p.month >= (9)::double precision) AND (p.month <= (11)::double
    precision)) AND (p.monthlytotal IS NOT NULL))
GROUP BY p.siteid, p.year
HAVING (count(*) = 3);

--
-- Definition for view annual_avgfallprecip (OID = 464354) : 
--
CREATE VIEW tables.annual_avgfallprecip
AS
SELECT row_number() OVER (
ORDER BY annual_avgfallprecip_all.siteid, annual_avgfallprecip_all.year) AS
    valueid, annual_avgfallprecip_all.seasonalavg AS datavalue, annual_avgfallprecip_all.siteid, ((annual_avgfallprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 729 AS variableid
FROM annual_avgfallprecip_all;

--
-- Definition for view annual_avgrh (OID = 464358) : 
--
CREATE VIEW tables.annual_avgrh
AS
SELECT row_number() OVER (
ORDER BY annual_avgrh_all.siteid, annual_avgrh_all.year) AS valueid,
    annual_avgrh_all.rh AS datavalue, annual_avgrh_all.siteid, ((annual_avgrh_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 707 AS originalvariableid, 708 AS variableid
FROM annual_avgrh_all;

--
-- Definition for view annual_avgspringairtemp_all (OID = 464362) : 
--
CREATE VIEW tables.annual_avgspringairtemp_all
AS
SELECT a.siteid, a.year, avg(a.monthlyavg) AS seasonalavg
FROM monthly_airtemp_all a
WHERE ((a.month = ANY (ARRAY[(3)::double precision, (4)::double precision,
    (5)::double precision])) AND (a.monthlyavg IS NOT NULL))
GROUP BY a.siteid, a.year
HAVING (count(*) = 3);

--
-- Definition for view annual_avgspringairtemp (OID = 464367) : 
--
CREATE VIEW tables.annual_avgspringairtemp
AS
SELECT row_number() OVER (
ORDER BY annual_avgspringairtemp_all.siteid,
    annual_avgspringairtemp_all.year) AS valueid, annual_avgspringairtemp_all.seasonalavg AS datavalue, annual_avgspringairtemp_all.siteid, ((annual_avgspringairtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 724 AS variableid
FROM annual_avgspringairtemp_all;

--
-- Definition for view annual_avgspringprecip_all (OID = 464371) : 
--
CREATE VIEW tables.annual_avgspringprecip_all
AS
SELECT p.siteid, p.year, avg(p.monthlytotal) AS seasonalavg
FROM monthly_precip_all p
WHERE ((p.month = ANY (ARRAY[(3)::double precision, (4)::double precision,
    (5)::double precision])) AND (p.monthlytotal IS NOT NULL))
GROUP BY p.siteid, p.year
HAVING (count(*) = 3);

--
-- Definition for view annual_avgspringprecip (OID = 464375) : 
--
CREATE VIEW tables.annual_avgspringprecip
AS
SELECT row_number() OVER (
ORDER BY annual_avgspringprecip_all.siteid,
    annual_avgspringprecip_all.year) AS valueid, annual_avgspringprecip_all.seasonalavg AS datavalue, annual_avgspringprecip_all.siteid, ((annual_avgspringprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 733 AS variableid
FROM annual_avgspringprecip_all;

--
-- Definition for view annual_avgsummerairtemp_all (OID = 464380) : 
--
CREATE VIEW tables.annual_avgsummerairtemp_all
AS
SELECT a.siteid, a.year, avg(a.monthlyavg) AS seasonalavg
FROM monthly_airtemp_all a
WHERE (a.month = ANY (ARRAY[(6)::double precision, (7)::double precision,
    (8)::double precision]))
GROUP BY a.siteid, a.year
HAVING (count(*) = 3);

--
-- Definition for view annual_avgsummerairtemp (OID = 466286) : 
--
CREATE VIEW tables.annual_avgsummerairtemp
AS
SELECT row_number() OVER (
ORDER BY annual_avgsummerairtemp_all.siteid,
    annual_avgsummerairtemp_all.year) AS valueid, annual_avgsummerairtemp_all.seasonalavg AS datavalue, annual_avgsummerairtemp_all.siteid, ((annual_avgsummerairtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 726 AS variableid
FROM annual_avgsummerairtemp_all;

--
-- Definition for view annual_avgsummerdischarge_all (OID = 466290) : 
--
CREATE VIEW tables.annual_avgsummerdischarge_all
AS
SELECT monthly_discharge_all.siteid, monthly_discharge_all.year,
    avg(monthly_discharge_all.monthlyavg) AS seasonalavg
FROM monthly_discharge_all
WHERE (((monthly_discharge_all.month >= (6)::double precision) AND
    (monthly_discharge_all.month <= (8)::double precision)) AND (monthly_discharge_all.monthlyavg IS NOT NULL))
GROUP BY monthly_discharge_all.siteid, monthly_discharge_all.year
HAVING (count(*) = 3);

--
-- Definition for view annual_avgsummerdischarge (OID = 466294) : 
--
CREATE VIEW tables.annual_avgsummerdischarge
AS
SELECT row_number() OVER (
ORDER BY annual_avgsummerdischarge_all.siteid,
    annual_avgsummerdischarge_all.year) AS valueid, annual_avgsummerdischarge_all.seasonalavg AS datavalue, annual_avgsummerdischarge_all.siteid, ((annual_avgsummerdischarge_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 700 AS originalvariableid, 737 AS variableid
FROM annual_avgsummerdischarge_all;

--
-- Definition for view annual_avgsummerprecip_all (OID = 466298) : 
--
CREATE VIEW tables.annual_avgsummerprecip_all
AS
SELECT p.siteid, p.year, avg(p.monthlytotal) AS seasonalavg
FROM monthly_precip_all p
WHERE ((p.month = ANY (ARRAY[(6)::double precision, (7)::double precision,
    (8)::double precision])) AND (p.monthlytotal IS NOT NULL))
GROUP BY p.siteid, p.year
HAVING (count(*) = 3);

--
-- Definition for view annual_avgsummerprecip (OID = 466302) : 
--
CREATE VIEW tables.annual_avgsummerprecip
AS
SELECT row_number() OVER (
ORDER BY annual_avgsummerprecip_all.siteid,
    annual_avgsummerprecip_all.year) AS valueid, annual_avgsummerprecip_all.seasonalavg AS datavalue, annual_avgsummerprecip_all.siteid, ((annual_avgsummerprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 735 AS variableid
FROM annual_avgsummerprecip_all;

--
-- Definition for view annual_avgsummerrh_all (OID = 466306) : 
--
CREATE VIEW tables.annual_avgsummerrh_all
AS
SELECT monthly_rh_all.siteid, monthly_rh_all.year, ((((0.611)::double
    precision * exp((((17.3)::double precision * avg(((ln(((((0.611)::double precision * exp((((17.3)::double precision * monthly_rh_all.at) / (monthly_rh_all.at + (237.3)::double precision)))) * monthly_rh_all.rh) / (100.0)::double precision)) + (0.4926)::double precision) / ((0.0708)::double precision - ((0.00421)::double precision * ln(((((0.611)::double precision * exp((((17.3)::double precision * monthly_rh_all.at) / (monthly_rh_all.at + (237.3)::double precision)))) * monthly_rh_all.rh) / (100.0)::double precision))))))) / (avg(((ln(((((0.611)::double precision * exp((((17.3)::double precision * monthly_rh_all.at) / (monthly_rh_all.at + (237.3)::double precision)))) * monthly_rh_all.rh) / (100.0)::double precision)) + (0.4926)::double precision) / ((0.0708)::double precision - ((0.00421)::double precision * ln(((((0.611)::double precision * exp((((17.3)::double precision * monthly_rh_all.at) / (monthly_rh_all.at + (237.3)::double precision)))) * monthly_rh_all.rh) / (100.0)::double precision)))))) + (237.3)::double precision)))) / ((0.611)::double precision * exp((((17.3)::double precision * avg(monthly_rh_all.at)) / (avg(monthly_rh_all.at) + (237.3)::double precision))))) * (100.0)::double precision) AS seasonalavgrh, avg(monthly_rh_all.at) AS seasonalavgat
FROM monthly_rh_all
WHERE (monthly_rh_all.month = ANY (ARRAY[6, 7, 8]))
GROUP BY monthly_rh_all.siteid, monthly_rh_all.year
HAVING (count(*) = 3);

--
-- Definition for view annual_avgsummerrh (OID = 467723) : 
--
CREATE VIEW tables.annual_avgsummerrh
AS
SELECT row_number() OVER (
ORDER BY annual_avgsummerrh_all.siteid, annual_avgsummerrh_all.year) AS
    valueid, annual_avgsummerrh_all.seasonalavgrh AS datavalue, annual_avgsummerrh_all.siteid, ((annual_avgsummerrh_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 707 AS originalvariableid, 739 AS variableid
FROM annual_avgsummerrh_all;

--
-- Definition for view annual_avgwinterairtemp (OID = 471480) : 
--
CREATE VIEW tables.annual_avgwinterairtemp
AS
SELECT row_number() OVER (
ORDER BY annual_avgwinterairtemp_all.siteid,
    annual_avgwinterairtemp_all.year) AS valueid, annual_avgwinterairtemp_all.seasonalavg AS datavalue, annual_avgwinterairtemp_all.siteid, ((annual_avgwinterairtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 719 AS variableid
FROM annual_avgwinterairtemp_all;

--
-- Definition for view annual_avgwinterprecip (OID = 471484) : 
--
CREATE VIEW tables.annual_avgwinterprecip
AS
SELECT row_number() OVER (
ORDER BY annual_avgwinterprecip_all.siteid,
    annual_avgwinterprecip_all.year) AS valueid, annual_avgwinterprecip_all.seasonalavg AS datavalue, annual_avgwinterprecip_all.siteid, ((annual_avgwinterprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 731 AS variableid
FROM annual_avgwinterprecip_all;

--
-- Definition for view annual_avgwinterrh (OID = 471488) : 
--
CREATE VIEW tables.annual_avgwinterrh
AS
SELECT row_number() OVER (
ORDER BY annual_avgwinterrh_all.siteid, annual_avgwinterrh_all.year) AS
    valueid, annual_avgwinterrh_all.seasonalavgrh AS datavalue, annual_avgwinterrh_all.siteid, ((annual_avgwinterrh_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 707 AS originalvariableid, 741 AS variableid
FROM annual_avgwinterrh_all;

--
-- Definition for view annual_peakdischarge (OID = 471492) : 
--
CREATE VIEW tables.annual_peakdischarge
AS
SELECT row_number() OVER (
ORDER BY annual_peakdischarge_all.siteid, annual_peakdischarge_all.year) AS
    valueid, annual_peakdischarge_all.datavalue, annual_peakdischarge_all.siteid, ((annual_peakdischarge_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 689 AS originalvariableid, 712 AS variableid
FROM annual_peakdischarge_all;

--
-- Definition for view annual_peaksnowdepth (OID = 471497) : 
--
CREATE VIEW tables.annual_peaksnowdepth
AS
SELECT row_number() OVER (
ORDER BY annual_peaksnowdepth_all.siteid, annual_peaksnowdepth_all.year) AS
    valueid, annual_peaksnowdepth_all.datavalue, annual_peaksnowdepth_all.siteid, ((annual_peaksnowdepth_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 692 AS originalvariableid, 705 AS variableid
FROM annual_peaksnowdepth_all
WHERE (annual_peaksnowdepth_all.datavalue > (0)::double precision);

--
-- Definition for view annual_peakswe (OID = 471501) : 
--
CREATE VIEW tables.annual_peakswe
AS
SELECT row_number() OVER (
ORDER BY annual_peakswe_all.siteid, annual_peakswe_all.year) AS valueid,
    annual_peakswe_all.datavalue, annual_peakswe_all.siteid, ((annual_peakswe_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 693 AS originalvariableid, 717 AS variableid
FROM annual_peakswe_all
WHERE (annual_peakswe_all.datavalue > (0)::double precision);

--
-- Definition for view annual_totalprecip (OID = 471505) : 
--
CREATE VIEW tables.annual_totalprecip
AS
SELECT row_number() OVER (
ORDER BY annual_totalprecip_all.siteid, annual_totalprecip_all.year) AS
    valueid, annual_totalprecip_all.datavalue, annual_totalprecip_all.siteid, ((annual_totalprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 703 AS variableid
FROM annual_totalprecip_all;

--
-- Definition for view odmdatavalues_metric (OID = 478883) : 
--
CREATE VIEW tables.odmdatavalues_metric
AS
((((((((
SELECT v.valueid, v.datavalue, v.valueaccuracy, v.localdatetime,
    v.utcoffset, (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, va.variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE (va.variableunitsid = ANY (ARRAY[1, 2, 33, 36, 39, 47, 52, 54, 80,
    86, 90, 96, 116, 119, 121, 137, 143, 168, 170, 181, 188, 192, 198, 199, 205, 221, 254, 258, 304, 309, 310, 331, 332, 333, 335, 336]))
UNION ALL
SELECT v.valueid, ((v.datavalue - (32)::double precision) *
    (0.555555556)::double precision) AS datavalue, v.valueaccuracy, v.localdatetime, v.utcoffset, (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, 96 AS variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE (va.variableunitsid = 97))
UNION ALL
SELECT v.valueid, (v.datavalue * (25.4)::double precision) AS datavalue,
    v.valueaccuracy, v.localdatetime, v.utcoffset, (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, 54 AS variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE ((va.variableunitsid = 49) AND (((lower((va.variablename)::text) ~~
    '%precipitation%'::text) OR (lower((va.variablename)::text) ~~ '%snow water equivalent%'::text)) OR (lower((va.variablename)::text) ~~ '%snowfall%'::text))))
UNION ALL
SELECT v.valueid, (v.datavalue * (0.0254)::double precision) AS datavalue,
    v.valueaccuracy, v.localdatetime, v.utcoffset, (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, 52 AS variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE ((va.variableunitsid = 49) AND (lower((va.variablename)::text) ~~
    '%snow depth%'::text)))
UNION ALL
SELECT v.valueid, (v.datavalue * (0.02832)::double precision) AS datavalue,
    v.valueaccuracy, v.localdatetime, v.utcoffset, (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, 36 AS variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE ((va.variableunitsid = 35) AND (lower((va.variablename)::text) ~~
    '%discharge%'::text)))
UNION ALL
SELECT v.valueid, (v.datavalue * (0.44704)::double precision) AS datavalue,
    v.valueaccuracy, v.localdatetime, v.utcoffset, (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, 119 AS variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE ((va.variableunitsid = 120) AND (lower((va.variablename)::text) ~~
    '%wind speed%'::text)))
UNION ALL
SELECT v.valueid, (v.datavalue * (697.8)::double precision) AS datavalue,
    v.valueaccuracy, v.localdatetime, v.utcoffset, (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, 33 AS variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE ((va.variableunitsid = 29) AND (lower((va.variablename)::text) ~~
    '%radiation%'::text)))
UNION ALL
SELECT v.valueid, (v.datavalue * (0.3048)::double precision) AS datavalue,
    v.valueaccuracy, v.localdatetime, v.utcoffset, (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, 52 AS variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE ((va.variableunitsid = 48) AND (((((((lower((va.variablename)::text)
    ~~ '%gage height%'::text) OR (lower((va.variablename)::text) ~~ '%water depth%'::text)) OR (lower((va.variablename)::text) ~~ '%distance%'::text)) OR (lower((va.variablename)::text) ~~ '%ice thickness%'::text)) OR (lower((va.variablename)::text) ~~ '%free board%'::text)) OR (lower((va.variablename)::text) ~~ '%luminescent dissolved oxygen%'::text)) OR (lower((va.variablename)::text) ~~ '%snow depth%'::text))))
UNION ALL
SELECT v.valueid, (v.datavalue * (1233.48183754752)::double precision) AS
    datavalue, v.valueaccuracy, v.localdatetime, v.utcoffset, (v.localdatetime - ((v.utcoffset || 'hour'::text))::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, 126 AS variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE ((va.variableunitsid = 48) AND (lower((va.variablename)::text) ~~
    '%volume%'::text)))
UNION ALL
SELECT v.valueid, v.datavalue, v.valueaccuracy, v.localdatetime,
    v.utcoffset, (v.localdatetime + '-09:00:00'::interval) AS datetimeutc, d.siteid, va.variableid AS originalvariableid, va.variablename, va.samplemedium, 90 AS variableunitsid, va.timeunitsid AS variabletimeunits, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, public.st_geographyfromtext(s.geolocation) AS geographylocation, s.geolocation, s.spatialcharacteristics
FROM (((datavalues v JOIN datastreams d ON ((d.datastreamid =
    v.datastreamid))) JOIN sites s ON ((d.siteid = s.siteid))) JOIN variables va ON ((d.variableid = va.variableid)))
WHERE ((va.variableunitsid = 315) AND (((lower((va.variablename)::text) ~~
    '%sea level pressure%'::text) OR (lower((va.variablename)::text) ~~ '%altimeter setting rate%'::text)) OR (lower((va.variablename)::text) ~~ '%barometric pressure%'::text)))
GROUP BY v.valueid, v.datavalue, v.valueaccuracy, v.localdatetime,
    v.utcoffset, d.siteid, va.variableid, va.variablename, va.samplemedium, va.variableunitsid, va.timeunitsid, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, s.geolocation, s.spatialcharacteristics;

--
-- Comments
--
COMMENT ON SCHEMA public IS 'standard public schema';
COMMENT ON VIEW tables.daily_airtemp IS 'This view restricts data values to the range: -80F <= DataValue < 115F.  Sets the daily air temperature variableid = 686';
COMMENT ON VIEW tables.daily_airtempmax IS 'This view restricts data values to the range: -80F <= datavalue < 115F.  Sets the daily max air temperature variableid = 687';
COMMENT ON VIEW tables.daily_airtempmin IS 'This view restricts data values to the range: -80F <= datavalue < 115F.  Sets the daily min air temperature variableid = 688';
COMMENT ON VIEW tables.daily_discharge IS 'This view restricts data values to the range: datavalue >=0.  Sets the daily discharge variableid=689.';
COMMENT ON VIEW tables.daily_rh IS 'This view restricts data values to the range: datavalue > 0 and datadalue <= 100.  Sets the daily relative humidity variableid=691';
COMMENT ON VIEW tables.daily_watertemp IS 'This view restricts data values to those which are not null.  Sets the daily water temperature variableid=694.';
COMMENT ON VIEW tables.daily_winddirection IS 'This view restricts data values to the range: datavalue >= 0 and datavalue <= 360.  Sets the daily wind direction variableid=695.';
COMMENT ON VIEW tables.daily_windspeed IS 'This view restricts the data values to the range: datavalue >= 0 and datavalue < 50.  Sets the daily wind speed variableid=696';
COMMENT ON VIEW tables.hourly_airtemp IS 'This view restricts data values to the range: -80F <= DataValue < 115F.  Sets the hourly air temperature variableid=677';
COMMENT ON VIEW tables.hourly_rh IS 'This view restricts data values to the range: datavalue > 0 and datavalue <= 100.  Sets the hourly relative humidity variableid=679';
COMMENT ON VIEW tables.hourly_winddirection IS 'This view restricts data values to the range: datavalue >= 0 and datavalue <= 360.  Sets the hourly wind direction variableid=682';
COMMENT ON VIEW tables.hourly_windspeed IS 'This view restricts data values to the range: datavalue >= 0 and datavalue < 50.  Sets the hourly wind speed variableid=685';
COMMENT ON VIEW tables.monthly_airtemp_all IS 'This view creates monthly averages using "daily_airtemp".  Restricted to months with at least 10 days of data.';
COMMENT ON VIEW tables.monthly_airtemp IS 'This view creates "monthly_air temp" with the fields: valueid, datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets the monthly air temperature variableid=697 and originalvariableid=686.  ';
COMMENT ON VIEW tables.monthly_discharge_all IS 'This view creates monthly averages using "daily_discharge".  Restricted to months with at least 10 days of data.';
COMMENT ON VIEW tables.monthly_discharge IS 'This view creates "monthly_discharge" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=689 and variableid=700.';
COMMENT ON VIEW tables.monthly_precip_all IS 'This view creates monthly totals using "daily_precip".  Restricted to months with at least 10 days of data.';
COMMENT ON VIEW tables.monthly_precip IS 'This view creates "monthly_precip" with the fields: valueid, datavalue,siteid,utcdatetime,originalvariableid,variableid.  Sets the originalvariableid=690 and variableid=701';
COMMENT ON VIEW tables.monthly_rh IS 'This view creates "monthly_rh" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=691 and variableid=707.';
COMMENT ON VIEW tables.monthly_snowdepthavg_all IS 'This view creates monthly averages using "daily_snowdepth".  Restricted to months with at least 1 day of data.';
COMMENT ON VIEW tables.monthly_snowdepthavg IS 'This view creates "monthly_snowdepthavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=702';
COMMENT ON VIEW tables.monthly_sweavg_all IS 'This view creates monthly averages using "daily_swe".  Restricted to months with at least 1 day or data.';
COMMENT ON VIEW tables.monthly_sweavg IS 'This view creates "monthly_sweavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=721';
COMMENT ON VIEW tables.annual_avgairtemp IS 'This view creates annual air temperature averages using "monthly_airtemp_all".  Requires all 12 months to create annual air temperature average and the monthly average cannot be null.  Sets originalvariableid=697 and variableid=699.';
COMMENT ON VIEW tables.annual_avgdischarge IS 'This view creates annual discharge averages using "monthly_discharge_all".  Requires all 12 months to create annual discharge averages and the monthly average cannot be null.  Sets originalvariableid=700 and variableid=710.';
COMMENT ON VIEW tables.annual_avgfallairtemp_all IS 'This view creates annual fall air temperature averages using "monthly_airtemp_all".  Requires all three months; September, October and November; to create annual fall average.  ';
COMMENT ON VIEW tables.annual_avgfallairtemp IS 'This view creates "annual_avgfallairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=722.';
COMMENT ON VIEW tables.annual_avgfallprecip_all IS 'This view creates annual average fall precipitation total using "monthly_precip_all".  Requires all three months; September, October and November; to create annual average total.';
COMMENT ON VIEW tables.annual_avgfallprecip IS 'This view creates "annual_avgfallprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=729';
COMMENT ON VIEW tables.annual_avgrh IS 'This view creates "annual_avgrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets variableid=708 and originalvariableid=707';
COMMENT ON VIEW tables.annual_avgspringairtemp_all IS 'This view creates annual spring air temperature averages using "monthly_airtemp_all".  Requires all three months; March, April and May; to create annual spring air temperature average.';
COMMENT ON VIEW tables.annual_avgspringairtemp IS 'This view creates "annual_avgspringairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=724';
COMMENT ON VIEW tables.annual_avgspringprecip_all IS 'This view creates annual spring precipitation total averages using "monthly_precip_all".  Requires all three months: March, April and May; to create annual spring precipitation total average.';
COMMENT ON VIEW tables.annual_avgspringprecip IS 'This view creates "annual_avgspringprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=733';
COMMENT ON VIEW tables.annual_avgsummerairtemp_all IS 'This view creates annual summer air temperature averages using "monthly_airtemp_all".  Requires all three months; June, July and August; to create annual summer air temperature average';
COMMENT ON VIEW tables.annual_avgsummerairtemp IS 'This view creates "annual_avgsummerairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=726';
COMMENT ON VIEW tables.annual_avgsummerdischarge_all IS 'This view creates annual average summer discharge using "monthly_discharge_all".  Requires all three months; June, July, August; to create annual average summer discharge.';
COMMENT ON VIEW tables.annual_avgsummerdischarge IS 'This view creates "annual_avgsummerdischarge" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=700 and variableid=737';
COMMENT ON VIEW tables.annual_avgsummerprecip_all IS 'This view creates annual average summer precipitation totals using "monthly_precip_all".  Requires all three months; June, July, August; to create annual average summer precipitation totals.';
COMMENT ON VIEW tables.annual_avgsummerprecip IS 'This view creates "annual_avgsummerprecip" with the fields: valueid, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=735';
COMMENT ON VIEW tables.annual_avgsummerrh_all IS 'This view creates annual average summer relative humidity by calculating the seasonal relative humdity using the monthly air temperature and monthly relative humidity averages.   Requires all three months; June, July, August; to create annual average summer relative humidity';
COMMENT ON VIEW tables.annual_avgsummerrh IS 'This view creates "annual_avgsummerrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=707 and variableid=739.';
COMMENT ON VIEW tables.annual_avgwinterairtemp IS 'This view creates "annual_avgwinterairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=719';
COMMENT ON VIEW tables.annual_avgwinterprecip IS 'This view creates "annual_avgwinterprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=731';
COMMENT ON VIEW tables.annual_avgwinterrh IS 'This view creates "annual_avgwinterrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=707 and vairableid=741';
COMMENT ON VIEW tables.annual_peakdischarge IS 'This view creates "annual_peakdischarge" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=689 and variableid=712';
COMMENT ON VIEW tables.annual_peaksnowdepth IS 'This view creates "annual_peaksnowdepth" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=705';
COMMENT ON VIEW tables.annual_peakswe IS 'This view creates "annual_peakswe" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=717';
COMMENT ON VIEW tables.annual_totalprecip IS 'This view creates "annual_totalprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid= and variableid=';
COMMENT ON VIEW tables.odmdatavalues_metric IS 'This view creates recreates the odm version of the datavalues table with all metric units.';
