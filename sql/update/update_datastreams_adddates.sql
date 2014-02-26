declare @BeginDateTime as varchar(10), @EndDateTime as varchar(10),@datastreamID as int;

DECLARE loop_cursor CURSOR FOR
SELECT datastreamID from datastreams;

OPEN loop_cursor;
FETCH NEXT FROM loop_cursor INTO @datastreamID;
WHILE @@FETCH_STATUS = 0
BEGIN
  select @BeginDateTime = LTRIM(STR(YEAR(MIN(v.LocalDateTime))))+'-'+ RIGHT('0' + CAST(MONTH(MIN(v.LocalDateTime)) AS VARCHAR), 2) +'-'+RIGHT('0' + CAST(DAY(MIN(v.LocalDateTime)) AS VARCHAR), 2), 
         @EndDateTime= LTRIM(STR(YEAR(MAX(v.LocalDateTime))))+'-'+ RIGHT('0' + CAST(MONTH(MAX(v.LocalDateTime)) AS VARCHAR), 2) +'-'+RIGHT('0' + CAST(DAY(MAX(v.LocalDateTime)) AS VARCHAR), 2)
  from DataValues v
  where v.DatastreamID=@datastreamID
  GROUP BY v.DatastreamID,UTCOffset

 update Datastreams
  set BDATE=@BeginDateTime,
      EDATE=@EndDateTime
  where datastreamid=@datastreamID 
 select @BeginDateTime = NULL, @EndDateTime=NULL
FETCH NEXT FROM loop_cursor INTO @datastreamID;
END;
CLOSE loop_cursor;
DEALLOCATE loop_cursor;