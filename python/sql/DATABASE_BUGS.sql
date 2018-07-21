--select * from tables.hourly_precip where siteid = 15710 
--select * from tables.daily_airtemp where siteid in (select siteid from tables.sites where sourceid between 248 and 258) limit 10 
--select * from tables.sources
--select * from tables.datastreams where siteid in (select siteid from tables.sites where sourceid between 248 and 258)
--select * from tables.datavalues where datastreamid in (select datastreamid from tables.datastreams where siteid = 14929)
--select * from tables.datavalues where datastreamid in (select datastreamid from tables.datastreams where siteid in (select siteid from tables.sites where sourceid = 254)) limit 10
--select siteid from tables.sites where sourceid = 254 order by siteid
--select * from tables.datavalues where datastreamid in (select datastreamid from tables.datastreams where siteid between 14919 and 14950 ) limit 10
select * from tables.datastreams where siteid between 14919 and 14950 order by datastreamid 
--select * from tables.datavalues where datastreamid between 36238 and 36730 