

-- =============================================
-- author: amy jacobs
-- create date: june 1, 2013
-- updated 10-17-2013: inserted column 'insertdate' so that it i could tell when the summary had been created. asj
-- description: create the hourly air temperatures at 2m.
-- this stored procedure is sending the data to a temp table for the hourly_airtempdatavalues, which will be range restricted with views or used
-- to create daily, monthly, seasonal and yearly summaries.
-- =============================================


create or replace function uspgethourlyairtemp (int,int) returns void
as '
begin


	declare @datetimeutc datetime, 
				@maxvalue float,
    			@minvalue float, 
    			@avgvalue float,
    			@avgvalue1m float,
    			@avgvalue3m float, 
    			@maxvalue1m float, 
    			@maxvalue3m float,
    			@minvalue1m float, 
    			@minvalue3m float,
    			@qualifierid int;

    -- ish
    -- variableid = 218 is ish average air temp hourly. sourceid = 209
    if exists (select * from seriescatalog_62 where siteid= @siteid and variableid=218)
    begin
		declare max_cursor cursor for
			select 	dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
			from 		odmdatavalues_metric as dv
			inner join seriescatalog_62 sc on sc.siteid = dv.siteid
			where sc.siteid = @siteid and dv.originalvariableid=218
			group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));
        
		open max_cursor;
		fetch next from max_cursor into @datetimeutc, @avgvalue;

		while @@fetch_status = 0
		begin
			insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
			values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
			fetch next from max_cursor into @datetimeutc, @avgvalue;
      end
		close max_cursor;
		deallocate max_cursor;
	end


    -- uaf/werc: temp/hourly/c, ast
    -- variableid = 81. sourceid = 29, 30, 31, 34
    -- need to make sure offset is 2m or 1.5m
    else if exists (select * from odmdatavalues_metric where siteid= @siteid and originalvariableid=81 and (offsetvalue = 2 or offsetvalue = 1.5))
    begin
		declare max_cursor cursor for
			select 	dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
			from 		odmdatavalues_metric as dv
			where 	dv.siteid = @siteid 
			and 		dv.originalvariableid=81 
			and 		(dv.offsetvalue = 2 or dv.offsetvalue = 1.5) 
			and 		dv.siteid in
						(select distinct siteid 
						from 	odmdatavalues_metric 
						where @siteid = siteid)
			group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
				values(@avgvalue, @datetimeutc,@siteid,@varid, getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
        end
			close max_cursor;
			deallocate max_cursor;
    end
    -- uaf/werc: temp/hourly/c, ast
    -- variableid = 81. needs to be converted to a daily value. sourceid = 29, 30, 31, 34
    -- need to convert 1m and 3m to 2m
    -- need to convert to utcdatetime
    if exists (select * from odmdatavalues_metric where siteid= @siteid and originalvariableid=81 and offsetvalue = 1)
     begin
          declare max_cursor cursor for
					select 	dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
              	from 		odmdatavalues_metric as dv
              	where 	dv.siteid = @siteid 
              	and 		dv.originalvariableid=81 
              	and 		dv.offsetvalue = 1 
              	and 		dv.siteid in
              				(select distinct siteid 
              				from 		odmdatavalues_metric 
              				where @siteid = siteid)
					group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));
              
          	open max_cursor;
            fetch next from max_cursor into @datetimeutc, @avgvalue1m;
              
              while @@fetch_status = 0
              begin
              		select 	@avgvalue3m = avg(dv.datavalue)
                  from 		odmdatavalues_metric as dv
                  where 	dv.siteid = @siteid 
                  and 		dv.originalvariableid=81 
                  and 		dv.offsetvalue = 3
                  and 		@datetimeutc = dateadd(hh, datepart(hh, dv.datetimeutc), dateadd(d, datediff(d, 0, dv.datetimeutc), 0)) and dv.siteid in
                        	(select distinct siteid from odmdatavalues_metric where @siteid = siteid);
                      		--select @avgvalue = (@avgvalue3m - @avgvalue1m)/2 + @avgvalue1m;
                      		-- if the 2m average temp is null, check and see if there is a 1m air temp and use it.
                  if (@avgvalue3m is not null and @avgvalue1m is not null)
                  begin
                  		select @avgvalue = (@avgvalue3m - @avgvalue1m)*.5 + @avgvalue1m;
                  end
                  else if (@avgvalue3m is null and @avgvalue1m is not null)
                  begin
                       select @avgvalue = @avgvalue1m;
                  end
                  else
                   begin
                       select @avgvalue = null
                   end
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
                      fetch next from max_cursor into @datetimeutc, @avgvalue1m;
               end

