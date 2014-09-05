USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSummerPrecip]    Script Date: 09/04/2014 10:43:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[ANNUAL_AvgSummerPrecip] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvg as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
701 as OriginalVariableID, 
735 as VariableID
from ANNUAL_AvgSummerPrecip_ALL;






















GO

