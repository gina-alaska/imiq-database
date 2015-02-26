use IARCOD

select p.SiteID,AVG(DataValue) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgWinterPrecip
from ANNUAL_AvgWinterPrecip as p
group by p.SiteID