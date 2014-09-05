USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSpringPrecip]    Script Date: 09/04/2014 10:41:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[ANNUAL_AvgSpringPrecip] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvg as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
701 as OriginalVariableID, 
733 as VariableID
from ANNUAL_AvgSpringPrecip_ALL;






















GO

