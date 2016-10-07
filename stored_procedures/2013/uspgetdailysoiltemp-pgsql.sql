use iarcod
;

/****** object:  storedprocedure uspgetdailysoiltemp    script date: 02/20/2013 12:58:16 ******/
set ansi_nulls on
;

;











-- =============================================
-- author:		amy jacobs
-- create date: april 9,2012
-- description:	create the daily soil temp
-- =============================================
create procedure uspgetdailysoiltemp 
	-- add the parameters for the stored procedure here
	@siteid int
as
begin
	-- set nocount on added to prevent extra result sets from
	-- interfering with select statements.
	set nocount on;

	declare @localdatetime datetime, @maxvalue float,
    @minvalue float, @avgvalue float, @offsetvalue float,
    @methodid int, @qualifierid int, @offsettypeid int, @variableid int;
    
    -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offset=5
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=5 )
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=5
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=5;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offsetvalue=10
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=10)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=10
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=10;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end 
    -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offsetvalue=15
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=15)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=15
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=15;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end 
       -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offsetvalue=20
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=20)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=20
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=20;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offsetvalue=25
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=25)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=25
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=25;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end  
    -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offsetvalue=30
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=30)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=30
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=30;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end   
    -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offsetvalue=45
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=45)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=45
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=45;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end  
    -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offsetvalue=70
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=70)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=70
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=70;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end  
    -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offsetvalue=95
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=95)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=95
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=95;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end     
     -- variableid = 321 is soil temp.  needs to be converted to a daily value.  sourceid = 39 offsetvalue=120
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=321 and offsetvalue=120)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.localdatetime), avg(dv.datavalue)
		from odmdatavalues as dv
		where siteid = @siteid and variableid=321 and offsetvalue=120
		group by convert(date,dv.localdatetime);
        select @methodid = s.methodid, @variableid=s.variableid,@offsettypeid=offsettypeid,@offsetvalue=offsetvalue
		    from odmdatavalues s
		    where s.siteid = @siteid and s.variableid=321 and offsetvalue=120;
	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailysoiltempdatavalues (datavalue,utcdatetime, variableid,siteid,methodid,offsettypeid,offsetvalue)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid,@offsettypeid,@offsetvalue);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end 
end

;

