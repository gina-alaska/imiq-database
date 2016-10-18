
CREATE function KUPARUK_uspGetDailyPrecip (int,int) returns void as '
BEGIN
	DECLARE localDateTime timestamp; maxValue float;
    minValue float;  avgValue float; avgValue1m float; avgValue3m float; maxValue1m float; maxValue3m float; minValue1m float; minValue3m float;
    methodID int; qualifierID int; variableID int;
    SELECT CONVERT(Date,dv.DateTimeUTC), SUM(dv.DataValue)
		FROM ODMDataValues AS dv
		WHERE dv.SiteID = @SiteID and dv.VariableID=84 and dv.siteid in
		(select distinct siteid from seriesCatalog where @SiteID = siteid);
    END
END
;
' LANGUAGE 'plpgsql';