insert into HOURLY_RHDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
select D_RH.DataValue as DataValue,D_RH.DateTimeUTC as UTCDateTime,D_RH.SiteID as SiteID,80 as OriginalVariableID, GETDATE() as InsertDate
from ODMDataValues_metric D_RH
where D_RH.SiteID in (select siteid from sites where sourceid in(29,30,31,34)) and D_RH.OriginalVariableID=80 and D_RH.OffsetValue=2 and
SiteID not in (select SiteID from HOURLY_RHDataValues where OriginalVariableID=80 and UTCDateTime=D_RH.DateTimeUTC)
order by DateTimeUTC