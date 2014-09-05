USE [IARCOD]
GO

/****** Object:  View [dbo].[DAILY_WaterTemp]    Script Date: 09/04/2014 10:49:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












CREATE view [dbo].[DAILY_WaterTemp] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.OriginalVariableID as OriginalVariableID, 
VariableID=694
from DAILY_WaterTempDataValues v
inner join sites s on v.siteid = s.siteid
where v.DataValue is not null 
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.OriginalVariableID, 
s.SourceID

















GO

