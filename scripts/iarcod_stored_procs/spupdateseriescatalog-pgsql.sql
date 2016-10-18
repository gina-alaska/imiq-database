use iarcod
;

/****** object:  storedprocedure spupdateseriescatalog    script date: 02/20/2013 12:55:19 ******/
set ansi_nulls on
;

;

-- =============================================
-- author:		jeff horsburgh
-- create date: 10-5-2006
-- modified:  1-31-2007
-- description:	clears the seriescatalog table
-- and regenerates it from scratch.
-- =============================================

create procedure spupdateseriescatalog as

--clear out the entire seriescatalog table
delete from  seriescatalog

--reset the primary key field
dbcc checkident (seriescatalog, reseed, 0)

--recreate the records in the seriescatalog table
insert into seriescatalog
select     dv.siteid, s.sitecode, s.sitename, dv.variableid, v.variablecode, 
           v.variablename, v.speciation, v.variableunitsid, u.unitsname as variableunitsname, v.samplemedium, 
           v.valuetype, v.timesupport, v.timeunitsid, u1.unitsname as timeunitsname, v.datatype, 
           v.generalcategory, dv.methodid, m.methoddescription, dv.sourceid, so.organization, 
           so.sourcedescription, so.citation, dv.qualitycontrollevelid, qc.qualitycontrollevelcode, dv.begindatetime, 
           dv.enddatetime, dv.begindatetimeutc, dv.enddatetimeutc, dv.valuecount 
from  (
select siteid, variableid, methodid, qualitycontrollevelid, sourceid, min(localdatetime) as begindatetime, 
           max(localdatetime) as enddatetime, min(datetimeutc) as begindatetimeutc, max(datetimeutc) as enddatetimeutc, 
		   count(datavalue) as valuecount
from datavalues
group by siteid, variableid, methodid, qualitycontrollevelid, sourceid) dv
           inner join sites s on dv.siteid = s.siteid 
		   inner join variables v on dv.variableid = v.variableid 
		   inner join units u on v.variableunitsid = u.unitsid 
		   inner join methods m on dv.methodid = m.methodid 
		   inner join units u1 on v.timeunitsid = u1.unitsid 
		   inner join sources so on dv.sourceid = so.sourceid 
		   inner join qualitycontrollevels qc on dv.qualitycontrollevelid = qc.qualitycontrollevelid
group by   dv.siteid, s.sitecode, s.sitename, dv.variableid, v.variablecode, v.variablename, v.speciation,
           v.variableunitsid, u.unitsname, v.samplemedium, v.valuetype, v.timesupport, v.timeunitsid, u1.unitsname, 
		   v.datatype, v.generalcategory, dv.methodid, m.methoddescription, dv.sourceid, so.organization, 
		   so.sourcedescription, so.citation, dv.qualitycontrollevelid, qc.qualitycontrollevelcode, dv.begindatetime,
		   dv.enddatetime, dv.begindatetimeutc, dv.enddatetimeutc, dv.valuecount
order by   dv.siteid, dv.variableid, v.variableunitsid







;

