USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[KUPARUK_uspGetDailyPrecip]    Script Date: 02/20/2013 12:52:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Amy Jacobs
-- Create date: April 16,2012
-- Description:	Create the daily precip average for Kuparuk.  Used in Toolik paper.  
-- =============================================
CREATE PROCEDURE [dbo].[KUPARUK_uspGetDailyPrecip] 
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
    
 
    -- UAF/WERC:  Precip/mm, AST
    -- VariableID = 84. SourceID = 31
    -- Needs to be converted to a Daily value.  
    -- Need to convert to UTCDateTime
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=84)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=84 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=84;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO KUPARUK_DailyAvgPrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
    -- SNOTEL  Temp/daily/inches, UTC
    -- VariableID = 394, SourceID = 124
    -- Convert from inches to mm
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=394)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), dv.DataValue
		FROM DataValues AS dv
		INNER JOIN seriesCatalog ON seriesCatalog.datastreamID = dv.datastreamID
		WHERE seriesCatalog.SiteID = @SiteID and seriesCatalog.VariableID=394;
		
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=394;
		    
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        select @avgValue = @avgValue * 25.4;
	        INSERT INTO KUPARUK_DailyAvgPrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
    -- Toolik  Precip/hourly/mm, AST
    -- VariableID = 461, SourceID = 145
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
 ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID= 461)
  BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=461 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=461;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO KUPARUK_DailyAvgPrecipDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@AvgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @AvgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
END





GO

