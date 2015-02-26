use IARCOD

select p.SiteID,AVG(SeasonalAvg) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgFallPrecip
from Annual_AvgFallPrecip_ALL as p
group by p.SiteID