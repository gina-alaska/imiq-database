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

DROP VIEW tables.monthly_airtemp_all;
SET search_path = tables, pg_catalog;

--
-- Name: monthly_airtemp_all; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW monthly_airtemp_all AS
SELECT d.siteid, date_part('year'::text, d.utcdatetime) AS year, date_part('month'::text, d.utcdatetime) AS month, avg(d.datavalue) AS monthlyavg, count(*) AS total FROM daily_airtemp d GROUP BY d.siteid, date_part('year'::text, d.utcdatetime), date_part('month'::text, d.utcdatetime) HAVING (count(*) >= 10);


--
-- Name: VIEW monthly_airtemp_all; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_airtemp_all IS 'This view creates monthly averages using "daily_airtemp".  Restricted to months with at least 10 days of data.';


--
-- PostgreSQL database dump complete
--

