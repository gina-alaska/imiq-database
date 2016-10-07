USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetAllMonthlyAvgWindDirection]    Script Date: 01/09/2015 13:43:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Amy Jacobs
-- Create date: April 19,2012
-- Description:	Create the monthly average for all years
--		        wind direction average.  
-- =============================================
CREATE PROCEDURE [dbo].[uspGetAllMonthlyAvgWindDirection] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @localDateTime datetime, @localMonth int,@localYear int,@maxValue float,
    @minValue float, @avgValue float, @avgValue1m float, @avgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float,
    @methodID int, @qualifierID int, @variableID int,@loglaw int,@sinValue float,@cosValue float,
    @xValue float, @yValue float, @totValues int;
    
   
    -- All monthly wind speed values for SourceID=31 and SiteID=2128
   IF EXISTS (SELECT * FROM MonthlyAvgWindDirectionDataValues)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT month,AVG(SIN(RADIANS(dv.DataValue))), AVG(COS(RADIANS(dv.DataValue)))
		FROM MonthlyAvgWindDirectionDataValues AS dv
		WHERE (dv.VariableID=83 or dv.VariableID=471) and (dv.siteid=2128 or dv.siteid in (select distinct siteid from sites where sourceid=31))
		GROUP BY month
		order by month;
		

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localYear, @yValue, @xValue;
		
	    WHILE @@FETCH_STATUS = 0
	    
	    BEGIN

	               select @avgValue = DEGREES(ATN2(@xValue,@yValue))
	              if @avgValue < 0
	              BEGIN
			        select @avgValue = @avgValue + 360
			      END 
	               INSERT INTO AvgWindDirectionPerMonth2 (DataValue, month)
	               VALUES(@avgValue, @localYear);     
	       
			FETCH NEXT FROM max_cursor INTO @localYear, @yValue, @xValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
END















GO

