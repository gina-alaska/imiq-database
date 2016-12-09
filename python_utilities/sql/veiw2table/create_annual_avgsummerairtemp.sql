﻿
CREATE TABLE tables.annual_avgsummerairtemp_2 AS 
 SELECT row_number() OVER (ORDER BY annual_avgsummerairtemp_all.siteid, annual_avgsummerairtemp_all.year) AS valueid,
    annual_avgsummerairtemp_all.seasonalavg AS datavalue,
    annual_avgsummerairtemp_all.siteid,
    (annual_avgsummerairtemp_all.year || '-01-01'::text)::timestamp without time zone AS utcdatetime,
    697 AS originalvariableid,
    726 AS variableid
   FROM tables.annual_avgsummerairtemp_all;

ALTER TABLE tables.annual_avgsummerairtemp_2
  ADD CONSTRAINT annual_avgsummerairtemp_valueid PRIMARY KEY (valueid);

CREATE INDEX annual_avgsummerairtemp_siteid_idx
  ON tables.annual_avgsummerairtemp_2
  USING btree
  (siteid);
  

ALTER TABLE tables.annual_avgsummerairtemp_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerairtemp_2 TO imiq;
GRANT ALL ON TABLE tables.annual_avgsummerairtemp_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_avgsummerairtemp_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_avgsummerairtemp_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_avgsummerairtemp_2 TO rwspicer;
COMMENT ON TABLE tables.annual_avgsummerairtemp_2
  IS 'This table creates "annual_avgsummerairtemp_2" with the fields: valueid, datavalue, siteid, utcdatetime, originalvariableid and variableid.  Sets originalvariableid=697 and variableid=726';
