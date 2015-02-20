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

DROP VIEW tables.annual_peaksnowdepth;
SET search_path = tables, pg_catalog;

--
-- Name: annual_peaksnowdepth; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_peaksnowdepth AS
SELECT row_number() OVER (ORDER BY annual_peaksnowdepth_all.siteid, annual_peaksnowdepth_all.year) AS valueid, annual_peaksnowdepth_all.datavalue, annual_peaksnowdepth_all.siteid, ((annual_peaksnowdepth_all.year || '-01-01'::text))::timestamp without time zone AS utcdatetime, 692 AS originalvariableid, 705 AS variableid FROM annual_peaksnowdepth_all WHERE (annual_peaksnowdepth_all.datavalue > (0)::double precision);


--
-- Name: VIEW annual_peaksnowdepth; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_peaksnowdepth IS 'This view creates "annual_peaksnowdepth" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=705';


--
-- PostgreSQL database dump complete
--

