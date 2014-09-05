USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetHourlyWindSpeed]    Script Date: 09/04/2014 10:37:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		Amy Jacobs
-- Create date: June 9, 2013
-- Update: 10-18-2013.  Added column 'InsertDate' to 'HOURLY_WindSpeedDataValues'.  ASJ
-- Description:	Create the hourly wind speed average.  
-- =============================================
CREATE PROCEDURE [dbo].[uspGetHourlyWindSpeed] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime,@avgValue float,@OffsetValue float,@OffsetTypeID float;
 
    -- NCDC:  WindSpeed/ms
    -- VariableID = 335. SourceID = 209
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=335)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
   
    -- UAF/WERC:  WindSpeed/ms, AST
    -- VariableID = 82. SourceID = 29,30,31,34
   ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=82)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		select DateAdd(hh, DATEPART(hh, WS.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WS.DateTimeUTC), 0)) as DateTimeUTC,DataValue,MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID
          from ODMDataValues_metric WS
          inner join
           (select SiteID,DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID
            from ODMDataValues_metric 
            where SiteID=@SiteID and OriginalVariableID=@VarID
            group by SiteID,DateTimeUTC,OffsetTypeID) as MAX_Offset
            on MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC 
            WHERE WS.SiteID = @SiteID and OriginalVariableid=@VarID and WS.OffsetValue=MAX_Offset.max_OffsetValue
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
  

    -- Toolik  Windspeed/ms, AST
    -- VariableID = 469, SourceID = 145
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=469 )
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		select DateAdd(hh, DATEPART(hh, WS.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WS.DateTimeUTC), 0)) as DateTimeUTC,DataValue,MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID
          from ODMDataValues_metric WS
          inner join
           (select SiteID,DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID
            from ODMDataValues_metric 
            where SiteID=@SiteID and OriginalVariableID=@VarID
            group by SiteID,DateTimeUTC,OffsetTypeID) as MAX_Offset
            on MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC 
            WHERE WS.SiteID = @SiteID and OriginalVariableid=@VarID and WS.OffsetValue=MAX_Offset.max_OffsetValue
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
  
    -- USGS Windspeed/ms
    -- VariableID = 313, SourceID = 39
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=313 )
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue),Offsetvalue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    
    -- ARM Windspeed/ms
    -- VariableID = 529, SourceID = 202
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=529)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END

    -- ARM Windspeed/ms
    -- VariableID = 541, SourceID = 1,203
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=541)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    -- ARM Windspeed/ms
    -- VariableID = 535, SourceID = 203
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=535)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- LPeters Windspeed/ms
    -- VariableID = 292, SourceID = 182
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=292)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END

    -- NOAA Windspeed/ms
    -- VariableID = 511, SourceID = 35
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=511)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    -- RWIS Windspeed/ms
    -- VariableID = 566, SourceID = 213
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=566)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
END













GO

