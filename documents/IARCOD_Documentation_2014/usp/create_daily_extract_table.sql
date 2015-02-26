USE [IARCOD]
GO

/****** Object:  Table [dbo].[Extract_Daily]    Script Date: 09/03/2014 06:33:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Extract_Daily](
	[yyyy] [int] NOT NULL,
	[mm] [int] NOT NULL,
	[dd] [int] NOT NULL,
	[hh] [int] NOT NULL,
	[id] [int] NOT NULL,
	[lat] [varchar](30) NOT NULL,
	[long] [varchar](30) NOT NULL,
	[elev_m] [varchar](30) NOT NULL,
	[atemp_ave_C] [varchar](30) NOT NULL,
	[atemp_max_C] [varchar](30) NOT NULL,
	[atemp_min_C] [varchar](30) NOT NULL,
	[rh_ave] [varchar](30) NOT NULL,
	[rh_max] [varchar](30) NOT NULL,
	[rh_min] [varchar](30) NOT NULL,
	[wspd_m_s] [varchar](30) NOT NULL,
	[wdir_deg] [varchar](30) NOT NULL,
	[snowdepth_m] [varchar](30) NOT NULL,
	[swe_mm] [varchar](30) NOT NULL,
	[snowfall_mm] [varchar](30) NOT NULL,
	[precip_mm] [varchar](30) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

