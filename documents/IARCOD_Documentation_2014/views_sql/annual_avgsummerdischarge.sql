USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSummerDischarge]    Script Date: 09/04/2014 10:43:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[ANNUAL_AvgSummerDischarge] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvg as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
700 as OriginalVariableID, 
737 as VariableID
from ANNUAL_AvgSummerDischarge_ALL;























GO

