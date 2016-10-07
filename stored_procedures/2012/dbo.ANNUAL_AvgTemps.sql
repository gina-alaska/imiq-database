USE [IARCOD]
GO

/****** Object:  Table [dbo].[ANNUAL_AvgTemps]    Script Date: 11/20/2012 11:50:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ANNUAL_AvgTemps](
	[SiteID] [int] NOT NULL,
	[Avg] [float] NULL,
	[totalYears] [int] NULL
) ON [PRIMARY]

GO

