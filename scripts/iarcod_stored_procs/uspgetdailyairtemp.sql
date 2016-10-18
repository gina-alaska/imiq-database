USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyAirTemp]    Script Date: 02/20/2013 12:56:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Amy Jacobs
-- Create date: Feb 16,2012
-- Description:	Create the daily air temperatures at 2m. 
-- Updated: 8/2/2012 
-- Updates: This stored procedure is sending the data to a temp table for the DAILY_AirTempDataValues, which will be used to calculate
-- monthly, yearly data values
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailyAirTemp] 
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
    
    -- NCDC GHCN.  SourceID = 4 
    -- VariableID = 403 is TMAX
    -- VariableID = 404 is TMIN
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND VariableID=403)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=403;

		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=403;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @maxValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SELECT @minValue = dv.DataValue
	        FROM DataValues AS dv
	        INNER JOIN seriesCatalog ON seriesCatalog.DatastreamID = dv.datastreamID
	        WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=404 and dv.LocalDateTime = @localDateTime;

		    SELECT @avgValue = ( @maxValue - @minValue ) / 2 + @minValue;
		    
		    --if the avgValue is NULL, but we have a max or a min value stored, use it
		    IF(@avgValue is NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = @maxValue;
			END
			ELSE IF (@avgValue is NULL and @minValue is not NULL)
			BEGIN
				SELECT @avgValue = @minValue;
			END 
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @maxValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- If there is no GHCN, check for ISH
    -- VariableID = 218 is ISH Average Air Temp hourly.  Needs to be converted to a Daily value.  SourceID = 4
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=218)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), AVG(dv.DataValue)
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=218
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=218;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- UAF/WERC:  Temp/hourly/C, AST
    -- VariableID = 81. Needs to be converted to a Daily value.  SourceID = 29, 30, 31, 34
    -- Need to make sure offset is 2m or 1.5m
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=81 AND (OffsetValue = 2 or OffsetValue = 1.5))
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=81 and (dv.offsetvalue = 2 or dv.offsetvalue = 1.5) and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=81;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  -- UAF/WERC:  Temp/hourly/C, AST
    -- VariableID = 81. Needs to be converted to a Daily value.  SourceID = 29, 30, 31, 34
    -- Need to convert 1m and 3m to 2m
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=81 AND OffsetValue = 1)
     BEGIN
          DECLARE max_cursor CURSOR FOR 
              SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
              FROM ODMDataValues AS dv
              WHERE dv.SiteID = @SiteID and dv.VariableID=81 and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriesCatalog where @SiteID = siteid)
              GROUP BY CONVERT(Date,dv.DateTimeUTC);
              
		      select @methodID = s.methodID, @variableID=s.VariableID
		       from seriesCatalog s
		       WHERE s.SiteID = @SiteID and s.VariableID=81;
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @avgValue3m = avg(dv.DataValue)
                      FROM ODMDataValues AS dv
                      WHERE dv.SiteID = @SiteID and dv.VariableID=81 and dv.offsetvalue = 3 and @localDateTime = CONVERT(Date,dv.DateTimeUTC) and dv.siteid in 
                  (select distinct siteid from seriesCatalog where @SiteID = siteid);
                  SELECT @avgValue = (@avgValue3m - @avgValue1m)/2 + @avgValue1m;
                  -- If the 2m average temp is NULL, check and see if there is a 1m air temp and use it.
                   IF (@avgValue is  NULL and @avgValue1m is not NULL)
                   BEGIN
                       SELECT @avgValue = @avgValue1m;
                   END
	               INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	               VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
                  FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
