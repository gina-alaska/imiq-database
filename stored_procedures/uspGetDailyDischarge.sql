USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyDischarge]    Script Date: 01/09/2015 13:44:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Amy Jacobs
-- Create date: July 19, 2013
-- Description:	Create the daily Discharge average.  
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailyDischarge] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTime datetime, @maxValue float,
    @minValue float, @avgValue float, @avgValue1m float, @avgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float,
    @variableID int;
    
    -- NWIS.  Discharge/cubic feet per second/Daily.  AST
    -- SourceID = 139,199
    -- VariableID = 56
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=56)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
    -- LChamberlinStreamDischarge_cfs_dataTypeUnk AST
    -- VariableID = 304 Discharge/Daily/cfs. SourceID = 183
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=304)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
    
     -- FWS_Discharge:  Discharge/cfs/Daily AST
    -- VariableID = 343. Sourceid = 154
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=343)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
  
    -- USGS_BLM_Discharge:  Discharge/minutely/cfs, AST
    -- VariableID = 445. Needs to be converted to a Daily value.  SourceID = 199
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=445)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
    
     -- USGS_BLM_Discharge:  Discharge/every 30 minutes/cfs, AST
    -- VariableID = 497. Needs to be converted to a Daily value.  SourceID = 199
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=497)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
    
    -- UAFWERC_Discharge:  Discharge/hourly/cms, AST
    -- VariableID = 90, SourceID = 30,29
   
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=90)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
    
    
    -- UAFWERC_Discharge_MINUTE_calculated:  Discharge/minute/cms, AST
    -- VariableID = 145, SourceID = 31
   
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=145)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
    
    -- UAFWERC_Discharge_QUARTER_HOUR_calculated:  Discharge/every 15 minute/cms, AST
    -- VariableID = 148, SourceID = 31
   
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=148)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
    
   -- UAFWERC_Discharge_HOURLY_calculated:  Discharge/hourly/cms, AST
    -- VariableID = 149, SourceID = 31
   
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=149)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
         
   -- UAFWERC_Discharge_Sporadic:  Discharge/sporadic/cms, AST
    -- VariableID = 150, SourceID = 31
   
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=150)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
    
    -- BLM-WERC_Whitman-Arp_Discharge:  Discharge/sporadic/cms, AST
    -- VariableID = 152, SourceID = 164
   
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=152)
      BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_DischargeDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID);
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
    
END













GO

