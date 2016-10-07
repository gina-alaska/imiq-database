use IARCOD
select p.SiteID,AVG(SeasonalAvg) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgSummerAirTemp
from Annual_AvgSummerAirTemp_ALL as p
inner join dbo.Sites s on s.SiteID = p.SiteID
group by p.SiteID