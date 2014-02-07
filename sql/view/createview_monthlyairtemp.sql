USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_AirTemp]    Script Date: 02/07/2014 11:16:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[MONTHLY_AirTemp] as
select d.SiteID,s.sitename,year(utcdatetime) as year, MONTH(utcdatetime) as month, avg(datavalue) as MonthlyAvg,COUNT(*) as total
from Daily_AirTemp d
inner join sites s on d.siteid = s.siteid
group by d.SiteID,sitename,year(UTCDateTime), MONTH(utcdatetime)
having COUNT(*) >= 10;






GO

