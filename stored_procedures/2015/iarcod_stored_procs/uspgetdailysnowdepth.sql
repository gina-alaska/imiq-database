USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailySnowDepth]    Script Date: 02/20/2013 12:57:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Amy Jacobs
-- Create date: August 14, 2012
-- Description:	Create the daily snow depth average.  
-- Units: meters, format Decimal(6,3)
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailySnowDepth] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @localDateTime datetime, @maxValue float,
    @minValue float, @avgValue float, @avgValue1m float, @avgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float,
    @methodID int, @qualifierID int, @variableID int;
    
    -- NCDC GHCN.  Snow Depth/mm/Daily.  SourceID = 4 
    -- VariableID = 402
    -- Convert from mm to meters
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND VariableID=402)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime),dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=402;
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=402;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue / 1000;
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- If there is no GHCN, check for ISH
    -- VariableID = 370 is ISH Snow Depth/hourly/cm.  Needs to be converted to a Daily value.  SourceID = 4
    -- Convert from cm to meters
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=370)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), AVG(dv.DataValue)
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=370
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=370;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue / 100;
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- UAF/WERC:  Snow Depth/cm, AST
    -- VariableID = 75. Needs to be converted to a Daily value.  SourceID = 29, 30, 34
    -- Need to convert to UTCDateTime
    -- Need to convert from cm to meters
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=75)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=75 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=75;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue / 100;
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  
    -- USGS:  Snow depth/hourly/cm, AST
    -- VariableID = 320. Needs to be converted to a Daily value.  SourceID = 39
    -- Need to convert to UTCDateTime
    -- Need to convert from cm to meters
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=320)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=320 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=320;
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue / 100;
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
	        FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- RAWS/NPS:  Snow depth/daily/mm, UTC
    -- VariableID = 440, SourceID = 116
    -- Convert from mm to meters
   
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=440)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=440;
		
		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=440;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue / 1000;
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- Snow Course  Snow Depth/daily/inches, UTC
    -- VariableID = 396, SourceID = 200
    -- Convert from inches to mm
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=396)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=396;
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=396;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @avgValue = @avgValue * 0.0254;
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END

  -- UAF/WERC. Snow Depth/meters/Daily  SourceID = 31
    -- VariableID = 339 AST
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @varID=339)
         BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=@varID and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid);
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=@varID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
-- UAF/WERC. Snow Depth/meters/Hourly  SourceID = 31
    -- VariableID = 193
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @varID=193)
         BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=@varID and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=@varID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
-- UAF/WERC. Snow Depth/cm/Yearly  SourceID = 3, SourceID = 193
-- VariableID = 142 AST
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @varID=142)
         BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime),dv.DataValue
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=@varID and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=@varID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue / 100;
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
-- ARM. Snow Depth/mm/Minutely  SourceID = 1, 203
-- VariableID = 543
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID = @SiteID AND @varID=543)
         BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=@varID and dv.siteid in 
		(select distinct siteid from ODMDatavalues where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=@varID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue / 1000;
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END    
END








GO

