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

DROP VIEW tables.annual_avgspringairtemp_all;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgspringairtemp_all; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgspringairtemp_all AS
SELECT a.siteid, a.year, avg(a.monthlyavg) AS seasonalavg FROM monthly_airtemp_all a WHERE ((a.month = ANY (ARRAY[(3)::double precision, (4)::double precision, (5)::double precision])) AND (a.monthlyavg IS NOT NULL)) GROUP BY a.siteid, a.year HAVING (count(*) = 3);


--
-- Name: VIEW annual_avgspringairtemp_all; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgspringairtemp_all IS 'This view creates annual spring air temperature averages using "monthly_airtemp_all".  Requires all three months; March, April and May; to create annual spring air temperature average.';


--
-- PostgreSQL database dump complete
--

