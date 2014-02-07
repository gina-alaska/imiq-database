USE [IARCOD]
GO

/****** Object:  View [dbo].[DAILY_AirTemp]    Script Date: 02/07/2014 10:03:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE view [dbo].[DAILY_AirTemp] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.OriginalVariableID as VariableID, 
s.SourceID as SourceID
from DAILY_AirTempDataValues v
inner join sites s on v.siteid = s.siteid
where (v.DataValue >= -62.22 and v.DataValue <= 46.11) and v.DataValue is not null -- -80F <= DataValue < 115F
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.OriginalVariableID, 
s.SourceID













GO

