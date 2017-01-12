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

DROP VIEW tables.monthly_precip_all;
SET search_path = tables, pg_catalog;

--
-- Name: monthly_precip_all; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW monthly_precip_all AS
SELECT p.siteid, date_part('year'::text, p.utcdatetime) AS year, date_part('month'::text, p.utcdatetime) AS month, sum(p.datavalue) AS monthlytotal, count(*) AS total FROM daily_precip p GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime) HAVING (count(*) >= 10);


--
-- Name: VIEW monthly_precip_all; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_precip_all IS 'This view creates monthly totals using "daily_precip".  Restricted to months with at least 10 days of data.';


--
-- PostgreSQL database dump complete
--

