select *
into tables.daily_Precip_2
from
(
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID 
/*VariableID=690*/
from  
tables.daily_PrecipDataValues v
INNER JOIN tables.Sites s on s.SiteID = v.SiteID
INNER JOIN tables.DAILY_Precip_Thresholds t on t.SiteID = v.SiteID
/*cross apply  tables.GetMaxDailyPrecip(v.UTCDateTime,v.SiteID,0,t.MaxThreshold) as m*/
where (v.DataValue >= t.MinThreshold and v.DataValue < t.MaxThreshold) 
/*and v.ValueID = m.ValueID*/

) as m;

ALTER TABLE tables.daily_precip_2 ADD COLUMN variableID integer NOT NULL DEFAULT 690;