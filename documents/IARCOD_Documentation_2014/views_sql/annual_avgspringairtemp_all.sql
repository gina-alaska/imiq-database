USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSpringAirTemp_ALL]    Script Date: 09/04/2014 10:41:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[ANNUAL_AvgSpringAirTemp_ALL] as
select a.SiteID,year,AVG(MonthlyAvg) as SeasonalAvg
from MONTHLY_AirTemp_ALL a
where month in (3,4,5) and MonthlyAvg is not null
group by SiteID,year
having COUNT(*) = 3;














GO

