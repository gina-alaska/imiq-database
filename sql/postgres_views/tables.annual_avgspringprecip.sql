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

DROP VIEW tables.annual_avgspringprecip;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgspringprecip; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgspringprecip AS
SELECT row_number() OVER (ORDER BY annual_avgspringprecip_all.siteid, annual_avgspringprecip_all.year) AS valueid, annual_avgspringprecip_all.seasonalavg AS datavalue, annual_avgspringprecip_all.siteid, ((annual_avgspringprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 733 AS variableid FROM annual_avgspringprecip_all;


--
-- Name: VIEW annual_avgspringprecip; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgspringprecip IS 'This view creates "annual_avgspringprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=733';


--
-- PostgreSQL database dump complete
--

