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

DROP VIEW tables.annual_peakswe;
SET search_path = tables, pg_catalog;

--
-- Name: annual_peakswe; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_peakswe AS
SELECT row_number() OVER (ORDER BY annual_peakswe_all.siteid, annual_peakswe_all.year) AS valueid, annual_peakswe_all.datavalue, annual_peakswe_all.siteid, ((annual_peakswe_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 693 AS originalvariableid, 717 AS variableid FROM annual_peakswe_all WHERE (annual_peakswe_all.datavalue > (0)::double precision);


--
-- Name: VIEW annual_peakswe; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_peakswe IS 'This view creates "annual_peakswe" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=693 and variableid=717';


--
-- PostgreSQL database dump complete
--

