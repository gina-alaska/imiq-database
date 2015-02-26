USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_Discharge_ALL]    Script Date: 09/04/2014 10:52:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[MONTHLY_Discharge_ALL] as
select p.SiteID,YEAR(utcdatetime) as year, MONTH(utcdatetime) as month, AVG(datavalue) as MonthlyAvg,COUNT(*) as total
from DAILY_Discharge p
group by p.SiteID,year(UTCDateTime), MONTH(utcdatetime)
having COUNT(*) >= 10;













GO

