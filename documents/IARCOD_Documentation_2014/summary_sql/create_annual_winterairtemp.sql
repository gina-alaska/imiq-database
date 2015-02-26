/****** Script for SelectTopNRows command from SSMS  ******/
use IARCOD

DECLARE @yearNum AS int = 1895;
DECLARE @SeasonalAvg AS float = NULL;
WHILE @yearNum <= 2014
BEGIN


INSERT INTO ANNUAL_AvgWinterAirTemp_ALL (SiteID, year, SeasonalAvg) select SiteID, @yearNum, AVG(MonthlyAvg)
from MONTHLY_AirTemp_ALL
where ((month=12 and year=@yearNum - 1) or
  (month in (1,2) and year=@yearNum))
group by SiteID
having COUNT(*) = 3;

SET @yearNum = @yearNum+1
END