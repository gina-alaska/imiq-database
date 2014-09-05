USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSpringAirTemp]    Script Date: 09/04/2014 10:40:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO













CREATE view [dbo].[ANNUAL_AvgSpringAirTemp] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvg as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
697 as OriginalVariableID, 
724 as VariableID
from ANNUAL_AvgSpringAirTemp_ALL;




















GO

