-- Function: tables.uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer)

-- DROP FUNCTION tables.uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailyavgsoilmoisture_anaktuvikpass(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
        avgValue float;
        loopCursor refcursor;

BEGIN
-- UAF/WERC: Soil MOisture/hourly, AKST
-- SourceID = 30,29 VariableID = 89
-- need to check offset = 10 cm
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 89 and offserValue = 10)
  THEN
    OPEN loopCursor
    for execute format('SELECT date_trunc(''day'',dv.datetimeutc), AVG(dv.DataValue) FROM tables.odmdatavalues_metric AS dv '
                          'WHERE dv.SiteID = 907 and dv.originalVariableID=89 and (dv.offsetvalue = 10) GROUP BY date_trunc(''day'',dv.datetimeutc);') using site_id, var_id;
        loop
        fetch loopCursor into dateTimeUTC, avgValue;
        if not found then 
          exit; 
        end if;
        INSERT INTO tables.DAILY_AnaktuvikPassSoilMoisureDataValues (DataValue,UTCDateTime, VariableID,SiteID,MethodID)
	       VALUES(avgValue, dateTimeUTC, $2,$1, methodID);
        end loop;                      
    CLOSE loopCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailyavgsoilmoisture_anaktuvikpass(integer, integer) TO chaase;
