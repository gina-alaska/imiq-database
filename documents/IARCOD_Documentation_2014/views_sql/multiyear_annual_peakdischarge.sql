USE [IARCOD]
GO

/****** Object:  View [dbo].[MULTIYEAR_ANNUAL_AvgPeakDischarge]    Script Date: 09/04/2014 11:01:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE view [dbo].[MULTIYEAR_ANNUAL_AvgPeakDischarge] as
select ROW_NUMBER() OVER (ORDER BY i.SiteID,i.AvgAnnual) AS ValueID, 
i.AvgAnnual as DataValue,
SiteID, 
CAST('12-31-9999' AS DATETIME) as UTCDateTime,
712 as OriginalVariableID,
713 as VariableID
from MULTIYEAR_ANNUAL_ALL_AvgPeakDischarge i
where i.totalYears >=1













GO

