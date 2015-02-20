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

DROP VIEW tables.annual_avgdischarge;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgdischarge; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgdischarge AS
SELECT row_number() OVER (ORDER BY monthly_discharge_all.siteid, monthly_discharge_all.year) AS valueid, avg(monthly_discharge_all.monthlyavg) AS datavalue, monthly_discharge_all.siteid, ((monthly_discharge_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 700 AS originalvariableid, 710 AS variableid FROM monthly_discharge_all WHERE ((monthly_discharge_all.month = ANY (ARRAY[(12)::double precision, (1)::double precision, (2)::double precision, (3)::double precision, (4)::double precision, (5)::double precision, (6)::double precision, (7)::double precision, (8)::double precision, (9)::double precision, (10)::double precision, (11)::double precision])) AND (monthly_discharge_all.monthlyavg IS NOT NULL)) GROUP BY monthly_discharge_all.siteid, monthly_discharge_all.year HAVING (count(*) = 12);


--
-- Name: VIEW annual_avgdischarge; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgdischarge IS 'This view creates annual discharge averages using "monthly_discharge_all".  Requires all 12 months to create annual discharge averages and the monthly average cannot be null.  Sets originalvariableid=700 and variableid=710.';


--
-- PostgreSQL database dump complete
--

