use IARCOD
select p.SiteID,AVG(DataValue) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgPeakSnowDepth
from ANNUAL_PeakSnowDepth as p
group by p.SiteID