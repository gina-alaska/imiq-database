USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetHourlyAirTemp]    Script Date: 09/04/2014 10:35:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Amy Jacobs
-- Create date: June 1, 2013
-- Updated 10-17-2013:  Inserted column 'InsertDate' so that it I could tell when the summary had been created.   ASJ
-- Updated 2-12-2014:  Added SNOTEL hourly air temp
-- Description:	Create the hourly air temperatures at 2m. 
--  This stored procedure is sending the data to a temp table for the HOURLY_AirTempDataValues, which will be range restricted with views or used
-- to create daily, monthly, seasonal and yearly summaries.
-- =============================================
CREATE PROCEDURE [dbo].[uspGetHourlyAirTemp] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime, @maxValue float,
    @minValue float, @avgValue float, @avgValue1m float, @avgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float,
    @qualifierID int, @date date, @numDateTime int; 

    -- ISH
    -- VariableID = 218 is ISH Average Air Temp hourly. SourceID = 209
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=218)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		
		FROM ODMDataValues_metric AS dv
		INNER JOIN seriesCatalog sc ON sc.siteID = dv.siteID
		WHERE sc.SiteID = @SiteID and dv.OriginalVariableid=218
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    -- UAF/WERC:  Temp/hourly/C, AST
    -- VariableID = 81. SourceID = 29, 30, 31, 34
    -- Need to make sure offset is 2m or 1.5m
    ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND OriginalVariableID=81 AND (OffsetValue = 2 or OffsetValue = 1.5))
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=81 and (dv.offsetvalue = 2 or dv.offsetvalue = 1.5) and dv.siteid in 
		(select distinct siteid from ODMDatavalues_metric where @SiteID = siteid)
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID, GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- UAF/WERC:  Temp/hourly/C, AST
    -- VariableID = 81. Needs to be converted to a Daily value.  SourceID = 29, 30, 31, 34
    -- Need to convert 1m and 3m to 2m
    -- Need to convert to UTCDateTime
    IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID and OriginalVariableID=81  AND OffsetValue = 1)
     BEGIN
          DECLARE max_cursor CURSOR FOR 
		  SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
              FROM ODMDataValues_metric AS dv
              WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=81 and dv.offsetvalue = 1 and dv.siteid in 
              (select siteid from ODMDatavalues_metric where @SiteID = siteid)
		  GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
              
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue1m;
              
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @avgValue3m = avg(dv.DataValue)
                      FROM ODMDataValues_metric AS dv
                      WHERE dv.SiteID = @SiteID and dv.OriginalvariableID=81 and dv.offsetvalue = 3 
                            and @DateTimeUTC = DateAdd(hh, DATEPART(hh, dv.DateTimeUTC), DateAdd(d, DateDiff(d, 0, dv.DateTimeUTC), 0));
                      --SELECT @avgValue = (@avgValue3m - @avgValue1m)/2 + @avgValue1m;
                      -- If the 2m average temp is NULL, check and see if there is a 1m air temp and use it.
                      IF (@avgValue3m is not NULL and @avgValue1m is not NULL)
                        BEGIN
                          SELECT @avgValue = (@avgValue3m - @avgValue1m)*.5 + @avgValue1m;
                        END
                      ELSE IF (@avgValue3m is NULL and @avgValue1m is not NULL)
                      BEGIN
                       SELECT @avgValue = @avgValue1m;
                      END
                      ELSE
                       BEGIN
                       SELECT @avgValue = NULL
                       END
	                      INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	                      VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
                      FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue1m;
               END

	     CLOSE max_cursor;
		 DEALLOCATE max_cursor;
    END
    -- USGS:  Temp/hourly/C, AST
    -- VariableID = 310. SourceID = 39
    -- NO OFFSET VALUE IS GIVEN
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=310)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		  SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and  dv.OriginalVariableID=310  and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END  
    -- BLM/Kemenitz. Temp/C/Hourly  SourceID = 199
    -- VariableID = 442 AVG AT
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=442)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and  dv.OriginalVariableID=442  and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
             FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    -- BLM/Kemenitz. Temp/C/Minute  SourceID = 199
    -- VariableID = 504 AVG AT
    -- Need to compute hourly average
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=504)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and  dv.OriginalVariableID=504  and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- NOAA/ESRL/CRN Temp/C/Minute  SourceID = 35
    -- VariableID = 519 AVG AT
    -- Need to compute hourly average
    ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID = @SiteID AND OriginalVariableID=519)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
        FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=519 
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- ARM. Temp/C/Minute  SourceID = 202,203
    -- VariableID = 527 AVG AT
    ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID = @SiteID AND @VarID=527)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
        FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	       INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    -- ARM. Temp/C/Second  SourceID = 203
    -- VariableID = 538 AVG AT
    ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID = @SiteID AND @VarID=538)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
        FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID 
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END  
     -- LPeters. Temp/F/Hourly  SourceID = 182
    -- VariableID = 279 AVG AT
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=279)
      BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
        FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID 
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END  
   -- LPeters. Temp/C/Hourly  SourceID = 182
    -- VariableID = 288 AVG AT
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=288)
      BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
        FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID 
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END  
     -- RWIS. Temp/F/Hourly  SourceID = 213
    -- VariableID = 563 AVG AT
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=563)
      BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
        FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID 
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0

	    BEGIN
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END  
    -- Toolik  Temp/hourly/C, AST
    -- VariableID = 466, SourceID = 145
    -- Need to calculate 2m AT by using 1m and 3m AT
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=466)
  BEGIN
          DECLARE max_cursor CURSOR FOR 
          SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
              FROM ODMDataValues_metric AS dv
              WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=466 and dv.offsetvalue = 1 /*toolik field station */
		  GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
              
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue1m;
              
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @avgValue3m = avg(dv.DataValue)
                      FROM ODMDataValues_metric AS dv
                      WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=466 and dv.offsetvalue = 3 
                            and @DateTimeUTC = DateAdd(hh, DATEPART(hh, dv.DateTimeUTC), DateAdd(d, DateDiff(d, 0, dv.DateTimeUTC), 0));
                            
                      -- Calculate average at2m
                      IF (@avgValue3m is not NULL and @avgValue1m is not NULL)
                      BEGIN
                       SELECT @avgValue = (@avgValue3m - @avgValue1m)*.5 + @avgValue1m;
                      END
                      
                      -- If the 3m average temp is NULL, check and see if there is a 1m air temp and use it.
                      ELSE IF (@avgValue3m is  NULL and @avgValue1m is not NULL)
                      BEGIN
                       SELECT @avgValue = @avgValue1m;
                      END
                      
                      -- If both are null
                      ELSE IF (@avgValue3m is  NULL and @avgValue1m is NULL)
                      BEGIN
                       SELECT @avgValue = NULL;
                      END
					
	        INSERT INTO HOURLY_AirTempDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue1m;
                 END

               CLOSE max_cursor;
              DEALLOCATE max_cursor;
          END
   

   END       



















GO

