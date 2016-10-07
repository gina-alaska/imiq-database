USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetHourlySWE]    Script Date: 01/09/2015 13:49:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Amy Jacobs
-- Create date: June 13, 2013
-- Description:	Create the hourly SWE average.  
-- Units: mm 
-- =============================================
CREATE PROCEDURE [dbo].[uspGetHourlySWE] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime,  @avgValue float;
    
    -- NCDC ISH.  SWE/mm/Minute.  SourceID = 209
    -- VariableID = 373
    -- AVG the SWE (for snow depth) for each hour
    IF EXISTS (SELECT * FROM seriesCatalog_all WHERE SiteID= @SiteID AND @VarID=373)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0)) as DateTimeUTC,AVG(dv.DataValue)
		
		FROM ODMDataValues_metric AS dv
		INNER JOIN seriesCatalog_all sc ON sc.siteID = dv.siteID
		WHERE sc.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, DateTimeUTC), DateAdd(d, DateDiff(d, 0, DateTimeUTC), 0));
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO HOURLY_SWEDataValues (DataValue,UTCDateTime, SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC,@SiteID,@VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
    END

END




GO

