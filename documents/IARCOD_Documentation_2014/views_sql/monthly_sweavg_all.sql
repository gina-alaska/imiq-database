USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_SWEAvg_ALL]    Script Date: 09/04/2014 10:54:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[MONTHLY_SWEAvg_ALL] as
select p.SiteID,YEAR(utcdatetime) as year, MONTH(utcdatetime) as month, AVG(datavalue) as MonthlyAvg,COUNT(*) as total
from DAILY_SWE p
inner join sites s on p.siteid = s.siteid
group by p.SiteID,year(UTCDateTime), MONTH(utcdatetime)
having COUNT(*) >= 1;












GO

