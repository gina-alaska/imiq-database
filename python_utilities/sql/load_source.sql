DO $$ DECLARE siteID int; srcID int; varID int; sourceCursor refcursor; siteCursor refcursor;
BEGIN
  --select vID = 1084;
  OPEN sourceCursor
  for execute('SELECT sor.sourceID from tables.sources as sor where sor.SourceID in (212)');
      loop
      fetch sourceCursor into srcID;
      if not found then exit; end if;
      OPEN siteCursor
        for execute('SELECT si.siteID from tables.sites as si where si.sourceID = $1') using srcID;
            loop
            fetch siteCursor into siteID;
            if not found then exit; end if;
             execute tables.uspgetdailysnowdepth(siteID, 612);
            end loop;
      CLOSE siteCursor;
      end loop; 
  CLOSE sourceCursor;
END$$;