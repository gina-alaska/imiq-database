USE [IARCOD]
GO

/****** Object:  View [dbo].[ODMDataValues]    Script Date: 09/04/2014 11:08:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[ODMDataValues] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue, 
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
d.variableid as VariableID, 
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation, 
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
group by v.valueid, 
v.datavalue, 
v.valueaccuracy, 
v.localdatetime, 
v.UTCOffset, 
d.siteid, 
d.variableid, 
v.offsetvalue, 
v.offsettypeid, 
v.CensorCode, 
v.QualifierID, 
d.MethodID, 
s.SourceID, 
v.DerivedFromID, 
d.qualityControlLevelID,
s.GeoLocation,
s.SpatialCharacteristics










GO

