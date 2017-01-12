CREATE MATERIALIZED VIEW tables.seriescatalog AS 
SELECT datastreamid
      ,datastreamname
      ,siteid
      ,sitecode
      ,sitename
      ,boundarycatalog.offsetvalue
      ,u.unitsabbreviation
      ,boundarycatalog.offsettypeid
      ,variableid
      ,variablecode
      ,variablename
      ,speciation
      ,variableunitsid
      ,samplemedium
      ,valuetype
      ,timesupport
      ,timeunitsid
      ,datatype
      ,generalcategory
      ,methodid
      ,methoddescription
      ,sourceid
      ,organization
      ,sourcedescription
      ,citation
      ,qualitycontrollevelid
      ,qualitycontrollevelcode
      ,begindatetime
      ,enddatetime
      ,begindatetimeutc
      ,enddatetimeutc
      ,lat
      ,long
      ,elev
      ,geolocationtext
      ,spatialcharacteristics
      ,totalvalues
      ,totalmissingvalues
      ,CAST(date_part('year',begindatetime) as integer) - CAST(date_part('year',begindatetime) as integer) % 10 AS startdecade
      ,CAST(date_part('year',enddatetime) as integer) - CAST(date_part('year',enddatetime) as integer) % 10 AS enddecade
      ,date_part('year',enddatetime) - date_part('year',begindatetime) AS totalyears
  -- ~ into tables.seriescatalog
  FROM tables.boundarycatalog
 left join tables.offsettypes o on o.offsettypeid=tables.boundaryCatalog.offsettypeid
 left join tables.units u on u.unitsid=o.offsetunitsid
 where lower(spatialcharacteristics)='point';
