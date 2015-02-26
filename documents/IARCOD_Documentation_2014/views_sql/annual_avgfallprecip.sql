USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgFallPrecip]    Script Date: 09/04/2014 10:39:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[ANNUAL_AvgFallPrecip] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvg as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
701 as OriginalVariableID, 
729 as VariableID
from ANNUAL_AvgFallPrecip_ALL;




















GO

