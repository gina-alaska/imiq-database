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

DROP VIEW tables.hourly_rh;
SET search_path = tables, pg_catalog;

--
-- Name: hourly_rh; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW hourly_rh AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 679 AS variableid FROM (hourly_rhdatavalues v JOIN sites s ON ((v.siteid = s.siteid))) WHERE ((v.datavalue > (0)::double precision) AND (v.datavalue <= (100)::double precision)) GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;


--
-- Name: VIEW hourly_rh; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW hourly_rh IS 'This view restricts data values to the range: datavalue > 0 and datavalue <= 100.  Sets the hourly relative humidity variableid=679';


--
-- PostgreSQL database dump complete
--

