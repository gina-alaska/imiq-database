USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailySWE]    Script Date: 01/09/2015 13:46:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO













-- =============================================
-- Author:		Amy Jacobs
-- Create date: July 17, 2013
-- Description:	Create the daily SWE average.  
-- Units: mm 
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailySWE] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime,  @avgValue float;
    
    -- NCDC ISH.  SWE SourceID = 209
    -- VariableID = 373
    -- AVG the SWE (for snow depth) for each day
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=373)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,AVG(dv.DataValue)	
		FROM HOURLY_SWE  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, 681,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- NCDC GHCN.  SWE SourceID = 210
    -- VariableID = 751
    -- AVG the SWE (for snow on ground) for each day
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=751)
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
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- UAF/WERC:  
    -- VariableID = 215. SourceID = 193
    -- Need to convert from cm to mm
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=215)
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
	        select @avgValue = @avgValue * 10; -- convert from cm to mm
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END

    -- Snow Course:  
    -- VariableID = 397. SourceID = 200
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=397)
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
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- SNOTEL:  
    -- VariableID = 395 SourceID =  212
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=395)
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
	           INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	           VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    -- UAF:  
    -- VariableID = 21 SourceID = 3
    -- Need to convert from cm to mm
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=21)
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
	        select @avgValue = @avgValue * 10; -- convert from cm to mm
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END	
END









GO

