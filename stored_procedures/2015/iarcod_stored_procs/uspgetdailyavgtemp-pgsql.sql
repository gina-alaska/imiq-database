use iarcod
;

/****** object:  storedprocedure uspgetdailyavgtemp    script date: 02/20/2013 12:56:21 ******/
set ansi_nulls on
;

;




-- =============================================
-- author:		amy jacobs
-- create date: april 12,2012
-- description:	create the daily average air temperature.
-- for toolik project  
-- =============================================
create procedure uspgetdailyavgtemp 
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
    
      -- uaf/werc:  temp/hourly/c, ast
    -- variableid = 81. needs to be converted to a daily value.  sourceid = 31
    -- need to make sure offset is 2m or 1.5m
    -- need to convert to utcdatetime
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=81 and (offsetvalue = 2 or offsetvalue = 1.5))
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
	        insert into dailytempavgdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  -- uaf/werc:  temp/hourly/c, ast
    -- variableid = 81. needs to be converted to a daily value.  sourceid = 31
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
	               insert into dailytempavgdatavalues  (datavalue,utcdatetime, variableid,siteid,methodid)
	               values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
                  fetch next from max_cursor into @localdatetime, @avgvalue1m;
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
	        insert into dailytempavgdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
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
	             insert into dailytempavgdatavalues  (datavalue,utcdatetime, variableid,siteid,methodid)
	                values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
                 fetch next from max_cursor into @localdatetime, @minvalue1m;
      end

          close max_cursor;
              deallocate max_cursor;

  end
  
end



;

