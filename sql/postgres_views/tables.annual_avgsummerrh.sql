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

DROP VIEW tables.annual_avgsummerrh;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgsummerrh; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgsummerrh AS
SELECT row_number() OVER (ORDER BY annual_avgsummerrh_all.siteid, annual_avgsummerrh_all.year) AS valueid, annual_avgsummerrh_all.seasonalavgrh AS datavalue, annual_avgsummerrh_all.siteid, ((annual_avgsummerrh_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 707 AS originalvariableid, 739 AS variableid FROM annual_avgsummerrh_all;


--
-- Name: VIEW annual_avgsummerrh; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgsummerrh IS 'This view creates "annual_avgsummerrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=707 and variableid=739.';


--
-- PostgreSQL database dump complete
--

