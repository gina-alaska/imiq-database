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

DROP VIEW tables.annual_avgfallairtemp;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgfallairtemp; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgfallairtemp AS
SELECT row_number() OVER (ORDER BY annual_avgfallairtemp_all.siteid, annual_avgfallairtemp_all.year) AS valueid, annual_avgfallairtemp_all.seasonalavg AS datavalue, annual_avgfallairtemp_all.siteid, ((annual_avgfallairtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 722 AS variableid FROM annual_avgfallairtemp_all;


--
-- Name: VIEW annual_avgfallairtemp; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgfallairtemp IS 'This view creates "annual_avgfallairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=722.';


--
-- PostgreSQL database dump complete
--

