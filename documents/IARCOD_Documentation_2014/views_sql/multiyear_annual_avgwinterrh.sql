USE [IARCOD]
GO

/****** Object:  View [dbo].[MULTIYEAR_ANNUAL_AvgWinterRH]    Script Date: 09/04/2014 11:07:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE view [dbo].[MULTIYEAR_ANNUAL_AvgWinterRH] as
select ROW_NUMBER() OVER (ORDER BY i.SiteID,i.AvgAnnual) AS ValueID, 
i.AvgAnnual as DataValue,
SiteID, 
CAST('12-31-9999' AS DATETIME) as UTCDateTime,
741 as OriginalVariableID,
742 as VariableID
from MULTIYEAR_ANNUAL_ALL_AvgWinterRH i
where i.totalYears >=5


















GO

