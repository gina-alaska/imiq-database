USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetHourlyPrecip]    Script Date: 01/09/2015 13:48:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		Amy Jacobs
-- Create date: June 6, 2013
-- Update: 10/18/2013.  Added in 'InsertDate' column to 'HOURLY_PrecipDataValues'.   ASJ
-- Update: 5-30-2014.   Updated RWIS select to only pick the earliest timestamp per hour for the hourly total.
-- Description:	Create the hourly precip average for North of 62 in Alaska.  
-- =============================================
CREATE  PROCEDURE [dbo].[uspGetHourlyPrecip] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime,@AvgValue float;
    
    -- ISH
    -- VariableID = 340 is ISH Precip/UTC hourly/mm.  SourceID = 209
    -- Taking the highest precip recorded in the hour
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=340)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,MAX(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
		
    -- UAF/WERC:  Precip/mm, AST
    -- VariableID = 84. SourceID = 29, 30, 31, 34
    -- Taking the MAX precip in the hour
    ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=84)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,MAX(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
  
    -- USGS:  Precip/hourly/mm, AST
    -- VariableID = 319. SourceID = 39
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=319)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,MAX(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    
    -- Toolik  Precip/hourly/mm, AST
    -- VariableID = 461, SourceID = 145
    -- Not loading Precip tipping bucket (variableid=495).  Need to see if VariableID=461 includes tipping bucket values
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=461)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,MAX(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
  
    -- ARC LTER /hourly/mm, AST
    -- VariableID = 823, SourceID = 144
    
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=823)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,MAX(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- AON /hourly/mm, AST
    -- VariableID = 811, SourceID = 222
    
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=811)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,SUM(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END	
	
    -- BLM/Kemenitz. Precip/mm/Hourly  SourceID = 199
    -- VariableID = 496 
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=496)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,MAX(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
  -- BLM/Kemenitz. Precip/inches/every 15 minutes  SourceID = 199
    -- VariableID = 458 
    -- SUM, not max, since the DataValue is not accumulating over the hour.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=458)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,SUM(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
-- BLM/Kemenitz. Precip/inches/Minute  SourceID = 139
-- VariableID = 336
-- SUM, not max
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=336)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,SUM(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
-- NOAA. Precip/mm/Minute  SourceID = 35
    -- VariableID = 522 
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=522)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,MAX(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
-- ARM TPS. Precip/mm/Minute  SourceID = 1,203
-- VariableID = 539 Precip Rate/hour
-- Need to compute daily average
-- SUM, not max, since the DataValue is not accumulating over the hour.
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=539)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,SUM(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
 
 -- ARM. Precip/mm/Minute  SourceID = 202
-- VariableID = 526
-- Need to compute hourly
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=526)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,SUM(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- LPeters. Precip/Hourly  SourceID = 182
    -- VariableID = 294 Avg AT
    -- MAX precip for the hour
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=294)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,MAX(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END     
	-- RWIS. Precip/Mintues  SourceID = 213
    -- VariableID = 575
    -- Taking the value on the hour, since it is the accumulated value for the hour
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=575)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT  DateAdd(hh, DATEPART(hh, dv.DateTimeUTC), DateAdd(d, DateDiff(d, 0, dv.DateTimeUTC), 0)) as DateTimeUTC,dv.DataValue
		FROM ODMDataValues_metric AS dv
		INNER JOIN (
		    SELECT DateAdd(hh, DATEPART(hh, dv2.DateTimeUTC), DateAdd(d, DateDiff(d, 0, dv2.DateTimeUTC), 0)) as HourTimeUTC,MIN(dv2.DateTimeUTC) as DateTimeUTC
		    FROM ODMDataValues_metric dv2
		    WHERE dv2.SiteID = @SiteID and dv2.OriginalVariableID=@VarID
		    GROUP BY DateAdd(hh, DATEPART(hh, dv2.DateTimeUTC), DateAdd(d, DateDiff(d, 0, dv2.DateTimeUTC), 0))) dv3
		ON dv3.DateTimeUTC = dv.DateTimeUTC
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		order by DateTimeUTC;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC,@avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END     
END
























GO

