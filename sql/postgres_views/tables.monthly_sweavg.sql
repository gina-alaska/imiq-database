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

DROP VIEW tables.monthly_sweavg;
SET search_path = tables, pg_catalog;

--
-- Name: monthly_sweavg; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW monthly_sweavg AS
SELECT row_number() OVER (ORDER BY monthly_sweavg_all.siteid, monthly_sweavg_all.monthlyavg) AS valueid, monthly_sweavg_all.monthlyavg AS datavalue, monthly_sweavg_all.siteid, ((((monthly_sweavg_all.year || '-'::text) || monthly_sweavg_all.month) || '-01'::text))::timestamp without time zone AS utcdatetime, 693 AS originalvariableid, 721 AS variableid FROM monthly_sweavg_all;


--
-- Name: VIEW monthly_sweavg; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_sweavg IS 'This view creates "monthly_sweavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=721';


--
-- PostgreSQL database dump complete
--

