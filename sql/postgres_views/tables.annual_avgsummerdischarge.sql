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

DROP VIEW tables.annual_avgsummerdischarge;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgsummerdischarge; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgsummerdischarge AS
SELECT row_number() OVER (ORDER BY annual_avgsummerdischarge_all.siteid, annual_avgsummerdischarge_all.year) AS valueid, annual_avgsummerdischarge_all.seasonalavg AS datavalue, annual_avgsummerdischarge_all.siteid, ((annual_avgsummerdischarge_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 700 AS originalvariableid, 737 AS variableid FROM annual_avgsummerdischarge_all;


--
-- Name: VIEW annual_avgsummerdischarge; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgsummerdischarge IS 'This view creates "annual_avgsummerdischarge" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=700 and variableid=737';


--
-- PostgreSQL database dump complete
--

