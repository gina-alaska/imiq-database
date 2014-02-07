SELECT DatastreamID
      ,DatastreamName
      ,SiteID
      ,SiteCode
      ,SiteName
      ,boundarycatalog_62.OffsetValue
      ,u.UnitsAbbreviation
      ,boundarycatalog_62.OffsetTypeID
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
      ,GeoLocation
      ,GeoLocationText
      ,SpatialCharacteristics
      ,TotalValues
      ,YEAR(BeginDateTime) - YEAR(BeginDateTime) % 10 AS StartDecade
	  ,Year(EndDateTime) - YEAR(EndDateTime) % 10 AS EndDecade
	  ,YEAR(EndDateTime) - YEAR(BeginDateTime) AS TotalYears
  INTO [IARCOD].[dbo].[seriesCatalog_62]
  FROM [IARCOD].[dbo].[boundaryCatalog_62]
 left join OffsetTypes o on o.OffsetTypeID=boundaryCatalog_62.offsetTypeID
 left join Units u on u.UnitsID=o.OffsetUnitsID
  GO