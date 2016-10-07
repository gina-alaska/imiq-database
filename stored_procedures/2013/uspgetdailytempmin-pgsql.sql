

-- =============================================
-- author:		amy jacobs
-- create date: april 9,2012
-- description:	create the daily minimum air temperatures
-- note: this table that is holding the min airtemp data values has been deleted, since it was run with an old verion
-- of the seriescatalog.  if a new version is needed, run again
-- (nov 11,2012).
-- =============================================
create or replace function uspgetdailytempmin (int,int) returns void
as '
begin

	declare localdatetime timestamp; maxvalue float;
    minvalue float; avgvalue float; avgvalue1m float; avgvalue3m float; maxvalue1m float; maxvalue3m float; minvalue1m float; minvalue3m float;
    methodid int; qualifierid int; variableid int;


    -- usgs:  temp/hourly/c, ast
    -- variableid = 310. needs to be converted to a daily value.  sourceid = 39
    -- no offset value is given
    -- need to convert to utcdatetime
    if exists (select * from seriescatalog where siteid= @siteid and variableid=310)
    begin
	    declare max_cursor cursor for
		select convert(date,dv.datetimeutc), min(dv.datavalue)
		from odmdatavalues as dv
		where dv.siteid = @siteid and dv.variableid=310 and dv.siteid in
		(select distinct siteid from seriescatalog where @siteid = siteid)
		group by convert(date,dv.datetimeutc);
		 select @methodid = s.methodid, @variableid=s.variableid
		    from seriescatalog s
		    where s.siteid = @siteid and s.variableid=310;

	    open max_cursor; 
		fetch next from max_cursor into @localdatetime, @avgvalue;

	    while @@fetch_status = 0
	    begin
	        insert into dailytempmindatavalues (datavalue,utcdatetime, variableid,siteid,methodid)
	        values(convert(decimal(10,2),@avgvalue), @localdatetime, @variableid,@siteid, @methodid);
	        fetch next from max_cursor into @localdatetime, @avgvalue;
        end

	    close max_cursor;
		deallocate max_cursor;

    end

end;
' language 'plpgsql';
