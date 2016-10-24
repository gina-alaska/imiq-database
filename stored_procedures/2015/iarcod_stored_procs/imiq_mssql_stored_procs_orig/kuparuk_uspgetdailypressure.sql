USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[KUPARUK_uspGetDailyPressure]    Script Date: 02/20/2013 12:52:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Amy Jacobs
-- Create date: April 18,2012
-- Description:	Create the daily station pressure.  
-- Units: meters, format Decimal(6,3)
-- =============================================
CREATE PROCEDURE [dbo].[KUPARUK_uspGetDailyPressure] 
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
    
  
    -- UAF/WERC:  pressure/mbar, AST
    -- VariableID = 125. Needs to be converted to a Daily value.  SourceID = 31
    -- Need to convert to UTCDateTime
    
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=125)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=125 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=125;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailyPressureDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(@avgValue, @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  
-- Toolik. Pressure/hourly  SourceID = 145
-- VariableID = 468
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID = @SiteID AND @varID=468)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=468 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=468;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailyPressureDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(@avgValue, @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
END







GO

