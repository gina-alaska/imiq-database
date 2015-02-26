use IARCOD
select p.SiteID,AVG(DataValue) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgDischarge
from ANNUAL_AvgDischarge as p
group by p.SiteID