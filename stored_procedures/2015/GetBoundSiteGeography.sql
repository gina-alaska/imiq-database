USE [IARCOD]
GO

/****** Object:  UserDefinedFunction [dbo].[GetBoundSiteGeography]    Script Date: 01/09/2015 13:50:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Amy Jacobs
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[GetBoundSiteGeography] 
(
	-- Add the parameters for the function here
	@LonMin nvarchar(50),
	@LatMin nvarchar(50),
	@LonMax nvarchar(50),
	@LatMax nvarchar(50)
)
RETURNS 
@retBoundSiteGeography TABLE 
(
	-- Add the column definitions for the TABLE variable here
	SiteID int PRIMARY KEY NOT NULL
)
AS
BEGIN
    DECLARE
		@BoundingBox geography;
	SET @BoundingBox = geography::STPolyFromText('POLYGON(('+@LonMin+' '+@LatMin+','+@LonMax+' '+@LatMin+','+@LonMax+' '+@LatMax+','+@LonMin+' '+@LatMax+','+@LonMin+' '+@LatMin+'))',4326);
	-- Fill the table variable with the rows for your result set
	INSERT INTO @retBoundSiteGeography
	SELECT SiteID FROM SiteGeography WHERE @BoundingBox.STIntersects(GeographyLocation) = 1;
    -- Return the information to the caller
    RETURN;
END



GO

