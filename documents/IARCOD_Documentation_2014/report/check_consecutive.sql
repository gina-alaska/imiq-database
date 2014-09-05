declare @valueID as int, @siteID as int, @varID as int, @origVarID as int, @utcDateTime as datetime, @dailyValue as float;
declare @prevSiteID as int, @prevVarID as int, @prevDailyValue as float;
declare @inc as int, @msg as varchar(2000);

DECLARE loop_cursor CURSOR FOR
SELECT ValueID, SiteID, VariableID, OriginalVariableID, UTCDateTime, DataValue from DAILY_Precip ORDER BY SiteID, VariableID, UTCDateTime; /* ISH: SourceID=209, VariableID=218) */
OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @valueID,@siteID,@varID,@origVarID,@utcDateTime,@dailyValue;

WHILE @@FETCH_STATUS = 0
BEGIN
	IF (@siteID != @prevSiteID
		or @varID != @prevVarID)
	BEGIN
		set @prevSiteID = @siteID
		set @prevVarID = @varID
		set @prevDailyValue = @dailyValue
		set @inc = 0
	END
	ELSE IF (@dailyValue = @prevDailyValue
			and @dailyValue > 0)
	BEGIN
		set @inc = @inc + 1
		IF (@inc = 5) /* check for 5 in a row */
 		BEGIN
			PRINT @msg
			PRINT RTRIM(CAST(@valueID as nvarchar(12))) + N',' + RTRIM(CAST(@siteID as nvarchar(12))) + N',' + RTRIM(CAST(@varID as nvarchar(10))) + N',' + RTRIM(CAST(@origVarID as nvarchar(10))) + N',' + RTRIM(CAST(@utcDateTime as nvarchar(30))) + N',' + RTRIM(CAST(@dailyValue as nvarchar(15)))
		END
		ELSE IF (@inc > 5)
			PRINT RTRIM(CAST(@valueID as nvarchar(12))) + N',' + RTRIM(CAST(@siteID as nvarchar(12))) + N',' + RTRIM(CAST(@varID as nvarchar(10))) + N',' + RTRIM(CAST(@origVarID as nvarchar(10))) + N',' + RTRIM(CAST(@utcDateTime as nvarchar(30))) + N',' + RTRIM(CAST(@dailyValue as nvarchar(15)))
		ELSE
			set @msg = RTRIM(CAST(@msg as nvarchar(2000))) + RTRIM(CAST(@valueID as nvarchar(12))) + N',' + RTRIM(CAST(@siteID as nvarchar(12))) + N',' + RTRIM(CAST(@varID as nvarchar(10))) + N',' + RTRIM(CAST(@origVarID as nvarchar(10))) + N',' + RTRIM(CAST(@utcDateTime as nvarchar(30))) + N',' + RTRIM(CAST(@dailyValue as nvarchar(15))) + CHAR(13) + CHAR(10)
	END
	ELSE
	BEGIN
		set @prevDailyValue = @dailyValue
		set @inc = 0
		set @msg = N''
	END
	FETCH NEXT FROM loop_cursor INTO @valueID,@siteID,@varID,@origVarID,@utcDateTime,@dailyValue;
END

CLOSE loop_cursor;
DEALLOCATE loop_cursor;
