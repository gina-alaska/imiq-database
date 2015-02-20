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

DROP VIEW tables.monthly_snowdepthavg;
SET search_path = tables, pg_catalog;

--
-- Name: monthly_snowdepthavg; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW monthly_snowdepthavg AS
SELECT row_number() OVER (ORDER BY monthly_snowdepthavg_all.siteid, monthly_snowdepthavg_all.monthlyavg) AS valueid, monthly_snowdepthavg_all.monthlyavg AS datavalue, monthly_snowdepthavg_all.siteid, ((((monthly_snowdepthavg_all.year || '-'::text) || monthly_snowdepthavg_all.month) || '-01'::text))::timestamp without time zone AS utcdatetime, 692 AS originalvariableid, 702 AS variableid FROM monthly_snowdepthavg_all;


--
-- Name: VIEW monthly_snowdepthavg; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_snowdepthavg IS 'This view creates "monthly_snowdepthavg" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets the originalvariableid=692 and variableid=702';


--
-- PostgreSQL database dump complete
--

