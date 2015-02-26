select AT.SiteID as SiteID,AT.DateTimeUTC,AT.DataValue as AT,RH.DataValue as RH
from ODMDataValues_metric AT
left outer join
(select SiteID,DateTimeUTC,DataValue
from ODMDataValues_metric
where OriginalVariableID=523) AS RH
on AT.SiteID=RH.SiteID and AT.DateTimeUTC=RH.DateTimeUTC
where AT.SiteID in (select siteid from sites where sourceid in( 202)) and AT.OriginalVariableID=527