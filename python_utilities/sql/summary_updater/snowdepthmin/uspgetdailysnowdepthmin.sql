-- Function: tables.uspgetdailysnowdepthmin(integer, integer)

-- DROP FUNCTION tables.uspgetdailysnowdepthmin(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailysnowdepthmin(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE DateTimeUTC timestamp without time zone;
	minValue float;
	maxCursor refcursor;

BEGIN
-- UTC Datetime $ convert MIN from cm to meters for:
-- USGS:  Snow depth/hourly/cm, AST
-- SourceID = 39, VariableID = 320 
-- Need to convert from cm to meters
  IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= $1 AND 320=$2)
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',DateTimeUTC), MIN(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                          'WHERE dv.SiteID = 988 and dv.originalVariableID=320 GROUP BY date_trunc(''day'',DateTimeUTC);') USING site_id, var_id;
        loop
        fetch maxCursor into dateTimeUTC, minValue;
        if not found then 
	  exit;
	end if;
	SELECT minValue = minValue/100;
	INSERT INTO tables.dialy_snowdepthmindatavalues (datavalue, utcdatetime,siteid,origianlvariableid, insertdate) 
	       VALUES (minValue, dateTimeUTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;  
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailysnowdepthmin(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmin(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmin(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmin(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmin(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailysnowdepthmin(integer, integer) TO chaase;
