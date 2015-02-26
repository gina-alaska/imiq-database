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

DROP VIEW tables.annual_avgspringairtemp;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgspringairtemp; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgspringairtemp AS
SELECT row_number() OVER (ORDER BY annual_avgspringairtemp_all.siteid, annual_avgspringairtemp_all.year) AS valueid, annual_avgspringairtemp_all.seasonalavg AS datavalue, annual_avgspringairtemp_all.siteid, ((annual_avgspringairtemp_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 697 AS originalvariableid, 724 AS variableid FROM annual_avgspringairtemp_all;


--
-- Name: VIEW annual_avgspringairtemp; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgspringairtemp IS 'This view creates "annual_avgspringairtemp" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=724';


--
-- PostgreSQL database dump complete
--

