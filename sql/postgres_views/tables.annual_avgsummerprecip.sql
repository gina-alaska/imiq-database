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

DROP VIEW tables.annual_avgsummerprecip;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgsummerprecip; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgsummerprecip AS
SELECT row_number() OVER (ORDER BY annual_avgsummerprecip_all.siteid, annual_avgsummerprecip_all.year) AS valueid, annual_avgsummerprecip_all.seasonalavg AS datavalue, annual_avgsummerprecip_all.siteid, ((annual_avgsummerprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 735 AS variableid FROM annual_avgsummerprecip_all;


--
-- Name: VIEW annual_avgsummerprecip; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgsummerprecip IS 'This view creates "annual_avgsummerprecip" with the fields: valueid, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=701 and variableid=735';


--
-- PostgreSQL database dump complete
--

