-- create_annual_snowdepth_all.sql
-- 
-- version 1.0.0
-- updated 2017-01-13
-- 
-- changelog:
-- 1.0.0: initial version

CREATE TABLE tables.annual_peaksnowdepth_all_2 AS 
 select siteid,
	extract(year from date_trunc('year',utcdatetime)) as year ,
	max(datavalue) as datavalue
  from tables.daily_snowdepth
  where extract(month from utcdatetime) in (3::double precision, 4::double precision, 5::double precision, 6::double precision)
  group by siteid,date_trunc('year',utcdatetime)
  order by siteid,date_trunc('year',utcdatetime);

CREATE INDEX annual_peaksnowdepth_all_2_siteid_idx
  ON tables.annual_peaksnowdepth_all_2
  USING btree
  (siteid);

ALTER TABLE tables.annual_peaksnowdepth_all_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.annual_peaksnowdepth_all_2 TO imiq;
GRANT ALL ON TABLE tables.annual_peaksnowdepth_all_2 TO asjacobs;
GRANT ALL ON TABLE tables.annual_peaksnowdepth_all_2 TO chaase;
GRANT SELECT ON TABLE tables.annual_peaksnowdepth_all_2 TO imiq_reader;
GRANT ALL ON TABLE tables.annual_peaksnowdepth_all_2 TO rwspicer;
COMMENT ON TABLE tables.annual_peaksnowdepth_all_2 IS
	'This view creates "annual_peaksnowdepth_all" from daily summary table';
