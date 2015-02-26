use IARCOD
select MRH.Siteid as SiteID, MRH.RH as RH, MRH.AT as AT, total as totalYears into 
MULTIYEAR_ANNUAL_ALL_AvgRH
from
(select RH.Siteid, RH.RH,rh.AT as AT, RH.total
from
(SELECT d.SiteID,AVG(d.AT) as AT,
	       (0.611 * EXP((17.3 * AVG((LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100))))
	       /(AVG((LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*d.AT)/(d.AT+237.3))))*d.RH/100))) + 237.3))) 
	       / (0.611 * EXP((17.3 * AVG(d.AT))
	       /(AVG(d.AT) + 237.3))) * 100.0 as RH, COUNT(*) as total
from
(select SiteID,AT,RH
from ANNUAL_AvgRH_ALL
) as d
group by d.SiteID) as RH
) as MRH;