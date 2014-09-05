USE [IARCOD]
GO

/****** Object:  View [dbo].[DAILY_WindSpeed]    Script Date: 09/04/2014 10:50:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE view [dbo].[DAILY_WindSpeed] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.OriginalVariableID as OriginalVariableID, 
VariableID=696
from DAILY_WindSpeedDataValues v
inner join sites s on v.siteid = s.siteid
where (v.DataValue >= 0 and v.DataValue < 50)
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.OriginalVariableID, 
s.SourceID
























GO

