USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetAllAvgWindDirection]    Script Date: 02/20/2013 12:55:34 ******/
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
CREATE PROCEDURE [dbo].[uspGetAllAvgWindDirection] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @localDateTime datetime, @localMonth int,@localYear int,@maxValue float,
    @minValue float, @avgValue float, @avgValue1m float, @avgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float,
    @methodID int, @qualifierID int, @variableID int,@loglaw int,@sinValue float,@cosValue float,
    @xValue float, @yValue float, @totValues int;
    
   
    -- UAF/WERC:  WindSpeed/ms, AST
    -- VariableID = 83. SourceID = 31
   IF EXISTS (SELECT * FROM AvgWindDirectionPerMonth)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT AVG(SIN(RADIANS(dv.DataValue))), AVG(COS(RADIANS(dv.DataValue)))
		FROM AvgWindDirectionPerMonth AS dv
		;
		

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @yValue, @xValue;
		
	    WHILE @@FETCH_STATUS = 0
	    
	    BEGIN
	        select @avgValue = DEGREES(ATN2(@xValue,@yValue));
	              if @avgValue < 0
	              BEGIN
			        select @avgValue = @avgValue + 360
			      END 
	               PRINT convert(varchar,@avgValue);
			         
	       
			FETCH NEXT FROM max_cursor INTO @yValue, @xValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
END












GO

