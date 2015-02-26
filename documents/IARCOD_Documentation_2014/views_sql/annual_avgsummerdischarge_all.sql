USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSummerDischarge_ALL]    Script Date: 09/04/2014 10:43:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[ANNUAL_AvgSummerDischarge_ALL] as
select SiteID,year,AVG(MonthlyAvg) as SeasonalAvg
from MONTHLY_Discharge_ALL
where month between 6 and 8 and MonthlyAvg is not null
group by SiteID,year
having COUNT(*) = 3;













GO

