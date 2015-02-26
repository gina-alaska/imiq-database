USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSpringPrecip_ALL]    Script Date: 09/04/2014 10:41:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[ANNUAL_AvgSpringPrecip_ALL] as
select p.SiteID,year,AVG(MonthlyTotal) as SeasonalAvg
from MONTHLY_Precip_ALL p
where month in (3,4,5) and MonthlyTotal is not null
group by p.SiteID,year
having COUNT(*) = 3;












GO

