insert into DAILY_RHDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
select  DataValue, DateTimeUTC, SiteID, 435  as OriginalVariableID, GETDATE() as InsertDate
from ODMDataValues_metric 
where SiteID in (select siteid from Sites where sourceid in (211,214,215,216,217,218,219) and OriginalVariableID=435 
order by SiteID,DateTimeUTC
