use iarcod
;

/****** object:  storedprocedure uspgetdailyairtemp    script date: 02/20/2013 12:56:05 ******/
set ansi_nulls on
;

set quoted_identifier on
;



-- =============================================
-- author:		amy jacobs
-- create date: feb 16,2012
-- description:	create the daily air temperatures at 2m. 
-- updated: 8/2/2012 
-- updates: this stored procedure is sending the data to a temp table for the daily_airtempdatavalues, which will be used to calculate
-- monthly, yearly data values
-- =============================================
create procedure uspgetdailyairtemp 
	-- add the parameters for the stored procedure here
	@siteid int, @varid int
as
begin
	-- set nocount on added to prevent extra result sets from
	-- interfering with select statements.
	set nocount on;

	declare @localdatetime datetime, @maxvalue float,
    @minvalue float, @avgvalue float, @avgvalue1m float, @avgvalue3m float, @maxvalue1m float, @maxvalue3m float, @minvalue1m float, @minvalue3m float,
    @methodid int, @qualifierid int, @variableid int;
    
    -- ncdc ghcn.  sourceid = 4 
    -- variableid = 403 is tmax
    -- variableid = 404 is tmin
    if exists (select * from seriescatalog where siteid = @siteid and variableid=403)
    begin
	    declare max_cursor cursor for 
		select dv.localdatetime, dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=403;

		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=403;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @maxvalue;

	    while @@fetch_status = 0
	    begin
	        select @minvalue = dv.datavalue
	        from datavalues as dv
	        inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
	        where seriescatalog.siteid = @siteid and seriescatalog.variableid=404 and dv.localdatetime = @localdatetime;

		    select @avgvalue = ( @maxvalue - @minvalue ) / 2 + @minvalue;
		    
		    --if the avgvalue is null, but we have a max or a min value stored, use it
		    if(@avgvalue is null and @maxvalue is not null)
		    begin
				select @avgvalue = @maxvalue;
			end
			else if (@avgvalue is null and @minvalue is not null)
			begin
				select @avgvalue = @minvalue;
			end 
	        insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @maxvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- if there is no ghcn, check for ish
    -- variableid = 218 is ish average air temp hourly.  needs to be converted to a daily value.  sourceid = 4
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=218)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=218
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=218;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
     -- uaf/werc:  temp/hourly/c, ast
    -- variableid = 81. needs to be converted to a daily value.  sourceid = 29, 30, 31, 34
    -- need to make sure offset is 2m or 1.5m
    -- need to convert to utcdatetime
    else if exists (select * from odmdatavalues where siteid= @siteid and variableid=81 and (offsetvalue = 2 or offsetvalue = 1.5))
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=81 and (dv.offsetvalue = 2 or dv.offsetvalue = 1.5) and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=81;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  -- uaf/werc:  temp/hourly/c, ast
    -- variableid = 81. needs to be converted to a daily value.  sourceid = 29, 30, 31, 34
    -- need to convert 1m and 3m to 2m
    -- need to convert to utcdatetime
    else if exists (select * from odmdatavalues where siteid= @siteid and variableid=81 and offsetvalue = 1)
     begin
          declare max_cursor cursor for 
              select convert(date,dv.datetimeutc), avg(dv.datavalue)
              from odmdatavalues as dv
              where dv.siteid = @siteid and dv.variableid=81 and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriescatalog where @siteid = siteid)
              group by convert(date,dv.datetimeutc);
              
		      select @methodid = s.methodid, @variableid=s.variableid
		       from seriescatalog s
		       where s.siteid = @siteid and s.variableid=81;
          open max_cursor;
              fetch next from max_cursor into @localdatetime, @avgvalue1m;
              
              while @@fetch_status = 0
              begin
                      select @avgvalue3m = avg(dv.datavalue)
                      from odmdatavalues as dv
                      where dv.siteid = @siteid and dv.variableid=81 and dv.offsetvalue = 3 and @localdatetime = convert(date,dv.datetimeutc) and dv.siteid in 
                  (select distinct siteid from seriescatalog where @siteid = siteid);
                  select @avgvalue = (@avgvalue3m - @avgvalue1m)/2 + @avgvalue1m;
                  -- if the 2m average temp is null, check and see if there is a 1m air temp and use it.
                   if (@avgvalue is  null and @avgvalue1m is not null)
                   begin
                       select @avgvalue = @avgvalue1m;
                   end
	               insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	               values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
                  fetch next from max_cursor into @localdatetime, @avgvalue1m;
              end

	    close max_cursor;
		deallocate max_cursor;