close max_cursor;
deallocate max_cursor;
    end
    -- usgs: temp/hourly/c, ast
    -- variableid = 310. sourceid = 39
    -- no offset value is given
    else if exists (select * from seriescatalog_62 where siteid= @siteid and variableid=310)
    begin
declare max_cursor cursor for
select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
from odmdatavalues_metric as dv
where dv.siteid = @siteid and dv.originalvariableid=310 and dv.siteid in
(select distinct siteid from seriescatalog_62 where @siteid = siteid)
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));

open max_cursor;
fetch next from max_cursor into @datetimeutc, @avgvalue;

while @@fetch_status = 0
begin
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
fetch next from max_cursor into @datetimeutc, @avgvalue;
        end

close max_cursor;
deallocate max_cursor;

    end
    -- blm/kemenitz. temp/c/hourly sourceid = 199
    -- variableid = 442 avg at
    else if exists (select * from seriescatalog_62 where siteid = @siteid and @varid=442)
    begin
declare max_cursor cursor for
select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
from odmdatavalues_metric as dv
where dv.siteid = @siteid and dv.originalvariableid=442 and dv.siteid in
(select distinct siteid from seriescatalog_62 where @siteid = siteid)
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));

open max_cursor;
fetch next from max_cursor into @datetimeutc, @avgvalue;

while @@fetch_status = 0

begin
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
             fetch next from max_cursor into @datetimeutc, @avgvalue;
        end

close max_cursor;
deallocate max_cursor;
end
    -- blm/kemenitz. temp/c/minute sourceid = 199
    -- variableid = 504 avg at
    -- need to compute hourly average
    else if exists (select * from seriescatalog_62 where siteid = @siteid and @varid=504)
    begin
declare max_cursor cursor for
select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
from odmdatavalues_metric as dv
where dv.siteid = @siteid and dv.originalvariableid=504 and dv.siteid in
(select distinct siteid from seriescatalog_62 where @siteid = siteid)
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));

open max_cursor;
fetch next from max_cursor into @datetimeutc, @avgvalue;

while @@fetch_status = 0
begin
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
fetch next from max_cursor into @datetimeutc, @avgvalue;
        end

close max_cursor;
deallocate max_cursor;

    end
    -- arm. temp/c/minute sourceid = 35
    -- variableid = 519 avg at
    -- need to compute hourly average
    else if exists (select * from odmdatavalues_metric where siteid = @siteid and originalvariableid=519)
    begin
declare max_cursor cursor for
select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
        from odmdatavalues_metric as dv
        where dv.siteid = @siteid and dv.originalvariableid=519
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));
        
open max_cursor;
fetch next from max_cursor into @datetimeutc, @avgvalue;

while @@fetch_status = 0

begin
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
fetch next from max_cursor into @datetimeutc, @avgvalue;
        end

close max_cursor;
deallocate max_cursor;

    end
    -- arm. temp/c/minute sourceid = 202,203
    -- variableid = 527 avg at
    else if exists (select * from odmdatavalues_metric where siteid = @siteid and @varid=527)
    begin
declare max_cursor cursor for
select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
        from odmdatavalues_metric as dv
        where dv.siteid = @siteid and dv.originalvariableid=@varid
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));
        
open max_cursor;
fetch next from max_cursor into @datetimeutc, @avgvalue;

while @@fetch_status = 0

begin
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
fetch next from max_cursor into @datetimeutc, @avgvalue;
        end

close max_cursor;
deallocate max_cursor;
    end
    -- arm. temp/c/second sourceid = 203
    -- variableid = 538 avg at
    else if exists (select * from odmdatavalues_metric where siteid = @siteid and @varid=538)
    begin
