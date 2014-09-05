use IARCOD

select p.SiteID,AVG(SeasonalAvg) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgSummerPrecip
from Annual_AvgSummerPrecip_ALL as p
group by p.SiteID