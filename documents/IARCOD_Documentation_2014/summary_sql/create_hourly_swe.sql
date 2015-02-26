
declare @g geography select @g=geoposition from NHD_HUC8; 
SELECT @g=@g.STUnion(geoposition) FROM NHD_HUC8

select *
into HOURLY_SWE
from
(
select /* everything but the arctic */
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID, 
VariableID=681
from HOURLY_SWEDataValues v, Sites as s
where (v.DataValue >= 0 and v.DataValue < 1200) 
and s.SiteID=v.SiteID and @g.STIntersects(GeoLocation)  <> 1.0 
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID
UNION ALL     /* Arctic HUC threshold */
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID, 
VariableID=681
from HOURLY_SWEDataValues v, NHD_HUC8 as Bounds, Sites as s
where (v.DataValue >= 0 and v.DataValue < 609.6) 
and s.SiteID=v.SiteID and @g.STIntersects(GeoLocation)  = 1.0 
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID ) as m
