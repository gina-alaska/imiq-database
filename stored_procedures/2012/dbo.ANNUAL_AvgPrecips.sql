USE [IARCOD]
GO

INSERT INTO [dbo].[ANNUAL_AvgPrecips]
           ([SiteID]
           ,[Avg]
           ,[totalYears])
     VALUES
           (<SiteID, int,>
           ,<Avg, float,>
           ,<totalYears, int,>)
GO

