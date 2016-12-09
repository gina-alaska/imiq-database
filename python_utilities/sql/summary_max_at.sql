--select * from tables.variables where lower(variablename) like 'temperature' and lower(samplemedium) like 'air' and timeunitsid in (102,103)

-- select * from tables.variables where variableid between 1032 and 1045
--select * from tables.variables where variableid < 100
--select * from tables.datastreams where variableid = 1032

select date_trunc('day', localdatetime), max(datavalue) from tables.datavalues where datastreamid = 33413 group by localdatetime order by date_trunc('day', localdatetime)