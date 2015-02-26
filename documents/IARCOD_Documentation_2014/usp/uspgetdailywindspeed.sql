USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyWindSpeed]    Script Date: 09/02/2014 14:01:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Amy Jacobs
-- Create date: July 15, 2013
-- Update: 10-18-2013.  Added column 'InsertDate' to 'DAILY_WindSpeedDataValues'.  ASJ
-- Added in SourceID=164 on 6-13-2014
-- Description:	Create the hourly wind speed average.  
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailyWindSpeed] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime,@avgValue float,@OffsetValue float,@OffsetTypeID float;
	
    
    -- NCDC ISH:  WindSpeed/ms
    -- VariableID = 335. SourceID = 209
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=335)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
      
    -- NCDC GHCN:  WindSpeed/ms
    -- VariableID = 743. SourceID = 210
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=743)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    -- UAF/WERC:  WindSpeed/ms, AST
    -- VariableID = 82. SourceID = 29,30,31,34
   ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=82)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		select CONVERT(Date,WS.DateTimeUTC) as DateTimeUTC,AVG(DataValue),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID
          from ODMDataValues_metric WS
          inner join
           (select SiteID,DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID
            from ODMDataValues_metric 
            where SiteID=@SiteID and OriginalVariableID=@VarID
            group by SiteID,DateTimeUTC,OffsetTypeID) as MAX_Offset
            on MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC 
            WHERE WS.SiteID = @SiteID and OriginalVariableid=@VarID and WS.OffsetValue=MAX_Offset.max_OffsetValue
         group by CONVERT(Date,WS.DateTimeUTC),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
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
		select CONVERT(Date,WS.DateTimeUTC) as DateTimeUTC,AVG(DataValue),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID
          from ODMDataValues_metric WS
          inner join
           (select SiteID,DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID
            from ODMDataValues_metric 
            where SiteID=@SiteID and OriginalVariableID=@VarID
            group by SiteID,DateTimeUTC,OffsetTypeID) as MAX_Offset
            on MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC 
            WHERE WS.SiteID = @SiteID and OriginalVariableid=@VarID and WS.OffsetValue=MAX_Offset.max_OffsetValue
         group by CONVERT(Date,WS.DateTimeUTC),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
  
    -- USGS Windspeed/ms
    -- VariableID = 313, SourceID = 39
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=313 )
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END

    -- UAF/BLM
    -- VariableID = 645, SourceID = 164
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=645 )
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- RAWS Windspeed/ms
    -- VariableID = 429, SourceID = 211
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=429 )
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
 
    -- ARM Windspeed/ms
    -- VariableID = 529, SourceID = 202
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=529)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END

    -- ARM Windspeed/ms
    -- VariableID = 541, SourceID = 1,203
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=541)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
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
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- LPeters Windspeed/ms
    -- VariableID = 292, SourceID = 182
   ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=292)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
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
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    -- RWIS Windspeed/ms
    -- VariableID = 566, SourceID = 213
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=566)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC),AVG(dv.DataValue),OffsetValue,OffsetTypeID	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WindSpeedDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
END















GO

