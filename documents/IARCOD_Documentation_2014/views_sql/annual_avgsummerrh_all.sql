USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgSummerRH_ALL]    Script Date: 09/04/2014 10:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[ANNUAL_AvgSummerRH_ALL] as
SELECT SiteID,year, 
	       (0.611 * EXP((17.3 * AVG((LOG((0.611*(EXP((17.3*AT)/(AT+237.3))))*RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*AT)/(AT+237.3))))*RH/100))))
	       /(AVG((LOG((0.611*(EXP((17.3*AT)/(AT+237.3))))*RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*AT)/(AT+237.3))))*RH/100))) + 237.3))) 
	       / (0.611 * EXP((17.3 * AVG(AT))
	       /(AVG(AT) + 237.3))) * 100.0 as SeasonalAvgRH, AVG(AT) as SeasonalAvgAT
from
MONTHLY_RH_ALL
where month in (6,7,8) 
group by SiteID,year
having COUNT(*) = 3;














GO

