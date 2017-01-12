-- View: tables.odmdatavalues_metric

-- DROP VIEW tables.odmdatavalues_metric;

CREATE OR REPLACE VIEW tables.odmdatavalues_metric AS 
 SELECT v.valueid,
    v.datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime - ((v.utcoffset || 'hour'::text)::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    va.variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = ANY (ARRAY[1, 2, 33, 36, 39, 47, 52, 54, 80, 86, 90, 96, 116, 119, 121, 137, 143, 168, 170, 181, 188, 192, 198, 199, 205, 221, 254, 258, 304, 309, 310, 331, 332, 333, 335, 336])
UNION ALL
 SELECT v.valueid,
    (v.datavalue - 32::double precision) * 0.555555556::double precision AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime - ((v.utcoffset || 'hour'::text)::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    96 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = 97
UNION ALL
 SELECT v.valueid,
    v.datavalue * 25.4::double precision AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime - ((v.utcoffset || 'hour'::text)::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    54 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = 49 AND (lower(va.variablename::text) ~~ '%precipitation%'::text OR lower(va.variablename::text) ~~ '%snow water equivalent%'::text OR lower(va.variablename::text) ~~ '%snowfall%'::text)
UNION ALL
 SELECT v.valueid,
    v.datavalue * 0.0254::double precision AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime - ((v.utcoffset || 'hour'::text)::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    52 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = 49 AND lower(va.variablename::text) ~~ '%snow depth%'::text
UNION ALL
 SELECT v.valueid,
    v.datavalue * 0.02832::double precision AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime - ((v.utcoffset || 'hour'::text)::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    36 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = 35 AND lower(va.variablename::text) ~~ '%discharge%'::text
UNION ALL
 SELECT v.valueid,
    v.datavalue * 0.44704::double precision AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime - ((v.utcoffset || 'hour'::text)::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    119 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = 120 AND lower(va.variablename::text) ~~ '%wind speed%'::text
UNION ALL
 SELECT v.valueid,
    v.datavalue * 697.8::double precision AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime - ((v.utcoffset || 'hour'::text)::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    33 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = 29 AND lower(va.variablename::text) ~~ '%radiation%'::text
UNION ALL
 SELECT v.valueid,
    v.datavalue * 0.3048::double precision AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime - ((v.utcoffset || 'hour'::text)::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    52 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = 48 AND (lower(va.variablename::text) ~~ '%gage height%'::text OR lower(va.variablename::text) ~~ '%water depth%'::text OR lower(va.variablename::text) ~~ '%distance%'::text OR lower(va.variablename::text) ~~ '%ice thickness%'::text OR lower(va.variablename::text) ~~ '%free board%'::text OR lower(va.variablename::text) ~~ '%luminescent dissolved oxygen%'::text OR lower(va.variablename::text) ~~ '%snow depth%'::text)
UNION ALL
 SELECT v.valueid,
    v.datavalue * 1233.48183754752::double precision AS datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime - ((v.utcoffset || 'hour'::text)::interval) AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    126 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = 48 AND lower(va.variablename::text) ~~ '%volume%'::text
UNION ALL
 SELECT v.valueid,
    v.datavalue,
    v.valueaccuracy,
    v.localdatetime,
    v.utcoffset,
    v.localdatetime + '-09:00:00'::interval AS datetimeutc,
    d.siteid,
    va.variableid AS originalvariableid,
    va.variablename,
    va.samplemedium,
    90 AS variableunitsid,
    va.timeunitsid AS variabletimeunits,
    v.offsetvalue,
    v.offsettypeid,
    v.censorcode,
    v.qualifierid,
    d.methodid,
    s.sourceid,
    v.derivedfromid,
    d.qualitycontrollevelid,
    st_geographyfromtext(s.geolocation) AS geographylocation,
    s.geolocation,
    s.spatialcharacteristics
   FROM tables.datavalues v
     JOIN tables.datastreams d ON d.datastreamid = v.datastreamid
     JOIN tables.sites s ON d.siteid = s.siteid
     JOIN tables.variables va ON d.variableid = va.variableid
  WHERE va.variableunitsid = 315 AND (lower(va.variablename::text) ~~ '%sea level pressure%'::text OR lower(va.variablename::text) ~~ '%altimeter setting rate%'::text OR lower(va.variablename::text) ~~ '%barometric pressure%'::text)
  GROUP BY v.valueid, v.datavalue, v.valueaccuracy, v.localdatetime, v.utcoffset, d.siteid, va.variableid, va.variablename, va.samplemedium, va.variableunitsid, va.timeunitsid, v.offsetvalue, v.offsettypeid, v.censorcode, v.qualifierid, d.methodid, s.sourceid, v.derivedfromid, d.qualitycontrollevelid, s.geolocation, s.spatialcharacteristics;

ALTER TABLE tables.odmdatavalues_metric
  OWNER TO imiq;
GRANT ALL ON TABLE tables.odmdatavalues_metric TO imiq;
GRANT ALL ON TABLE tables.odmdatavalues_metric TO asjacobs;
GRANT SELECT ON TABLE tables.odmdatavalues_metric TO imiq_reader;
GRANT ALL ON TABLE tables.odmdatavalues_metric TO rwspicer;
COMMENT ON VIEW tables.odmdatavalues_metric
  IS 'This view creates recreates the odm version of the datavalues table with all metric units.';
