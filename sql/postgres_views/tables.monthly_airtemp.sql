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

DROP VIEW tables.monthly_airtemp;
SET search_path = tables, pg_catalog;

--
-- Name: monthly_airtemp; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW monthly_airtemp AS
SELECT row_number() OVER (ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.monthlyavg) AS valueid, monthly_airtemp_all.monthlyavg AS datavalue, monthly_airtemp_all.siteid, ((((((monthly_airtemp_all.year)::character varying)::text || '-'::text) || ((monthly_airtemp_all.month)::character varying)::text) || '-01'::text))::timestamp without time zone AS utcdatetime, 686 AS originalvariableid, 697 AS variableid FROM monthly_airtemp_all;


--
-- Name: VIEW monthly_airtemp; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_airtemp IS 'This view creates "monthly_air temp" with the fields: valueid, datavalue,siteid,utcdatetime,originalvariableid and variableid.  Sets the monthly air temperature variableid=697 and originalvariableid=686.  ';


--
-- PostgreSQL database dump complete
--

