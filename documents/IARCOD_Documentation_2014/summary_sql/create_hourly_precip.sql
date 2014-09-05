use IARCOD

declare @g geography select @g=geoposition from NHD_HUC8; 
SELECT @g=@g.STUnion(geoposition) FROM NHD_HUC8

select *
into HOURLY_Precip
from
(
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID, 
VariableID=678
from HOURLY_PrecipDataValues v, NHD_HUC8 as Bounds, Sites as s
where (v.DataValue >= 0 and v.DataValue < 120) 
and s.SiteID=v.SiteID and @g.STIntersects(GeoLocation) = 0 
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
VariableID=678
from HOURLY_PrecipDataValues v, NHD_HUC8 as Bounds, Sites as s
where (v.DataValue >= 0 and v.DataValue < 60) 
and s.SiteID=v.SiteID and Bounds.geoposition.STIntersects(GeoLocation) = 1 and  Bounds.ID not in (35,36,37,38,39,41,40,42,60,61,62,63)
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID
UNION ALL     /* HUC 35,36,37,38,39,40,41,42 threshold */
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID, 
VariableID=678
from HOURLY_PrecipDataValues v, NHD_HUC8 as Bounds, Sites as s
where (v.DataValue >= 0 and v.DataValue < 20) 
and s.SiteID=v.SiteID and Bounds.geoposition.STIntersects(GeoLocation) = 1 and  Bounds.ID in (35,36,37,38,39,41,40,42)
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID
UNION ALL     /* HUC 60,61,62,63 threshold */
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID, 
VariableID=678
from HOURLY_PrecipDataValues v, NHD_HUC8 as Bounds, Sites as s
where (v.DataValue >= 0 and v.DataValue < 10) 
and s.SiteID=v.SiteID and Bounds.geoposition.STIntersects(GeoLocation) = 1 and  Bounds.ID in (60,61,62,63)
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID ) as m
