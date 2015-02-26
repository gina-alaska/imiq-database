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

DROP VIEW tables.annual_avgwinterprecip;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgwinterprecip; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgwinterprecip AS
SELECT row_number() OVER (ORDER BY annual_avgwinterprecip_all.siteid, annual_avgwinterprecip_all.year) AS valueid, annual_avgwinterprecip_all.seasonalavg AS datavalue, annual_avgwinterprecip_all.siteid, ((annual_avgwinterprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 731 AS variableid FROM annual_avgwinterprecip_all;


--
-- Name: VIEW annual_avgwinterprecip; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgwinterprecip IS 'This view creates "annual_avgwinterprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=731';


--
-- PostgreSQL database dump complete
--

