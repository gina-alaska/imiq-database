USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyAirTempMax]    Script Date: 01/09/2015 13:44:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Amy Jacobs
-- Create date: Sept 18, 2013
-- Added in InsertDate on 2/12/2014
-- Description:	Daily max air temperatures at 2m. 
-- This stored procedure is sending the data to a temp table for the DAILY_AirTempMaxDataValues, which will be used to calculate
-- monthly, yearly data values
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailyAirTempMax] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime,@Value float,@Value1m float, @Value3m float, @OriginalVariableID int;
    
    -- NCDC GHCN.  SourceID = 210 
    -- VariableID = 403 is TMAX
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=403)
	    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.DateTimeUTC, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
   
    -- RAWS/NPS:  Temp/daily/C, UTC
    -- VariableID = 433, SourceID = 211,214,215,216,217,218,219
    -- No offset value is given
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=433)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.DateTimeUTC, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- SNOTEL  Temp/daily/F, AST
    -- VariableID = 628, SourceID = 212
    -- No offset value is given
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=628)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
    -- SNOTEL  Temp/daily/F, AST
    -- VariableID = 668, SourceID = 212
    -- No offset value is given
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=668)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 

    -- SNOTEL  Temp/daily/F, AST
    -- VariableID = 391, SourceID = 212
    -- No offset value is given
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=391)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
     
    -- McCall  Temp/daily/F, AST
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- VariableID = 195 (TMAX), SourceID = 178,182
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=195)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    

    -- UAF. Temp/C/Daily  SourceID = 180
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- VariableID = 223 is TMAX
       IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=223)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
     -- Chamberlin. Temp/F/Daily  SourceID = 183
    -- VariableID = 295 is TMAX
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- Need to convert from F to C.
       IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=295)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
    -- Toolik  Temp/daily/C, AST
    -- VariableID = 487 (TMAX), SourceID = 145
    -- Need to calculate 2m AT by using 1m and 3m AT
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
 ELSE IF EXISTS (SELECT * FROM seriesCatalog where SiteID= @SiteID AND @varID=487)
  BEGIN
          DECLARE max_cursor CURSOR FOR 
              SELECT dv.LocalDateTime, dv.Datavalue
              FROM ODMDatavalues_metric AS dv
              WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID and dv.offsetvalue = 1 
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value1m;
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @Value3m = dv.DataValue
                      FROM ODMDataValues_metric AS dv
                      WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=487 and dv.offsetvalue = 3 and @DateTimeUTC = dv.LocalDateTime
                 SELECT @Value = (@Value3m - @Value1m)/2 + @Value1m;
                  
                 -- if the 2m AT avg is NULL, check and see if there is a 1m AT and use that
                 IF (@Value is NULL and @Value1m is not NULL)
                 BEGIN
                    SELECT @Value = @Value1m;
                  END;
	             INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	                   VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
                 FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value1m;
      END
          CLOSE max_cursor;
              DEALLOCATE max_cursor;

END

     -- GHCN Original Station Observation scans. Temp/F/Daily  SourceID = 225
    -- VariableID = 836 is TMAX
    -- Need to convert from F to C.
       IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=836)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempMaxDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@Value, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @Value;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
END












GO

