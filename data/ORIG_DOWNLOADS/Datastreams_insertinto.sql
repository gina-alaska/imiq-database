USE [IARCOD]
GO

INSERT INTO [dbo].[Datastreams]
           ([DatastreamName]
           ,[SiteID]
           ,[VariableID]
           ,[FieldName]
           ,[DeviceID]
           ,[MethodID]
           ,[Comments]
           ,[QualityControlLevelID]
           ,[RangeMin]
           ,[RangeMax]
           ,[StartDate]
           ,[EndDate]
           ,[AnnualTiming]
           ,[DownloadDate])
     VALUES
           (<DatastreamName, nvarchar(255),>
           ,<SiteID, int,>
           ,<VariableID, int,>
           ,<FieldName, nvarchar(50),>
           ,<DeviceID, int,>
           ,<MethodID, int,>
           ,<Comments, nvarchar(max),>
           ,<QualityControlLevelID, int,>
           ,<RangeMin, decimal(8,2),>
           ,<RangeMax, decimal(8,2),>
           ,<StartDate, date,>
           ,<EndDate, date,>
           ,<AnnualTiming, nvarchar(255),>
           ,<DownloadDate, date,>)
GO

