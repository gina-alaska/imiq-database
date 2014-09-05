USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSummerAirTemp_ALL]    Script Date: 09/04/2014 10:42:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[ANNUAL_AvgSummerAirTemp_ALL] as
select a.SiteID,year,AVG(MonthlyAvg) as SeasonalAvg
from MONTHLY_AirTemp_ALL a
where month in (6,7,8) 
group by SiteID,year
having COUNT(*) = 3;














GO

