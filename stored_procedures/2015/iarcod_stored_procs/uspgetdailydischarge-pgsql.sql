use iarcod
;

/****** object:  storedprocedure uspgetdailydischarge    script date: 02/20/2013 12:56:37 ******/
set ansi_nulls on
;

;





-- =============================================
-- author:		amy jacobs
-- create date: august 9,2012
-- description:	create the daily discharge average.  
-- =============================================
create procedure uspgetdailydischarge 
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
    
    -- nwis.  discharge/cubic feet per second/daily.  ast
    -- sourceid = 139,199
    -- variableid = 56
    -- convert from cfs to cms
    if exists (select * from seriescatalog where siteid = @siteid and @varid=56)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=56;
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=56;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        select @avgvalue = @avgvalue *  0.02832;
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- lchamberlinstreamdischarge_cfs_datatypeunk ast
    -- variableid = 304 discharge/daily/cfs. sourceid = 183
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=304)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=304;
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=304;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        select @avgvalue = @avgvalue *  0.02832;
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
     -- fws_discharge:  discharge/cfs/daily ast
    -- variableid = 343. sourceid = 154
    -- need to convert to utcdatetime
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=343)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=343 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=343;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        select @avgvalue = @avgvalue *  0.02832;
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  
    -- usgs_blm_discharge:  discharge/minutely/cfs, ast
    -- variableid = 445. needs to be converted to a daily value.  sourceid = 199
    -- need to convert to utcdatetime
    else if exists (select * from seriescatalog where siteid= @siteid and @varid=445)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=445 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=445;
		
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        select @avgvalue = @avgvalue *  0.02832;
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
	        fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
     -- usgs_blm_discharge:  discharge/every 30 minutes/cfs, ast
    -- variableid = 497. needs to be converted to a daily value.  sourceid = 199
    -- need to convert to utcdatetime
    else if exists (select * from seriescatalog where siteid= @siteid and @varid=497)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=497 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=497;
		
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        select @avgvalue = @avgvalue *  0.02832;
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
	        fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- uafwerc_discharge:  discharge/hourly/cms, ast
    -- variableid = 90, sourceid = 30
   
    else if exists (select * from seriescatalog where siteid= @siteid and @varid=90)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=90 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=90;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
        -- uafwerc_discharge_minute_calculated:  discharge/minute/cms, ast
    -- variableid = 145, sourceid = 31
   
    else if exists (select * from seriescatalog where siteid= @siteid and @varid=145)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=145 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=145;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- uafwerc_discharge_quarter_hour_calculated:  discharge/every 15 minute/cms, ast
    -- variableid = 148, sourceid = 31
   
    else if exists (select * from seriescatalog where siteid= @siteid and @varid=148)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=148 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=148;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
   -- uafwerc_discharge_hourly_calculated:  discharge/hourly/cms, ast
    -- variableid = 149, sourceid = 31
   
    else if exists (select * from seriescatalog where siteid= @siteid and @varid=149)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=149 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=149;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end      
   -- uafwerc_discharge_sporadic:  discharge/sporadic/cms, ast
    -- variableid = 150, sourceid = 31
   
    else if exists (select * from seriescatalog where siteid= @siteid and @varid=150)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=150 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=150;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end   
    
    -- blm-werc_whitman-arp_discharge:  discharge/sporadic/cms, ast
    -- variableid = 152, sourceid = 164
   
    else if exists (select * from seriescatalog where siteid= @siteid and @varid=152)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=152 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=152;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_dischargedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end   
end










;

