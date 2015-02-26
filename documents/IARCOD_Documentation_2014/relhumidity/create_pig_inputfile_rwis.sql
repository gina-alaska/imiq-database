

select rh.SiteID,rh.DateTimeUTC, rh.DataValue as RH, at.DataValue as AT
from ODMDataValues_metric rh
inner join(
select *
from ODMDataValues_metric 
where SiteID in (select SiteID from Sites where SourceID=213) and OriginalVariableID=563)as at
on rh.siteid=at.siteid and rh.DateTimeUTC=at.DateTimeUTC
where rh.SiteID in (select siteid from Sites where sourceid=213) and rh.OriginalVariableID=565 
order by rh.SiteID,rh.DateTimeUTC