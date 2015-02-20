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

DROP VIEW tables.annual_avgsummerairtemp_all;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgsummerairtemp_all; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgsummerairtemp_all AS
SELECT a.siteid, a.year, avg(a.monthlyavg) AS seasonalavg FROM monthly_airtemp_all a WHERE (a.month = ANY (ARRAY[(6)::double precision, (7)::double precision, (8)::double precision])) GROUP BY a.siteid, a.year HAVING (count(*) = 3);


--
-- Name: VIEW annual_avgsummerairtemp_all; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgsummerairtemp_all IS 'This view creates annual summer air temperature averages using "monthly_airtemp_all".  Requires all three months; June, July and August; to create annual summer air temperature average';


--
-- PostgreSQL database dump complete
--

