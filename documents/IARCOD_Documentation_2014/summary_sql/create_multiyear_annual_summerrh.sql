/****** Script for SelectTopNRows command from SSMS  ******/
/*
creSeasonalAvgATeWinterSeasonalAvgRH.sql
This query will calculSeasonalAvgATe the average winter relSeasonalAvgATive humidity, winter being 12(yyyy-1),1(yyyy),2(yyyy)
*/

INSERT INTO MULTIYEAR_ANNUAL_ALL_AvgSummerRH (SiteID, AvgAnnual,totalYears) SELECT SiteID, 
	       (0.611 * EXP((17.3 * AVG((LOG((0.611*(EXP((17.3*SeasonalAvgAT)/(SeasonalAvgAT+237.3))))*SeasonalAvgRH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*SeasonalAvgAT)/(SeasonalAvgAT+237.3))))*SeasonalAvgRH/100))))
	       /(AVG((LOG((0.611*(EXP((17.3*SeasonalAvgAT)/(SeasonalAvgAT+237.3))))*SeasonalAvgRH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*SeasonalAvgAT)/(SeasonalAvgAT+237.3))))*SeasonalAvgRH/100))) + 237.3))) 
	       / (0.611 * EXP((17.3 * AVG(SeasonalAvgAT))
	       /(AVG(SeasonalAvgAT) + 237.3))) * 100.0 as AvgAnnual,COUNT(*) as totalYears

from ANNUAL_AvgSummerRH_ALL
group by SiteID;
