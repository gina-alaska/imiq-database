use iarcod
;

/****** object:  storedprocedure uspgetallavgwinddirection    script date: 02/20/2013 12:55:34 ******/
set ansi_nulls on
;

;






-- =============================================
-- author:		amy jacobs
-- create date: april 19,2012
-- description:	create the monthly average for all years
--		        wind direction average.  
-- =============================================
create procedure uspgetallavgwinddirection 
	
as
begin
	-- set nocount on added to prevent extra result sets from
	-- interfering with select statements.
	set nocount on;

	declare @localdatetime datetime, @localmonth int,@localyear int,@maxvalue float,
    @minvalue float, @avgvalue float, @avgvalue1m float, @avgvalue3m float, @maxvalue1m float, @maxvalue3m float, @minvalue1m float, @minvalue3m float,
    @methodid int, @qualifierid int, @variableid int,@loglaw int,@sinvalue float,@cosvalue float,
    @xvalue float, @yvalue float, @totvalues int;
    
   
    -- uaf/werc:  windspeed/ms, ast
    -- variableid = 83. sourceid = 31
   if exists (select * from avgwinddirectionpermonth)
    begin
	    declare max_cursor cursor for 
		select avg(sin(radians(dv.datavalue))), avg(cos(radians(dv.datavalue)))
		from avgwinddirectionpermonth as dv
		;
		

	    open max_cursor;
		fetch next from max_cursor into @yvalue, @xvalue;
		
	    while @@fetch_status = 0
	    
	    begin
	        select @avgvalue = degrees(atn2(@xvalue,@yvalue));
	              if @avgvalue < 0
	              begin
			        select @avgvalue = @avgvalue + 360
			      end 
	               print convert(varchar,@avgvalue);
			         
	       
			fetch next from max_cursor into @yvalue, @xvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end
    
end












;

