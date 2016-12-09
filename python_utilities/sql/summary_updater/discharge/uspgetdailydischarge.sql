-- Function: tables.uspgetdailydischarge(integer, integer)

-- DROP FUNCTION tables.uspgetdailydischarge(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailydischarge(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE DateTimeUTC timestamp without time zone;
	avgValue float;
	max_cursor refcursor;

BEGIN
-- take the value for:
--   NWIS: Discharge/cubic feet per second/ Daily. AKST
--   SourceID = 139,199,  VariableID = 56
-- OR 
--   LChamberlinStreamDischarge_cfs_dataTypeUnk: Discharge/Daily/cfs. AKST
--   SourceID = 183, VariableID = 304
-- OR
--   FWS_Discharge: Discharge/cfs/Daily. AKST
--   SourceID = 154, VariableID = 343
-- OR
--   BLM-WERC_Whitman-Arp_Discharge:  Discharge/sporadic/cms, AKST
--   SourceID = 164, VariableID = 152
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 and $2 = 56)  OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 304) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 343) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 152) 
  THEN
    OPEN max_cursor
    for execute format('SELECT date_trunc(''day'',dv.localdatetime) as DateTimeUTC, dv.DataValue FROM tables.odmdatavalues_metric AS dv '
                         'WHERE dv.siteid = $1 and dv.originalvariableid=$2;') USING site_id,var_id;
        loop
        fetch max_cursor into DateTimeUTC, avgValue;
	  if not found then
	    exit;
	  end if;
	  INSERT INTO tables.daily_dischargedatavalues (datavalue,utcdatetime,originalvariableid,siteid, insertdate) 
	         VALUES(avgValue,DateTimeUTC,$2,$1, NOW());
	end loop;
     close max_cursor;
-- average measurments to get a daily value for: 
--   USGS_BLM_Discharge: Discharge/minutely/cfs. AKST
--   SourceID = 199, VariableID = 445
-- OR 
--   USGS_BLM_Discharge: Discharge/every 30 minuets/cfs. AKST
--   SourceID = 199, VariableID = 497
-- OR
--   UAFWERC_Discharge:  Discharge/hourly/cms. AKST
--   SourceID = 30,29, VariableID = 90
-- OR
--   UAFWERC_Discharge_MINUTE_calculated:  Discharge/minutes/cms. AKST
--   SourceID = 31, VariableID = 145
-- OR
--   UAFWERC_Discharge_QUARTER_HOUR_calculated:  Discharge/every 15 minutes/cms, AKST
--   SourceID = 31, VariableID = 148
-- OR
--   UAFWERC_Discharge_HOURLY_calculated:  Discharge/hourly/cms, AKST
--   SourceID = 31, VariableID = 149
-- OR
--   UAFWERC_Discharge_SPORDAIC:  Discharge/sopradic/cms, AKST
--   SourceID = 31, VariableID = 150
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 445) OR 
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 497) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 90) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 145) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 148) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 149) OR
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 150) OR 
        EXISTS (SELECT * FROM tables.odmdatavalues_metric WHERE siteid = $1 AND $2 = 1084)
  THEN
    OPEN max_cursor
    for execute format('SELECT  date_trunc(''day'',dv.datetimeutc - interval ''18 hours'') as DateTimeUTC, AVG(dv.DataValue) FROM tables.odmdatavalues_metric AS dv
                           WHERE dv.siteid = $1 and dv.originalvariableid= $2
                           GROUP BY date_trunc(''day'',dv.datetimeutc - interval ''18 hours'');') USING site_id,var_id;
        loop
        fetch max_cursor into DateTimeUTC, avgValue;
	  if not found then
	    exit;
	  end if;
	  INSERT INTO tables.daily_dischargedatavalues (datavalue,utcdatetime,originalvariableid,siteid, insertdate) 
 	         VALUES(avgValue,DateTimeUTC,$2,$1, NOW());
	end loop;
     close max_cursor;
  END IF;





END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailydischarge(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailydischarge(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailydischarge(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailydischarge(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailydischarge(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailydischarge(integer, integer) TO chaase;
