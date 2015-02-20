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

DROP VIEW tables.annual_avgsummerairtemp;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgsummerairtemp; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgsummerairtemp AS
SELECT row_number() OVER (ORDER BY annual_avgsummerairtemp_all.siteid, annual_avgsummerairtemp_all.year) AS valueid, annual_avgsummerairtemp_all.seasonalavg AS datavalue, annual_avgsummerairtemp_all.siteid, ((annual_avgsummerairtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 726 AS variableid FROM annual_avgsummerairtemp_all;


--
-- Name: VIEW annual_avgsummerairtemp; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgsummerairtemp IS 'This view creates "annual_avgsummerairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=726';


--
-- PostgreSQL database dump complete
--

