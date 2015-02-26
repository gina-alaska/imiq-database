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

DROP VIEW tables.annual_avgfallairtemp_all;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgfallairtemp_all; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgfallairtemp_all AS
SELECT a.siteid, a.year, avg(a.monthlyavg) AS seasonalavg FROM monthly_airtemp_all a WHERE (((a.month >= (9)::double precision) AND (a.month <= (11)::double precision)) AND (a.monthlyavg IS NOT NULL)) GROUP BY a.siteid, a.year HAVING (count(*) = 3);


--
-- Name: VIEW annual_avgfallairtemp_all; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgfallairtemp_all IS 'This view creates annual fall air temperature averages using "monthly_airtemp_all".  Requires all three months; September, October and November; to create annual fall average.  ';


--
-- PostgreSQL database dump complete
--

