use IARCOD
select p.SiteID,AVG(DataValue) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgPeakSWE
from ANNUAL_PeakSWE as p
group by p.SiteID