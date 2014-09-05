USE [IARCOD]
GO

/****** Object:  View [dbo].[DAILY_Discharge]    Script Date: 09/04/2014 10:48:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE view [dbo].[DAILY_Discharge] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID,
VariableID=689
from DAILY_DischargeDataValues v
inner join sites s on v.siteid = s.siteid
where v.DataValue >= 0
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID




















GO

