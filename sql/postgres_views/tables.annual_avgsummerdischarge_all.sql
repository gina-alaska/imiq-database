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

DROP VIEW tables.annual_avgsummerdischarge_all;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgsummerdischarge_all; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgsummerdischarge_all AS
SELECT monthly_discharge_all.siteid, monthly_discharge_all.year, avg(monthly_discharge_all.monthlyavg) AS seasonalavg FROM monthly_discharge_all WHERE (((monthly_discharge_all.month >= (6)::double precision) AND (monthly_discharge_all.month <= (8)::double precision)) AND (monthly_discharge_all.monthlyavg IS NOT NULL)) GROUP BY monthly_discharge_all.siteid, monthly_discharge_all.year HAVING (count(*) = 3);


--
-- Name: VIEW annual_avgsummerdischarge_all; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgsummerdischarge_all IS 'This view creates annual average summer discharge using "monthly_discharge_all".  Requires all three months; June, July, August; to create annual average summer discharge.';


--
-- PostgreSQL database dump complete
--

