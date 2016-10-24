
declare site_loop_cursor cursor for
select distinct siteid from seriescatalog_62;

open site_loop_cursor;
fetch next from site_loop_cursor into @siteid;
while @@fetch_status = 0
begin

  select @begindatetime = ltrim(str(year(min(v.localdatetime))))+'-'+ right('0' + cast(month(min(v.localdatetime)) as varchar), 2) +'-'+right('0' + cast(day(min(v.localdatetime)) as varchar), 2),
         @enddatetime= ltrim(str(year(max(v.localdatetime))))+'-'+ right('0' + cast(month(max(v.localdatetime)) as varchar), 2) +'-'+right('0' + cast(day(max(v.localdatetime)) as varchar), 2)
  from datavalues v
  inner join datastreams d on v.datastreamid=d.datastreamid
  where v.datastreamid in (select datastreamid from seriescatalog_62 where siteid=@siteid)
  group by d.siteid,utcoffset

  select @geolocation=geolocation
  from sites
  where siteid=@siteid
  
  insert into sites_summary (siteid,geolocation,begindate,enddate) values(@siteid,@geolocation,@begindatetime,@enddatetime)
  
fetch next from site_loop_cursor into @siteid;
end;
close loop_cursor;
deallocate loop_cursor;