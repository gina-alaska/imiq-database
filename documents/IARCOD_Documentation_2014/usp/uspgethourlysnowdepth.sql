USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetHourlySnowDepth]    Script Date: 09/04/2014 10:36:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		Amy Jacobs
-- Create date: June 13, 2013
-- Update:  10-18-2013.  Added in 'InsertDate' to 'HOURLY_SnowDepthDataValues' table  ASJ
-- Description:	Create the hourly snow depth average.  
-- Units: meters
-- =============================================
CREATE PROCEDURE [dbo].[uspGetHourlySnowDepth] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime, @avgValue float;
    
    -- ISH
    -- VariableID = 370 is ISH Snow Depth SourceID = 209
    -- convert from cm to meters
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=370)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		
		FROM ODMDataValues_metric AS dv
		INNER JOIN seriesCatalog sc ON sc.siteID = dv.siteID
		WHERE sc.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_SnowDepthDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue/100, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
     -- UAF/WERC:  Snow Depth
    -- VariableID = 75.  SourceID = 29, 30, 34
    -- Need to convert from cm to meters
    ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=75)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		
		FROM ODMDataValues_metric AS dv
		INNER JOIN seriesCatalog sc ON sc.siteID = dv.siteID
		WHERE sc.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_SnowDepthDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue/100, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
  
    -- USGS:  Snow depth/hourly/cm
    -- VariableID = 320.   SourceID = 39
    -- Need to convert from cm to meters
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=320)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		
		FROM ODMDataValues_metric AS dv
		INNER JOIN seriesCatalog sc ON sc.siteID = dv.siteID
		WHERE sc.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_SnowDepthDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue/100, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
   
-- UAF/WERC. Snow Depth/meters/Hourly  SourceID = 31
    -- VariableID = 193
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=193)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		
		FROM ODMDataValues_metric AS dv
		INNER JOIN seriesCatalog sc ON sc.siteID = dv.siteID
		WHERE sc.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_SnowDepthDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END

-- ARM. Snow Depth/mm/Minutely  SourceID = 1, 203
-- VariableID = 543
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=543)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		
		FROM ODMDataValues_metric AS dv
		INNER JOIN seriesCatalog sc ON sc.siteID = dv.siteID
		WHERE sc.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_SnowDepthDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID, InsertDate)
	        VALUES(@avgValue/1000, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
-- RWIS. Snow Depth/cm/Minutely  SourceID = 213
-- VariableID = 584
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=584)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		
		FROM ODMDataValues_metric AS dv
		INNER JOIN seriesCatalog sc ON sc.siteID = dv.siteID
		WHERE sc.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_SnowDepthDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID, InsertDate)
	        VALUES(@avgValue/100, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
END








GO

