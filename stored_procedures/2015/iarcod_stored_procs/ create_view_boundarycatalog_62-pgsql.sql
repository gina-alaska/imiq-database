create view boundarycatalog_62 as

select s.datastreamid, s.datastreamname, s.siteid, site.sitecode, site.sitename, v.variableid, v.variablecode, v.variablename, v.speciation, v.variableunitsid,
               v.samplemedium, v.valuetype, v.timesupport, v.timeunitsid, v.datatype, v.generalcategory, m.methodid, s.deviceid, m.methoddescription, site.sourceid,
               source.organization, source.sourcedescription, source.citation, s.qualitycontrollevelid, q.qualitycontrollevelcode, i.begindatetime, i.enddatetime, i.begindatetimeutc,
               i.enddatetimeutc, geography::stgeomfromtext(site.geolocation, 4326) as geolocation, site.geolocation as geolocationtext, site.spatialcharacteristics, i.totalvalues
from datavaluesaggregate as i inner join
               dbo.datastreams as s on i.datastreamid = s.datastreamid inner join
               dbo.sites as site on s.siteid = site.siteid inner join
               dbo.variables as v on s.variableid = v.variableid inner join
               dbo.methods as m on s.methodid = m.methodid inner join
               dbo.sources as source on site.sourceid = source.sourceid inner join
               dbo.qualitycontrollevels as q on s.qualitycontrollevelid = q.qualitycontrollevelid
where cast(geography::stgeomfromtext(site.geolocation, 4326).lat as float) > 62.0 and s.siteid != 2052 and s.siteid != 8044;










