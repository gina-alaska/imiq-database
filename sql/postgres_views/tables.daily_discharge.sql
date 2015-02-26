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

DROP VIEW tables.daily_discharge;
SET search_path = tables, pg_catalog;

--
-- Name: daily_discharge; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW daily_discharge AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 689 AS variableid FROM (daily_dischargedatavalues v JOIN sites s ON ((v.siteid = s.siteid))) WHERE (v.datavalue >= (0)::double precision) GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;


--
-- Name: VIEW daily_discharge; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW daily_discharge IS 'This view restricts data values to the range: datavalue >=0.  Sets the daily discharge variableid=689.';


--
-- PostgreSQL database dump complete
--

