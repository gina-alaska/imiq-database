use IARCOD
select p.SiteID,AVG(DataValue) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgWinterAirTemp
from ANNUAL_AvgWinterAirTemp as p
group by p.SiteID