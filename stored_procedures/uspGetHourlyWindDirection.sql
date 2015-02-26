USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetHourlyWindDirection]    Script Date: 01/09/2015 13:49:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		Amy Jacobs
-- Create date: June 9, 2013
-- Description:	Create the hourly wind speed average.  
-- Updated: 10-18-2013 to add in column 'InsertDate' into table 'HOURLY_WindDirectionDataValues' table.  ASJ
-- =============================================
CREATE PROCEDURE [dbo].[uspGetHourlyWindDirection] 
	-- Add the parameters for the stored procedure here
	-- Create vector components:
	--    x = Wind Speed * COS(Wind Direction * PI/180)
	--    y = Wind Speed * SIN(Wind Direction * PI/180)
	-- Offsets, used to go from vector back to radial:
	--    if (x > 0  and y > 0) Offset=0
	--    if (x < 0 ) Offset=180
	--    if (x > 0) and y < 0) Offset=360
	-- if x <> 0, and x and y are not null
	--    Wind Direction = ARCTAN(y/x)*180/PI + Offset
	-- else if x = 0
	--    Wind Direction = 0
	-- else
	--    Wind Direction = null
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime,@avgValue float,@x float, @y float,@offset float,@OffsetValue float,@OffsetTypeID float;
 
    -- NCDC:  WindDirection
    -- VariableID = 334. SourceID = 209
    -- WS VariableID=335
    IF EXISTS (SELECT *  FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=334)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		    AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select SiteID,DateTimeUTC,DataValue as M
		  from ODMDataValues_metric WS
		  where WS.SiteID=@SiteID and WS.OriginalVariableID=335) as WS
		 on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC		
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END
  -- WERC Wind Direction
  -- VariableID=83  SourceID = 29,30,31,34,223
  -- WS Variable=82
    IF EXISTS (SELECT *  FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=83)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		       AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)), WS.max_OffsetValue,WS.max_OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select WS.SiteID,WS.DateTimeUTC,DataValue as M,MAX_Offset.max_OffsetValue as max_OffsetValue,MAX_Offset.max_OffsetTypeID
          from ODMDataValues_metric WS
          inner join
           (select SiteID,DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID
            from ODMDataValues_metric 
            where SiteID=@SiteID and OriginalVariableID=82
            group by SiteID,DateTimeUTC,OffsetTypeID) as MAX_Offset
            on MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC 
            WHERE WS.SiteID = @SiteID and WS.OriginalVariableid=82 and WS.OffsetValue=MAX_Offset.max_OffsetValue) as WS  
		 on WD.SiteID=WS.SiteID and WS.DateTimeUTC=WD.DateTimeUTC 	
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID and WD.OffsetValue=WS.max_OffsetValue 
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),WS.max_OffsetValue,WS.max_OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@offsetValue,@offsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID, @OffsetValue,@OffsetTypeID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@offsetValue,@offsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END
  -- Toolik Wind Direction
  -- VariableID=471  SourceID = 145
  -- WS Variable=470  Wind vector magnitude, 
  -- offset of 5
    IF EXISTS (SELECT *  FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=471)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		       AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)), WS.max_OffsetValue,WS.max_OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select WS.SiteID,WS.DateTimeUTC,DataValue as M,MAX_Offset.max_OffsetValue as max_OffsetValue,MAX_Offset.max_OffsetTypeID
          from ODMDataValues_metric WS
          inner join
           (select SiteID,DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID
            from ODMDataValues_metric 
            where SiteID=@SiteID and OriginalVariableID=470
            group by SiteID,DateTimeUTC,OffsetTypeID) as MAX_Offset
            on MAX_Offset.SiteID=WS.SiteID and MAX_Offset.DateTimeUTC=WS.DateTimeUTC 
            WHERE WS.SiteID = @SiteID and WS.OriginalVariableid=470 and WS.OffsetValue=MAX_Offset.max_OffsetValue) as WS  
		 on WD.SiteID=WS.SiteID and WS.DateTimeUTC=WD.DateTimeUTC 	
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID and WD.OffsetValue=WS.max_OffsetValue 
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),WS.max_OffsetValue,WS.max_OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@offsetValue,@offsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID, @OffsetValue,@OffsetTypeID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@offsetValue,@offsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END
	 