end
    -- usgs:  temp/hourly/c, ast
    -- variableid = 310. needs to be converted to a daily value.  sourceid = 39
    -- no offset value is given
    -- need to convert to utcdatetime
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=310)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=310 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=310;
		
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
	        fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- raws/nps:  temp/daily/c, utc
    -- variableid = 432, sourceid = 114 and sourceid = 116
    -- no offset value is given
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=432)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=432;
		
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=432;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- snotel  temp/daily/c, utc
    -- variableid = 393, sourceid = 124
    -- no offset value is given
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=393)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=393;
		
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=393;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    
    -- toolik  temp/hourly/c, ast
    -- variableid = 489 (tmin), variableid = 487 (tmax), sourceid = 145
    -- need to calculate 2m at by using 1m and 3m at
    -- need to convert hourly to daily
    -- need to convert from ast to utc time
 else if exists (select * from seriescatalog where siteid= @siteid and variableid=489)
  begin
          declare max_cursor cursor for 
              select dv.localdatetime, dv.datavalue
              from odmdatavalues as dv
              where dv.siteid = @siteid and dv.variableid=489 and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriescatalog where @siteid = siteid);
            select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=489;
          open max_cursor;
              fetch next from max_cursor into @localdatetime, @minvalue1m;
              
              while @@fetch_status = 0
              begin
                      select @maxvalue1m = dv.datavalue
                      from odmdatavalues as dv
                      where dv.siteid = @siteid and dv.variableid=487 and dv.offsetvalue = 1 and @localdatetime = dv.localdatetime and dv.siteid in 
                  (select distinct siteid from seriescatalog where @siteid = siteid);
                  select @avgvalue1m = (@maxvalue1m - @minvalue1m)/2 + @minvalue1m;
                  
                  select @minvalue3m = dv.datavalue
                      from odmdatavalues as dv
                      where dv.siteid = @siteid and dv.variableid=489 and dv.offsetvalue = 3 and @localdatetime = dv.localdatetime and dv.siteid in 
                  (select distinct siteid from seriescatalog where @siteid = siteid);
                  
                   select @maxvalue3m = dv.datavalue
                      from odmdatavalues as dv
                      where dv.siteid = @siteid and dv.variableid=487 and dv.offsetvalue = 3 and @localdatetime = dv.localdatetime and dv.siteid in 
                  (select distinct siteid from seriescatalog where @siteid = siteid);
                  
                  select @avgvalue3m = (@maxvalue3m - @minvalue3m)/2 + @minvalue3m;
                  select @avgvalue = (@avgvalue3m - @avgvalue1m)/2 + @avgvalue1m;
                  
                  
                 -- if the 2m at avg is null, check and see if there is a 1m at and use that
                 if (@avgvalue is null and @avgvalue1m is not null)
                 begin
                    select @avgvalue = @avgvalue1m;
                  end
                 else if (@avgvalue1m is null and @maxvalue1m is not null)
                   begin
					 select @avgvalue = @maxvalue1m;
					end
			     else if (@avgvalue1m is null and @minvalue1m is not null)
					begin
						select @avgvalue = @minvalue1m;
					end;
	             insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	                values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
                 fetch next from max_cursor into @localdatetime, @minvalue1m;
      end

          close max_cursor;
              deallocate max_cursor;

  end
  
    -- mccall  temp/daily/f, ast
    -- variableid = 195 (tmax), variableid = 196 (tmin), sourceid = 178 and sourceid = 182
    -- need to convert to avg at
 else if exists (select * from seriescatalog where siteid= @siteid and @varid=195)
    begin
	    declare max_cursor cursor for 
		select dv.localdatetime, dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=195;
	    select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=195;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @maxvalue;

	    while @@fetch_status = 0
	    begin
	        select @minvalue = dv.datavalue
		    from datavalues as dv
		    inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		    where seriescatalog.siteid = @siteid and seriescatalog.variableid=196 and dv.localdatetime = @localdatetime;
		    select @avgvalue =  (@maxvalue - @minvalue ) / 2 + @minvalue;
		    
		    if (@avgvalue is null and @maxvalue is not null)
		    begin
				select @avgvalue = @maxvalue;
			end
			else if (@avgvalue is null and @minvalue is not null)
			begin
				select @avgvalue = @minvalue;
			end
		    select @avgvalue = (@avgvalue - 32) / 9 * 5;
			
	        insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @maxvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
