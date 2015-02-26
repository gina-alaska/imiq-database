use IARCOD
insert into DAILY_RHDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate) 
select MRH.RH as DataValue, CONVERT(Date,UTCDateTime) as UTCDateTime, MRH.Siteid, 679 as OriginalVariableID,GETDATE() as InsertDate
from
(select RH.Siteid, CONVERT(Date,UTCDateTime) as UTCDateTime,RH.RH,rh.AT as AT, RH.total
from
(SELECT d.SiteID,CONVERT(Date,UTCDateTime) as UTCDateTime, AVG(d.AT) as AT,
	       (0.611 * EXP((17.3 * AVG((LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100))))
	       /(AVG((LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100))) + 237.3))) 
	       / (0.611 * EXP((17.3 * AVG(d.AT))
	       /(AVG(d.AT) + 237.3))) * 100.0 as RH, COUNT(*) as total
from
(select AT.SiteID as SiteID,CONVERT(Date,AT.UTCDateTime) as UTCDateTime,AT.DataValue as AT,RH.DataValue as RH
from HOURLY_AirTemp AT
left outer join
(select SiteID,CONVERT(Date,UTCDateTime) as UTCDateTime,DataValue
from HOURLY_RH
where VariableID=679) AS RH  
on AT.SiteID=RH.SiteID and AT.UTCDateTime=RH.UTCDateTime
where AT.SiteID in (select siteid from sites where sourceid in(35)) and AT.VariableID=677
  and AT.DataValue is not null and RH.DataValue is not null ) as d
group by d.SiteID,d.UTCDateTime) as RH
) as MRH;