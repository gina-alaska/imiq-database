USE [IARCOD]
GO

/****** Object:  View [dbo].[HOURLY_AirTemp]    Script Date: 01/30/2014 13:21:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE view [dbo].[HOURLY_AirTemp] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.OriginalVariableID as VariableID, 
s.SourceID as SourceID,
v.insertdate
from HOURLY_AirTempDataValues v
inner join sites s on v.siteid = s.siteid
where (v.DataValue >= -62.22 and v.DataValue <= 46.11) and v.DataValue is not null -- -80F <= DataValue < 115F
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.OriginalVariableID, 
v.InsertDate,
s.SourceID














GO

