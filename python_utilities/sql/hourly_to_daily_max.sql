--select * from tables.datastreams where variableid = 81
--select * from tables.datavalues where datastreamid = 18016
select date_trunc('day',LocalDateTime), MAX(DataValue) from tables.odmdatavalues_metric 
	WHERE siteid = 907 and originalvariableid = 81 group by date_trunc('day',LocalDateTime) order by date_trunc('day',LocalDateTime)
--select date_trunc('day',datetimeutc), MAX(DataValue) from tables.odmdatavalues_metric 
--	WHERE siteid = 907 and originalvariableid = 81 group by date_trunc('day',datetimeutc) order by date_trunc('day',datetimeutc)