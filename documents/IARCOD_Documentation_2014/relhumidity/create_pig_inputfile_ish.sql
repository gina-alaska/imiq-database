

select dp.DateTimeUTC, dp.SiteID, dp.originalVariableID,dp.DataValue as DP, at.DataValue as AT
from ODMDataValues_metric dp
inner join(
select *
from ODMDataValues_metric 
where SiteID in (select SiteID from Sites where SourceID=209) and OriginalVariableID=218)as at
on dp.siteid=at.siteid and dp.DateTimeUTC=at.DateTimeUTC
where dp.SiteID in (select siteid from Sites where sourceid=209) and dp.OriginalVariableID=332
order by dp.SiteID,dp.DateTimeUTC