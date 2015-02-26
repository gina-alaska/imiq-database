USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgFallAirTemp]    Script Date: 09/04/2014 10:39:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO














CREATE view [dbo].[ANNUAL_AvgFallAirTemp] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvg as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
697 as OriginalVariableID, 
722 as VariableID
from ANNUAL_AvgFallAirTemp_ALL;





















GO

