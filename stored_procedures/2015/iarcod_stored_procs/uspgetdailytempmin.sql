
CREATE PROCEDURE [dbo].[uspGetDailyTempMin] 
	@SiteID int, @VarID int
AS
BEGIN
--	DECLARE @localDateTime datetime, @maxValue float, @minValue float, @avgValue float, @avgValue1m float, @avgValue3m float, @maxValue1m float, @maxValue3m float, @minValue1m float, @minValue3m float, @methodID int, @qualifierID int, @variableID int;
    IF EXISTS (SELECT * FROM seriesCatalog WHERE SiteID= @SiteID AND VariableID=310)
    BEGIN
		SELECT CONVERT(Date,dv.DateTimeUTC), MIN(dv.DataValue) FROM ODMDataValues AS dv WHERE dv.SiteID = @SiteID and dv.VariableID=310 and dv.siteid in 
		(select distinct siteid from seriesCatalog where @SiteID = siteid) GROUP BY CONVERT(Date,dv.DateTimeUTC);
        END
    END

GO

