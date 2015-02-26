USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_TotalPrecip]    Script Date: 09/04/2014 10:46:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










CREATE view [dbo].[ANNUAL_TotalPrecip] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID, 
DataValue,
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
701 as OriginalVariableID, 
703 as VariableID
from ANNUAL_TotalPrecip_ALL;








GO