END
    -- USGS:  Temp/hourly/C, AST
    -- VariableID = 310. Needs to be converted to a Daily value.  SourceID = 39
    -- No offset value is given
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=310)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=310 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=310;
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
	        FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- RAWS/NPS:  Temp/daily/C, UTC
    -- VariableID = 432, SourceID = 114 and SourceID = 116
    -- No offset value is given
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=432)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=432;
		
		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=432;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- SNOTEL  Temp/daily/C, UTC
    -- VariableID = 393, SourceID = 124
    -- No offset value is given
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=393)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=393;
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=393;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
    -- Toolik  Temp/hourly/C, AST
    -- VariableID = 489 (TMIN), VariableID = 487 (TMAX), SourceID = 145
    -- Need to calculate 2m AT by using 1m and 3m AT
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
 ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=489)
  BEGIN
          DECLARE max_cursor CURSOR FOR 
              SELECT dv.LocalDateTime, dv.DataValue
              FROM ODMDataValues AS dv
              WHERE dv.SiteID = @SiteID and dv.VariableID=489 and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriesCatalog where @SiteID = siteid);
            select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=489;
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @localDateTime, @minValue1m;
              
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @maxValue1m = dv.DataValue
                      FROM ODMDataValues AS dv
                      WHERE dv.SiteID = @SiteID and dv.VariableID=487 and dv.offsetvalue = 1 and @localDateTime = dv.LocalDateTime and dv.siteid in 
                  (select distinct siteid from seriesCatalog where @SiteID = siteid);
                  SELECT @avgValue1m = (@maxValue1m - @minValue1m)/2 + @minValue1m;
                  
                  select @minValue3m = dv.datavalue
                      FROM ODMDataValues AS dv
                      WHERE dv.SiteID = @SiteID and dv.VariableID=489 and dv.offsetvalue = 3 and @localDateTime = dv.LocalDateTime and dv.siteid in 
                  (select distinct siteid from seriesCatalog where @SiteID = siteid);
                  
                   select @maxValue3m = dv.datavalue
                      FROM ODMDataValues AS dv
                      WHERE dv.SiteID = @SiteID and dv.VariableID=487 and dv.offsetvalue = 3 and @localDateTime = dv.LocalDateTime and dv.siteid in 
                  (select distinct siteid from seriesCatalog where @SiteID = siteid);
                  
                  SELECT @avgValue3m = (@maxValue3m - @minValue3m)/2 + @minValue3m;
                  SELECT @avgValue = (@avgValue3m - @avgValue1m)/2 + @avgValue1m;
                  
                  
                 -- if the 2m AT avg is NULL, check and see if there is a 1m AT and use that
                 IF (@avgValue is NULL and @avgValue1m is not NULL)
                 BEGIN
                    SELECT @avgValue = @avgValue1m;
                  END
                 ELSE IF (@avgValue1m is NULL and @maxValue1m is not NULL)
                   BEGIN
					 SELECT @avgValue = @maxValue1m;
					END
			     ELSE IF (@avgValue1m is NULL and @minValue1m is not NULL)
					BEGIN
						SELECT @avgValue = @minValue1m;
					END;
	             INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	                VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
                 FETCH NEXT FROM max_cursor INTO @localDateTime, @minValue1m;
      END

          CLOSE max_cursor;
              DEALLOCATE max_cursor;

  END
  
    -- McCall  Temp/daily/F, AST
    -- VariableID = 195 (TMAX), VariableID = 196 (TMIN), SourceID = 178 and SourceID = 182
    -- Need to convert to AVG AT
 ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=195)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=195;
	    select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=195;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @maxValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SELECT @minValue = dv.DataValue
		    FROM DataValues AS dv
		    INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		    WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=196 and dv.LocalDateTime = @localDateTime;
		    SELECT @avgValue =  (@maxValue - @minValue ) / 2 + @minValue;
		    
		    IF (@avgValue is NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = @maxValue;
			END
			ELSE IF (@avgValue is NULL and @minValue is not NULL)
			BEGIN
				SELECT @avgValue = @minValue;
			END
		    SELECT @avgValue = (@avgValue - 32) / 9 * 5;
			
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @maxValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
-- McCall  Temp/daily/C, AST
    -- VariableID = 277, SourceID = 179
 ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=277)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=277;
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=277;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	               INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	               VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
	               FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- UAF. Temp/C/Daily  SourceID = 180
    -- VariableID = 223 is TMAX
    -- VariableID = 225 is TMIN
    -- Need to compute average.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND VariableID=223)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=223;
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=223;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @maxValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SELECT @minValue = dv.DataValue
	        FROM DataValues AS dv
	        INNER JOIN seriesCatalog ON seriesCatalog.DatastreamID = dv.datastreamID
	        WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=225 and dv.LocalDateTime = @localDateTime;
		    SELECT @avgValue = ( @maxValue - @minValue ) / 2 + @minValue;
		    
		    IF (@avgValue is NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = @maxValue;
			END
			ELSE IF (@avgValue is NULL and @minValue is not NULL)
			BEGIN
				SELECT @avgValue = @minValue;
			END
			
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @maxValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- Chamberlin. Temp/F/Daily  SourceID = 183
    -- VariableID = 295 is TMAX
    -- VariableID = 296 is TMIN
    -- Need to compute average.
    -- Need to convert from F to C.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND VariableID=295)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=295;

        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=295;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @maxValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SELECT @minValue = dv.DataValue
	        FROM DataValues AS dv
	        INNER JOIN seriesCatalog ON seriesCatalog.DatastreamID = dv.datastreamID
	        WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=296 and dv.LocalDateTime = @localDateTime;
		    SELECT @avgValue = ( @maxValue - @minValue ) / 2 + @minValue;
		    
		    IF (@avgValue is NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = @maxValue;
			END
			ELSE IF (@avgValue is NULL and @minValue is not NULL)
			BEGIN
				SELECT @avgValue = @minValue;
			END
		    SELECT @avgValue = (@avgValue - 32) / 9 * 5;
			
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
	        FETCH NEXT FROM max_cursor INTO @localDateTime, @maxValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- BLM/Kemenitz. Temp/C/Daily  SourceID = 199
    -- VariableID = 61 AVG AT
    -- Need to compute average.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=61)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=61;

        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=61;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  -- BLM/Kemenitz. Temp/C/Hourly  SourceID = 199
    -- VariableID = 442 AVG AT
    -- Need to compute daily average
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=442)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), AVG(dv.DataValue)
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=442
		GROUP BY CONVERT(Date,dv.LocalDateTime);
		
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=442;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  -- BLM/Kemenitz. Temp/C/Minute  SourceID = 199
    -- VariableID = 504 AVG AT
    -- Need to compute daily average
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=504)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), AVG(dv.DataValue)
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=504
		GROUP BY CONVERT(Date,dv.LocalDateTime);
		
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=504;
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
		    
	       INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
