USE [IARCOD]
GO

/****** Object:  View [dbo].[HOURLY_UTCDateTime]    Script Date: 09/04/2014 10:51:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[HOURLY_UTCDateTime] as
select SiteID, UTCDateTime
from HOURLY_AirTemp
union
select SiteID, UTCDateTime
from HOURLY_RH
union
select SiteID, UTCDateTime
from HOURLY_WindSpeed
union
select SiteID, UTCDateTime
from HOURLY_WindDirection
union
select SiteID, UTCDateTime
from HOURLY_Precip
union
select SiteID, UTCDateTime
from HOURLY_SnowDepth
union
select SiteID, UTCDateTime
from HOURLY_SWE

GO