-- ARC LTER Wind Direction
-- VariableID=829, SourceID=144 
-- Wind Speed VariableID=827
IF EXISTS (SELECT *  FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=829)
   BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		    AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select SiteID,DateTimeUTC,DataValue as M
		  from ODMDataValues_metric WS
		  where WS.SiteID=@SiteID and WS.OriginalVariableID=827) as WS
		 on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC		
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END
	 
-- AON Wind Direction
-- VariableID=817, SourceID=222 
-- Wind Speed VariableID=815
IF EXISTS (SELECT *  FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=817)
   BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		    AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select SiteID,DateTimeUTC,DataValue as M
		  from ODMDataValues_metric WS
		  where WS.SiteID=@SiteID and WS.OriginalVariableID=815) as WS
		 on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC		
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END
	 
-- USGS Wind Direction
-- VariableID=314, SourceID=39 
-- Wind Speed VariableID=313
IF EXISTS (SELECT *  FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=314)
   BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		    AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select SiteID,DateTimeUTC,DataValue as M
		  from ODMDataValues_metric WS
		  where WS.SiteID=@SiteID and WS.OriginalVariableID=313) as WS
		 on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC		
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END
-- ARM Wind Direction
-- VariableID=528, SourceID=202 
-- Wind Speed VariableID=529
IF EXISTS (SELECT *  FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=528)
   BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		    AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select SiteID,DateTimeUTC,DataValue as M
		  from ODMDataValues_metric WS
		  where WS.SiteID=@SiteID and WS.OriginalVariableID=529) as WS
		 on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC		
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END
-- LPeters Wind Direction
-- VariableID=290, SourceID=182
-- Wind Speed VariableID=292
IF EXISTS (SELECT *  FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=290)
   BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		    AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select SiteID,DateTimeUTC,DataValue as M
		  from ODMDataValues_metric WS
		  where WS.SiteID=@SiteID and WS.OriginalVariableID=292) as WS
		 on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC		
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END	 
-- NOAA Wind Direction
-- VariableID=512, SourceID=35
-- Wind Speed VariableID=511
IF EXISTS (SELECT *  FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=512)
   BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		    AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select SiteID,DateTimeUTC,DataValue as M
		  from ODMDataValues_metric WS
		  where WS.SiteID=@SiteID and WS.OriginalVariableID=511) as WS
		 on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC		
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END		 
-- RWIS Wind Direction
-- VariableID=568, SourceID=213
-- Wind Speed VariableID=566
IF EXISTS (SELECT *  FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=568)
   BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)) as DateTimeUTC,
		    AVG(WS.M*SIN(WD.DataValue*PI()/180)), AVG(WS.M*COS(WD.DataValue*PI()/180)),OffsetValue, OffsetTypeID
		FROM ODMDataValues_metric AS WD
		inner join 
		 (select SiteID,DateTimeUTC,DataValue as M
		  from ODMDataValues_metric WS
		  where WS.SiteID=@SiteID and WS.OriginalVariableID=566) as WS
		 on WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC		
		WHERE WD.SiteID = @SiteID and WD.OriginalVariableid=@VarID
		GROUP BY DateAdd(hh, DATEPART(hh, WD.DateTimeUTC), DateAdd(d, DateDiff(d, 0, WD.DateTimeUTC), 0)),OffsetValue,OffsetTypeID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        
	        IF @x is not null and @y is not null and @x <> 0
	          BEGIN
	                IF @x>0 and @y >0
	                BEGIN
	                        SELECT @offset=0.0;
	                END
	                ELSE IF (@x< 0)             
	                BEGIN
	                        SELECT @offset=180.0;
	                END
	                ELSE IF @x > 0 and @y < 0
	                BEGIN
	                        SELECT @offset=360.0;
	                END
	                SELECT @avgValue = ATAN(@y/@x)*180/PI()+@offset;	                     
	          END
	        ELSE IF @x=0
	           BEGIN
	             SELECT @avgValue = 0;
	            END
	        ELSE
	          BEGIN
	                SELECT @avgValue = NULL;
	           END
	        INSERT INTO HOURLY_WindDirectionDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID, OffsetValue,OffsetTypeID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,@OffsetValue,@OffsetTypeID,GETDATE());
	    FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @y, @x,@OffsetValue,@OffsetTypeID;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	 END		 	 
END









GO

