-- View: tables.boundarycatalog

-- DROP VIEW tables.boundarycatalog;

CREATE TABLE tables.boundarycatalog_2 AS 
 SELECT s.datastreamid,
    s.datastreamname,
    s.siteid,
    site.sitecode,
    site.sitename,
    i.offsetvalue,
    i.offsettypeid,
    v.variableid,
    v.variablecode,
    v.variablename,
    v.speciation,
    v.variableunitsid,
    v.samplemedium,
    v.valuetype,
    v.timesupport,
    v.timeunitsid,
    v.datatype,
    v.generalcategory,
    m.methodid,
    s.deviceid,
    m.methoddescription,
    site.sourceid,
    source.organization,
    source.sourcedescription,
    source.citation,
    s.qualitycontrollevelid,
    q.qualitycontrollevelcode,
    i.begindatetime,
    i.enddatetime,
    i.begindatetimeutc,
    i.enddatetimeutc,
    st_ymax(site.geolocation::geometry) AS lat,
    st_xmax(site.geolocation::geometry) AS long,
    st_zmax(site.geolocation::geometry) AS elev,
    site.geolocation AS geolocationtext,
    site.spatialcharacteristics,
    i.totalvalues,
    i.missingdatavaluestotal AS totalmissingvalues
   FROM tables.datavaluesaggregate i
     JOIN tables.datastreams s ON i.datastreamid = s.datastreamid
     JOIN tables.sites site ON s.siteid = site.siteid
     JOIN tables.variables v ON s.variableid = v.variableid
     JOIN tables.methods m ON s.methodid = m.methodid
     JOIN tables.sources source ON site.sourceid = source.sourceid
     JOIN tables.qualitycontrollevels q ON s.qualitycontrollevelid = q.qualitycontrollevelid
  WHERE s.siteid <> 2052 AND s.siteid <> 8044;

-- ~ ALTER TABLE tables.boundarycatalog_2
  -- ~ ADD CONSTRAINT boundarycatalog_datastreamid_2 PRIMARY KEY (datastreamid);

CREATE INDEX boundarycatalog_siteid_idx_2
  ON tables.boundarycatalog_2
  USING btree
  (siteid);

ALTER TABLE tables.boundarycatalog_2
  OWNER TO imiq;
GRANT ALL ON TABLE tables.boundarycatalog_2 TO imiq;
GRANT ALL ON TABLE tables.boundarycatalog_2 TO asjacobs;
GRANT ALL ON TABLE tables.boundarycatalog_2 TO chaase;
GRANT SELECT ON TABLE tables.boundarycatalog_2 TO imiq_reader;
GRANT ALL ON TABLE tables.boundarycatalog_2 TO rwspicer;
