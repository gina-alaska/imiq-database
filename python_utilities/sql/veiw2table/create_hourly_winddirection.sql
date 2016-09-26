﻿
CREATE TABLE tables.hourly_winddirection_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    682 AS variableid
   FROM tables.hourly_winddirectiondatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision AND v.datavalue <= 360::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.hourly_winddirection_2
  ADD CONSTRAINT hourly_winddirection_valueid PRIMARY KEY (valueid);

CREATE INDEX hourly_winddirection_siteid_idx
  ON tables.hourly_winddirection_2
  USING btree
  (siteid);

ALTER TABLE tables.hourly_winddirection_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.hourly_winddirection_2 TO imiq;
GRANT ALL ON TABLE tables.hourly_winddirection_2 TO asjacobs;
GRANT ALL ON TABLE tables.hourly_winddirection_2 TO chaase;
GRANT SELECT ON TABLE tables.hourly_winddirection_2 TO imiq_reader;
GRANT ALL ON TABLE tables.hourly_winddirection_2 TO rwspicer;
COMMENT ON TABLE tables.hourly_winddirection_2
  IS 'This view restricts data values to the range: datavalue >= 0 and datavalue <= 360.  Sets the hourly wind direction variableid=682';
