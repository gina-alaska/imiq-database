USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgWinterAirTemp]    Script Date: 09/04/2014 10:44:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO













CREATE view [dbo].[ANNUAL_AvgWinterAirTemp] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvg as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
697 as OriginalVariableID, 
719 as VariableID
from ANNUAL_AvgWinterAirTemp_ALL ;























GO

