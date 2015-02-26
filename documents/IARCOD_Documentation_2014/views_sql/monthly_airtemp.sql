USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_AirTemp]    Script Date: 09/04/2014 10:52:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












CREATE view [dbo].[MONTHLY_AirTemp] as
select ROW_NUMBER() OVER (ORDER BY SiteID,MonthlyAvg) AS ValueID, 
MonthlyAvg as DataValue,
SiteID, 
CAST(CAST(year AS varchar) + '-' + CAST(month AS varchar) + '-01'  AS DATETIME) as UTCDateTime,
686 as OriginalVariableID,
697 as VariableID
from MONTHLY_AirTemp_ALL











GO

