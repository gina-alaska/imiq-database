USE [IARCOD]
GO

/****** Object:  View [dbo].[MULTIYEAR_ANNUAL_AvgRH]    Script Date: 09/04/2014 11:03:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE view [dbo].[MULTIYEAR_ANNUAL_AvgRH] as
select ROW_NUMBER() OVER (ORDER BY i.SiteID,i.RH) AS ValueID, 
i.RH as DataValue,
SiteID, 
CAST('12-31-9999' AS DATETIME) as UTCDateTime,
708 as OriginalVariableID,
709 as VariableID
from MULTIYEAR_ANNUAL_ALL_AvgRH i
where i.totalYears >=5










GO

