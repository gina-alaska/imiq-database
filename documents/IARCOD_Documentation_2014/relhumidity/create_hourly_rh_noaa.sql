insert into HOURLY_RHDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
select D_RH.DataValue as DataValue,D_RH.DateTimeUTC as UTCDateTime,D_RH.SiteID as SiteID,518 as OriginalVariableID, GETDATE() as InsertDate
from ODMDataValues_metric D_RH
where D_RH.SiteID in (select siteid from sites where sourceid in(35)) and D_RH.OriginalVariableID=518 
order by DateTimeUTC