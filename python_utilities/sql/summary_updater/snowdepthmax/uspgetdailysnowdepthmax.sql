-- Function: tables.uspgetdailysnowdepthmax(integer, integer)

-- DROP FUNCTION tables.uspgetdailysnowdepthmax(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailysnowdepthmax(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE DateTimeUTC timestamp without time zone;
	maxValue float;
	maxCursor refcursor;

BEGIN
-- UTC Datetime $ convert MAX from cm to meters for:
-- USGS:  Snow depth/hourly/cm, AST
-- SourceID = 39, VariableID = 320 
-- Need to convert from cm to meters
  IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= $1 AND 320=$2)
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',DateTimeUTC), MAX(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = $1 and dv.originalVariableID=320 GROUP BY date_trunc(''day'',DateTimeUTC);') USING site_id, var_id;
        loop
        fetch maxCursor into dateTimeUTC, maxValue;
        if not found then 
	  exit;
	end if;
	SELECT maxValue = maxValue/100;
	INSERT INTO tables.dialy_snowdepthmaxdatavalues (datavalue, utcdatetime,siteid,origianlvariableid, insertdate) 
	       VALUES (maxValue, dateTimeUTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;  
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailysnowdepthmax(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmax(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmax(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmax(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmax(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmax(integer, integer) TO chaase;
