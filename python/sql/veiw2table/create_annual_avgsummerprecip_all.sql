﻿
CREATE TABLE tables.annual_avgsummerprecip_all_2 AS 
 SELECT p.siteid,
    p.year,
    avg(p.monthlytotal) AS seasonalavg
   FROM tables.monthly_precip_all p
  WHERE (p.month = ANY (ARRAY[6::double precision, 7::double precision, 8::double precision])) AND p.monthlytotal IS NOT NULL
  GROUP BY p.siteid, p.year
 HAVING count(*) = 3;

CREATE INDEX annual_avgsummerprecip_all_siteid_idx
  ON tables.annual_avgsummerprecip_all_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_avgsummerprecip_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_all_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_all_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgsummerprecip_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerprecip_all_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgsummerprecip_all_2
  IS 'This view creates annual average summer precipitation totals using "monthly_precip_all".  Requires all three months; June, July, August; to create annual average summer precipitation totals.';
