declare @siteID as int, @sourceID as int, @varID as int;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (209); /* ISH: SourceID=209, VariableID=340) */
select @varID = 340;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (29, 30, 31, 34); /* UAF/WERC: SourceID in (29, 30, 31, 34), VariableID=84) */
select @varID = 84;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (39); /* USGS: 39, VariableID=319) */
select @varID = 319;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (145); /* Toolik: SourceID=145, VariableID=461) */
select @varID = 461;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (199); /* BLM: SourceID=199, VariableID=496) */
select @varID = 496;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (199); /* BLM: SourceID=199, VariableID=458) */
select @varID = 458;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (139); /* BLM: SourceID=139, VariableID=336) */
select @varID = 336;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (35); /* BLM: SourceID=35, VariableID=522) */
select @varID = 522;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (1,203); /* BLM: SourceID=1,203, VariableID=539) */
select @varID = 539;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (182); /* LPeters: SourceID=182, VariableID=294) */
select @varID = 294;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (213); /* RWIS: SourceID=213, VariableID=575) */
select @varID = 575;
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
	        execute uspGetHourlyPrecip @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;