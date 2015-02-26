USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspGetDailyPrecip]    Script Date: 09/02/2014 13:52:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		Amy Jacobs
-- Create date: July 16, 2013
-- Updated: 10-17-2013.  Added in 'InsertDate' column to 'DAILY_PrecipDataValues' table.  ASJ
-- updated 8-28-2014:  Using 'Hourly_precip' and not 'daily_precip', which has had the hourly
--     thresholds applied to the data already.
-- Added in SourceID=164, UAF-BLM Chrip Arp
-- Description:	Create the hourly precip average for North of 62 in Alaska.  
-- =============================================
CREATE  PROCEDURE [dbo].[uspGetDailyPrecip] 
	-- Add the parameters for the stored procedure here
	@SiteID int, @VarID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateTimeUTC datetime,@AvgValue float;
    
    -- NCDC GHCN
    -- VariableID = 398  SourceID = 210
    -- Taking the highest precip recorded in the hour
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=398)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC)  as DateTimeUTC,MAX(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC) ;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
		
    -- ISH
    -- VariableID = 340 is ISH Precip/UTC hourly/mm.  SourceID = 209
    -- SUM of hourly precip values for the day
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=340 and SiteID not in (select siteid from sites where
     LocationDescription like '%WBANID:%' and SourceID=209)) --the siteids which have a match in GHCN, based on wban
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
		
    -- UAF/WERC:  Precip/mm, AST
    -- VariableID = 84. SourceID = 29, 30, 31, 34
    -- Taking the MAX precip in the hour
    ELSE IF EXISTS (SELECT * FROM ODMDataValues_metric WHERE SiteID= @SiteID AND @VarID=84)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
  
    -- USGS:  Precip/hourly/mm, AST
    -- VariableID = 319. SourceID = 39
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=319)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- RAWS:  
    -- VariableID = 441. SourceID = 211,214,215,216,217,218,219
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=441)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.DateTimeUTC) as DateTimeUTC,MAX(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.DateTimeUTC);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
		
    -- SNOTEL:  
    -- AKST, need to use localdatetime to stay on same day
    -- VariableID = 394. SourceID = 212
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=394)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime) as DateTimeUTC,dv.DataValue	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
	-- SNOTEL:  
    -- AKST, need to use localdatetime to stay on same day
    -- VariableID = 610. SourceID = 212
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=610)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv3.LocalDateTime,
               CurrentDataValue = CASE WHEN dv3.DataValue >= dv3.PrevDataValue THEN dv3.DataValue - dv3.PrevDataValue
                       WHEN PrevDataValue > dv3.DataValue THEN 0
                       ELSE dv3.DataValue END
        FROM
       (SELECT  dv.LocalDateTime, dv.DataValue,(SELECT TOP 1 dv2.DataValue as PrevDataValue
		    FROM ODMDataValues_metric dv2
		    WHERE dv2.SiteID = @SiteID and dv2.OriginalVariableID=@VarID and dv2.LocalDateTime < dv.LocalDateTime and dv2.DataValue >= 0 order by dv2.LocalDateTime DESC) as PrevDataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID and dv.DataValue >= 0) AS dv3
		where dv3.DataValue >= 0
		order by dv3.LocalDateTime;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
	-- SNOTEL:  
    -- AKST, need to use localdatetime to stay on same day
    -- VariableID = 634. SourceID = 212
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=634)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT dv3.LocalDateTime,
               CurrentDataValue = CASE WHEN dv3.DataValue >= dv3.PrevDataValue THEN dv3.DataValue - dv3.PrevDataValue
                       WHEN PrevDataValue > dv3.DataValue THEN 0
                       ELSE dv3.DataValue END
        FROM
       (SELECT  dv.LocalDateTime, dv.DataValue,(SELECT TOP 1 dv2.DataValue as PrevDataValue
		    FROM ODMDataValues_metric dv2
		    WHERE dv2.SiteID = @SiteID and dv2.OriginalVariableID=@VarID and dv2.LocalDateTime < dv.LocalDateTime and dv2.DataValue >= 0 order by dv2.LocalDateTime DESC) as PrevDataValue
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableID=@VarID and dv.DataValue >= 0) AS dv3
		where dv3.DataValue >= 0
		order by dv3.LocalDateTime;
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- Toolik  Precip/hourly/mm, AST
    -- VariableID = 461, SourceID = 145
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=461)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
  
    -- McCall:  
    -- VariableID = 199. SourceID = 178,182
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=199)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
  
    -- UAF:  
    -- VariableID = 274. SourceID = 180
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=274)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- Chamberlin:  
    -- VariableID = 301. SourceID = 183
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=301)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
    -- BLM/Kemenitz. Precip/mm/Hourly  SourceID = 199
    -- 8/28/2014:  All data values pulled, too many errors
    -- VariableID = 496 
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=496)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
  -- BLM/Kemenitz. Precip/inches/every 15 minutes  SourceID = 199
    -- 8/28/2014:  All data values pulled, too many errors
    -- VariableID = 458 
    -- SUM, not max, since the DataValue is not accumulating over the hour.
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=458)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID);
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END

    -- BLM:  
    -- VariableID = 62 SourceID = 199
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=62)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID);
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
		
-- BLM/Kemenitz. Precip/inches/Minute  SourceID = 139
-- VariableID = 336
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=336)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
-- NOAA. Precip/mm/Minute  SourceID = 35
    -- VariableID = 522 
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=522)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	
-- ARM TPS. Precip/mm/Minute  SourceID = 1,203, VariableID=539
-- 8/28/2014:  Currently no data values loaded in hourly or daily 
-- SUM, not max, since the DataValue is not accumulating over the hour.
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=539)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
 
    -- LPeters. Precip/Hourly  SourceID = 182
    -- VariableID = 294 
    -- MAX precip for the hour
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=294)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM HOURLY_Precip  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
	   
	-- RWIS. Precip/Mintues  SourceID = 213
    -- VariableID = 575
  ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=575)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.UTCDateTime) as DateTimeUTC,SUM(dv.DataValue)
		FROM HOURLY_Precip  AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.UTCDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END
    -- UAF-BLM:  
    -- VariableID = 646. SourceID = 164
    ELSE IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND @VarID=646)
    BEGIN
	    DECLARE max_cursor CURSOR FOR 
		SELECT CONVERT(Date,dv.LocalDateTime) as DateTimeUTC,SUM(dv.DataValue)	
		FROM ODMDataValues_metric AS dv
		WHERE dv.SiteID = @SiteID and dv.OriginalVariableid=@VarID
		GROUP BY CONVERT(Date,dv.LocalDateTime);
        
	    OPEN max_cursor;
		FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;

	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO DAILY_PrecipDataValues (DataValue,UTCDateTime,SiteID,OriginalVariableID,InsertDate)
	        VALUES(@avgValue, @DateTimeUTC, @SiteID, @VarID,GETDATE());
			FETCH NEXT FROM max_cursor INTO @DateTimeUTC, @avgValue;
        END
	    CLOSE max_cursor;
		DEALLOCATE max_cursor;
	END	  
END






















GO

