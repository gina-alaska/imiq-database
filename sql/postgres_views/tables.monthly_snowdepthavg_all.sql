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

DROP VIEW tables.monthly_snowdepthavg_all;
SET search_path = tables, pg_catalog;

--
-- Name: monthly_snowdepthavg_all; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW monthly_snowdepthavg_all AS
SELECT p.siteid, date_part('year'::text, p.utcdatetime) AS year, date_part('month'::text, p.utcdatetime) AS month, avg(p.datavalue) AS monthlyavg, count(*) AS total FROM daily_snowdepth p GROUP BY p.siteid, date_part('year'::text, p.utcdatetime), date_part('month'::text, p.utcdatetime) HAVING (count(*) >= 1);


--
-- Name: VIEW monthly_snowdepthavg_all; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_snowdepthavg_all IS 'This view creates monthly averages using "daily_snowdepth".  Restricted to months with at least 1 day of data.';


--
-- PostgreSQL database dump complete
--
