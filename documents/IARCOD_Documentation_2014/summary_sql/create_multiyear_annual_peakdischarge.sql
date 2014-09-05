use IARCOD
select p.SiteID,AVG(DataValue) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgPeakDischarge
from ANNUAL_PeakDischarge as p
group by p.SiteID