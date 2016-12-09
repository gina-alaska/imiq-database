

CREATE OR REPLACE VIEW tables._15min_watertemp AS 
  select dv.valueid, 
         dv.datavalue, 
         (dv.localdatetime + dv.utcoffset * interval '1 hour') as utcdatetime, 
         ds.siteid, 
         ds.variableid as originalvariableid,
         1143 AS variableid
   from tables.datavalues dv 
     inner join tables.datastreams ds on ds.datastreamid = dv.datastreamid 
     inner join tables.variables v on v.variableid = ds.variableid 
   where lower(v.samplemedium) like '%surface water%' 
     and lower(v.variablename) like 'temperature' 
     and v.timesupport = 15;

ALTER TABLE tables._15min_watertemp
  OWNER TO imiq;
GRANT ALL ON TABLE tables._15min_watertemp TO imiq;
GRANT ALL ON TABLE tables._15min_watertemp TO asjacobs;
GRANT SELECT ON TABLE tables._15min_watertemp TO imiq_reader;
GRANT ALL ON TABLE tables._15min_watertemp TO rwspicer;
COMMENT ON VIEW tables._15min_watertemp
  IS 'This view creates "_15min_watertemp" with the fields: valueid,datavalue,siteid,utcdatetime,originalvariableid and variableid'
