USE [IARCOD]
GO

/****** Object:  View [dbo].[HOURLY_Precip]    Script Date: 02/07/2014 11:26:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE view [dbo].[HOURLY_Precip] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as VariableID, 
s.SourceID as SourceID
from HOURLY_PrecipDataValues v, NHD_HUC8 as Bounds, Sites as s
where (v.DataValue >= 0 and v.DataValue < 635) 
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
v.originalvariableid as VariableID, 
s.SourceID as SourceID
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
v.originalvariableid as VariableID, 
s.SourceID as SourceID
from HOURLY_PrecipDataValues v, NHD_HUC8 as Bounds, Sites as s
where (v.DataValue >= 0 and v.DataValue < 10) 
and s.SiteID=v.SiteID and Bounds.geoposition.STIntersects(GeoLocation) = 1 and  Bounds.ID in (60,61,62,63)
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID
















GO

