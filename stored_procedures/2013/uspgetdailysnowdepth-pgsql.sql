use iarcod
;

/****** object:  storedprocedure uspgetdailysnowdepth    script date: 02/20/2013 12:57:27 ******/
set ansi_nulls on
;

;






-- =============================================
-- author:		amy jacobs
-- create date: august 14, 2012
-- description:	create the daily snow depth average.  
-- units: meters, format decimal(6,3)
-- =============================================
create procedure uspgetdailysnowdepth 
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
    
    -- ncdc ghcn.  snow depth/mm/daily.  sourceid = 4 
    -- variableid = 402
    -- convert from mm to meters
    if exists (select * from seriescatalog where siteid = @siteid and variableid=402)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime),dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=402;
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=402;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
			select @avgvalue = @avgvalue / 1000;
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- if there is no ghcn, check for ish
    -- variableid = 370 is ish snow depth/hourly/cm.  needs to be converted to a daily value.  sourceid = 4
    -- convert from cm to meters
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=370)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=370
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=370;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
			select @avgvalue = @avgvalue / 100;
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
     -- uaf/werc:  snow depth/cm, ast
    -- variableid = 75. needs to be converted to a daily value.  sourceid = 29, 30, 34
    -- need to convert to utcdatetime
    -- need to convert from cm to meters
    else if exists (select * from odmdatavalues where siteid= @siteid and variableid=75)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=75 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=75;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
			select @avgvalue = @avgvalue / 100;
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  
    -- usgs:  snow depth/hourly/cm, ast
    -- variableid = 320. needs to be converted to a daily value.  sourceid = 39
    -- need to convert to utcdatetime
    -- need to convert from cm to meters
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=320)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=320 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=320;
		
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
			select @avgvalue = @avgvalue / 100;
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
	        fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- raws/nps:  snow depth/daily/mm, utc
    -- variableid = 440, sourceid = 116
    -- convert from mm to meters
   
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=440)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=440;
		
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=440;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
			select @avgvalue = @avgvalue / 1000;
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- snow course  snow depth/daily/inches, utc
    -- variableid = 396, sourceid = 200
    -- convert from inches to mm
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=396)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=396;
		
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=396;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        select @avgvalue = @avgvalue * 0.0254;
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end

  -- uaf/werc. snow depth/meters/daily  sourceid = 31
    -- variableid = 339 ast
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=339)
         begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=@varid and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid);
		
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=@varid;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
-- uaf/werc. snow depth/meters/hourly  sourceid = 31
    -- variableid = 193
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=193)
         begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=@varid and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=@varid;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
-- uaf/werc. snow depth/cm/yearly  sourceid = 3, sourceid = 193
-- variableid = 142 ast
    else if exists (select * from seriescatalog where siteid = @siteid and @varid=142)
         begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime),dv.datavalue
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=@varid and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=@varid;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
			select @avgvalue = @avgvalue / 100;
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end 
-- arm. snow depth/mm/minutely  sourceid = 1, 203
-- variableid = 543
    else if exists (select * from odmdatavalues where siteid = @siteid and @varid=543)
         begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=@varid and dv.siteid in 
		(select distinct siteid from odmdatavalues where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		select @methodid = s.methodid, @variableid=s.variableid
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=@varid;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
			select @avgvalue = @avgvalue / 1000;
	        insert into daily_snowdepthdatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end    
end








;

