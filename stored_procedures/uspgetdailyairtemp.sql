USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyAirTemp]    Script Date: 01/09/2015 13:43:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		Amy Jacobs
-- Create date: June 14, 2013

-- Updated:  Fixed the Avg Air Temp from the min and max values on 9-5-2013.  ASJ
-- Update 9-19-2013:  Changed the date selection for GHCN (210) and Mccall (178,182) ASJ
-- Update 10-18-2013:  Added 'InsertDate' to 'DAILY_AirTempDataValues' table.  ASJ
-- NOTE 10-10-2013:  I need to change the way that GHCN is selected for an extract, so that I'm not pulling any
--      ISH stations for the DAILY.  ASJ
-- Added in SourceID=164, UAF-BLM Chris Arp on 6/13/2014
-- Description:	Create the daily air temperatures at 2m. 
-- This stored procedure is sending the data to a temp table for the DAILY_AirTempDataValues, which will be used to calculate
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

	DECLARE @DateTimeLocal datetime,@maxValue float,
    @minValue float, @avgValue float, @avgValue1m float, @avgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float,
    @methodID int, @qualifierID int, @variableID int;
    
    -- NCDC GHCN.  SourceID = 210 
    -- VariableID = 403 is TMAX
    -- VariableID = 404 is TMIN
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=404)
    BEGIN

        DECLARE date_cursor CURSOR FOR
        SELECT distinct dv.DateTimeUTC
        FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and (dv.OriginalVariableid=@VarID or dv.OriginalVariableID=403);

	    OPEN date_cursor;
		FETCH NEXT FROM date_cursor INTO @DateTimeLocal;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SELECT @maxValue = dv.DataValue
	        FROM ODMDataValues_metric AS dv
	        WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=403 and dv.DateTimeUTC = @DateTimeLocal;

	        SELECT @minValue = dv.DataValue
	        FROM ODMDataValues_metric AS dv
	        WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID and dv.DateTimeUTC = @DateTimeLocal;
	        
		    --compute avgValue
		    IF(@minValue is not NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = ( @maxValue - @minValue ) / 2 + @minValue;
			END
		    IF(@minValue is NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = @maxValue;
			END
			ELSE IF (@minValue is not NULL and @maxValue is NULL)
			BEGIN
				SELECT @avgValue = @minValue;
			END 
			ELSE IF (@minValue is NULL and @maxValue is NULL)
			BEGIN
			   SELECT @avgValue = NULL
			END
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM date_cursor INTO @DateTimeLocal;
        END

	    CLOSE date_cursor;
		DEALLOCATE date_cursor;

    END
   
    -- RAWS:  Temp/daily/C, UTC
    -- VariableID = 432, SourceID =  (211,214,215,216,217,218,219)
    -- No offset value is given
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=432)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- SNOTEL  Temp/daily/F, AST
    -- VariableID = 626, SourceID = 212
    -- No offset value is given
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=626)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
        -- SNOTEL  Temp/daily/F, AST
    -- VariableID = 666, SourceID = 212
    -- No offset value is given
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=666)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
 
    -- SNOTEL  Temp/daily/F, AST
    -- VariableID = 393, SourceID = 212
    -- No offset value is given
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=393)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- McCall  Temp/daily/F, AST
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- VariableID = 195 (TMAX), VariableID = 196 (TMIN), SourceID = 178 and SourceID = 182
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=195)
BEGIN

        DECLARE date_cursor CURSOR FOR
        SELECT distinct dv.LocalDateTime
        FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and (dv.OriginalVariableid=@VarID or dv.OriginalVariableID=196);

	    OPEN date_cursor;
		FETCH NEXT FROM date_cursor INTO @DateTimeLocal;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SELECT @maxValue = dv.DataValue
	        FROM ODMDataValues_metric AS dv
	        WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID and dv.LocalDateTime = @DateTimeLocal;

	        SELECT @minValue = dv.DataValue
	        FROM ODMDataValues_metric AS dv
	        WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=196 and dv.DateTimeUTC = @DateTimeLocal;
	        
		    --compute avgValue
		    IF(@minValue is not NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = ( @maxValue - @minValue ) / 2 + @minValue;
			END
		    IF(@minValue is NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = @maxValue;
			END
			ELSE IF (@minValue is not NULL and @maxValue is NULL)
			BEGIN
				SELECT @avgValue = @minValue;
			END 
			ELSE IF (@minValue is NULL and @maxValue is NULL)
			BEGIN
			   SELECT @avgValue = NULL
			END
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM date_cursor INTO @DateTimeLocal;
        END

	    CLOSE date_cursor;
		DEALLOCATE date_cursor;

    END
-- McCall  Temp/daily/C, AST
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- VariableID = 277, SourceID = 179
      ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=277)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- UAF. Temp/C/Daily  SourceID = 180
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- VariableID = 223 is TMAX
    -- VariableID = 225 is TMIN
    -- Need to compute average.
       IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=223)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @maxValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SELECT @minValue = dv.DataValue
	        FROM ODMDataValues_metric AS dv
	        WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=225 and dv.LocalDateTime = @DateTimeLocal;
	        
          --compute avgValue
		    IF(@minValue is not NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = ( @maxValue - @minValue ) / 2 + @minValue;
			END
		    IF(@minValue is NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = @maxValue;
			END
			ELSE IF (@minValue is not NULL and @maxValue is NULL)
			BEGIN
				SELECT @avgValue = @minValue;
			END 
			ELSE IF (@minValue is NULL and @maxValue is NULL)
			BEGIN
			   SELECT @avgValue = NULL
			END
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @maxValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- Chamberlin. Temp/F/Daily  SourceID = 183
    -- VariableID = 295 is TMAX
    -- VariableID = 296 is TMIN
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- Need to compute average.
    -- Need to convert from F to C.
       IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=295)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @maxValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SELECT @minValue = dv.DataValue
	        FROM ODMDataValues_metric AS dv
	        WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=296 and dv.LocalDateTime= @DateTimeLocal;
	        
        --compute avgValue
		    IF(@minValue is not NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = ( @maxValue - @minValue ) / 2 + @minValue;
			END
		    IF(@minValue is NULL and @maxValue is not NULL)
		    BEGIN
				SELECT @avgValue = @maxValue;
			END
			ELSE IF (@minValue is not NULL and @maxValue is NULL)
			BEGIN
				SELECT @avgValue = @minValue;
			END 
			ELSE IF (@minValue is NULL and @maxValue is NULL)
			BEGIN
			   SELECT @avgValue = NULL
			END
	        INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @maxValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- BLM/Kemenitz. Temp/C/Daily  SourceID = 199
    -- VariableID = 61 AVG AT
    -- Need to take LocalDateTime, not DateTimeUTC, since it is already a daily value
    -- Need to compute average.
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=61)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- UAF Permafrost. Temp/C/Daily  SourceID = 206
    -- VariableID = 550 AVG AT
    -- Need to compute average.
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=550)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- ISH  SourceID = 209
    -- VariableID = 218
    -- Need to compute daily average from hourly
    -- Do not want to have hourly sites that already have a daily in GHCN
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=218 and SiteID not in (select siteid from sites where
     LocationDescription like '%WBANID:%' and SourceID=209)) --the siteids which have a match in GHCN, based on wban
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- UAF WERC  SourceID = 29,30,31,34,223
    -- VariableID = 677, summary hourly air temp
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=81)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,677,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- USGS SourceID = 39
    -- VariableID = 310
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=310)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- BLM/Kemenitz SourceID = 199
    -- VariableID = 442
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=442)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- BLM/Kemenitz SourceID = 199
    -- VariableID = 504
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=504)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- NOAA SourceID = 35
    -- VariableID = 519
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=519)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- ARM SourceID = 202,203
    -- VariableID = 527
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=527)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- ARM SourceID = 203
    -- VariableID = 538
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=538)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- LPeters SourceID = 182
    -- VariableID = 279
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=279)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- LPeters SourceID = 182
    -- VariableID = 288
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=288)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- RWIS SourceID = 213
    -- VariableID = 563
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=563)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- UAF-BLM:  Temp/daily/C
    -- VariableID = 640, SourceID =  164
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=640)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END   

    
    -- Toolik  Temp/daily/C, AST
    -- VariableID = 489 (TMIN), VariableID = 487 (TMAX), SourceID = 145
    -- Need to calculate 2m AT by using 1m and 3m AT
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
 ELSE IF EXISTS (SELECT * FROM seriesCatalog where SiteID= @SiteID AND @varID=489)
  BEGIN
          DECLARE max_cursor CURSOR FOR 
              SELECT dv.LocalDateTime, dv.Datavalue
              FROM ODMDatavalues_metric AS dv
              WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID and dv.offsetvalue = 1 
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @minValue1m;
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @maxValue1m = dv.DataValue
                      FROM ODMDataValues_metric AS dv
                      WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=487 and dv.offsetvalue = 1 and @DateTimeLocal = dv.LocalDateTime
                  SELECT @avgValue1m = (@maxValue1m - @minValue1m)/2 + @minValue1m; 
                  select @minValue3m = dv.DataValue
                      FROM ODMDataValues_metric AS dv
                      WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID and dv.offsetvalue = 3 and @DateTimeLocal = dv.LocalDateTime
                   select @maxValue3m = dv.DataValue
                      FROM ODMDataValues_metric AS dv
                      WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=487 and dv.offsetvalue = 3 and @DateTimeLocal = dv.LocalDateTime;            
                  SELECT @avgValue3m = (@maxValue3m - @minValue3m)/2 + @minValue3m;
                  SELECT @avgValue = (@avgValue3m - @avgValue1m)/2 + @avgValue1m;             
                 -- if the 2m AT avg is NULL, check and see if there is a 1m AT and use that
                 IF (@avgValue is NULL and @avgValue1m is not NULL)
                 BEGIN
                    SELECT @avgValue = @avgValue1m;
                  END
                 ELSE IF (@avgValue is NULL and @avgValue1m is NULL and @maxValue1m is not NULL)
                   BEGIN
				 SELECT @avgValue = @maxValue1m;
					END
			     ELSE IF (@avgValue is NULL and @avgValue1m is NULL and @minValue1m is not NULL)
					BEGIN
						SELECT @avgValue = @minValue1m;
					END;
	             	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	                   VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
                 FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @minValue1m;
      END
          CLOSE max_cursor;
              DEALLOCATE max_cursor;

END

	-- ARC LTER SourceID=144
    -- VariableID = 819, summary hourly air temp (677)
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=819)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,677,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
  
 	-- AON SourceID=222
    -- VariableID = 786, summary hourly air temp (677)
    -- Need to compute daily average from hourly
   ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=786)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime), avg(dv.DataValue)
		FROM HOURLY_AirTemp AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		group by CONVERT(Date,dv.UTCDateTime)

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,677,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
      
    -- Permafrost GI:  Temp/daily/C
    -- VariableID = 550, SourceID =  224
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=550)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END   
    
    -- GHCN Original Observation Scans:  Temp/daily/F
    -- VariableID = 838, SourceID =  225
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=838)
    BEGIN
	   	DECLARE max_cursor CURSOR FOR 
		SELECT dv.LocalDateTime, dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	       	INSERT INTO DAILY_AirTempDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeLocal,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeLocal, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END   
END
























GO

