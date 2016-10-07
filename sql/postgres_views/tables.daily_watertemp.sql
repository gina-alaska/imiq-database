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

DROP VIEW tables.daily_watertemp;
SET search_path = tables, pg_catalog;

--
-- Name: daily_watertemp; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW daily_watertemp AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 694 AS variableid FROM (daily_watertempdatavalues v JOIN sites s ON ((v.siteid = s.siteid))) WHERE (v.datavalue IS NOT NULL) GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;


--
-- Name: VIEW daily_watertemp; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW daily_watertemp IS 'This view restricts data values to those which are not null.  Sets the daily water temperature variableid=694.';


--
-- PostgreSQL database dump complete
--
