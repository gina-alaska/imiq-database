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

DROP VIEW tables.annual_avgwinterrh;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgwinterrh; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgwinterrh AS
SELECT row_number() OVER (ORDER BY annual_avgwinterrh_all.siteid, annual_avgwinterrh_all.year) AS valueid, annual_avgwinterrh_all.seasonalavgrh AS datavalue, annual_avgwinterrh_all.siteid, ((annual_avgwinterrh_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 707 AS originalvariableid, 741 AS variableid FROM annual_avgwinterrh_all;


--
-- Name: VIEW annual_avgwinterrh; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgwinterrh IS 'This view creates "annual_avgwinterrh" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=707 and vairableid=741';


--
-- PostgreSQL database dump complete
--

