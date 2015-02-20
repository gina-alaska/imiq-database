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

DROP VIEW tables.annual_avgrh;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgrh; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgrh AS
SELECT row_number() OVER (ORDER BY annual_avgrh_all.siteid, annual_avgrh_all.year) AS valueid, annual_avgrh_all.rh AS datavalue, annual_avgrh_all.siteid, ((annual_avgrh_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 707 AS originalvariableid, 708 AS variableid FROM annual_avgrh_all;


--
-- Name: VIEW annual_avgrh; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgrh IS 'This view creates "annual_avgrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets variableid=708 and originalvariableid=707';


--
-- PostgreSQL database dump complete
--

