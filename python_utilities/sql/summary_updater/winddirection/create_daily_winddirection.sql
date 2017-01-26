-- create_daily_winddirection.sql
--     creates tables.daily_winddirection_2.
--  Note: to finish update drop tables.daily_winddirection, and rename this 
--  table to tables.daily_winddirection
--
-- version 1.0.0
-- updated 2017-01-10
-- 
-- changelog:
-- 1.0.0: added metadata comments.

CREATE TABLE tables.daily_winddirection_2 AS 
 SELECT v.valueid,
    v.datavalue,
    v.utcdatetime,
    v.siteid,
    v.originalvariableid,
    695 AS variableid
   FROM tables.daily_winddirectiondatavalues v
     JOIN tables.sites s ON v.siteid = s.siteid
  WHERE v.datavalue >= 0::double precision AND v.datavalue <= 360::double precision
  GROUP BY v.valueid, v.datavalue, v.utcdatetime, v.siteid, v.originalvariableid, s.sourceid;

ALTER TABLE tables.daily_winddirection_2
  ADD CONSTRAINT daily_winddirection_valueid_2 PRIMARY KEY (valueid);

CREATE INDEX daily_winddirection_siteid_idx_2
  ON tables.daily_winddirection_2
  USING btree
  (siteid);

ALTER TABLE tables.daily_winddirection_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.daily_winddirection_2 TO imiq;
GRANT ALL ON TABLE tables.daily_winddirection_2 TO asjacobs;
GRANT ALL ON TABLE tables.daily_winddirection_2 TO chaase;
GRANT SELECT ON TABLE tables.daily_winddirection_2 TO imiq_reader;
GRANT ALL ON TABLE tables.daily_winddirection_2 TO rwspicer;
COMMENT ON TABLE tables.daily_winddirection_2
  IS 'This view restricts data values to the range: datavalue >= 0 and datavalue <= 360.  Sets the daily wind direction variableid=695.';
