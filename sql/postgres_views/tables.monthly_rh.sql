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

DROP VIEW tables.monthly_rh;
SET search_path = tables, pg_catalog;

--
-- Name: monthly_rh; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW monthly_rh AS
SELECT row_number() OVER (ORDER BY monthly_rh_all.siteid, monthly_rh_all.rh) AS valueid, monthly_rh_all.rh AS datavalue, monthly_rh_all.siteid, ((((monthly_rh_all.year || '-'::text) || monthly_rh_all.month) || '-01'::text))::timestamp without time zone AS utcdatetime, 691 AS originalvariableid, 707 AS variableid FROM monthly_rh_all;


--
-- Name: VIEW monthly_rh; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_rh IS 'This view creates "monthly_rh" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=691 and variableid=707.';


--
-- PostgreSQL database dump complete
--

