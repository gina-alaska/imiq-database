create view monthly_airtemp as

	select 	d.siteid,
				s.sitename,year(utcdatetime) as year, 
				month(utcdatetime) as month, 
				avg(datavalue) as monthlyavg,
				count(*) as total
	from 		daily_airtemp d
	inner join sites s on d.siteid = s.siteid
	group by d.siteid,sitename,year(utcdatetime), month(utcdatetime)
	having count(*) >= 10;

