--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = tables, pg_catalog;

DROP VIEW tables.annual_avgairtemp;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgairtemp; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgairtemp AS
SELECT row_number() OVER (ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.year) AS valueid, avg(monthly_airtemp_all.monthlyavg) AS datavalue, monthly_airtemp_all.siteid, ((monthly_airtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 699 AS variableid FROM monthly_airtemp_all WHERE ((monthly_airtemp_all.month = ANY (ARRAY[(12)::double precision, (1)::double precision, (2)::double precision, (3)::double precision, (4)::double precision, (5)::double precision, (6)::double precision, (7)::double precision, (8)::double precision, (9)::double precision, (10)::double precision, (11)::double precision])) AND (monthly_airtemp_all.monthlyavg IS NOT NULL)) GROUP BY monthly_airtemp_all.siteid, monthly_airtemp_all.year HAVING (count(*) = 12);


--
-- Name: VIEW annual_avgairtemp; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgairtemp IS 'This view creates annual air temperature averages using "monthly_airtemp_all".  Requires all 12 months to create annual air temperature average and the monthly average cannot be null.  Sets originalvariableid=697 and variableid=699.';


--
-- PostgreSQL database dump complete
--

