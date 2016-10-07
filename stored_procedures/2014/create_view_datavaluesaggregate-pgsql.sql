create view datavaluesaggregate as

select 	datastreamid, offsetvalue, offsettypeid,convert(varchar(100), min(localdatetime), 120) as begindatetime, convert(varchar(100), max(localdatetime), 120) as enddatetime,
               convert(varchar(100), dateadd(hour, -utcoffset, min(localdatetime)), 120) as begindatetimeutc, convert(varchar(100), dateadd(hour, -utcoffset,
               max(localdatetime)), 120) as enddatetimeutc, count(*) as totalvalues
from tables.datavalues
group by datastreamid,offsetvalue, offsettypeid,utcoffset;



