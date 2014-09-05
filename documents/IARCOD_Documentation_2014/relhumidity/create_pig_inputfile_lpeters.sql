select AT.SiteID as SiteID,AT.UTCDateTime as DateTimeUTC,RH.DataValue as RH,AT.DataValue as AT
from HOURLY_AirTempDataValues AT
full join
(select SiteID,UTCDateTime,DataValue
from HOURLY_RHDataValues
where OriginalVariableID=293) AS RH
on AT.SiteID=RH.SiteID and AT.UTCDateTime=RH.UTCDateTime
where AT.SiteID in (select siteid from sites where sourceid in( 182)) and AT.OriginalVariableID in (279)
order by AT.SiteID,AT.UTCDateTime