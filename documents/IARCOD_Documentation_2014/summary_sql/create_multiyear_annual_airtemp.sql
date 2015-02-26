
select a.SiteID,AVG(DataValue) as AvgAnnual,COUNT(*) as totalYears
into MULTIYEAR_ANNUAL_ALL_AvgAirTemp
from ANNUAL_AvgAirTemp as a
group by a.SiteID