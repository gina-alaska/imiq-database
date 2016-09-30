-- Function: tables.uspgetdailywatertemp(integer, integer)

-- DROP FUNCTION tables.uspgetdailywatertemp(integer, integer);

CREATE OR REPLACE FUNCTION tables.uspgetdailywatertemp(
    site_id integer,
    var_id integer)
  RETURNS void AS
$BODY$
DECLARE dateTimeUTC timestamp without time zone;
        value float;
        offsetValue float;
        offsetType int;
        maxCursor refcursor;

BEGIN
-- take utc average for:
--   WERC, water temperature AKST
--   SourceID = 31, VariableID = 221 
-- OR 
--   WERC, water temperature AKST
--   SourceID = 30, VariableID = 92
-- OR 
--   USGS Water Temperature AKST
--   SourceID = 139,199, VariableID = 58
-- OR 
--   Toolik Field Station, Water Temperature, AKST
--   SourceID = 145, VariableID = 481
-- OR 
--   Tooolik Field Station, Water Temerature, AKST 
--   SourceID = 145, Variable = 495
-- OR 
--   WERC/BLM, Water Temperature, AKST
--   SourceID = 164, VariableID = 164
--   164 is variable ID of stream bed 
-- OR 
--   ADNR AHS deg c
--   SourceID = 259, VariableID = 1074
-- OR 
--   ADNR AHS deg f
--   SourceID = 259, VariableID = 1075
-- OR
--   CALON surface temp 
--   SourceID = 261, variableID = 1127
-- OR
--   CALON bedtemp 
--   SourceID = 261, variableID = 1128
-- OR
--   CALON laketemp 
--   SourceID = 261, variableID = 1129
  IF EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 221) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 92) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 58) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 481) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 495) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 164) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1074) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1075) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1127) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1128) OR
     EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 1129)
  THEN
    OPEN maxCursor
    for execute format('SELECT date_trunc(''day'',DateTimeUTC), AVG(dv.DataValue) FROM tables.ODMDataValues_metric AS dv '
                        'WHERE dv.SiteID = $1 and dv.OriginalVariableid = $2 GROUP BY date_trunc(''day'',DateTimeUTC);') USING site_id, var_id;
        loop
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
	INSERT INTO tables.daily_watertempdatavalues(datavalue, utcdatetime,siteid,originalvariableid, insertdate) 
	       VALUES (value, dateTimeUTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;
-- averages all water temp dephts for
--   WERC NSL Water Temerature. AKST
--   Source ID = 193, VariableID = 155 
  ELSIF EXISTS (SELECT * FROM tables.odmdatavalues_metric where siteid = $1 and $2 = 155)
  THEN 
  OPEN maxCursor
    for execute format('select date_trunc(''day'',wt.DateTimeUTC) as DateTimeUTC,AVG(DataValue),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID from tables.ODMDataValues_metric WT '
          'inner join '
            '(select SiteID,date_trunc(''day'',DateTimeUTC) as DateTimeUTC,MAX(OffsetValue) as max_OffsetValue,OffsetTypeID as max_OffsetTypeID from tables.ODMDataValues_metric '
            'where SiteID=$1 and OriginalVariableID=$2 group by SiteID, date_trunc(''day'',DateTimeUTC),OffsetTypeID) as MAX_Offset '
            'on MAX_Offset.SiteID=WT.SiteID and MAX_Offset.DateTimeUTC=date_trunc(''day'',wt.DateTimeUTC) and MAX_Offset.max_OffsetValue=WT.OffsetValue and MAX_Offset.max_OffsetTypeID=WT.OffsetTypeID '
            'WHERE WT.SiteID = $1 and OriginalVariableid=$2 group by date_trunc(''day'',wt.DateTimeUTC),MAX_Offset.max_OffsetValue,MAX_Offset.max_OffsetTypeID;') USING site_id, var_id;
        loop
        fetch maxCursor into dateTimeUTC, value;
        if not found then 
	  exit;
	end if;
	INSERT INTO tables.daily_watertempdatavalues(datavalue, utcdatetime,siteid,originalvariableid, insertdate) 
	       VALUES (value, dateTimeUTC, $1, $2,NOW());
        end loop;
    CLOSE maxCursor;
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tables.uspgetdailywatertemp(integer, integer)
  OWNER TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywatertemp(integer, integer) TO public;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywatertemp(integer, integer) TO imiq;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywatertemp(integer, integer) TO asjacobs;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywatertemp(integer, integer) TO rwspicer;
GRANT EXECUTE ON FUNCTION tables.uspgetdailywatertemp(integer, integer) TO chaase;
