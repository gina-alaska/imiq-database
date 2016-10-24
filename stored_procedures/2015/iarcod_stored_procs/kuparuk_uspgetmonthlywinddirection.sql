USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[KUPARUK_uspGetMonthlyWindDirection]    Script Date: 02/20/2013 12:54:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Amy Jacobs
-- Create date: April 17,2012
-- Description:	Create the daily wind direction average.  
-- =============================================
CREATE PROCEDURE [dbo].[KUPARUK_uspGetMonthlyWindDirection] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @localDateTime datetime, @localMonth datetime,@localYear datetime,@maxValue float,
    @minValue float, @avgValue float, @avgValue1m float, @avgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float,
    @methodID int, @qualifierID int, @variableID int,@loglaw int,@sinValue float,@cosValue float,
    @xValue float, @yValue float, @totValues int;
    
   
     -- UAF/WERC:  WindSpeed/ms, AST
    -- VariableID = 83. SourceID = 31
    -- Needs to be converted to a Daily value.  
    -- Need to convert to UTCDateTime
   IF EXISTS (SELECT * FROM DailyAvgWindDirectionDataValues WHERE SiteID= @SiteID AND VariableID=83)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT month(dv.UTCDateTime), year(dv.UTCDateTime),AVG(SIN(RADIANS(dv.DataValue))), AVG(COS(RADIANS(dv.DataValue)))
		FROM DailyAvgWindDirectionDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=83 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY month(dv.UTCDateTime),year(dv.UTCDateTime);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=83;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localMonth, @localYear, @yValue, @xValue;
		
	    WHILE @@FETCH_STATUS = 0
	    
	    BEGIN
	        SELECT @totValues = count(dv.DataValue)
	        FROM DailyAvgWindDirectionDataValues AS dv
	        WHERE dv.SiteID = @SiteID and dv.VariableID=83  and month(dv.UTCDateTime) = @localMonth and YEAR(dv.UTCDateTime) = @localYear;
	        
	       if @totValues >= 10
				BEGIN
	               select @avgValue = DEGREES(ATN2(@xValue,@yValue))
	              if @avgValue < 0
	              BEGIN
			        select @avgValue = @avgValue + 360
			      END       
	               INSERT INTO MonthlyAvgWindDirectionDataValues2 (DataValue,month,year, VariableID,SiteID,MethodID)
	               VALUES(@avgValue, convert(int,@localMonth), convert(int,@localYear), @variableID,@SiteID, @methodID);

			    END
			    
			FETCH NEXT FROM max_cursor INTO @localMonth, @localYear, @yValue, @xValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  

    -- Toolik  Precip/hourly/mm, AST
    -- VariableID = 471, SourceID = 145
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
 ELSE IF EXISTS (SELECT * FROM DailyAvgWindDirectionDataValues WHERE SiteID= @SiteID AND VariableID= 471)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT month(dv.UTCDateTime), year(dv.UTCDateTime), AVG(SIN(RADIANS(dv.DataValue))), AVG(COS(RADIANS(dv.DataValue)))
		FROM DailyAvgWindDirectionDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=471 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY month(dv.UTCDateTime),year(dv.UTCDateTime);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=471;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localMonth, @localYear, @yValue, @xValue;
		
	    WHILE @@FETCH_STATUS = 0
	    
	    BEGIN
	        SELECT @totValues = count(dv.DataValue)
	        FROM DailyAvgWindDirectionDataValues AS dv
	        WHERE dv.SiteID = @SiteID and dv.VariableID=471  and month(dv.UTCDateTime) = @localMonth and YEAR(dv.UTCDateTime) = @localYear;
	        
	       if @totValues >= 10
				BEGIN
				
	             select @avgValue = DEGREES(ATN2(@xValue,@yValue))
	             if @avgValue < 0
	             BEGIN
			       select @avgValue = @avgValue + 360
			     END       
	               INSERT INTO MonthlyAvgWindDirectionDataValues2 (DataValue,month,year, VariableID,SiteID,MethodID)
	               VALUES(@avgValue, convert(int,@localMonth), convert(int,@localYear), @variableID,@SiteID, @methodID);

			    END

				FETCH NEXT FROM max_cursor INTO @localMonth, @localYear, @yValue, @xValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
END












GO

