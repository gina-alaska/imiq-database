declare @siteID as int, @sourceID as int, @varID as int;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (193); 
select @varID = 155;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID 
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyWaterTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;