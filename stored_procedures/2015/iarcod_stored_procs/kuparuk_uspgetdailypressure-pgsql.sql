use iarcod
;

/****** object:  storedprocedure kuparuk_uspgetdailypressure    script date: 02/20/2013 12:52:59 ******/
set ansi_nulls on
;

;





-- =============================================
-- author:		amy jacobs
-- create date: april 18,2012
-- description:	create the daily station pressure.  
-- units: meters, format decimal(6,3)
-- =============================================
create procedure kuparuk_uspgetdailypressure 
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
    
  
    -- uaf/werc:  pressure/mbar, ast
    -- variableid = 125. needs to be converted to a daily value.  sourceid = 31
    -- need to convert to utcdatetime
    
    if exists (select * from odmdatavalues where siteid= @siteid and variableid=125)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=125 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=125;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailypressuredatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(@avgvalue, @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
  
-- toolik. pressure/hourly  sourceid = 145
-- variableid = 468
    else if exists (select * from odmdatavalues where siteid = @siteid and @varid=468)
    begin
	    declare max_cursor cursor for 
		select convert(date,dv.datetimeutc), avg(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=468 and dv.siteid in 
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=468;

	    open max_cursor;
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailypressuredatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(@avgvalue, @localdatetime, @variableid,@siteid, @methodid);
			fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end 
end







;

