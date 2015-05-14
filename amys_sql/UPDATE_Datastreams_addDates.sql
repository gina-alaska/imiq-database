--Update tables.datastreams to add the BDATE and EDATE for the datastreams.
DO $$
DECLARE
BeginDateTime VARCHAR(10);
EndDateTime VARCHAR(10);
datastream_ID INTEGER;
loop_cursor refcursor;

BEGIN

OPEN loop_cursor FOR execute('select datastreamid from tables.datastreams');
loop
  fetch loop_cursor into datastream_ID;
  if not found then
	exit;
  end if;
  select to_char(min(v.localdatetime),'YYYY-MM-DD'), to_char(max(v.localdatetime),'YYYY-MM-DD') into BeginDateTime, EndDateTime
  from tables.datavalues v
  where v.datastreamid = datastream_ID
  GROUP BY v.datastreamid,v.utcoffset;

 update tables.datastreams
  set BDATE = BeginDateTime,
      EDATE = EndDateTime
  where datastreamid = datastream_ID; 
 select NULL,NULL into BeginDateTime, EndDateTime;
 end loop;
close loop_cursor;
END $$;
