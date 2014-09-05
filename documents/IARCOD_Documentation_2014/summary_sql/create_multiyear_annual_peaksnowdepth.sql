use IARCOD
select p.SiteID,AVG(DataValue) as AvgAnnualTotal,COUNT(*) as totalYears
into MULTIYEAR_AnnualPeakSnowDepth_ALL_Avg
from ANNUAL_PeakSnowDepth as p
group by p.SiteID