-- Function: tables.uspgetdailysoiltemp(integer)

-- DROP FUNCTION tables.uspgetdailysoiltemp(integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailysoiltemp(site_id integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
        value float;
        maxCursor refcursor;
BEGIN
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=5 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=5 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=5;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
  -- offset = 10 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=10 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=10 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=10;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;

   -- offset = 15 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=15 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=15 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=15;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
 -- offset = 20 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=20 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=20 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=20;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 25 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=25 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=25 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=25;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 30 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=30 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=30 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=30;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 45 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=45 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=45 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=45;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 70 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=70 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=70 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=70;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 95 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=95 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=95 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=95;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
    -- offset = 120 
  IF EXISTS (SELECT * FROM ODMDataValues WHERE SiteID= $1 AND VariableID=321 AND OffsetValue=120 )
  THEN 
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',dv.LocalDateTime), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE SiteID = $1 and originalVariableID=321 and offsetValue=120 GROUP BY date_trunc(''day'',dv.LocalDateTime);') using site_id;
        loop
        select s.methodID as methodID, s.originalvariableID as originalVariableID, s.OffsetTypeID as OffsetTypeID, s.OffsetValue as OffsetValue
		    from tables.ODMDataValues_metric s
		    WHERE s.SiteID = 988 and s.originalVariableID=321 and OffsetValue=120;
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
         INSERT INTO tables.DailySoilTempDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID,OffsetTypeID,OffsetValue)
	        VALUES(Value, localDateTime, variableID,SiteID, methodID,OffsetTypeID,OffsetValue);
        end loop;
    CLOSE maxCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailysoiltemp(integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysoiltemp(integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysoiltemp(integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysoiltemp(integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysoiltemp(integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysoiltemp(integer) TO chaase;