-- mccall  temp/daily/c, ast
    -- variableid = 277, sourceid = 179
 else if exists (select * from seriescatalog where siteid= @siteid and variableid=277)
    begin
	    declare max_cursor cursor for 
		select dv.localdatetime, dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=277;
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=277;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	               insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	               values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
	               fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- uaf. temp/c/daily  sourceid = 180
    -- variableid = 223 is tmax
    -- variableid = 225 is tmin
    -- need to compute average.
    else if exists (select * from seriescatalog where siteid = @siteid and variableid=223)
    begin
	    declare max_cursor cursor for 
		select dv.localdatetime, dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=223;
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=223;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @maxvalue;

	    while @@fetch_status = 0
	    begin
	        select @minvalue = dv.datavalue
	        from datavalues as dv
	        inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
	        where seriescatalog.siteid = @siteid and seriescatalog.variableid=225 and dv.localdatetime = @localdatetime;
		    select @avgvalue = ( @maxvalue - @minvalue ) / 2 + @minvalue;
		    
		    if (@avgvalue is null and @maxvalue is not null)
		    begin
				select @avgvalue = @maxvalue;
			end
			else if (@avgvalue is null and @minvalue is not null)
			begin
				select @avgvalue = @minvalue;
			end
			
	        insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @maxvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
     -- chamberlin. temp/f/daily  sourceid = 183
    -- variableid = 295 is tmax
    -- variableid = 296 is tmin
    -- need to compute average.
    -- need to convert from f to c.
    else if exists (select * from seriescatalog where siteid = @siteid and variableid=295)
    begin
	    declare max_cursor cursor for 
		select dv.localdatetime, dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=295;

        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=295;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @maxvalue;

	    while @@fetch_status = 0
	    begin
	        select @minvalue = dv.datavalue
	        from datavalues as dv
	        inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
	        where seriescatalog.siteid = @siteid and seriescatalog.variableid=296 and dv.localdatetime = @localdatetime;
		    select @avgvalue = ( @maxvalue - @minvalue ) / 2 + @minvalue;
		    
		    if (@avgvalue is null and @maxvalue is not null)
		    begin
				select @avgvalue = @maxvalue;
			end
			else if (@avgvalue is null and @minvalue is not null)
			begin
				select @avgvalue = @minvalue;
			end
		    select @avgvalue = (@avgvalue - 32) / 9 * 5;
			
	        insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
	        fetch next from max_cursor into @localdatetime, @maxvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
     -- blm/kemenitz. temp/c/daily  sourceid = 199
    -- variableid = 61 avg at
    -- need to compute average.
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=61)
    begin
	    declare max_cursor cursor for 
		select dv.localdatetime, dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=61;

        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=61;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	       insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  -- blm/kemenitz. temp/c/hourly  sourceid = 199
    -- variableid = 442 avg at
    -- need to compute daily average
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=442)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=442
		group by convert(date,dv.localdatetime);
		
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=442;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0

	    begin
	       insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
           fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  -- blm/kemenitz. temp/c/minute  sourceid = 199
    -- variableid = 504 avg at
    -- need to compute daily average
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=504)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=504
		group by convert(date,dv.localdatetime);
		
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=504;
		
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
		    
	       insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
-- arm. temp/c/minute  sourceid = 35
    -- variableid = 519 avg at
    -- need to compute daily average
    else if exists (select * from odmdatavalues where siteid = @siteid and variableid=519)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
        from odmdatavalues as dv
        where dv.siteid = @siteid and dv.variableid=519 
		group by convert(date,dv.localdatetime);
        
        select @methodid = s.methodid, @variableid=s.variableid
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=519;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0

	    begin
	       insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
           fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
-- arm. temp/c/minute  sourceid = 203
    -- variableid = 527 avg at
    -- need to compute daily average
    else if exists (select * from odmdatavalues where siteid = @siteid and @varid=527)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
        from odmdatavalues as dv
        where dv.siteid = @siteid and dv.variableid=@varid
		group by convert(date,dv.localdatetime);
        
        select @methodid = s.methodid, @variableid=s.variableid
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=@varid;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0

	    begin
	       insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
           fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;
    end
 
 -- arm. temp/c/second  sourceid = 203
    -- variableid = 538 avg at
    -- need to compute daily average
    else if exists (select * from odmdatavalues where siteid = @siteid and @varid=538)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
        from odmdatavalues as dv
        where dv.siteid = @siteid and dv.variableid=@varid 
		group by convert(date,dv.localdatetime);
        
        select @methodid = s.methodid, @variableid=s.variableid
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=@varid;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0

	    begin
	       insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
           fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;
    end  
 
    -- lpeters. temp/f/hourly  sourceid = 182
    -- variableid = 279 avg at
    -- need to compute daily average
    -- need to convert to utc time
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=279)
      begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
        from odmdatavalues as dv
        where dv.siteid = @siteid and dv.variableid=@varid 
		group by convert(date,dv.datetimeutc);
        
        select @methodid = s.methodid, @variableid=s.variableid
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=@varid;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0

	    begin
	       select @avgvalue = (@avgvalue - 32) / 9 * 5;
	       insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
           fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;
    end  
    -- lpeters. temp/f/hourly  sourceid = 182
    -- variableid = 288 avg at
    -- need to compute daily average
    -- need to convert to utc time
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=288)
      begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
        from odmdatavalues as dv
        where dv.siteid = @siteid and dv.variableid=@varid 
		group by convert(date,dv.datetimeutc);
        
        select @methodid = s.methodid, @variableid=s.variableid
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=@varid;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0

	    begin
	       select @avgvalue = (@avgvalue - 32) / 9 * 5;
	       insert into daily_airtempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
           fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;
    end  
end








;

