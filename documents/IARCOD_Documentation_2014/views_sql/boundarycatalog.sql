USE [IARCOD]
GO

/****** Object:  View [dbo].[boundaryCatalog]    Script Date: 09/04/2014 10:47:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE view [dbo].[boundaryCatalog] as
SELECT s.DatastreamID, s.DatastreamName, s.SiteID, site.SiteCode, site.SiteName, i.offsetValue,i.offsetTypeID,v.VariableID, v.VariableCode, v.VariableName, v.Speciation, v.VariableUnitsID, 
               v.SampleMedium, v.ValueType, v.TimeSupport, v.TimeUnitsID, v.DataType, v.GeneralCategory, m.MethodID, s.DeviceID, m.MethodDescription, site.SourceID, 
               source.Organization, source.SourceDescription, source.Citation, s.QualityControlLevelID, q.QualityControlLevelCode, i.BeginDateTime, i.EndDateTime, i.BeginDateTimeUTC, 
               i.EndDateTimeUTC, geography::STGeomFromText(site.GeoLocation, 4326).Lat AS Lat, geography::STGeomFromText(site.GeoLocation, 4326).Long AS Long,geography::STGeomFromText(site.GeoLocation, 4326).Z AS Elev, site.GeoLocation as GeoLocationText, site.SpatialCharacteristics, i.TotalValues
FROM dbo.DataValuesAggregate AS i  INNER JOIN
               dbo.Datastreams AS s ON i.DatastreamID = s.DatastreamID INNER JOIN
               dbo.Sites AS site ON s.SiteID = site.SiteID INNER JOIN
               dbo.Variables AS v ON s.VariableID = v.VariableID INNER JOIN
               dbo.Methods AS m ON s.MethodID = m.MethodID INNER JOIN
               dbo.Sources AS source ON site.SourceID = source.SourceID INNER JOIN
               dbo.QualityControlLevels AS q ON s.QualityControlLevelID = q.QualityControlLevelID
where  s.SiteID != 2052 AND s.SiteID != 8044;














GO

