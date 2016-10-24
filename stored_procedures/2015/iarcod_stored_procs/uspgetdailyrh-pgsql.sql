use iarcod
;

/****** object:  storedprocedure uspgetdailyrh    script date: 02/20/2013 12:57:12 ******/
set ansi_nulls on
;

;











-- =============================================
-- author:		amy jacobs
-- create date: march 7, 2012
-- description:	create the daily relative humidity at 2m for all of arcticlcc 
-- =============================================
create procedure uspgetdailyrh 
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
    

    -- arm.  rh/minute/utc sourceid = 202
    -- variableid = 523, minute
    -- needs to be converted to a daily value. 
   if exists (select * from seriescatalog where siteid= @siteid and variableid= 523)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid= 523
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid= 523;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_rhdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
     -- uaf/werc:  rh/hourly/1m and 3m/ast
    -- variableid = 80. needs to be converted to a daily value.  sourceid = 29, 30, 31, 34
    -- need to make sure offset is 2m or 1.5m
    -- need to convert to utcdatetime
    else if exists (select * from odmdatavalues where siteid= @siteid and variableid=80 and (offsetvalue = 2 or offsetvalue = 1.5))
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=80 and (dv.offsetvalue = 2 or dv.offsetvalue = 1.5) and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=80;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_rhdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  -- uaf/werc:  rh/hourly/1m and 3m/ast
    -- variableid = 80. needs to be converted to a daily value.  sourceid = 29, 30, 31, 34
    -- need to convert 1m and 3m to 2m
    -- need to convert to utcdatetime
    else if exists (select * from odmdatavalues where siteid= @siteid and variableid=80 and offsetvalue = 1)
     begin
          declare max_cursor cursor for 
              select convert(date,dv.datetimeutc), avg(dv.datavalue)
              from odmdatavalues as dv
              where dv.siteid = @siteid and dv.variableid=80 and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriescatalog where @siteid = siteid)
              group by convert(date,dv.datetimeutc);
              
		      select @methodid = s.methodid, @variableid=s.variableid
		       from seriescatalog s
		       where s.siteid = @siteid and s.variableid=80;
          open max_cursor;
              fetch next from max_cursor into @localdatetime, @avgvalue1m;
              
              while @@fetch_status = 0
              begin
                      select @avgvalue3m = avg(dv.datavalue)
                      from odmdatavalues as dv
                      where dv.siteid = @siteid and dv.variableid=80 and dv.offsetvalue = 3 and @localdatetime = convert(date,dv.datetimeutc) and dv.siteid in 
                  (select distinct siteid from seriescatalog where @siteid = siteid);
                  select @avgvalue = (@avgvalue3m - @avgvalue1m)/2 + @avgvalue1m;
                  -- if the 2m average temp is null, check and see if there is a 1m air temp and use it.
                   if (@avgvalue is  null and @avgvalue1m is not null)
                   begin
                       select @avgvalue = @avgvalue1m;
                   end
	               insert into daily_rhdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	               values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
                  fetch next from max_cursor into @localdatetime, @avgvalue1m;
              end

	    close max_cursor;
		deallocate max_cursor;
end
    -- toolik:  rh/hourly/1m and 3m/ast
    -- variableid = 467. needs to be converted to a daily value.  sourceid = 145
    -- need to convert 1m and 3m to 2m
    -- need to convert to utcdatetime
    else if exists (select * from odmdatavalues where siteid= @siteid and variableid=467 and offsetvalue = 1)
     begin
          declare max_cursor cursor for 
              select convert(date,dv.datetimeutc), avg(dv.datavalue)
              from odmdatavalues as dv
              where dv.siteid = @siteid and dv.variableid=467 and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriescatalog where @siteid = siteid)
              group by convert(date,dv.datetimeutc)
              order by convert(date,dv.datetimeutc);
              
		      select @methodid = s.methodid, @variableid=s.variableid
		       from seriescatalog s
		       where s.siteid = @siteid and s.variableid=467;
          open max_cursor;
              fetch next from max_cursor into @localdatetime, @avgvalue1m;
              
              while @@fetch_status = 0
              begin
                      select @avgvalue3m = avg(dv.datavalue)
                      from odmdatavalues as dv
                      where dv.siteid = @siteid and dv.variableid=467 and dv.offsetvalue = 3 and @localdatetime = convert(date,dv.datetimeutc) and dv.siteid in 
                  (select distinct siteid from seriescatalog where @siteid = siteid);
                  select @avgvalue = (@avgvalue3m - @avgvalue1m)/2 + @avgvalue1m;
                  -- if the 2m average temp is null, check and see if there is a 1m air temp and use it.
                   if (@avgvalue is  null and @avgvalue1m is not null)
                   begin
                       select @avgvalue = @avgvalue1m;
                   end
	               insert into daily_rhdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	               values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
                  fetch next from max_cursor into @localdatetime, @avgvalue1m;
              end

	    close max_cursor;
		deallocate max_cursor;
end

    -- lchamberlin:  rh/daily/ast
    -- variableid = 299. sourceid = 183
    -- no offset value is given
    -- need to convert to utcdatetime
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=299)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), dv.datavalue
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=299 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=299;
		
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_rhdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
	        fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- raws/nps:  rh/daily/utc
    -- variableid = 435, sourceid = 114 and sourceid = 116
    -- no offset value is given
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=435)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=435;
		
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=435;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_rhdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    

    

    
     -- noaa. rh/minute sourceid = 35
    -- variableid = 518
    -- need to compute average.
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=518)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid= 518
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid= 518;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	       insert into daily_rhdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
      -- lpeters. rh/hourly sourceid = 182
    -- variableid = 293
    -- convert to utc
    -- need to compute average.
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=293)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where  siteid = @siteid and  variableid= 293
		group by convert(date,dv.datetimeutc);
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid= 293;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	       insert into daily_rhdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;
		
 end
       -- mccall. rh/daily/ast sourceid = 198
    -- variableid = 198
    -- convert to utc
    -- need to compute average.
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=198)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where  siteid = @siteid and  variableid= 198
		group by convert(date,dv.datetimeutc);
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid= 198;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	       insert into daily_rhdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
           values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;
		
 end

end






;

