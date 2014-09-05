USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgWinterRH]    Script Date: 09/04/2014 10:45:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO














CREATE view [dbo].[ANNUAL_AvgWinterRH] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
SeasonalAvgRH as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
707 as OriginalVariableID, 
741 as VariableID
from ANNUAL_AvgWinterRH_ALL ;
























GO

