create view daily_airtemp as

select	v.valueid as valueid,
	v.datavalue as datavalue,
	v.utcdatetime as utcdatetime,
	v.siteid as siteid,
	v.originalvariableid as variableid,
	s.sourceid as sourceid
from 	tables.daily_airtempdatavalues v
inner join tables.sites s on v.siteid = s.siteid
where 	(v.datavalue >= -62.22 and v.datavalue <= 46.11) and v.datavalue is not null -- -80f <= datavalue < 115f
group by v.valueid,
	 v.datavalue,
	 v.utcdatetime,
	 v.siteid,
	 v.originalvariableid,
	 s.sourceid;

