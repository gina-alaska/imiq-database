USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_AirTemp_ALL]    Script Date: 09/04/2014 10:52:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










CREATE view [dbo].[MONTHLY_AirTemp_ALL] as
select d.SiteID,year(utcdatetime) as year, MONTH(utcdatetime) as month, avg(datavalue) as MonthlyAvg,COUNT(*) as total
from Daily_AirTemp d
group by d.SiteID,year(UTCDateTime), MONTH(utcdatetime)
having COUNT(*) >= 10;









GO

