/* insertPeakSWE.sql
This query will populate the YEARLY_PeakSWE_Avg table.
*/
use IARCOD

SET NOCOUNT ON;      
DECLARE @maxYear int, @maxValue float,@SiteID int;
DECLARE site_cursor CURSOR FOR
SELECT distinct siteid
FROM DAILY_SWE;
 OPEN site_cursor;
  FETCH NEXT FROM site_cursor INTO @siteID;
  
WHILE @@FETCH_STATUS = 0BEGIN
  DECLARE max_cursor CURSOR FOR
   SELECT YEAR(d.UTCDateTime)as max_year, max(d.DataValue) as max_value, d.siteid
   from DAILY_SWE d
   where MONTH(d.UTCDateTime) in (3,4,5,6)
   and d.siteid = @siteid
   GROUP by YEAR(d.UTCDateTime),d.siteid
ORDER BY YEAR(d.UTCDateTime)
        OPEN max_cursor;

            FETCH NEXT FROM max_cursor INTO @maxYear, @maxValue, @SiteID;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO ANNUAL_PeakSWE_ALL (SiteID,year,DataValue)
            VALUES(@SiteID,@maxYear,@maxValue);
            FETCH NEXT FROM max_cursor INTO @maxYear, @maxValue, @SiteID;

         END
        CLOSE max_cursor;
            DEALLOCATE max_cursor;

       FETCH NEXT FROM site_cursor INTO @siteID;

END
CLOSE site_cursor;
        DEALLOCATE site_cursor;
