use IARCOD
insert into MONTHLY_RH_ALL (SiteID,year,month,RH,AT,total) 
select MRH.Siteid, MRH.year,MRH.month,MRH.RH, MRH.AT,MRH.total
from
(select RH.Siteid, RH.year,RH.month,RH.RH,rh.AT as AT, RH.total
from
(SELECT d.SiteID,year(d.utcdatetime) as year, month(d.UTCDateTime) as month, AVG(d.AT) as AT,
	       (0.611 * EXP((17.3 * AVG((LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100))))
	       /(AVG((LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100))) + 237.3))) 
	       / (0.611 * EXP((17.3 * AVG(d.AT))
	       /(AVG(d.AT) + 237.3))) * 100.0 as RH, COUNT(*) as total
from
(select AT.SiteID as SiteID,AT.UTCDateTime,AT.DataValue as AT,RH.DataValue as RH
from DAILY_AirTemp AT
left outer join
(select SiteID,UTCDateTime,DataValue
from DAILY_RH
where OriginalVariableID=467) AS RH
on AT.SiteID=RH.SiteID and AT.UTCDateTime=RH.UTCDateTime
where AT.SiteID in (select siteid from sites where sourceid in(145)) and AT.OriginalVariableID=489
  and AT.DataValue is not null and RH.DataValue is not null ) as d
group by d.SiteID,year(d.UTCDateTime), MONTH(d.UTCDateTime)
having COUNT(*) >=10) as RH
) as MRH;