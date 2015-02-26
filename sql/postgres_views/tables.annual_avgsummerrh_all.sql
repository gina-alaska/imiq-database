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

DROP VIEW tables.annual_avgsummerrh_all;
SET search_path = tables, pg_catalog;

--
-- Name: annual_avgsummerrh_all; Type: VIEW; Schema: tables; Owner: -
--

CREATE VIEW annual_avgsummerrh_all AS
SELECT monthly_rh_all.siteid, monthly_rh_all.year, ((((0.611)::double precision * exp((((17.3)::double precision * avg(((ln(((((0.611)::double precision * exp((((17.3)::double precision * monthly_rh_all.at) / (monthly_rh_all.at + (237.3)::double precision)))) * monthly_rh_all.rh) / (100.0)::double precision)) + (0.4926)::double precision) / ((0.0708)::double precision - ((0.00421)::double precision * ln(((((0.611)::double precision * exp((((17.3)::double precision * monthly_rh_all.at) / (monthly_rh_all.at + (237.3)::double precision)))) * monthly_rh_all.rh) / (100.0)::double precision))))))) / (avg(((ln(((((0.611)::double precision * exp((((17.3)::double precision * monthly_rh_all.at) / (monthly_rh_all.at + (237.3)::double precision)))) * monthly_rh_all.rh) / (100.0)::double precision)) + (0.4926)::double precision) / ((0.0708)::double precision - ((0.00421)::double precision * ln(((((0.611)::double precision * exp((((17.3)::double precision * monthly_rh_all.at) / (monthly_rh_all.at + (237.3)::double precision)))) * monthly_rh_all.rh) / (100.0)::double precision)))))) + (237.3)::double precision)))) / ((0.611)::double precision * exp((((17.3)::double precision * avg(monthly_rh_all.at)) / (avg(monthly_rh_all.at) + (237.3)::double precision))))) * (100.0)::double precision) AS seasonalavgrh, avg(monthly_rh_all.at) AS seasonalavgat FROM monthly_rh_all WHERE (monthly_rh_all.month = ANY (ARRAY[6, 7, 8])) GROUP BY monthly_rh_all.siteid, monthly_rh_all.year HAVING (count(*) = 3);


--
-- Name: VIEW annual_avgsummerrh_all; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW annual_avgsummerrh_all IS 'This view creates annual average summer relative humidity by calculating the seasonal relative humdity using the monthly air temperature and monthly relative humidity averages.   Requires all three months; June, July, August; to create annual average summer relative humidity';


--
-- PostgreSQL database dump complete
--

