use iarcod
;

/****** object:  storedprocedure uspgetallmonthlyavgwinddirection    script date: 02/20/2013 12:55:48 ******/
set ansi_nulls on
;

;




-- =============================================
-- author:		amy jacobs
-- create date: april 19,2012
-- description:	create the monthly average for all years
--		        wind direction average.  
-- =============================================
create procedure uspgetallmonthlyavgwinddirection 
	
as
begin
	-- set nocount on added to prevent extra result sets from
	-- interfering with select statements.
	set nocount on;

	declare @localdatetime datetime, @localmonth int,@localyear int,@maxvalue float,
    @minvalue float, @avgvalue float, @avgvalue1m float, @avgvalue3m float, @maxvalue1m float, @maxvalue3m float, @minvalue1m float, @minvalue3m float,
    @methodid int, @qualifierid int, @variableid int,@loglaw int,@sinvalue float,@cosvalue float,
    @xvalue float, @yvalue float, @totvalues int;
    
   
    -- all monthly wind speed values for sourceid=31 and siteid=2128
   if exists (select * from monthlyavgwinddirectiondatavalues)
    begin
	    declare max_cursor cursor for 
		select month,avg(sin(radians(dv.datavalue))), avg(cos(radians(dv.datavalue)))
		from monthlyavgwinddirectiondatavalues as dv
		where (dv.variableid=83 or dv.variableid=471) and (dv.siteid=2128 or dv.siteid in (select distinct siteid from sites where sourceid=31))
		group by month
		order by month;
		

	    open max_cursor;
		fetch next from max_cursor into @localyear, @yvalue, @xvalue;
		
	    while @@fetch_status = 0
	    
	    begin

	               select @avgvalue = degrees(atn2(@xvalue,@yvalue))
	              if @avgvalue < 0
	              begin
			        select @avgvalue = @avgvalue + 360
			      end 
	               insert into avgwinddirectionpermonth2 (datavalue, month)
	               values(@avgvalue, @localyear);     
	       
			fetch next from max_cursor into @localyear, @yvalue, @xvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    
end















;

