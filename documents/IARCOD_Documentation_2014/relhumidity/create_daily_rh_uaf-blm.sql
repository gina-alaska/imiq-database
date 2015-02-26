insert into DAILY_RHDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
select  DataValue, DateTimeUTC, SiteID, 641  as OriginalVariableID, GETDATE() as InsertDate
from ODMDataValues_metric 
where SiteID in (select siteid from Sites where sourceid in (164)) and OriginalVariableID=641 
order by SiteID,DateTimeUTC