USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_SWEAvg]    Script Date: 09/04/2014 10:54:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[MONTHLY_SWEAvg] as
select ROW_NUMBER() OVER (ORDER BY SiteID,MonthlyAvg) AS ValueID, 
MonthlyAvg as DataValue,
SiteID, 
CAST(CAST(year AS varchar) + '-' + CAST(month AS varchar) + '-01'  AS DATETIME) as UTCDateTime,
693 as OriginalVariableID,
721 as VariableID
from MONTHLY_SWEAvg_ALL







GO

