USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyRH]    Script Date: 02/20/2013 12:57:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











-- =============================================
-- Author:		Amy Jacobs
-- Create date: March 7, 2012
-- Description:	Create the daily relative humidity at 2m for all of ArcticLCC 
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailyRH] 
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
    

    -- ARM.  RH/Minute/UTC SourceID = 202
    -- VariableID = 523, Minute
    -- Needs to be converted to a Daily value. 
   IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID= 523)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), AVG(dv.DataValue)
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID= 523
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID= 523;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_RHDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- UAF/WERC:  RH/hourly/1m and 3m/AST
    -- VariableID = 80. Needs to be converted to a Daily value.  SourceID = 29, 30, 31, 34
    -- Need to make sure offset is 2m or 1.5m
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=80 AND (OffsetValue = 2 or OffsetValue = 1.5))
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=80 and (dv.offsetvalue = 2 or dv.offsetvalue = 1.5) and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=80;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_RHDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  -- UAF/WERC:  RH/hourly/1m and 3m/AST
    -- VariableID = 80. Needs to be converted to a Daily value.  SourceID = 29, 30, 31, 34
    -- Need to convert 1m and 3m to 2m
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=80 AND OffsetValue = 1)
     BEGIN
          DECLARE max_cursor CURSOR FOR 
              SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
              FROM ODMDataValues AS dv
              WHERE dv.SiteID = @SiteID and dv.VariableID=80 and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriesCatalog where @SiteID = siteid)
              GROUP BY CONVERT(Date,dv.DateTimeUTC);
              
		      select @methodID = s.methodID, @variableID=s.VariableID
		       from seriesCatalog s
		       WHERE s.SiteID = @SiteID and s.VariableID=80;
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @avgValue3m = avg(dv.DataValue)
                      FROM ODMDataValues AS dv
                      WHERE dv.SiteID = @SiteID and dv.VariableID=80 and dv.offsetvalue = 3 and @localDateTime = CONVERT(Date,dv.DateTimeUTC) and dv.siteid in 
                  (select distinct siteid from seriesCatalog where @SiteID = siteid);
                  SELECT @avgValue = (@avgValue3m - @avgValue1m)/2 + @avgValue1m;
                  -- If the 2m average temp is NULL, check and see if there is a 1m air temp and use it.
                   IF (@avgValue is  NULL and @avgValue1m is not NULL)
                   BEGIN
                       SELECT @avgValue = @avgValue1m;
                   END
	               INSERT INTO DAILY_RHDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	               VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
                  FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
END
    -- Toolik:  RH/hourly/1m and 3m/AST
    -- VariableID = 467. Needs to be converted to a Daily value.  SourceID = 145
    -- Need to convert 1m and 3m to 2m
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=467 AND OffsetValue = 1)
     BEGIN
          DECLARE max_cursor CURSOR FOR 
              SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
              FROM ODMDataValues AS dv
              WHERE dv.SiteID = @SiteID and dv.VariableID=467 and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriesCatalog where @SiteID = siteid)
              GROUP BY CONVERT(Date,dv.DateTimeUTC)
              order by CONVERT(Date,dv.DateTimeUTC);
              
		      select @methodID = s.methodID, @variableID=s.VariableID
		       from seriesCatalog s
		       WHERE s.SiteID = @SiteID and s.VariableID=467;
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @avgValue3m = avg(dv.DataValue)
                      FROM ODMDataValues AS dv
                      WHERE dv.SiteID = @SiteID and dv.VariableID=467 and dv.offsetvalue = 3 and @localDateTime = CONVERT(Date,dv.DateTimeUTC) and dv.siteid in 
                  (select distinct siteid from seriesCatalog where @SiteID = siteid);
                  SELECT @avgValue = (@avgValue3m - @avgValue1m)/2 + @avgValue1m;
                  -- If the 2m average temp is NULL, check and see if there is a 1m air temp and use it.
                   IF (@avgValue is  NULL and @avgValue1m is not NULL)
                   BEGIN
                       SELECT @avgValue = @avgValue1m;
                   END
	               INSERT INTO DAILY_RHDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	               VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
                  FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
END

    -- LChamberlin:  RH/Daily/AST
    -- VariableID = 299. SourceID = 183
    -- No offset value is given
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=299)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), dv.DataValue
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=299 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid);
		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=299;
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_RHDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
	        FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- RAWS/NPS:  RH/daily/UTC
    -- VariableID = 435, SourceID = 114 and SourceID = 116
    -- No offset value is given
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=435)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=435;
		
		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=435;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_RHDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    

    

    
     -- NOAA. RH/Minute SourceID = 35
    -- VariableID = 518
    -- Need to compute average.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=518)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), AVG(dv.DataValue)
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID= 518
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID= 518;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       INSERT INTO DAILY_RHDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
      -- LPeters. RH/hourly SourceID = 182
    -- VariableID = 293
    -- convert to utc
    -- Need to compute average.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=293)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE  SiteID = @SiteID and  VariableID= 293
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID= 293;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       INSERT INTO DAILY_RHDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
		
 END
       -- McCall. RH/daily/AST SourceID = 198
    -- VariableID = 198
    -- convert to utc
    -- Need to compute average.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=198)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE  SiteID = @SiteID and  VariableID= 198
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID= 198;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       INSERT INTO DAILY_RHDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
           VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
		
 END

END






GO

