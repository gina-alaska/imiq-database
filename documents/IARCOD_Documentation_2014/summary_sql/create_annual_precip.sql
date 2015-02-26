USE [IARCOD]

select SiteID,year, DataValue 
into ANNUAL_TotalPrecip_ALL
from
(select SiteID,year,SUM(MonthlyTotal) as DataValue 
from MONTHLY_Precip_ALL
where month in (12,1,2,3,4,5,6,7,8,9,10,11) and MonthlyTotal is not null
group by SiteID,year
having COUNT(*) = 12) as d;

GO


