USE [IARCOD]
GO

/****** Object:  View [dbo].[DAILY_UTCDateTime]    Script Date: 09/04/2014 10:49:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[DAILY_UTCDateTime] as
select SiteID, UTCDateTime
from DAILY_AirTemp
union
select SiteID, UTCDateTime
from DAILY_RH
union
select SiteID, UTCDateTime
from DAILY_WindSpeed
union
select SiteID, UTCDateTime
from DAILY_WindDirection
union
select SiteID, UTCDateTime
from DAILY_Precip
union
select SiteID, UTCDateTime
from DAILY_SnowDepth
union
select SiteID, UTCDateTime
from DAILY_SWE

GO

