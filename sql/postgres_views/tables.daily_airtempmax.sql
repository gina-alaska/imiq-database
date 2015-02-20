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

DROP VIEW tables.daily_airtempmax;
SET search_path = tables, pg_catalog;

--
-- Name: daily_airtempmax; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW daily_airtempmax AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 687 AS variableid FROM (daily_airtempmaxdatavalues v JOIN sites s ON ((v.siteid = s.siteid))) WHERE ((v.datavalue >= ((-62.22))::double precision) AND (v.datavalue <= (46.11)::double precision)) GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;


--
-- Name: VIEW daily_airtempmax; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW daily_airtempmax IS 'This view restricts data values to the range: -80F <= datavalue < 115F.  Sets the daily max air temperature variableid = 687';


--
-- PostgreSQL database dump complete
--