-- ARM. Temp/C/Minute  SourceID = 35
    -- VariableID = 519 AVG AT
    -- Need to compute daily average
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID = @SiteID AND VariableID=519)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), AVG(dv.DataValue)
        FROM ODMDataValues AS dv
        WHERE dv.SiteID = @SiteID and dv.VariableID=519 
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
        select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=519;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
-- ARM. Temp/C/Minute  SourceID = 203
    -- VariableID = 527 AVG AT
    -- Need to compute daily average
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID = @SiteID AND @VarID=527)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), AVG(dv.DataValue)
        FROM ODMDataValues AS dv
        WHERE dv.SiteID = @SiteID and dv.VariableID=@VarID
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
        select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
 
 -- ARM. Temp/C/Second  SourceID = 203
    -- VariableID = 538 AVG AT
    -- Need to compute daily average
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID = @SiteID AND @VarID=538)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), AVG(dv.DataValue)
        FROM ODMDataValues AS dv
        WHERE dv.SiteID = @SiteID and dv.VariableID=@VarID 
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
        select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END  
 
    -- LPeters. Temp/F/Hourly  SourceID = 182
    -- VariableID = 279 AVG AT
    -- Need to compute daily average
    -- Need to convert to UTC time
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=279)
      BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
        FROM ODMDataValues AS dv
        WHERE dv.SiteID = @SiteID and dv.VariableID=@VarID 
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
        select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       SELECT @avgValue = (@avgValue - 32) / 9 * 5;
	       INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END  
    -- LPeters. Temp/F/Hourly  SourceID = 182
    -- VariableID = 288 AVG AT
    -- Need to compute daily average
    -- Need to convert to UTC time
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=288)
      BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
        FROM ODMDataValues AS dv
        WHERE dv.SiteID = @SiteID and dv.VariableID=@VarID 
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
        select @methodID = s.methodID, @variableID=s.VariableID
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       SELECT @avgValue = (@avgValue - 32) / 9 * 5;
	       INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
           FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END  
END








GO

