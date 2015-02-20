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

DROP VIEW tables.annual_peakdischarge;
SET search_path = tables, pg_catalog;

--
-- Name: annual_peakdischarge; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_peakdischarge AS
SELECT row_number() OVER (ORDER BY annual_peakdischarge_all.siteid, annual_peakdischarge_all.year) AS valueid, annual_peakdischarge_all.datavalue, annual_peakdischarge_all.siteid, ((annual_peakdischarge_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 689 AS originalvariableid, 712 AS variableid FROM annual_peakdischarge_all;


--
-- Name: VIEW annual_peakdischarge; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_peakdischarge IS 'This view creates "annual_peakdischarge" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=689 and variableid=712';


--
-- PostgreSQL database dump complete
--

