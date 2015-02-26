USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_Precip_ALL]    Script Date: 09/04/2014 10:53:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[MONTHLY_Precip_ALL] as
select p.SiteID,YEAR(utcdatetime) as year, MONTH(utcdatetime) as month, SUM(datavalue) as MonthlyTotal,COUNT(*) as total
from DAILY_Precip p
group by p.SiteID,year(UTCDateTime), MONTH(utcdatetime)
having COUNT(*) >= 10;








GO

