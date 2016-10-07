USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_Discharge]    Script Date: 09/04/2014 10:52:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[MONTHLY_Discharge] as
select ROW_NUMBER() OVER (ORDER BY SiteID,MonthlyAvg) AS ValueID, 
MonthlyAvg as DataValue,
SiteID, 
CAST(CAST(year AS varchar) + '-' + CAST(month AS varchar) + '-01'  AS DATETIME) as UTCDateTime,
689 as OriginalVariableID,
700 as VariableID
from MONTHLY_Discharge_ALL




GO
