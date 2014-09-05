USE [IARCOD]
GO

/****** Object:  View [dbo].[DAILY_WindDirection]    Script Date: 09/04/2014 10:49:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










CREATE view [dbo].[DAILY_WindDirection] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.OriginalVariableID as OriginalVariableID, 
VariableID=695
from DAILY_WindDirectionDataValues v
inner join sites s on v.siteid = s.siteid
where (v.DataValue >= 0 and v.DataValue <= 360)
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.OriginalVariableID, 
s.SourceID


























GO

