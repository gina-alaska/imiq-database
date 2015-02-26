USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSummerRH]    Script Date: 09/04/2014 10:44:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[ANNUAL_AvgSummerRH] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvgRH as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
707 as OriginalVariableID, 
739 as VariableID
from ANNUAL_AvgSummerRH_ALL;























GO

