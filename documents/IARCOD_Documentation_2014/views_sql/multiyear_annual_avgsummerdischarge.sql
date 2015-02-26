USE [IARCOD]
GO

/****** Object:  View [dbo].[MULTIYEAR_ANNUAL_AvgSummerDischarge]    Script Date: 09/04/2014 11:05:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE view [dbo].[MULTIYEAR_ANNUAL_AvgSummerDischarge] as
select ROW_NUMBER() OVER (ORDER BY i.SiteID,i.AvgAnnual) AS ValueID, 
i.AvgAnnual as DataValue,
SiteID, 
CAST('12-31-9999' AS DATETIME) as UTCDateTime,
737 as OriginalVariableID,
738 as VariableID
from MULTIYEAR_ANNUAL_ALL_AvgSummerDischarge i
where i.totalYears >=5




















GO

