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

DROP VIEW tables.annual_avgwinterairtemp;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgwinterairtemp; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgwinterairtemp AS
SELECT row_number() OVER (ORDER BY annual_avgwinterairtemp_all.siteid, annual_avgwinterairtemp_all.year) AS valueid, annual_avgwinterairtemp_all.seasonalavg AS datavalue, annual_avgwinterairtemp_all.siteid, ((annual_avgwinterairtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 719 AS variableid FROM annual_avgwinterairtemp_all;


--
-- Name: VIEW annual_avgwinterairtemp; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgwinterairtemp IS 'This view creates "annual_avgwinterairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=719';


--
-- PostgreSQL database dump complete
--

