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

DROP VIEW tables.annual_avgfallprecip;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgfallprecip; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgfallprecip AS
SELECT row_number() OVER (ORDER BY annual_avgfallprecip_all.siteid, annual_avgfallprecip_all.year) AS valueid, annual_avgfallprecip_all.seasonalavg AS datavalue, annual_avgfallprecip_all.siteid, ((annual_avgfallprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 729 AS variableid FROM annual_avgfallprecip_all;


--
-- Name: VIEW annual_avgfallprecip; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgfallprecip IS 'This view creates "annual_avgfallprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=729';


--
-- PostgreSQL database dump complete
--

