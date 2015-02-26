/****** Script for SelectTopNRows command from SSMS  ******/
/*
createWinterRH.sql
This query will calculate the average winter relative humidity, winter being 12(yyyy-1),1(yyyy),2(yyyy)
*/
DECLARE @yearNum AS int = 1902;
WHILE @yearNum <= 2014
BEGIN


INSERT INTO ANNUAL_AvgWinterRH_ALL (SiteID, year, SeasonalAvgRH,SeasonalAvgAT) SELECT SiteID,@yearNum, 
	       (0.611 * EXP((17.3 * AVG((LOG((0.611*(EXP((17.3*AT)/(AT+237.3))))*RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*AT)/(AT+237.3))))*RH/100))))
	       /(AVG((LOG((0.611*(EXP((17.3*AT)/(AT+237.3))))*RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*AT)/(AT+237.3))))*RH/100))) + 237.3))) 
	       / (0.611 * EXP((17.3 * AVG(AT))
	       /(AVG(AT) + 237.3))) * 100.0 as SeasonalAvgRH, AVG(AT) as SeasonalAvgAT

from MONTHLY_RH_ALL
where ((month=12 and year=@yearNum - 1) or
  (month in (1,2) and year=@yearNum))
group by SiteID
having COUNT(*) = 3;

SET @yearNum = @yearNum+1
END