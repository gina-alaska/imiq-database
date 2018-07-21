-- View: tables.annual_avgairtemp

-- DROP VIEW tables.annual_avgairtemp;

CREATE TABLE tables.annual_avgairtempTWO AS 
 SELECT row_number() OVER (ORDER BY monthly_airtemp_all.siteid, monthly_airtemp_all.year) AS valueid,
    avg(monthly_airtemp_all.monthlyavg) AS datavalue,
    monthly_airtemp_all.siteid,
    (monthly_airtemp_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    697 AS originalvariableid,
    699 AS variableid
   FROM tables.monthly_airtemp_all
  WHERE (monthly_airtemp_all.month = ANY (ARRAY[12::double precision, 1::double precision, 2::double precision, 3::double precision, 4::double precision, 5::double precision, 6::double precision, 7::double precision, 8::double precision, 9::double precision, 10::double precision, 11::double precision])) AND monthly_airtemp_all.monthlyavg IS NOT NULL
  GROUP BY monthly_airtemp_all.siteid, monthly_airtemp_all.year
 HAVING count(*) = 12;

ALTER TABLE tables.annual_avgairtempTWO
  ADD CONSTRAINT annual_avgairtempTWO_pkey PRIMARY KEY (valueid);

CREATE INDEX annual_avgairtemp_siteid_idx
  ON tables.annual_avgairtempTWO
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgairtempTWO
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgairtempTWO TO imiq;
GRANT ALL ON TABLE tables.annual_avgairtempTWO TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgairtempTWO TO chaase;
GRANT SELECT ON TABLE tables.annual_avgairtempTWO TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgairtempTWO TO rwspicer;
COMMENT ON TABLE tables.annual_avgairtempTWO
  IS 'This table is  annual air temperature averages using "monthly_airtemp_all".  Requires all 12 months to create annual air temperature average and the monthly average cannot be null.  Sets originalvariableid=697 and variableid=699.';
