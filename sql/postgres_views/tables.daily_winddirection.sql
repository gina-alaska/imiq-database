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

DROP VIEW tables.daily_winddirection;
SET search_path = tables, pg_catalog;

--
-- Name: daily_winddirection; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW daily_winddirection AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 695 AS variableid FROM (daily_winddirectiondatavalues v JOIN sites s ON ((v.siteid = s.siteid))) WHERE ((v.datavalue >= (0)::double precision) AND (v.datavalue <= (360)::double precision)) GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;


--
-- Name: VIEW daily_winddirection; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW daily_winddirection IS 'This view restricts data values to the range: datavalue >= 0 and datavalue <= 360.  Sets the daily wind direction variableid=695.';


--
-- PostgreSQL database dump complete
--

