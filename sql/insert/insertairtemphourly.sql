declare @siteID as int, @sourceID as int, @varID as int;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (209); /* ISH: SourceID=209, VariableID=218) */
select @varID = 218;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (29, 30, 31, 34); /* ISH: SourceID=29,30,31,34, VariableID=81) */
select @varID = 81;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID=39; /* USGS: SourceID=39, VariableID=310) */
select @varID = 310;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID=199; /* BLM/Kemenitz: SourceID=199, VariableID=442) */
select @varID = 442;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID=199; /* BLM/Kemenitz Minute: SourceID=199, VariableID=504) */
select @varID = 504;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID=35; /* ARM Minute: SourceID=35, VariableID=519) */
select @varID = 519;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in(202,203); /* ARM Minute: SourceID=202,203, VariableID=527) */
select @varID = 527;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID=203; /* ARM Second: SourceID=203, VariableID=538) */
select @varID = 538;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID=182; /* LPeters: SourceID=182, VariableID=279) */
select @varID = 279;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID=182; /* LPeters: SourceID=182, VariableID=288) */
select @varID = 288;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID=213; /* RWIS: SourceID=213, VariableID=563) */
select @varID = 563;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID=145; /* Toolik: SourceID=145, VariableID=466) */
select @varID = 466;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN


DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog_62
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetHourlyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

