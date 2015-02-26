use IARCOD

select *
into DAILY_Precip
from
(
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID, 
VariableID=690
from  
DAILY_PrecipDataValues v
INNER JOIN Sites s on s.SiteID = v.SiteID
INNER JOIN DAILY_Precip_Thresholds t on t.SiteID = v.SiteID
CROSS APPLY dbo.GetMaxDailyPrecip(v.UTCDateTime,v.SiteID,0,t.MaxThreshold) as m
where (v.DataValue >= t.MinThreshold and v.DataValue < t.MaxThreshold) 
and v.ValueID = m.ValueID

) as m