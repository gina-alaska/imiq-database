use IARCOD
select p.SiteID,AVG(DataValue) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgPrecip
from ANNUAL_TotalPrecip as p
group by p.SiteID