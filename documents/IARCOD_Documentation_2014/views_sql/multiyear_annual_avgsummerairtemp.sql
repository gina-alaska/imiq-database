USE [IARCOD]
GO

/****** Object:  View [dbo].[MULTIYEAR_ANNUAL_AvgSummerAirTemp]    Script Date: 09/04/2014 11:04:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[MULTIYEAR_ANNUAL_AvgSummerAirTemp] as
select ROW_NUMBER() OVER (ORDER BY i.SiteID,i.AvgAnnual) AS ValueID, 
i.AvgAnnual as DataValue,
SiteID, 
CAST('12-31-9999' AS DATETIME) as UTCDateTime,
726 as OriginalVariableID,
727 as VariableID
from MULTIYEAR_ANNUAL_ALL_AvgSummerAirTemp i
where i.totalYears >=5
















GO

