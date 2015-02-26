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

DROP VIEW tables.hourly_windspeed;
SET search_path = tables, pg_catalog;

--
-- Name: hourly_windspeed; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW hourly_windspeed AS
SELECT v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, 685 AS variableid FROM (hourly_windspeeddatavalues v JOIN sites s ON ((v.siteid = s.siteid))) WHERE ((v.datavalue >= (0)::double precision) AND (v.datavalue < (50)::double precision)) GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;


--
-- Name: VIEW hourly_windspeed; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW hourly_windspeed IS 'This view restricts data values to the range: datavalue >= 0 and datavalue < 50.  Sets the hourly wind speed variableid=685';


--
-- PostgreSQL database dump complete
--

