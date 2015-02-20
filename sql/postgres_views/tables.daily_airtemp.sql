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

DROP VIEW tables.daily_airtemp;
SET search_path = tables, pg_catalog;

--
-- Name: daily_airtemp; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW daily_airtemp AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 686 AS variableid FROM (daily_airtempdatavalues v JOIN sites s ON ((v.siteid = s.siteid))) WHERE ((v.datavalue >= ((-62.22))::double precision) AND (v.datavalue <= (46.11)::double precision)) GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;


--
-- Name: VIEW daily_airtemp; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW daily_airtemp IS 'This view restricts data values to the range: -80F <= DataValue < 115F.  Sets the daily air temperature variableid = 686';


--
-- PostgreSQL database dump complete
--

