-- Function: tables.getmaxdailyprecip(timestamp without time zone, integer, integer, integer)

-- DROP FUNCTION tables.getmaxdailyprecip(timestamp without time zone, integer, integer, integer);

CREATE OR REPLACE FUNCTION tables.getmaxdailyprecip(
    IN currentdatetime timestamp without time zone,
    IN siteid integer,
    IN mindatavalue integer,
    IN maxdatavalue integer)
  RETURNS TABLE(valueid integer, datavalue double precision, originalvariableid integer) AS
$BODY$
DECLARE
    currentdatetime ALIAS FOR $1;
    site_id ALIAS FOR $2;
    mindatavalue ALIAS FOR $3;
    maxdatavalue ALIAS FOR $4;
BEGIN
SELECT d.valueid, d.datavalue, d.originalvariableid FROM tables.daily_precipdatavalues d
	WHERE d.UTCDateTime = currentdatetime
	        and (d.DataValue >= mindatavalue and d.DataValue < maxdatavalue)
	        and d.SiteID=site_id
	ORDER BY d.DataValue DESC, d.OriginalVariableID DESC
        LIMIT 1;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION tables.getmaxdailyprecip(timestamp without time zone, integer, integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.getmaxdailyprecip(timestamp without time zone, integer, integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.getmaxdailyprecip(timestamp without time zone, integer, integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.getmaxdailyprecip(timestamp without time zone, integer, integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.getmaxdailyprecip(timestamp without time zone, integer, integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.getmaxdailyprecip(timestamp without time zone, integer, integer, integer) TO chaase;
