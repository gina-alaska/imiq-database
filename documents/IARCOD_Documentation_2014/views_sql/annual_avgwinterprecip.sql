USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgWinterPrecip]    Script Date: 09/04/2014 10:45:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












CREATE view [dbo].[ANNUAL_AvgWinterPrecip] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvg as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
701 as OriginalVariableID, 
731 as VariableID
from ANNUAL_AvgWinterPrecip_ALL ;






















GO

