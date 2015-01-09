USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailySnowDepth]    Script Date: 01/09/2015 13:45:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Amy Jacobs
-- Create date: July 17, 2013
-- Description:	Create the daily average snow depth.  
-- Update: 10-18-2013.  Updated to include column 'InsertDate' to 'DAILY_SnowDepthDataValues'.  ASJ
-- Update: 3-11-2014.  Added in SNOTEL, variableID=624, sourceID=212
-- Units: meters
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailySnowDepth] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime, @avgValue float;
    
    -- GHCN
    -- VariableID = 402 is GHCN Snow Depth SourceID = 210
    -- convert from mm to meters
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=402)
     BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv.DateTimeUTC as DateTimeUTC,dv.DataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @avgValue= @avgValue / 1000.0 -- convert mm to meters
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- ISH
    -- VariableID = 370 is ISH Snow Depth SourceID = 209
     ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=370 and SiteID not in (select siteid from sites where
     LocationDescription like '%WBANID:%' and SourceID=209)) --the siteids which have a match in GHCN, based on wban
    BEGIN
DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM Hourly_SnowDepth AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
     -- UAF/WERC:  Snow Depth
    -- VariableID = 75.  SourceID = 29, 30, 34, 223
    -- Using hourly summary variable ID = 680
    ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=75)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM Hourly_SnowDepth AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, 680,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
  
    -- AON:  Snow Depth/meters
    -- VariableID = 813.  SourceID = 222
    ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=222)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM Hourly_SnowDepth AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- USGS:  Snow depth
    -- VariableID = 320.   SourceID = 39
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=320)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM Hourly_SnowDepth AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    
    -- SNOTEL:  Snow depth
    -- VariableID = 612 SourceID = 212
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=612)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @avgValue= @avgValue / 100.0 -- convert cm to meters
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	      
    -- Snow Course:  Snow depth
    -- VariableID = 396 SourceID = 200
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=396)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	      
-- UAF/WERC. Snow Depth/meters/daily  SourceID = 31
    -- VariableID = 339
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=339)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END

-- UAF/WERC. Snow Depth  SourceID = 31
    -- VariableID = 193
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=193)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM Hourly_SnowDepth AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID,680,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
	-- AON. Snow Depth  SourceID = 222
    -- VariableID = 813
    -- use hourly summary value of 680
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=813)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM Hourly_SnowDepth AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID,680,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END

--   UAF/WERC. Snow Depth  SourceID = 3,193
    -- VariableID = 142
    -- Need to convert cm to meters
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=142)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @avgValue= @avgValue / 100.0 -- convert cm to meters
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
-- ARM. Snow Depth SourceID = 1, 203
-- VariableID = 543
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=543)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM Hourly_SnowDepth AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END

-- RAWS. Snow Depth/mm SourceID = (211,214,215,216,217,218,219)
-- VariableID = 440
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=440)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @avgValue = @avgValue  / 1000.0;  -- convert mm to meters
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
-- RWIS. Snow Depth SourceID = 213
-- VariableID = 584
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=584)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,AVG(dv.DataValue)
		FROM Hourly_SnowDepth AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END	
	
-- Permafrost GI. Snow Depth SourceID = 224
-- VariableID = 835
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=835)
    BEGIN
     DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC) as DateTimeUTC,AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @avgValue = @avgValue;  -- convert mm to meters
	        INSERT INTO DAILY_SnowDepthDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
END






















GO

