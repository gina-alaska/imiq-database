select D_AT1.SiteID as SiteID,D_AT1.DateTimeUTC as DateTimeUTC,D_AT1.DataValue as AT1,D_AT3.AT3, D_RH1.RH1, D_RH3.RH3
from ODMDataValues_metric D_AT1
left outer join
(select SiteID,DateTimeUTC,DataValue as AT3
from ODMDatavalues_metric
where OriginalVariableID=466 and OffsetValue=3) AS D_AT3
on D_AT1.SiteID=D_AT3.SiteID and D_AT1.DateTimeUTC=D_AT3.DateTimeUTC
left outer join
(select SiteID,DateTimeUTC,DataValue as RH1
from ODMDataValues_metric
where OriginalVariableID=467 and OffsetValue=1 ) as D_RH1
 on D_RH1.SiteID=D_AT1.SiteID and D_RH1.DateTimeUTC=D_AT1.DateTimeUTC
left outer join
(select SiteID,DateTimeUTC,DataValue as RH3
from ODMDataValues_metric
where OriginalVariableID=467 and OffsetValue=3 ) as D_RH3
 on D_RH3.SiteID=D_AT3.SiteID and D_RH3.DateTimeUTC=D_AT3.DateTimeUTC
where D_AT1.SiteID in (select siteid from sites where sourceid in (145)) and D_AT1.OriginalVariableID=466 and D_AT1.OffsetValue=1
union
select D_AT3.SiteID as SiteID,D_AT3.DateTimeUTC as DateTimeUTC,D_AT1.AT1 as AT1,D_AT3.DataValue as AT3, D_RH1.RH1, D_RH3.RH3
from ODMDataValues_metric D_AT3
left outer join
(select SiteID,DateTimeUTC,DataValue as AT1
from ODMDatavalues_metric
where OriginalVariableID=466 and OffsetValue=1) AS D_AT1
on D_AT3.SiteID=D_AT1.SiteID and D_AT3.DateTimeUTC=D_AT1.DateTimeUTC
left outer join
(select SiteID,DateTimeUTC,DataValue as RH1
from ODMDataValues_metric
where OriginalVariableID=467 and OffsetValue=1 ) as D_RH1
 on D_RH1.SiteID=D_AT1.SiteID and D_RH1.DateTimeUTC=D_AT1.DateTimeUTC
left outer join
(select SiteID,DateTimeUTC,DataValue as RH3
from ODMDataValues_metric
where OriginalVariableID=467 and OffsetValue=3 ) as D_RH3
 on D_RH3.SiteID=D_AT3.SiteID and D_RH3.DateTimeUTC=D_AT3.DateTimeUTC
where D_AT3.SiteID in (select siteid from sites where sourceid in(145)) and D_AT3.OriginalVariableID=466 and D_AT3.OffsetValue=3
order by D_AT1.SiteID,D_AT1.DateTimeUTC