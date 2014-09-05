USE [IARCOD]
GO

/****** Object:  UserDefinedFunction [dbo].[GetBoundSiteGeography]    Script Date: 09/05/2014 11:10:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Amy Jacobs
-- Create date: 
-- Description:	only being used on the ine.uaf.edu/werc/projects/lccdatalibrary website.  
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

