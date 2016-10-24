use iarcod
;

/****** object:  storedprocedure kuparuk_uspgetdailyrh_10    script date: 02/20/2013 12:53:16 ******/
set ansi_nulls on
;

;




-- =============================================
-- author:		amy jacobs
-- create date: april 18, 2012
-- description:	create the daily relative humidity at 2m for the kuparuk region
-- =============================================
create procedure kuparuk_uspgetdailyrh_10 
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
    

    -- uaf/werc:  rh/hourly/1m and 3m/ast
    -- variableid = 80. needs to be converted to a daily value.  sourceid = 31
    -- need to make sure offset is 2m or 1.5m
    -- need to convert to utcdatetime
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=80 and (offsetvalue = 2 or offsetvalue = 1.5))
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=80 and convert(int,datepart(hh,dv.localdatetime)) = 10  and (dv.offsetvalue = 2 or dv.offsetvalue = 1.5) and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=80;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailyrh10datavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  -- uaf/werc:  rh/hourly/1m and 3m/ast
    -- variableid = 80. needs to be converted to a daily value.  sourceid = 31
    -- need to convert 1m and 3m to 2m
    -- need to convert to utcdatetime
    else if exists (select * from odmdatavalues where siteid= @siteid and variableid=80 and offsetvalue = 1)
     begin
          declare max_cursor cursor for 
              select convert(date,dv.datetimeutc), avg(dv.datavalue)
              from odmdatavalues as dv
              where dv.siteid = @siteid and dv.variableid=80 and convert(int,datepart(hh,dv.localdatetime)) = 10  and dv.offsetvalue = 1 and dv.siteid in 
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
	               insert into dailyrh10datavalues (datavalue,utcdatetime, variableid,siteid,methodid)
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
              where dv.siteid = @siteid and dv.variableid=467 and convert(int,datepart(hh,dv.localdatetime)) = 10 and dv.offsetvalue = 1 and dv.siteid in 
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
	               insert into dailyrh10datavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	               values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
                  fetch next from max_cursor into @localdatetime, @avgvalue1m;
              end

	    close max_cursor;
		deallocate max_cursor;
end

 
end





;

