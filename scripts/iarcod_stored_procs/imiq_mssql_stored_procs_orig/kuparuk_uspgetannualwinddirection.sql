USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[KUPARUK_uspGetAnnualWindDirection]    Script Date: 02/20/2013 12:52:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












-- =============================================
-- Author:		Amy Jacobs
-- Create date: April 17,2012
-- Description:	Create the daily wind direction average.  
-- =============================================
CREATE PROCEDURE [dbo].[KUPARUK_uspGetAnnualWindDirection] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
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
    -- Needs to be converted to a Daily value.  
    -- Need to convert to UTCDateTime
   IF EXISTS (SELECT * FROM AvgWindDirectionPerYear WHERE SiteID= @SiteID AND VariableID=83)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT AVG(SIN(RADIANS(dv.DataValue))), AVG(COS(RADIANS(dv.DataValue))), COUNT(*)
		FROM AvgWindDirectionPerYear  AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=83 and dv.year >= 1989 and dv.year <= 2010 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY SiteID;
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=83;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @yValue, @xValue, @totValues;
		
	    WHILE @@FETCH_STATUS = 0
	    
	    BEGIN
	        
	        select @avgValue = DEGREES(ATN2(@xValue,@yValue));
	              if @avgValue < 0
	              BEGIN
			        select @avgValue = @avgValue + 360;
			      END 
	           
	               INSERT INTO AvgAnnualWindDirections_v2 (SiteID,Avg,totalYears)
	               VALUES(@SiteID,convert(decimal(10,2),@avgValue), @totValues);
			         
	       
			FETCH NEXT FROM max_cursor INTO @yValue, @xValue, @totValues;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  

    -- Toolik  Precip/hourly/mm, AST
    -- VariableID = 471, SourceID = 145
    -- Need to convert hourly to daily
    -- Need to convert from AST to UTC time
 ELSE IF EXISTS (SELECT * FROM AvgWindDirectionPerYear  WHERE SiteID= @SiteID AND VariableID= 471)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT AVG(SIN(RADIANS(dv.DataValue))), AVG(COS(RADIANS(dv.DataValue))), COUNT(*)
		FROM AvgWindDirectionPerYear  AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=471 and dv.year >= 1989  and dv.year <= 2010 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY SiteID;
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=471;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @yValue, @xValue, @totValues;
		
	    WHILE @@FETCH_STATUS = 0
	    
	    BEGIN
	         select @avgValue = DEGREES(ATN2(@xValue,@yValue));
	              if @avgValue < 0
	              BEGIN
			        select @avgValue = @avgValue + 360;
			      END 
	               INSERT INTO AvgAnnualWindDirections_v2 (SiteID,Avg,totalYears)
	               VALUES(@SiteID,convert(decimal(10,2),@avgValue), @totValues);
			    
			    
			FETCH NEXT FROM max_cursor INTO @yValue, @xValue, @totValues;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    
END












GO

