use iarcod
;

/****** object:  storedprocedure uspgetdailyswe    script date: 02/20/2013 12:59:09 ******/
set ansi_nulls on
;

;





-- =============================================
-- author:		amy jacobs
-- create date: feb 17,2012
-- description:	create the daily snow depth average.  
-- units: meters, format decimal(6,3)
-- =============================================
create procedure uspgetdailyswe 
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
    
    -- ncdc ish.  swe/mm/minute.  sourceid = 4 
    -- variableid = 373
    if exists (select * from seriescatalog where siteid = @siteid and variableid=373)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), sum(dv.datavalue)
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=373
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=373;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into daily_swedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
     -- uaf/werc:  daily/swe/cm, ast
    -- variableid = 215. sourceid = 31,193
    -- need to convert to utcdatetime
    -- need to convert from cm to mm
    else if exists (select * from odmdatavalues where siteid= @siteid and variableid=215)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=215 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=215;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
			select @avgvalue = @avgvalue * 10;
	        insert into daily_swedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  
   
  
    -- snow course  swe/daily/inches, utc
    -- variableid = 397, sourceid = 200
    -- convert from inches to mm
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=397)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=397;
		
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=397;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        select @avgvalue = @avgvalue * 25.4;
	        insert into daily_swedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- snotel  swe/daily/inches, utc
    -- variableid = 395, sourceid = 124
    -- convert from inches to mm
    else if exists (select * from seriescatalog where siteid= @siteid and variableid=395)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from datavalues as dv
		inner join seriescatalog on seriescatalog.datastreamid = dv.datastreamid
		where seriescatalog.siteid = @siteid and seriescatalog.variableid=395;
		
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=395;
		    
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        select @avgvalue = @avgvalue * 25.4;
	        insert into daily_swedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
      -- uaf/werc:  swe/cm/year, ast
    -- variableid = 21. sourceid = 3
    -- need to convert to utcdatetime
    -- need to convert from cm to mm
    else if exists (select * from odmdatavalues where siteid= @siteid and variableid=21)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), dv.datavalue
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=21 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=21;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
			select @avgvalue = @avgvalue * 10;
	        insert into daily_swedatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(6,3),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end 
end










;

