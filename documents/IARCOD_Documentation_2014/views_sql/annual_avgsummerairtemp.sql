USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSummerAirTemp]    Script Date: 09/04/2014 10:42:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[ANNUAL_AvgSummerAirTemp] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvg as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
697 as OriginalVariableID, 
726 as VariableID
from ANNUAL_AvgSummerAirTemp_ALL;






















GO

