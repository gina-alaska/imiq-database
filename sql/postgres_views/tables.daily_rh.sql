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

DROP VIEW tables.daily_rh;
SET search_path = tables, pg_catalog;

--
-- Name: daily_rh; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW daily_rh AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 691 AS variableid FROM (daily_rhdatavalues v JOIN sites s ON ((v.siteid = s.siteid))) WHERE ((v.datavalue > (0)::double precision) AND (v.datavalue <= (100)::double precision)) GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;


--
-- Name: VIEW daily_rh; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW daily_rh IS 'This view restricts data values to the range: datavalue > 0 and datadalue <= 100.  Sets the daily relative humidity variableid=691';


--
-- PostgreSQL database dump complete
--

