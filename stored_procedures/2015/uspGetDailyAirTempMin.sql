USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyAirTempMin]    Script Date: 01/09/2015 13:44:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		Amy Jacobs
-- Create date: Sept 18, 2013
-- Added in InsertDate on 2/12/2014
-- Description:	Daily Min air temperatures at 2m. 
-- This stored procedure is sending the data to a temp table for the DAILY_AirTempMinDataValues, which will be used to calculate
-- monthly, yearly data values
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailyAirTempMin] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime,@Value float,@Value1m float, @Value3m float, @OriginalVariableID int;
    
    -- NCDC GHCN.  SourceID = 210 
    -- VariableID = 404 is TMin
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=404)
	    BEGIN
	   	DECLARE Min_cursor CURSOR FOR 
		SELECT dv.DateTimeUTC, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN Min_cursor;
		FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE Min_cursor;
		DEALLOCATE Min_cursor;

    END
   
    -- RAWS/NPS:  Temp Min
    -- VariableID = 434, SourceID = 211
    -- No offset value is given
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=434)
    BEGIN
	   	DECLARE Min_cursor CURSOR FOR 
		SELECT dv.DateTimeUTC, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN Min_cursor;
		FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE Min_cursor;
		DEALLOCATE Min_cursor;

    END
    -- SNOTEL  Temp Min
    -- VariableID = 627, SourceID = 212
    -- No offset value is given
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=627)
    BEGIN
	   	DECLARE Min_cursor CURSOR FOR 
		SELECT dv.DateTimeUTC, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN Min_cursor;
		FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE Min_cursor;
		DEALLOCATE Min_cursor;

    END

    -- SNOTEL  Temp Min
    -- VariableID = 667, SourceID = 212
    -- No offset value is given
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=627)
    BEGIN
	   	DECLARE Min_cursor CURSOR FOR 
		SELECT dv.DateTimeUTC, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN Min_cursor;
		FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE Min_cursor;
		DEALLOCATE Min_cursor;

    END
       
    -- SNOTEL  Temp Min
    -- VariableID = 392, SourceID = 212
    -- No offset value is given
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=392)
    BEGIN
	   	DECLARE Min_cursor CURSOR FOR 
		SELECT dv.DateTimeUTC, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN Min_cursor;
		FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE Min_cursor;
		DEALLOCATE Min_cursor;

    END
    
    
  
    -- McCall  Temp/daily/F, AST
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- VariableID = 196 (TMin), SourceID = 178,182
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=196)
    BEGIN
	   	DECLARE Min_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN Min_cursor;
		FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE Min_cursor;
		DEALLOCATE Min_cursor;

    END
    

    -- UAF. Temp/C/Daily  SourceID = 180
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- VariableID = 225 is TMin
       IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=225)
    BEGIN
	   	DECLARE Min_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN Min_cursor;
		FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE Min_cursor;
		DEALLOCATE Min_cursor;

    END
    
     -- Chamberlin. Temp/F/Daily  SourceID = 183
    -- VariableID = 296 is TMin
       IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=296)
    BEGIN
	   	DECLARE Min_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN Min_cursor;
		FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE Min_cursor;
		DEALLOCATE Min_cursor;

    END
    
    -- Toolik  Temp/daily/C, AST
    -- VariableID = 489 (TMin), SourceID = 145
    -- Need to calculate 2m AT by using 1m and 3m AT
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
 ELSE IF EXISTS (SELECT * FROM seriesCatalog where SiteID= @SiteID AND @varID=489)
  BEGIN
          DECLARE Min_cursor CURSOR FOR 
              SELECT dv.LocalDateTime, dv.Datavalue
              FROM ODMDatavalues_metric AS dv
              WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID and dv.offsetvalue = 1 
          OPEN Min_cursor;
              FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value1m;
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @Value3m = dv.DataValue
                      FROM ODMDataValues_metric AS dv
                      WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=489 and dv.offsetvalue = 3 and @DateTimeUTC = dv.LocalDateTime
                 SELECT @Value = (@Value3m - @Value1m)/2 + @Value1m;
                  
                 -- if the 2m AT avg is NULL, check and see if there is a 1m AT and use that
                 IF (@Value is NULL and @Value1m is not NULL)
                 BEGIN
                    SELECT @Value = @Value1m;
                  END;
	             INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	                   VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
                 FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value1m;
      END
          CLOSE Min_cursor;
              DEALLOCATE Min_cursor;

END

    -- GHCN Original Station Observation scans. Temp/F/Daily  SourceID = 225
    -- VariableID = 837 is TMin
       IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=837)
    BEGIN
	   	DECLARE Min_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN Min_cursor;
		FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMinDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM Min_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE Min_cursor;
		DEALLOCATE Min_cursor;

    END
    
END












GO

