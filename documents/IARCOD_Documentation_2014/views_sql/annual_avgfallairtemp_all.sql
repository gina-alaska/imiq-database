USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgFallAirTemp_ALL]    Script Date: 09/04/2014 10:39:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE view [dbo].[ANNUAL_AvgFallAirTemp_ALL] as
select a.SiteID,year,AVG(MonthlyAvg) as SeasonalAvg
from MONTHLY_AirTemp_ALL a
where month between 9 and 11 and MonthlyAvg is not null
group by SiteID,year
having COUNT(*) = 3;






GO

