select  datastreamid , datastreamname, siteid, sitecode, sitename, 
        unitsabbreviation, offsettypeid, variableid, variablecode, 
        variablename, speciation, variableunitsid, samplemedium, 
        valuetype, timesupport, timeunitsid, datatype, generalcategory, 
        methodid, methoddescription, ser.sourceid, ser.organization, 
        ser.sourcedescription, ser.citation, qualitycontrollevelid, 
        qualitycontrollevelcode,
        MIN(begindatetime) as begindatetime, 
        max(enddatetime) as enddatetime, 
        min(begindatetimeutc) as begindatetimeutc, 
        max(enddatetimeutc) as enddatetimeutc, 
        lat, long, elev, geolocationtext, spatialcharacteristics, 
        sum(totalvalues) as totalvues, 
        sum(totalmissingvalues) as totalmissingvalues, 
        min(startdecade) as startdecade, 
        max(enddecade) as enddecade, 
        max(enddecade) - min(startdecade) as totalyears,
        so.sourcelink, so.contactname, so.phone, so.email, so.address, 
        so.city, so.state, so.zipcode, meta.topiccategory, 
        meta.title, meta.abstract, meta.profileversion, meta.metadatalink  
    from tables.seriescatalog ser 
        full join tables.sources so on ser.sourceid = so.sourceid
        full join tables.isometadata meta on meta.metadataid = so.metadataid    
    where lower(variablename) like 'water content' 
    group by datastreamid , datastreamname, siteid, sitecode, sitename, 
             unitsabbreviation, offsettypeid, variableid, variablecode, 
             variablename, speciation, variableunitsid, samplemedium, 
             valuetype, timesupport, timeunitsid, datatype,
              generalcategory, methodid, methoddescription, 
              ser.sourceid, ser.organization, ser.sourcedescription, 
              ser.citation, qualitycontrollevelid, qualitycontrollevelcode, 
              lat, long, elev, geolocationtext, spatialcharacteristics, 
              so.sourcelink, so.contactname, so.phone, so.email, so.address, 
              so.city, so.state, so.zipcode, meta.topiccategory, meta.title, 
              meta.abstract, meta.profileversion, meta.metadatalink 
    order by siteid 
