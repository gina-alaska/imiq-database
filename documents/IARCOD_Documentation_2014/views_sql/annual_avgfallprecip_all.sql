USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgFallPrecip_ALL]    Script Date: 09/04/2014 10:40:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE view [dbo].[ANNUAL_AvgFallPrecip_ALL] as
select p.SiteID,year,AVG(MonthlyTotal) as SeasonalAvg
from MONTHLY_Precip_ALL p
where month between 9 and 11 and MonthlyTotal is not null
group by p.SiteID,year
having COUNT(*) = 3;











GO

