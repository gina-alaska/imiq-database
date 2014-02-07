declare @siteID as int, @sourceID as int, @varID as int;
/*GHCN load 
SourceID: 210
VariableID for GHCN: 403 (TMAX), 404 (TMIN)
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (210);
select @varID = 404;
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*ISH load 
SourceID: 209
VariableID=218
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (209);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*UAF/WERC load 
SourceID: 29,30,31,34
VariableID=81
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (29,30,31,34);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*USGS load 
SourceID: 39
VariableID=310
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (39);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*BLM/Kemenitz load 
SourceID: 199
VariableID=442
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (199);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;
/*BLM/Kemenitz load 
SourceID: 199
VariableID=504
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (199);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*ARM load 
SourceID: 35
VariableID=519
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (35);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*ARM load 
SourceID: 202,203
VariableID=527
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (202,203);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*ARM load 
SourceID: 203
VariableID=538
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (203);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*LPeters load 
SourceID: 182
VariableID=279
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (182);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*LPeters load 
SourceID: 182
VariableID=288
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (182);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*RAWS/NPS
SourceID: 211
VariableID: 432
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (211);
select @varID = 432;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*SNOTEL
SourceID: 212,
VariableID: 393
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (212);
select @varID = 393;
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*Toolik Field Service
SourceID = 145,
VariableID = 489 (TMIN), 487 (TMAX)
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (145);
select @varID = 489;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*McCall
SourceID: 178, 182
VariableID: 195 (TMAX) 196 (TMIN)
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (178,182);
select @varID = 195;
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;


/*McCall
SourceID: 179
VariableID: 277
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (179);
select @varID = 277;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*UAF
SourceID: 180
VariableID: 223 (TMAX), 225(TMIN)
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (180);
select @varID = 223;
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*Chamberlin
SourceID: 183
VariableID: 295 (TMAX), 296(TMIN)
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (183);
select @varID = 295;
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*BLM/Kemenitz
SourceID: 199
VariableID: 61 
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (199);
select @varID = 61;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*BLM/Kemenitz
SourceID: 199
VariableID: 442
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (199);
select @varID = 442;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;


/*BLM/Kemenitz
SourceID: 199
VariableID: 504
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (199);
select @varID = 504;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*ARM
SourceID: 35
VariableID: 519
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (35);
select @varID = 519;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*ARM
SourceID: 203
VariableID: 527
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (203);
select @varID = 527;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*ARM
SourceID: 203
VariableID: 538
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (203);
select @varID = 538;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*LPeters
SourceID: 182
VariableID: 279
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (182);
select @varID = 279;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*LPeters
SourceID: 182
VariableID: 288
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (182);
select @varID = 288;
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @sourceID;

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE site_cursor CURSOR FOR 
		SELECT distinct siteid
		FROM seriesCatalog
		WHERE sourceid = @sourceID;
		
	    OPEN site_cursor;
		FETCH NEXT FROM site_cursor INTO @siteID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*Permafrost Lab UAF load 
SourceID: 206
VariableID for Permafrost Lab/UAF: 550
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (206);
select @varID = 550;
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*RWIS load 
SourceID: 213
VariableID:563
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (213);
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;

/*Toolik load 
SourceID: 145
VariableID:489
*/
DECLARE loop_cursor CURSOR FOR
SELECT SourceID from Sources where sourceID in (145);
select @varID = 489;
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
	        execute uspGetDailyAirTemp @siteID,@varID;
	        FETCH NEXT FROM site_cursor INTO @siteID;
        END;

	    CLOSE site_cursor;
		DEALLOCATE site_cursor;
		FETCH NEXT FROM loop_cursor INTO @sourceID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;