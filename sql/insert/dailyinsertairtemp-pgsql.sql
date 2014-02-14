declare @siteid as int, @sourceid as int, @varid as int;
/*ghcn load
sourceid: 210
variableid for ghcn: 403 (tmax), 404 (tmin)
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (210);
	select @varid = 404;
	
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
			select 	distinct siteid
			from 		seriescatalog_62
			where 	sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*ish load
sourceid: 209
variableid=218
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (209);
	select @varid = 218;
	open loop_cursor;
	fetch next from loop_cursor into @sourceid;

	while @@fetch_status = 0
	begin

		declare site_cursor cursor for
			select 	distinct siteid
			from 		seriescatalog_62
			where 	sourceid = @sourceid;

		open site_cursor;
		fetch next from site_cursor into @siteid;

		while @@fetch_status = 0
		begin
			execute uspgetdailyairtemp @siteid,@varid;
			fetch next from site_cursor into @siteid;
      end;

		close site_cursor;
		deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*uaf/werc load
sourceid: 29,30,31,34
variableid=81
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (29,30,31,34);
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
			execute uspgetdailyairtemp @siteid,@varid;
			fetch next from site_cursor into @siteid;
      end;

		close site_cursor;
		deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*usgs load
sourceid: 39
variableid=310
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (39);
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
			execute uspgetdailyairtemp @siteid,@varid;
			fetch next from site_cursor into @siteid;
      end;

		close site_cursor;
		deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*blm/kemenitz load
sourceid: 199
variableid=442
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (199);
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*blm/kemenitz load
sourceid: 199
variableid=504
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (199);
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*arm load
sourceid: 35
variableid=519
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (35);
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*arm load
sourceid: 202,203
variableid=527
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (202,203);
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*arm load
sourceid: 203
variableid=538
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (203);
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*lpeters load
sourceid: 182
variableid=279
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (182);
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*lpeters load
sourceid: 182
variableid=288
*/
declare loop_cursor cursor for
select sourceid from sources where sourceid in (182);
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*raws/nps
sourceid: 211
variableid: 432
*/
declare loop_cursor cursor for
select sourceid from sources where sourceid in (211);
select @varid = 432;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
		select distinct siteid
		from seriescatalog
		where sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
    end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*snotel
sourceid: 212,
variableid: 393
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (212);
	select @varid = 393;
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*toolik field service
sourceid = 145,
variableid = 489 (tmin), 487 (tmax)
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (145);
	select @varid = 489;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
		select distinct siteid
		from seriescatalog
		where sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
	end;
close loop_cursor;
deallocate loop_cursor;

/*mccall
sourceid: 178, 182
variableid: 195 (tmax) 196 (tmin)
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (178,182);
	select @varid = 195;
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;


/*mccall
sourceid: 179
variableid: 277
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (179);
	select @varid = 277;
	open loop_cursor;
	fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
		select distinct siteid
		from seriescatalog
		where sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*uaf
sourceid: 180
variableid: 223 (tmax), 225(tmin)
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (180);
	select @varid = 223;
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*chamberlin
sourceid: 183
variableid: 295 (tmax), 296(tmin)
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (183);
	select @varid = 295;
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*blm/kemenitz
sourceid: 199
variableid: 61
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (199);
	select @varid = 61;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

	while @@fetch_status = 0
	begin

		declare site_cursor cursor for
			select distinct siteid
			from seriescatalog
			where sourceid = @sourceid;

		open site_cursor;
		fetch next from site_cursor into @siteid;

		while @@fetch_status = 0
		begin
			execute uspgetdailyairtemp @siteid,@varid;
			fetch next from site_cursor into @siteid;
     end;

		close site_cursor;
		deallocate site_cursor;
		fetch next from loop_cursor into @sourceid;
	end;
close loop_cursor;
deallocate loop_cursor;

/*blm/kemenitz
sourceid: 199
variableid: 442
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (199);
	select @varid = 442;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
		select distinct siteid
		from seriescatalog
		where sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;


/*blm/kemenitz
sourceid: 199
variableid: 504
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (199);
	select @varid = 504;
	open loop_cursor;
	fetch next from loop_cursor into @sourceid;

	while @@fetch_status = 0
	begin

		declare site_cursor cursor for
			select distinct siteid
			from seriescatalog
			where sourceid = @sourceid;

		open site_cursor;
		fetch next from site_cursor into @siteid;

		while @@fetch_status = 0
		begin
			execute uspgetdailyairtemp @siteid,@varid;
			fetch next from site_cursor into @siteid;
      end;

		close site_cursor;
		deallocate site_cursor;
		fetch next from loop_cursor into @sourceid;
	end;
close loop_cursor;
deallocate loop_cursor;

/*arm
sourceid: 35
variableid: 519
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (35);
	select @varid = 519;
open loop_cursor;
fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
		select distinct siteid
		from seriescatalog
		where sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*arm
sourceid: 203
variableid: 527
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (203);
	select @varid = 527;
	open loop_cursor;
	fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
		select distinct siteid
		from seriescatalog
		where sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*arm
sourceid: 203
variableid: 538
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (203);
	select @varid = 538;
	open loop_cursor;
	fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
		select distinct siteid
		from seriescatalog
		where sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*lpeters
sourceid: 182
variableid: 279
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (182);
	select @varid = 279;
	open loop_cursor;
	fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
		select distinct siteid
		from seriescatalog
		where sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*lpeters
sourceid: 182
variableid: 288
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (182);
	select @varid = 288;
	open loop_cursor;
	fetch next from loop_cursor into @sourceid;

while @@fetch_status = 0
begin

	declare site_cursor cursor for
	select distinct siteid from seriescatalog
	where sourceid = @sourceid;

	open site_cursor;
	fetch next from site_cursor into @siteid;

	while @@fetch_status = 0
	begin
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
  	end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*permafrost lab uaf load
sourceid: 206
variableid for permafrost lab/uaf: 550
*/
declare loop_cursor cursor for
		select sourceid from sources where sourceid in (206);
		select @varid = 550;
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
		execute uspgetdailyairtemp @siteid,@varid;
		fetch next from site_cursor into @siteid;
   end;

	close site_cursor;
	deallocate site_cursor;
	fetch next from loop_cursor into @sourceid;
end;
close loop_cursor;
deallocate loop_cursor;

/*rwis load
sourceid: 213
variableid:563
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (213);
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
			execute uspgetdailyairtemp @siteid,@varid;
			fetch next from site_cursor into @siteid;
      end;

		close site_cursor;
		deallocate site_cursor;
		fetch next from loop_cursor into @sourceid;
	end;
close loop_cursor;
deallocate loop_cursor;

/*toolik load
sourceid: 145
variableid:489
*/
declare loop_cursor cursor for
	select sourceid from sources where sourceid in (145);
	select @varid = 489;
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
			execute uspgetdailyairtemp @siteid,@varid;
			fetch next from site_cursor into @siteid;
		end;

	close site_cursor;
	deallocate site_cursor;
fetch next from loop_cursor into @sourceid;
end;

close loop_cursor;
deallocate loop_cursor;

	
