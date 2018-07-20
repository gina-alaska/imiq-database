--Update tables.datastreams to add the BDATE and EDATE for the datastreams.
-- will only set if there is a change, also sets downloaddate to now().
DO $$
DECLARE
BeginDateTime VARCHAR(10);
EndDateTime VARCHAR(10);
BDD VARCHAR(10);
EDD VARCHAR(10);
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
 
 -- find old beign and end and only update if there is a change 
 select min(ds.BDATE), max(ds.EDATE) into bdd, edd
 from tables.datastreams ds
  where ds.datastreamid = datastream_ID;
 
 IF EDD != EndDateTime or BDD != BeginDateTime THEN
 update tables.datastreams
  set BDATE = BeginDateTime,
      EDATE = EndDateTime,
      DOWNLOADDATE = NOW()
  where datastreamid = datastream_ID; 
 END IF;
 select NULL,NULL into BeginDateTime, EndDateTime;
 end loop;
close loop_cursor;
END $$;

