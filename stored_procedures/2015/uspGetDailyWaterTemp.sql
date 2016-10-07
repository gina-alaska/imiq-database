USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyWaterTemp]    Script Date: 01/09/2015 13:47:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Amy Jacobs
-- Create date: March 31, 2014
-- Description:	Create the daily average water temperature.  
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailyWaterTemp] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTime datetime, @avgValue float, @variableID int,@OffsetValue float,@OffsetTypeID float;
    
    -- WERC, Water Temperature.  AST
    -- SourceID = 31
    -- VariableID = 221
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=221)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), avg(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        group by CONVERT(Date,dv.DateTimeUTC);
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WaterTempDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID,InsertDate)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END
 
    -- WERC, Water Temperature.  AST
    -- SourceID = 30
    -- VariableID = 92
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=92)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), avg(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        group by CONVERT(Date,dv.DateTimeUTC);
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WaterTempDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID,InsertDate)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END   
    
    -- USGS, Water Temperature.  AST
    -- SourceID = 139,199
    -- VariableID = 58
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=58)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), avg(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        group by CONVERT(Date,dv.DateTimeUTC);
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WaterTempDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID,InsertDate)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END   
 
    -- Toolik Field Station, Water Temperature.  AST
    -- SourceID = 145
    -- VariableID = 481
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=481)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), avg(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        group by CONVERT(Date,dv.DateTimeUTC);
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WaterTempDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID,InsertDate)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END 

    -- Toolik Field Station, Water Temperature.  AST
    -- SourceID = 145
    -- VariableID = 495
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=495)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), avg(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID
        group by CONVERT(Date,dv.DateTimeUTC);
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WaterTempDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID,InsertDate)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END 
    -- WERC/BLM, Water Temperature.  AST
   --  Averages of only tbed water temp depths for a site on a day.
    -- SourceID = 164
    -- VariableIDs
    -- Tsurf 546 
    -- Tbed 637
    -- Trun 638
    -- Tsurf40 636
    
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=637)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), avg(dv.DataValue)
		FROM ODMDataValues_metric AS dv
        WHERE dv.SiteID = @SiteID and dv.OriginalVariableID in (637)
        group by CONVERT(Date,dv.DateTimeUTC);
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WaterTempDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID,InsertDate)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END         
    
   -- WERC NSL Water Chemistry, Water Temperature.  AST
   --  Averages all water temp depths for a site on a day.
    -- SourceID = 193
    -- VariableID = 155
    
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND @VarID=155)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		select CONVERT(Date,WT.DateTimeUTC) as DateTimeUTC,AVG(DataValue),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID
          from ODMDataValues_metric WT
          inner join
           (select SiteID,CONVERT(Date,DateTimeUTC) as DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID
            from ODMDataValues_metric 
            where SiteID=@SiteID and OriginalVariableID=@VarID
            group by SiteID,CONVERT(Date,DateTimeUTC),OffsetTypeID) as MAX_Offset
            on MAX_Offset.SiteID=WT.SiteID and MAX_Offset.DateTimeUTC=CONVERT(Date,WT.DateTimeUTC) and MAX_Offset.max_OffsetValue=WT.OffsetValue and MAX_Offset.max_OffsetTypeID=WT.OffsetTypeID
            WHERE WT.SiteID = @SiteID and OriginalVariableid=@VarID 
         group by CONVERT(Date,WT.DateTimeUTC),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_WaterTempDataValues (DataValue,UTCDateTime, OriginalVariableID,SiteID,InsertDate)
	        VALUES(@avgValue, @DateTime, @VarID,@SiteID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTime, @avgValue,@OffsetValue,@OffsetTypeID;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END        
    

    
END





GO

