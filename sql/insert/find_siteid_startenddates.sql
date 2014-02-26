declare @BeginDateTime as varchar(10), @EndDateTime as varchar(10),@siteID as int,@sourceID as int, @geolocation as varchar(100);

DECLARE site_loop_cursor CURSOR FOR
SELECT distinct siteID from seriesCatalog_62;

OPEN site_loop_cursor;
FETCH NEXT FROM site_loop_cursor INTO @siteID;
WHILE @@FETCH_STATUS = 0
BEGIN

  select @BeginDateTime = LTRIM(STR(YEAR(MIN(v.LocalDateTime))))+'-'+ RIGHT('0' + CAST(MONTH(MIN(v.LocalDateTime)) AS VARCHAR), 2) +'-'+RIGHT('0' + CAST(DAY(MIN(v.LocalDateTime)) AS VARCHAR), 2), 
         @EndDateTime= LTRIM(STR(YEAR(MAX(v.LocalDateTime))))+'-'+ RIGHT('0' + CAST(MONTH(MAX(v.LocalDateTime)) AS VARCHAR), 2) +'-'+RIGHT('0' + CAST(DAY(MAX(v.LocalDateTime)) AS VARCHAR), 2)
  from DataValues v
  inner join Datastreams d on v.DatastreamID=d.DatastreamID
  where v.DatastreamID in (select DatastreamID from seriesCatalog_62 where SiteID=@siteID)
  GROUP BY d.SiteID,UTCOffset

  select @geolocation=geolocation
  from Sites
  where SiteID=@siteID
  
  insert into sites_summary (SiteID,GeoLocation,BeginDate,EndDate) values(@siteID,@geolocation,@BeginDateTime,@EndDateTime)
  select @BeginDateTime=NULL, @EndDateTime=NULL
  
FETCH NEXT FROM site_loop_cursor INTO @siteID;
END;
CLOSE site_loop_cursor;
DEALLOCATE site_loop_cursor;