declare max_cursor cursor for
select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
        from odmdatavalues_metric as dv
        where dv.siteid = @siteid and dv.originalvariableid=@varid
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));

open max_cursor;
fetch next from max_cursor into @datetimeutc, @avgvalue;

while @@fetch_status = 0

begin
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
fetch next from max_cursor into @datetimeutc, @avgvalue;
        end

close max_cursor;
deallocate max_cursor;
    end
     -- lpeters. temp/c/hourly sourceid = 182
    -- variableid = 279 avg at
    else if exists (select * from seriescatalog_62 where siteid = @siteid and @varid=279)
      begin
declare max_cursor cursor for
select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
        from odmdatavalues_metric as dv
        where dv.siteid = @siteid and dv.originalvariableid=@varid
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));
        
open max_cursor;
fetch next from max_cursor into @datetimeutc, @avgvalue;

while @@fetch_status = 0

begin
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
fetch next from max_cursor into @datetimeutc, @avgvalue;
        end

close max_cursor;
deallocate max_cursor;
    end
   -- lpeters. temp/c/hourly sourceid = 182
    -- variableid = 288 avg at
    else if exists (select * from seriescatalog_62 where siteid = @siteid and @varid=288)
      begin
declare max_cursor cursor for
select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
        from odmdatavalues_metric as dv
        where dv.siteid = @siteid and dv.originalvariableid=@varid
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));
        
open max_cursor;
fetch next from max_cursor into @datetimeutc, @avgvalue;

while @@fetch_status = 0

begin
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
fetch next from max_cursor into @datetimeutc, @avgvalue;
        end

close max_cursor;
deallocate max_cursor;
    end
     -- rwis. temp/c/hourly sourceid = 213
    -- variableid = 563 avg at
    else if exists (select * from seriescatalog_62 where siteid = @siteid and @varid=563)
      begin
declare max_cursor cursor for
select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
        from odmdatavalues_metric as dv
        where dv.siteid = @siteid and dv.originalvariableid=@varid
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));
        
open max_cursor;
fetch next from max_cursor into @datetimeutc, @avgvalue;

while @@fetch_status = 0

begin
insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
fetch next from max_cursor into @datetimeutc, @avgvalue;
        end

close max_cursor;
deallocate max_cursor;
    end
    -- toolik temp/hourly/c, ast
    -- variableid = 466, sourceid = 145
    -- need to calculate 2m at by using 1m and 3m at
  else if exists (select * from seriescatalog_62 where siteid= @siteid and variableid=466)
  begin
          declare max_cursor cursor for
          select dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0)) as datetimeutc,avg(dv.datavalue)
              from odmdatavalues_metric as dv
              where dv.siteid = @siteid and dv.originalvariableid=466 and dv.offsetvalue = 1 and dv.siteid in
              (select distinct siteid from seriescatalog_62 where @siteid = siteid)
group by dateadd(hh, datepart(hh, datetimeutc), dateadd(d, datediff(d, 0, datetimeutc), 0));
              
          open max_cursor;
              fetch next from max_cursor into @datetimeutc, @avgvalue1m;
              
              while @@fetch_status = 0
              begin
                      select @avgvalue3m = avg(dv.datavalue)
                      from odmdatavalues_metric as dv
                      where dv.siteid = @siteid and dv.originalvariableid=466 and dv.offsetvalue = 3
                            and @datetimeutc = dateadd(hh, datepart(hh, dv.datetimeutc), dateadd(d, datediff(d, 0, dv.datetimeutc), 0)) and dv.siteid in
                        (select distinct siteid from seriescatalog_62 where @siteid = siteid);
                      select @avgvalue = (@avgvalue3m - @avgvalue1m)*.5 + @avgvalue1m;
                      -- if the 2m average temp is null, check and see if there is a 1m air temp and use it.
                      if (@avgvalue is null and @avgvalue1m is not null)
                      begin
                       select @avgvalue = @avgvalue1m;
                      end

insert into hourly_airtempdatavalues (datavalue,utcdatetime, siteid,originalvariableid,insertdate)
values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
fetch next from max_cursor into @datetimeutc, @avgvalue;
                 end

               close max_cursor;
              deallocate max_cursor;
 
end 

end



end;
' language 'plpgsql';