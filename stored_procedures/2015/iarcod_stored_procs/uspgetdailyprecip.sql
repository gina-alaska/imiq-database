USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyPrecip]    Script Date: 02/20/2013 12:56:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Amy Jacobs
-- Create date: March 2,2012
-- Description:	Create the daily precip average for the entire LCC region.  
-- =============================================
CREATE  PROCEDURE [dbo].[uspGetDailyPrecip] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @localDateTime datetime, @maxValue float,
    @minValue float, @AvgValue float, @AvgValue1m float, @AvgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float,
    @methodID int, @qualifierID int, @variableID int;
    
    -- NCDC GHCN.  Precip/mm/Daily.  SourceID = 4 
    -- VariableID = 398
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND VariableID=398)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=398;
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=398;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- If there is no GHCN, check for ISH
    -- VariableID = 340 is ISH Precip/UTC hourly/mm.  Needs to be converted to a Daily value.  SourceID = 4
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=340)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), SUM(dv.DataValue)
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=340
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=340;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- UAF/WERC:  Precip/mm, AST
    -- VariableID = 84. SourceID = 29, 30, 31, 34
    -- Needs to be converted to a Daily value.  
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=84)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=84 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=84;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  
    -- USGS:  Precip/hourly/mm, AST
    -- VariableID = 319. SourceID = 39
    -- Needs to be converted to a Daily value.
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=319)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=319 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=319;
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
	        FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- RAWS/NPS:  Precip/daily/mm, UTC
    -- VariableID = 441, SourceID = 114 and SourceID = 116
   
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=441)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=441;
		
		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=441;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- SNOTEL  Temp/daily/inches, UTC
    -- VariableID = 394, SourceID = 124
    -- Convert from inches to mm
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=394)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=394;
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=394;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @AvgValue = @AvgValue * 25.4;
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
    -- Toolik  Precip/hourly/mm, AST
    -- VariableID = 461, SourceID = 145
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
 ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID= 461)
  BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=461 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=461;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  
  
    -- McCall  Precip/daily/inches 
    -- VariableID = 199, SourceID = 178 and SourceID = 182
    --need to convert from inches to mm
    -- need to do an average on the LocalDateTime, since three of the data values are not daily, but hourly.
 ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=199)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), SUM(dv.DataValue)
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=@VarID
		group by CONVERT(Date,dv.LocalDateTime);
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=@VarID;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @AvgValue = @AvgValue * 25.4;
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    -- UAF. Precip/mm/Daily  SourceID = 180
    -- VariableID = 274
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND VariableID=274)
   BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=274;
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=274;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- Chamberlin. Precip/inches/Daily  SourceID = 183
    -- VariableID = 301
    -- Need to convert to mm.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND VariableID=301)
     BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=301;
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=301;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @AvgValue = @AvgValue * 25.4;
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- BLM/Kemenitz. Precip/mm/Hourly  SourceID = 199
    -- VariableID = 496 
    -- Need to compute daily.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=496)
 BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=496 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=496;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  -- BLM/Kemenitz. Precip/inches/every 15 minutes  SourceID = 199
    -- VariableID = 458 
    -- Need to convert to mm
    -- Need to convert to UTC
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @varID=458)
     BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=458 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=458;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @AvgValue = @AvgValue * 25.4;
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  -- BLM/Kemenitz. Precip/inches/daily  SourceID = 199
  -- VariableID = 62
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @varID=62)
         BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), dv.DataValue
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=@varID and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=@varID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @AvgValue = @AvgValue * 25.4;
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
-- BLM/Kemenitz. Precip/inches/Minute  SourceID = 139
  -- VariableID = 336
  -- Convert from inches to mm
  -- Convert from AST to UTC
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID = @SiteID AND @varID=336)
         BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=@varID and dv.siteid in 
		(select distinct siteid from ODMDataValues where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=@varID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @AvgValue = @AvgValue * 25.4;
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
-- ARM. Precip/mm/Minute  SourceID = 35
    -- VariableID = 522 
    -- Need to compute daily average
    -- These values are all NULL, as of 2/17/2012
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID = @SiteID AND VariableID=522)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), SUM(dv.DataValue)
        FROM ODMDataValues AS dv
        WHERE dv.SiteID = @SiteID and dv.VariableID=522
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
        select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=522;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
-- ARM. Precip/mm/Minute  SourceID = 1,203
    -- VariableID = 539 Precip Rate/hour
    -- Need to compute daily average
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=539)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), SUM(dv.DataValue)
        FROM ODMDataValues AS dv
        WHERE dv.SiteID = @SiteID and dv.VariableID=@VarID
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
 
 -- ARM. Precip/mm/Second  SourceID = 203
    -- VariableID = 530 Precip rate
    -- Need to compute daily average
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID = @SiteID AND @VarID=530)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), SUM(dv.DataValue)
        FROM ODMDataValues AS dv
        WHERE dv.SiteID = @SiteID and dv.VariableID=@VarID 
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
        select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END  
 
    -- LPeters. Precip/inches/Hourly  SourceID = 182
    -- VariableID = 294 Avg AT
    -- Need to compute daily average
    -- Need to convert to UTC time
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=294)
      BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
        FROM ODMDataValues AS dv
        WHERE dv.SiteID = @SiteID and dv.VariableID=@VarID 
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
        select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       select @AvgValue = @AvgValue * 25.4;
	       INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END  
    
END









GO

