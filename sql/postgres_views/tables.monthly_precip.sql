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

DROP VIEW tables.monthly_precip;
SET search_path = tables, pg_catalog;

--
-- Name: monthly_precip; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW monthly_precip AS
SELECT row_number() OVER (ORDER BY monthly_precip_all.siteid, monthly_precip_all.monthlytotal) AS valueid, monthly_precip_all.monthlytotal AS datavalue, monthly_precip_all.siteid, ((((((monthly_precip_all.year)::character varying)::text || '-'::text) || ((monthly_precip_all.month)::character varying)::text) || '-01'::text))::timestamp without time zone AS utcdatetime, 690 AS originalvariableid, 701 AS variableid FROM monthly_precip_all;


--
-- Name: VIEW monthly_precip; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_precip IS 'This view creates "monthly_precip" with the fields: valueid, datavalue,siteid,utcdatetime,originalvariableid,variableid.  Sets the originalvariableid=690 and variableid=701';


--
-- PostgreSQL database dump complete
--

