USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailySoilTempMax]    Script Date: 01/09/2015 13:46:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Amy Jacobs
-- Create date: April 9,2012
-- Description:	Create the daily soil temp max
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDailySoilTempMax] 
	-- Add the parameters for the stored procedure here
	@SiteID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @localDateTime datetime, @maxValue float,
    @minValue float, @avgValue float, @OffsetValue float,
    @methodID int, @qualifierID int, @OffsetTypeID int, @variableID int;
    
    -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 Offset=5
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=5 )
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=5
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=5;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 OffsetValue=10
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=10)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=10
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=10;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
    -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 OffsetValue=15
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=15)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=15
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=15;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
       -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 OffsetValue=20
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=20)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=20
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=20;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END
    -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 OffsetValue=25
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=25)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=25
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=25;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END  
    -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 OffsetValue=30
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=30)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=30
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=30;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END   
    -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 OffsetValue=45
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=45)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=45
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=45;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END  
    -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 OffsetValue=70
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=70)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=70
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=70;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END  
    -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 OffsetValue=95
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=95)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=95
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=95;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END     
     -- VariableID = 321 is soil temp.  Needs to be converted to a Daily value.  SourceID = 39 OffsetValue=120
    IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= @SiteID AND VariableID=321 AND OffsetValue=120)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime), MAX(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE SiteID = @SiteID and VariableID=321 and offsetValue=120
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        select @methodID = s.methodID, @variableID=s.VariableID,@OffsetTypeID=OffsetTypeID,@OffsetValue=OffsetValue
		    from ODMDataValues s
		    WHERE s.SiteID = @SiteID and s.VariableID=321 and OffsetValue=120;
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DailySoilTempMaxDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(convert(decimal(10,2),@avgValue), @localDateTime, @variableID,@SiteID, @methodID,@OffsetTypeID,@OffsetValue);
			FETCH NEXT FROM max_cursor INTO @localDateTime, @avgValue;
        END

	    CLOSE max_cursor;
		DEALLOCATE max_cursor;

    END 
END



GO

