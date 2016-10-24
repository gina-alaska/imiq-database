USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailySWE]    Script Date: 02/20/2013 12:59:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Amy Jacobs
-- Create date: Feb 17,2012
-- Description:	Create the daily snow depth average.  
-- Units: meters, format Decimal(6,3)
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailySWE] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @localDateTime datetime, @maxValue float,
    @minValue float, @avgValue float, @avgValue1m float, @avgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float,
    @methodID int, @qualifierID int, @variableID int;
    
    -- NCDC ISH.  SWE/mm/Minute.  SourceID = 4 
    -- VariableID = 373
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID = @SiteID AND VariableID=373)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), SUM(dv.DataValue)
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=373
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=373;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
     -- UAF/WERC:  daily/SWE/cm, AST
    -- VariableID = 215. SourceID = 31,193
    -- Need to convert to UTCDateTime
    -- Need to convert from cm to mm
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=215)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=215 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=215;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue * 10;
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  
   
  
    -- Snow Course  SWE/daily/inches, UTC
    -- VariableID = 397, SourceID = 200
    -- Convert from inches to mm
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=397)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=397;
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=397;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @avgValue = @avgValue * 25.4;
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- SNOTEL  SWE/daily/inches, UTC
    -- VariableID = 395, SourceID = 124
    -- Convert from inches to mm
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=395)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=395;
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=395;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @avgValue = @avgValue * 25.4;
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
      -- UAF/WERC:  SWE/cm/year, AST
    -- VariableID = 21. SourceID = 3
    -- Need to convert to UTCDateTime
    -- Need to convert from cm to mm
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=21)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=21 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=21;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue * 10;
	        INSERT INTO DAILY_SWEDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
END










GO

