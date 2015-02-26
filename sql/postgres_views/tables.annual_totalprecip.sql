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

DROP VIEW tables.annual_totalprecip;
SET search_path = tables, pg_catalog;

--
-- Name: annual_totalprecip; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_totalprecip AS
SELECT row_number() OVER (ORDER BY annual_totalprecip_all.siteid, annual_totalprecip_all.year) AS valueid, annual_totalprecip_all.datavalue, annual_totalprecip_all.siteid, ((annual_totalprecip_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 701 AS originalvariableid, 703 AS variableid FROM annual_totalprecip_all;


--
-- Name: VIEW annual_totalprecip; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_totalprecip IS 'This view creates "annual_totalprecip" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid= and variableid=';


--
-- PostgreSQL database dump complete
--

