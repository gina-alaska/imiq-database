USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgPrecip]    Script Date: 09/04/2014 10:40:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE view [dbo].[ANNUAL_AvgPrecip] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID, 
SUM(MonthlyTotal) as DataValue,
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
701 as OriginalVariableID, 
703 as VariableID
from MONTHLY_Precip_ALL
where month in (12,1,2,3,4,5,6,7,8,9,10,11) and MonthlyTotal is not null
group by SiteID,year
having COUNT(*) = 12;






GO

