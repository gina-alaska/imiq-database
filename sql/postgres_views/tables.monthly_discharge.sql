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

DROP VIEW tables.monthly_discharge;
SET search_path = tables, pg_catalog;

--
-- Name: monthly_discharge; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW monthly_discharge AS
SELECT row_number() OVER (ORDER BY monthly_discharge_all.siteid, monthly_discharge_all.monthlyavg) AS valueid, monthly_discharge_all.monthlyavg AS datavalue, monthly_discharge_all.siteid, ((((((monthly_discharge_all.year)::character varying)::text || '-'::text) || ((monthly_discharge_all.month)::character varying)::text) || '-01'::text))::timestamp without time zone AS utcdatetime, 689 AS originalvariableid, 700 AS variableid FROM monthly_discharge_all;


--
-- Name: VIEW monthly_discharge; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_discharge IS 'This view creates "monthly_discharge" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets originalvariableid=689 and variableid=700.';


--
-- PostgreSQL database dump complete
--

