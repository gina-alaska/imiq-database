insert into DAILY_RHDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
select  DataValue, DateTimeUTC, SiteID, 299  as OriginalVariableID, GETDATE() as InsertDate
from ODMDataValues_metric 
where SiteID in (select siteid from Sites where sourceid in (183)) and OriginalVariableID=299 
order by SiteID,DateTimeUTC