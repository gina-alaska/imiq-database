use IARCOD

select p.SiteID,AVG(DataValue) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgSummerDischarge_ALL
from ANNUAL_AvgSummerDischarge as p
group by p.SiteID