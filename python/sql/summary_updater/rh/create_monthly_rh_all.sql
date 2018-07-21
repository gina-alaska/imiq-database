

CREATE table tables.monthly_rh_all_test AS
SELECT p.siteid,
        date_part('year'::text, p.utcdatetime) AS year,
         date_part('month'::text, p.utcdatetime) AS month, 
         avg(p.datavalue) AS rh, 
         count(*) AS total 
         FROM tables.daily_rh p 
         GROUP BY p.siteid, 
                    date_part('year'::text, p.utcdatetime), 
                    date_part('month'::text, p.utcdatetime) 
                    HAVING (count(*) >= 1);


--
-- Name: VIEW monthly_rh_all_test; Type: COMMENT; Schema: tables; Owner: -
--

COMMENT ON VIEW monthly_rh_all_test IS 'This view creates monthly averages using "daily_rh".  Restricted to months with at least 1 day or data.';

