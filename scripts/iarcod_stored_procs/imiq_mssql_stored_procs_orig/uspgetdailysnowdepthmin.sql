USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailySnowDepthMin]    Script Date: 02/20/2013 12:58:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Amy Jacobs
-- Create date: April 9, 2012
-- Description:	Create the daily snow depth min.  
-- Units: meters, format Decimal(6,3)
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailySnowDepthMin] 
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
    
  
    -- USGS:  Snow depth/hourly/cm, AST
    -- VariableID = 320. Needs to be converted to a Daily value.  SourceID = 39
    -- Need to convert to UTCDateTime
    -- Need to convert from cm to meters
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=320)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), MIN(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=320 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		 select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=320;
		
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
			select @avgValue = @avgValue / 100;
	        INSERT INTO DailySnowDepthMinDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(6,3),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
	        FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END

END








GO

