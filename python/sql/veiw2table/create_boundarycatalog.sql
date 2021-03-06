﻿-- View: tables.boundarycatalog

-- DROP VIEW tables.boundarycatalog;

CREATE MATERIALIZED VIEW tables.boundarycatalog AS 
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

-- ~ ALTER TABLE tables.boundarycatalog
  -- ~ ADD CONSTRAINT boundarycatalog_datastreamid PRIMARY KEY (datastreamid);

CREATE INDEX boundarycatalog_siteid_idx
  ON tables.boundarycatalog
  USING btree
  (siteid);

ALTER TABLE tables.boundarycatalog
  OWNER TO imiq;
GRANT ALL ON TABLE tables.boundarycatalog TO imiq;
GRANT ALL ON TABLE tables.boundarycatalog TO asjacobs;
GRANT ALL ON TABLE tables.boundarycatalog TO chaase;
GRANT SELECT ON TABLE tables.boundarycatalog TO imiq_reader;
GRANT ALL ON TABLE tables.boundarycatalog TO rwspicer;
