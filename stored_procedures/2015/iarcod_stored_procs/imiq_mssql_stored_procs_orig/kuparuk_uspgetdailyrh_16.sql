USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[KUPARUK_uspGetDailyRH_16]    Script Date: 02/20/2013 12:53:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		Amy Jacobs
-- Create date: April 18, 2012
-- Description:	Create the daily relative humidity at 2m.  
-- =============================================
create PROCEDURE [dbo].[KUPARUK_uspGetDailyRH_16] 
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
    

    -- UAF/WERC:  RH/hourly/1m and 3m/AST
    -- VariableID = 80. Needs to be converted to a Daily value.  SourceID = 31
    -- Need to make sure offset is 2m or 1.5m
    -- Need to convert to UTCDateTime
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=80 AND (OffsetValue = 2 or OffsetValue = 1.5))
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=80 and convert(int,datepart(hh,dv.LocalDateTime)) = 16  and (dv.offsetvalue = 2 or dv.offsetvalue = 1.5) and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid)
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
		select @methodID = s.methodID, @variableID=s.VariableID
		    from seriesCatalog s
		    WHERE s.SiteID = @SiteID and s.VariableID=80;

	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailyRH16DataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
  -- UAF/WERC:  RH/hourly/1m and 3m/AST
    -- VariableID = 80. Needs to be converted to a Daily value.  SourceID = 31
    -- Need to convert 1m and 3m to 2m
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=80 AND OffsetValue = 1)
     BEGIN
          DECLARE max_cursor CURSOR FOR 
              SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
              FROM ODMDataValues AS dv
              WHERE dv.SiteID = @SiteID and dv.VariableID=80 and convert(int,datepart(hh,dv.LocalDateTime)) = 16  and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriesCatalog where @SiteID = siteid)
              GROUP BY CONVERT(Date,dv.DateTimeUTC);
              
		      select @methodID = s.methodID, @variableID=s.VariableID
		       from seriesCatalog s
		       WHERE s.SiteID = @SiteID and s.VariableID=80;
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @avgValue3m = avg(dv.DataValue)
                      FROM ODMDataValues AS dv
                      WHERE dv.SiteID = @SiteID and dv.VariableID=80 and dv.offsetvalue = 3 and @localDateTime = CONVERT(Date,dv.DateTimeUTC) and dv.siteid in 
                  (select distinct siteid from seriesCatalog where @SiteID = siteid);
                  SELECT @avgValue = (@avgValue3m - @avgValue1m)/2 + @avgValue1m;
                  -- If the 2m average temp is NULL, check and see if there is a 1m air temp and use it.
                   IF (@avgValue is  NULL and @avgValue1m is not NULL)
                   BEGIN
                       SELECT @avgValue = @avgValue1m;
                   END
	               INSERT INTO DailyRH16DataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	               VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
                  FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
END
    -- Toolik:  RH/hourly/1m and 3m/AST
    -- VariableID = 467. Needs to be converted to a Daily value.  SourceID = 145
    -- Need to convert 1m and 3m to 2m
    -- Need to convert to UTCDateTime
    ELSE IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=467 AND OffsetValue = 1)
     BEGIN
          DECLARE max_cursor CURSOR FOR 
              SELECT CONVERT(Date,dv.DateTimeUTC), AVG(dv.DataValue)
              FROM ODMDataValues AS dv
              WHERE dv.SiteID = @SiteID and dv.VariableID=467 and convert(int,datepart(hh,dv.LocalDateTime)) = 16 and dv.offsetvalue = 1 and dv.siteid in 
              (select distinct siteid from seriesCatalog where @SiteID = siteid)
              GROUP BY CONVERT(Date,dv.DateTimeUTC)
              order by CONVERT(Date,dv.DateTimeUTC);
              
		      select @methodID = s.methodID, @variableID=s.VariableID
		       from seriesCatalog s
		       WHERE s.SiteID = @SiteID and s.VariableID=467;
          OPEN max_cursor;
              FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              
              WHILE @@FETCH_STATUS = 0
              BEGIN
                      SELECT @avgValue3m = avg(dv.DataValue)
                      FROM ODMDataValues AS dv
                      WHERE dv.SiteID = @SiteID and dv.VariableID=467 and dv.offsetvalue = 3 and @localDateTime = CONVERT(Date,dv.DateTimeUTC) and dv.siteid in 
                  (select distinct siteid from seriesCatalog where @SiteID = siteid);
                  SELECT @avgValue = (@avgValue3m - @avgValue1m)/2 + @avgValue1m;
                  -- If the 2m average temp is NULL, check and see if there is a 1m air temp and use it.
                   IF (@avgValue is  NULL and @avgValue1m is not NULL)
                   BEGIN
                       SELECT @avgValue = @avgValue1m;
                   END
	               INSERT INTO DailyRH16DataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	               VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID);
                  FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue1m;
              END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
END

 
END




GO

