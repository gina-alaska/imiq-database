
-- =============================================
-- Author: Amy Jacobs
-- Create date: June 14, 2013

-- Updated: Fixed the Avg Air Temp from the min and max values on 9-5-2013. ASJ
-- Update 9-19-2013: Changed the date selection for GHCN (210) and Mccall (178,182) ASJ
-- Update 10-18-2013: Added 'InsertDate' to 'DAILY_AirTempDataValues' table. ASJ
-- NOTE 10-10-2013: I need to change the way that GHCN is selected for an extract, so that I'm not pulling any
-- ISH stations for the DAILY. ASJ
-- Description: Create the daily air temperatures at 2m.
-- This stored procedure is sending the data to a temp table for the DAILY_AirTempDataValues, which will be used to calculate
-- monthly, yearly data values
-- =============================================

create or replace function uspgetdailyairtemp (int,int) returns void
as '
begin

declare datetimeutc timestamp;
        maxvalue float;
        minvalue float;
        avgvalue float;
        avgvalue1m float; 
        avgvalue3m float; 
        maxvalue1m float;
        maxvalue3m float; 
        minvalue1m float 
        minvalue3m float;
        methodid int;
        qualifierid int;
        variableid int;
 
    
    -- NCDC GHCN. SourceID = 210
    -- VariableID = 403 is TMAX
    -- VariableID = 404 is TMIN
    if exists (select * from seriescatalog_62 where siteid = @siteid and @varid=404)
    begin

        declare date_cursor cursor for
        			select distinct dv.datetimeutc
        			from            odmdatavalues_metric as dv
        			where           dv.siteid = @siteid 
        			and             (dv.originalvariableid=@varid or dv.originalvariableid=403);
        
		  open date_cursor;
		  fetch next from date_cursor into @datetimeutc;

		  while @@fetch_status = 0
		  begin
				select 	@maxvalue = dv.datavalue
				from 		odmdatavalues_metric as dv
				where 	dv.siteid = @siteid 
				and 		dv.originalvariableid=403 
				and 		dv.datetimeutc = @datetimeutc;

				select   @minvalue = dv.datavalue
				from 	   odmdatavalues_metric as dv
				where 	dv.siteid = @siteid 
				and 		dv.originalvariableid=@varid 
				and 		dv.datetimeutc = @datetimeutc;

				--compute avgvalue
				if(@minvalue is not null and @maxvalue is not null)
					begin
						select @avgvalue = ( @maxvalue - @minvalue ) / 2 + @minvalue;
					end
				if(@minvalue is null and @maxvalue is not null)
					begin
						select @avgvalue = @maxvalue;
					end
				else if (@minvalue is not null and @maxvalue is null)
					begin
						select @avgvalue = @minvalue;
					end
				else if (@minvalue is null and @maxvalue is null)
					begin
						select @avgvalue = null
					end
				
		   	insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values									   (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
			   
				fetch next from date_cursor into @datetimeutc;
      	end

     close date_cursor;
     deallocate date_cursor;

    end  -- NCDC GHCN. SourceID = 210
   
    -- raws/nps: temp/daily/c, utc
    -- variableid = 432, sourceid = 211
    -- no offset value is given
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=432)
    begin
		declare max_cursor cursor for
				  select dv.datetimeutc,
				  			dv.datavalue
				   from 	odmdatavalues_metric as dv
					where dv.siteid = @siteid 
					and 	dv.originalvariableid=@varid;

		open max_cursor;
		fetch next from max_cursor into @datetimeutc, @avgvalue;

		while @@fetch_status = 0
		begin
			insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
			values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
			fetch next from max_cursor into @datetimeutc, @avgvalue;
       end

		close max_cursor;
		deallocate max_cursor;

    end  -- raws/nps: temp/daily/c, utc
    
    -- snotel temp/daily/c, utc
    -- variableid = 393, sourceid = 212
    -- no offset value is given
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=393)
    begin
			declare max_cursor cursor for
					  select dv.datetimeutc, 
					  			dv.datavalue
						from 	odmdatavalues_metric as dv
						where	dv.siteid = @siteid 
						and 	dv.originalvariableid=@varid;

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values	                           (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
			
				fetch next from max_cursor into @datetimeutc, @avgvalue;
        	end

			close max_cursor;
			deallocate max_cursor;

    end  -- snotel temp/daily/c, utc
    
    -- mccall temp/daily/f, ast
    -- need to take localdatetime, not datetimeutc, since it is already a daily value
    -- variableid = 195 (tmax), variableid = 196 (tmin), sourceid = 178 and sourceid = 182
    if exists (select * from seriescatalog_62 where siteid = @siteid and @varid=195)
		 begin

        declare date_cursor cursor for
        			 select distinct dv.datetimeutc
        			 from 	odmdatavalues_metric as dv
        			 where 	dv.siteid = @siteid 
        			 and 		(dv.originalvariableid=@varid 
        			 or   	dv.originalvariableid=196);

			open date_cursor;
			fetch next from date_cursor into @datetimeutc;

			while @@fetch_status = 0
			begin
				select 	@maxvalue = dv.datavalue
				from 		odmdatavalues_metric as dv
				where 	dv.siteid = @siteid 
				and 		dv.originalvariableid=@varid 
				and 		dv.datetimeutc = @datetimeutc;

				select 	@minvalue = dv.datavalue
				from 		odmdatavalues_metric as dv
				where 	dv.siteid = @siteid 
				and 		dv.originalvariableid=196 
				and 		dv.datetimeutc = @datetimeutc;

		 		--compute avgvalue
				if(@minvalue is not null and @maxvalue is not null)
					begin
						select @avgvalue = ( @maxvalue - @minvalue ) / 2 + @minvalue;
					end
				if(@minvalue is null and @maxvalue is not null)
					begin
						select @avgvalue = @maxvalue;
					end
				else if (@minvalue is not null and @maxvalue is null)
					begin
						select @avgvalue = @minvalue;
					end
				else if (@minvalue is null and @maxvalue is null)
					begin
						select @avgvalue = null
					end
				
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
			
				fetch next from date_cursor into @datetimeutc;
      	end

		close date_cursor;
		deallocate date_cursor;

    end
    
    -- mccall temp/daily/c, ast
    -- need to take localdatetime, not datetimeutc, since it is already a daily value
    -- variableid = 277, sourceid = 179
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=277)
    begin
			declare max_cursor cursor for
						select 	dv.localdatetime, 
								 	dv.datavalue
						from 		odmdatavalues_metric as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid;

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values										(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
        	end

			close max_cursor;
			deallocate max_cursor;

    end -- mccall temp/daily/c, ast
    
    -- uaf. temp/c/daily sourceid = 180
    -- need to take localdatetime, not datetimeutc, since it is already a daily value
    -- variableid = 223 is tmax
    -- variableid = 225 is tmin
    -- need to compute average.
    if exists (select * from seriescatalog_62 where siteid = @siteid and @varid=223)
    begin
			declare max_cursor cursor for
					  select dv.localdatetime,
					         dv.datavalue
				     from 	odmdatavalues_metric as dv
                 where 	dv.siteid = @siteid 
                 and 	dv.originalvariableid=@varid;

         open max_cursor;
         fetch next from max_cursor into @datetimeutc, @maxvalue;

			while @@fetch_status = 0
			begin
				select 	@minvalue = dv.datavalue
				from 		odmdatavalues_metric as dv
				where 	dv.siteid = @siteid 
				and 		dv.originalvariableid=225 
				and 		dv.localdatetime = @datetimeutc;

          	--compute avgvalue
				if(@minvalue is not null and @maxvalue is not null)
					begin
						select @avgvalue = ( @maxvalue - @minvalue ) / 2 + @minvalue;
					end
				if(@minvalue is null and @maxvalue is not null)
					begin
						select @avgvalue = @maxvalue;
					end
				else if (@minvalue is not null and @maxvalue is null)
					begin
						select @avgvalue = @minvalue;
					end
				else if (@minvalue is null and @maxvalue is null)
					begin
						select @avgvalue = null
					end
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @maxvalue;
         end

			close max_cursor;
			deallocate max_cursor;

    end-- uaf. temp/c/daily sourceid = 180
    
    -- chamberlin. temp/f/daily sourceid = 183
    -- variableid = 295 is tmax
    -- variableid = 296 is tmin
    -- need to take localdatetime, not datetimeutc, since it is already a daily value
    -- need to compute average.
    -- need to convert from f to c.
    if exists (select * from seriescatalog_62 where siteid = @siteid and @varid=295)
    begin
			declare max_cursor cursor for
						select 	dv.localdatetime, 
								 	dv.datavalue
						from 		odmdatavalues_metric as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid;

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @maxvalue;

			while @@fetch_status = 0
			begin
					select 	@minvalue = dv.datavalue
					from 		odmdatavalues_metric as dv
					where		 dv.siteid = @siteid 
					and 		dv.originalvariableid=296 
					and 		dv.localdatetime= @datetimeutc;

        	 		--compute avgvalue
			 		if(@minvalue is not null and @maxvalue is not null)
						begin
							select @avgvalue = ( @maxvalue - @minvalue ) / 2 + @minvalue;
						end
					if(@minvalue is null and @maxvalue is not null)
						begin
							select @avgvalue = @maxvalue;
						end
					else if (@minvalue is not null and @maxvalue is null)
						begin
							select @avgvalue = @minvalue;
						end
					else if (@minvalue is null and @maxvalue is null)
						begin
							select @avgvalue = null
					end
				
			   	insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
			   	values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
			   
            	fetch next from max_cursor into @datetimeutc, @maxvalue;
         end

			close max_cursor;
			deallocate max_cursor;

    end -- chamberlin. temp/f/daily sourceid = 183
    
    -- blm/kemenitz. temp/c/daily sourceid = 199
    -- variableid = 61 avg at
    -- need to take localdatetime, not datetimeutc, since it is already a daily value
    -- need to compute average.
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=61)
    begin
			declare max_cursor cursor for
						select 	dv.localdatetime, 
								 	dv.datavalue
						from 		odmdatavalues_metric as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid;

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
					insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
					values										(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
					fetch next from max_cursor into @datetimeutc, @avgvalue;
        	end

			close max_cursor;
			deallocate max_cursor;

    end -- blm/kemenitz. temp/c/daily sourceid = 199
    
    -- uaf permafrost. temp/c/daily sourceid = 206
    -- variableid = 550 avg at
    -- need to compute average.
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=550)
    begin
			declare max_cursor cursor for
						select dv.datetimeutc, 
								 dv.datavalue
						from   odmdatavalues_metric as dv
						where  dv.siteid = @siteid 
						and    dv.originalvariableid=@varid;

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
         end

			close max_cursor;
			deallocate max_cursor;

    end -- uaf permafrost. temp/c/daily sourceid = 206
    
    -- ish sourceid = 209
    -- variableid = 218
    -- need to compute daily average from hourly
    -- do not want to have hourly sites that already have a daily in ghcn
    else if exists (select * from seriescatalog_62 
                    where siteid= @siteid and @varid=218 
                    and siteid not in (9755,9757,9758,9759,9761,9763,9773,9774,9775,9776,9777,9778,9780,9782,9784,9786,9790,9797,9806,9807,9812,9817,9819,9821,9823,9824,9836,9839,9840,9844,
     9850,9852,9855,9856,9862,9870,9871,9872,9873,9875,9876,9877,9881,9883,9888,9889,9890,9895,9898,9911,9914,9918)) --the siteids which have a match in ghcn, based on wban
    begin
			declare  max_cursor cursor for
						select convert(date,dv.utcdatetime), 
								 avg(dv.datavalue)
						from 	hourly_airtempdatavalues as dv
						where dv.siteid = @siteid 
						and 	dv.originalvariableid=@varid
						group by convert(date,dv.utcdatetime)

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
        	end

		close max_cursor;
		deallocate max_cursor;

    end -- ish sourceid = 209
    
    -- uaf werc sourceid = 29,30,31,34
    -- variableid = 81
    -- need to compute daily average from hourly
    else if exists (select * from odmdatavalues_metric where siteid= @siteid and @varid=81)
    begin
			declare  max_cursor cursor for
						select 	convert(date,dv.utcdatetime), 
									avg(dv.datavalue)
						from 		hourly_airtempdatavalues as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid
						group by convert(date,dv.utcdatetime)

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
         end

			close max_cursor;
			deallocate max_cursor;

    end -- uaf werc sourceid = 29,30,31,34
    
    -- usgs sourceid = 39
    -- variableid = 310
    -- need to compute daily average from hourly
   else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=310)
   begin
		declare max_cursor cursor for
				  select convert(date,dv.utcdatetime), 
				 			avg(dv.datavalue)
					from 	hourly_airtempdatavalues as dv
					where dv.siteid = @siteid 
					and 	dv.originalvariableid=@varid
					group by convert(date,dv.utcdatetime)

		open max_cursor;
		fetch next from max_cursor into @datetimeutc, @avgvalue;

		while @@fetch_status = 0
		begin
			insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
			values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
			fetch next from max_cursor into @datetimeutc, @avgvalue;
      end

		close max_cursor;
		deallocate max_cursor;

    end -- usgs sourceid = 39
    
    -- blm/kemenitz sourceid = 199
    -- variableid = 442
    -- need to compute daily average from hourly
   else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=442)
   begin
			declare 	max_cursor cursor for
						select 	convert(date,dv.utcdatetime), 
									avg(dv.datavalue)
						from 		hourly_airtempdatavalues as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid
						group by convert(date,dv.utcdatetime)

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
         end

			close max_cursor;
			deallocate max_cursor;

    end    -- blm/kemenitz sourceid = 199
    
    -- blm/kemenitz sourceid = 199
    -- variableid = 504
    -- need to compute daily average from hourly
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=504)
    begin
			declare	max_cursor cursor for
						select 	convert(date,dv.utcdatetime), 
									avg(dv.datavalue)
						from 		hourly_airtempdatavalues as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid
						group by convert(date,dv.utcdatetime)

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values										(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
        	end

			close max_cursor;
			deallocate max_cursor;

    end -- blm/kemenitz sourceid = 199
    
    -- arm sourceid = 35
    -- variableid = 519
    -- need to compute daily average from hourly
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=519)
    begin
			declare 	max_cursor cursor for
						select 	convert(date,dv.utcdatetime), 
									avg(dv.datavalue)
						from 		hourly_airtempdatavalues as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid
						group by convert(date,dv.utcdatetime)

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
					insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
					values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
               fetch next from max_cursor into @datetimeutc, @avgvalue;
         end

			close max_cursor;
			deallocate max_cursor;

    end -- arm sourceid = 35
    
    -- arm sourceid = 202,203
    -- variableid = 527
    -- need to compute daily average from hourly
   else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=527)
   begin
			declare max_cursor cursor for
						select 	convert(date,dv.utcdatetime), 
									avg(dv.datavalue)
						from 		hourly_airtempdatavalues as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid
						group by convert(date,dv.utcdatetime)

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
         end

			close max_cursor;
			deallocate max_cursor;

    end -- arm sourceid = 202,203
    
    -- arm sourceid = 203
    -- variableid = 538
    -- need to compute daily average from hourly
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=538)
    begin
			declare max_cursor cursor for
						select 	convert(date,dv.utcdatetime), 
									avg(dv.datavalue)
						from 		hourly_airtempdatavalues as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid
						group by convert(date,dv.utcdatetime)

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
         end

			close max_cursor;
			deallocate max_cursor;

    end  -- arm sourceid = 203
    
    -- lpeters sourceid = 182
    -- variableid = 279
    -- need to compute daily average from hourly
   else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=279)
   begin
		declare  max_cursor cursor for
					select 	convert(date,dv.utcdatetime), 
								avg(dv.datavalue)
					from 		hourly_airtempdatavalues as dv
					where 	dv.siteid = @siteid 
					and 		dv.originalvariableid=@varid
					group by convert(date,dv.utcdatetime)

		open max_cursor;
		fetch next from max_cursor into @datetimeutc, @avgvalue;

		while @@fetch_status = 0
		begin
			insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
			values                              (@avgvalue, @datetimeutc,@siteid,@varid,getdate());
			fetch next from max_cursor into @datetimeutc, @avgvalue;
      end

		close max_cursor;
		deallocate max_cursor;

    end    -- lpeters sourceid = 182
    
    -- lpeters sourceid = 182
    -- variableid = 288
    -- need to compute daily average from hourly
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=288)
    begin
			declare max_cursor cursor for
						select 	convert(date,dv.utcdatetime), 
									avg(dv.datavalue)
						from 		hourly_airtempdatavalues as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid
			group by convert(date,dv.utcdatetime)

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values										(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
        	end

			close max_cursor;
			deallocate max_cursor;

    end   -- lpeters sourceid = 182
    
    
    -- rwis sourceid = 213
    -- variableid = 563
    -- need to compute daily average from hourly
    else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=563)
    begin
			declare 	max_cursor cursor for
						select 	convert(date,dv.utcdatetime), 
									avg(dv.datavalue)
						from 		hourly_airtempdatavalues as dv
						where 	dv.siteid = @siteid 
						and 		dv.originalvariableid=@varid
						group by convert(date,dv.utcdatetime)

			open max_cursor;
			fetch next from max_cursor into @datetimeutc, @avgvalue;

			while @@fetch_status = 0
			begin
				insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
				values 										(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
				fetch next from max_cursor into @datetimeutc, @avgvalue;
        	end

			close max_cursor;
			deallocate max_cursor;

    end   -- rwis sourceid = 213
    
    
    -- toolik temp/daily/c, ast
    -- variableid = 489 (tmin), variableid = 487 (tmax), sourceid = 145
    -- need to calculate 2m at by using 1m and 3m at
    -- need to convert hourly to daily
    -- need to convert from ast to utc time
 		else if exists (select * from seriescatalog_62 where siteid= @siteid and @varid=489)
  		begin
          declare max_cursor cursor for
              		select 	dv.localdatetime, 
              					dv.datavalue
              		from 		odmdatavalues_metric as dv
              		where 	dv.siteid = @siteid 
              		and 		dv.originalvariableid=@varid 
              		and 		dv.offsetvalue = 1
          open max_cursor;
          fetch next from max_cursor into @datetimeutc, @minvalue1m;
          while @@fetch_status = 0
          begin
          		select 	@maxvalue1m = dv.datavalue
               from 		odmdatavalues_metric as dv
               where 	dv.siteid = @siteid 
               and 		dv.originalvariableid=487 
               and 		dv.offsetvalue = 1 
               and 		@datetimeutc = dv.localdatetime;
               
               select @avgvalue1m = (@maxvalue1m - @minvalue1m)/2 + @minvalue1m;
               
               select 	@minvalue3m = dv.datavalue
               from 		odmdatavalues_metric as dv
               where 	dv.siteid = @siteid 
               and 		dv.originalvariableid=@varid 
               and 		dv.offsetvalue = 3 
               and 		@datetimeutc = dv.localdatetime;
               
               select 	@maxvalue3m = dv.datavalue
               from 		odmdatavalues_metric as dv
               where 	dv.siteid = @siteid 
               and 		dv.originalvariableid=487 
               and 		dv.offsetvalue = 3 
               and 		@datetimeutc = dv.localdatetime;
               
               select @avgvalue3m = (@maxvalue3m - @minvalue3m)/2 + @minvalue3m;
              
               select @avgvalue = (@avgvalue3m - @avgvalue1m)/2 + @avgvalue1m;
              
               -- if the 2m at avg is null, check and see if there is a 1m at and use that
               if (@avgvalue is null and @avgvalue1m is not null)
               	begin
                    select @avgvalue = @avgvalue1m;
                	end
               else if (@avgvalue is null and @avgvalue1m is null and @maxvalue1m is not null)
                   begin
							select @avgvalue = @maxvalue1m;
						 end
					else if (@avgvalue is null and @avgvalue1m is null and @minvalue1m is not null)
						begin
							select @avgvalue = @minvalue1m;
						end;
					insert into daily_airtempdatavalues (datavalue,utcdatetime,siteid,originalvariableid,insertdate)
					values(@avgvalue, @datetimeutc,@siteid,@varid,getdate());
               fetch next from max_cursor into @datetimeutc, @minvalue1m;
      	end
        close max_cursor;
        deallocate max_cursor;

end 

end



end;
' language 'plpgsql';