USE [IARCOD]
GO

/****** Object:  View [dbo].[MULTIYEAR_ANNUAL_AvgAirTemp]    Script Date: 09/04/2014 10:59:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE view [dbo].[MULTIYEAR_ANNUAL_AvgAirTemp] as
select ROW_NUMBER() OVER (ORDER BY i.SiteID,i.AvgAnnual) AS ValueID, 
i.AvgAnnual as DataValue,
SiteID, 
CAST('12-31-9999' AS DATETIME) as UTCDateTime,
699 as OriginalVariableID,
698 as VariableID
from MULTIYEAR_ANNUAL_ALL_AvgAirTemp i
where i.totalYears >=5











GO

