declare @siteid as int, @sourceid as int, @varid as int;

declare loop_cursor cursor for
select sourceid from sources where sourceid in (209); /* ish: sourceid=209, variableid=218) */
select @varid = 218;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
select sourceid from sources where sourceid in (29, 30, 31, 34); /* ish: sourceid=29,30,31,34, variableid=81) */
select @varid = 81;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
select sourceid from sources where sourceid=39; /* usgs: sourceid=39, variableid=310) */
select @varid = 310;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
select sourceid from sources where sourceid=199; /* blm/kemenitz: sourceid=199, variableid=442) */
select @varid = 442;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
select sourceid from sources where sourceid=199; /* blm/kemenitz minute: sourceid=199, variableid=504) */
select @varid = 504;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
select sourceid from sources where sourceid=35; /* arm minute: sourceid=35, variableid=519) */
select @varid = 519;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
select sourceid from sources where sourceid in(202,203); /* arm minute: sourceid=202,203, variableid=527) */
select @varid = 527;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
select sourceid from sources where sourceid=203; /* arm second: sourceid=203, variableid=538) */
select @varid = 538;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;
declare loop_cursor cursor for
select sourceid from sources where sourceid=182; /* lpeters: sourceid=182, variableid=279) */
select @varid = 279;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;
declare loop_cursor cursor for
select sourceid from sources where sourceid=182; /* lpeters: sourceid=182, variableid=288) */
select @varid = 288;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;
declare loop_cursor cursor for
select sourceid from sources where sourceid=213; /* rwis: sourceid=213, variableid=563) */
select @varid = 563;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
select sourceid from sources where sourceid=145; /* toolik: sourceid=145, variableid=466) */
select @varid = 466;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin


declare site_cursor cursor for
select distinct siteid
from seriescatalog_62
where sourceid = @sourceid;

open site_cursor;
fetch next from site_cursor into @siteid;

while @@fetch_status = 0
begin
execute uspgethourlyairtemp @siteid,@varid;
fetch next from site_cursor into @siteid;
        end;

close site_cursor;
deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

