USE [IARCOD]
GO

/****** Object:  UserDefinedFunction [dbo].[GetMaxDailyPrecip]    Script Date: 09/05/2014 11:09:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Amy Jacobs
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[GetMaxDailyPrecip] 
(
	-- Add the parameters for the function here
	@CurrentDateTime DateTime,
	@SiteID int,
	@MinDataValue int,
	@MaxDataValue int
)
RETURNS 
@retMaxDailyPrecip TABLE 
(
	-- Add the column definitions for the TABLE variable here
	ValueID int PRIMARY KEY NOT NULL,
	DataValue float NOT NULL,
	OriginalVariableID int NOT NULL
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	INSERT INTO @retMaxDailyPrecip
	SELECT TOP 1 ValueID, DataValue, OriginalVariableID FROM DAILY_PrecipDataValues
	WHERE UTCDateTime = @CurrentDateTime
	        and (DataValue >= @MinDataValue and DataValue < @MaxDataValue)
	        and SiteID=@SiteID
	ORDER BY DataValue DESC, OriginalVariableID DESC
    -- Return the information to the caller
    RETURN;
END





GO

