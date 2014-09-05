use IARCOD

SET NOCOUNT ON;      
DECLARE @maxYear int, @maxValue float,
@SiteID int, @variableID int;

DECLARE site_cursor CURSOR FOR
SELECT distinct siteid
FROM DAILY_Discharge;
 OPEN site_cursor;
  FETCH NEXT FROM site_cursor INTO @siteID;
  
WHILE @@FETCH_STATUS = 0BEGIN
  DECLARE max_cursor CURSOR FOR
   SELECT YEAR(d.UTCDateTime)as max_year, max(d.DataValue) as max_value, d.siteid
   from DAILY_Discharge d
   where MONTH(d.UTCDateTime) in (5,6)
   and d.siteid = @siteid
   GROUP by YEAR(d.UTCDateTime),d.siteid,d.variableid
ORDER BY YEAR(d.UTCDateTime)
        OPEN max_cursor;

            FETCH NEXT FROM max_cursor INTO @maxYear, @maxValue, @SiteID;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO ANNUAL_PeakDischarge_ALL (DataValue,year,SiteID)
            VALUES(@maxValue, @maxYear,@SiteID);
            FETCH NEXT FROM max_cursor INTO @maxYear, @maxValue, @SiteID;

         END
        CLOSE max_cursor;
            DEALLOCATE max_cursor;

       FETCH NEXT FROM site_cursor INTO @siteID;

END
CLOSE site_cursor;
        DEALLOCATE site_cursor;
