USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_Precip]    Script Date: 09/04/2014 10:53:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[MONTHLY_Precip] as
select ROW_NUMBER() OVER (ORDER BY SiteID,Monthlytotal) AS ValueID, 
MonthlyTotal as DataValue,
SiteID, 
CAST(CAST(year AS varchar) + '-' + CAST(month AS varchar) + '-01'  AS DATETIME) as UTCDateTime,
690 as OriginalVariableID,
701 as VariableID
from MONTHLY_Precip_ALL





GO

