USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyAvgTemp]    Script Date: 02/20/2013 12:56:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Amy Jacobs
-- Create date: April 12,2012
-- Description:	Create the daily average air temperature.
-- for Toolik project  
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailyAvgTemp] 
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
    
      -- UAF/WERC:  Temp/hourly/C, AST
    -- VariableID = 81. Needs to be converted to a Daily value.  SourceID = 31
    -- Need to make sure offset is 2m or 1.5m
    -- Need to convert to UTCDateTime
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=81 AND (OffsetValue = 2 or OffsetValue = 1.5))
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
	        INSERT INTO DailyTempAvgDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  -- UAF/WERC:  Temp/hourly/C, AST
    -- VariableID = 81. Needs to be converted to a Daily value.  SourceID = 31
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
	               INSERT INTO DailyTempAvgDataValues  (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	               VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
                  FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
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
	        INSERT INTO DailyTempAvgDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
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
	             INSERT INTO DailyTempAvgDataValues  (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	                VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
                 FETCH NEXT FROM max_cursor INTO @localDateTime, @minValue1m;
      END

          CLOSE max_cursor;
              DEALLOCATE max_cursor;

  END
  
END



GO

