USE [IARCOD]
GO

/****** Object:  View [dbo].[DAILY_RH]    Script Date: 09/04/2014 10:48:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










CREATE view [dbo].[DAILY_RH] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID, 
VariableID=691
from DAILY_RHDataValues v
inner join sites s on v.siteid = s.siteid
where (v.DataValue > 0 and v.DataValue <= 100) 
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID




















GO

