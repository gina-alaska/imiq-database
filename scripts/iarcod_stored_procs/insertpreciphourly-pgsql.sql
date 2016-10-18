declare @siteid as int, @sourceid as int, @varid as int;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (209); /* ish: sourceid=209, variableid=340) */
	select @varid = 340;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (29, 30, 31, 34); /* uaf/werc: sourceid in (29, 30, 31, 34), variableid=84) */
	select @varid = 84;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (39); /* usgs: 39, variableid=319) */
	select @varid = 319;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (145); /* toolik: sourceid=145, variableid=461) */
	select @varid = 461;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (199); /* blm: sourceid=199, variableid=496) */
	select @varid = 496;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (199); /* blm: sourceid=199, variableid=458) */
	select @varid = 458;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (139); /* blm: sourceid=139, variableid=336) */
	select @varid = 336;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (35); /* blm: sourceid=35, variableid=522) */
	select @varid = 522;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (1,203); /* blm: sourceid=1,203, variableid=539) */
	select @varid = 539;
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
			execute uspgethourlyprecip @siteid,@varid;
			fetch next from site_cursor into @siteid;
   	end;

		close site_cursor;
		deallocate site_cursor;
		fetch next from loop_cursor into @sourceid;
	end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (182); /* lpeters: sourceid=182, variableid=294) */
	select @varid = 294;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

declare loop_cursor cursor for
	select sourceid from sources where sourceid in (213); /* rwis: sourceid=213, variableid=575) */
	select @varid = 575;
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
		execute uspgethourlyprecip @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;
