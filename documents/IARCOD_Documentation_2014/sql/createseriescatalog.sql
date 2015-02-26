SELECT DatastreamID
      ,DatastreamName
      ,SiteID
      ,SiteCode
      ,SiteName
      ,boundarycatalog.OffsetValue
      ,u.UnitsAbbreviation
      ,boundarycatalog.OffsetTypeID
      ,VariableID
      ,VariableCode
      ,VariableName
      ,Speciation
      ,VariableUnitsID
      ,SampleMedium
      ,ValueType
      ,TimeSupport
      ,TimeUnitsID
      ,DataType
      ,GeneralCategory
      ,MethodID
      ,MethodDescription
      ,SourceID
      ,Organization
      ,SourceDescription
      ,Citation
      ,QualityControlLevelID
      ,QualityControlLevelCode
      ,BeginDateTime
      ,EndDateTime
      ,BeginDateTimeUTC
      ,EndDateTimeUTC
      ,Lat
      ,Long
      ,Elev
      ,GeoLocationText
      ,SpatialCharacteristics
      ,TotalValues
      ,YEAR(BeginDateTime) - YEAR(BeginDateTime) % 10 AS StartDecade
	  ,Year(EndDateTime) - YEAR(EndDateTime) % 10 AS EndDecade
	  ,YEAR(EndDateTime) - YEAR(BeginDateTime) AS TotalYears
  INTO [IARCOD].[dbo].[seriesCatalog]
  FROM [IARCOD].[dbo].[boundaryCatalog]
 left join OffsetTypes o on o.OffsetTypeID=boundaryCatalog.offsetTypeID
 left join Units u on u.UnitsID=o.OffsetUnitsID
  GO