﻿

CREATE TABLE tables.annual_avgdischarge_2 AS 
 SELECT row_number() OVER (ORDER BY monthly_discharge_all.siteid, monthly_discharge_all.year) AS valueid,
    avg(monthly_discharge_all.monthlyavg) AS datavalue,
    monthly_discharge_all.siteid,
    (monthly_discharge_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    700 AS originalvariableid,
    710 AS variableid
   FROM tables.monthly_discharge_all
  WHERE (monthly_discharge_all.month = ANY (ARRAY[12::double precision, 1::double precision, 2::double precision, 3::double precision, 4::double precision, 5::double precision, 6::double precision, 7::double precision, 8::double precision, 9::double precision, 10::double precision, 11::double precision])) AND monthly_discharge_all.monthlyavg IS NOT NULL
  GROUP BY monthly_discharge_all.siteid, monthly_discharge_all.year
 HAVING count(*) = 12;

ALTER TABLE tables.annual_avgdischarge_2
  ADD CONSTRAINT annual_avgdischarge_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgdischarge_siteid_idx
  ON tables.annual_avgdischarge_2
  USING btree
  (siteid);


ALTER TABLE tables.annual_avgdischarge_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgdischarge_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgdischarge_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgdischarge_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgdischarge_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgdischarge_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgdischarge_2
  IS 'This creates annual discharge averages using "monthly_discharge_all".  Requires all 12 months to create annual discharge averages and the monthly average cannot be null.  Sets originalvariableid=700 and variableid=710.';
