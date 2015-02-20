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

DROP VIEW tables.annual_avgfallprecip_all;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgfallprecip_all; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgfallprecip_all AS
SELECT p.siteid, p.year, avg(p.monthlytotal) AS seasonalavg FROM monthly_precip_all p WHERE (((p.month >= (9)::double precision) AND (p.month <= (11)::double precision)) AND (p.monthlytotal IS NOT NULL)) GROUP BY p.siteid, p.year HAVING (count(*) = 3);


--
-- Name: VIEW annual_avgfallprecip_all; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgfallprecip_all IS 'This view creates annual average fall precipitation total using "monthly_precip_all".  Requires all three months; September, October and November; to create annual average total.';


--
-- PostgreSQL database dump complete
--

