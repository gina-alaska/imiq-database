USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_PeakSnowDepth]    Script Date: 09/04/2014 10:46:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[ANNUAL_PeakSnowDepth] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
692 as OriginalVariableID, 
705 as VariableID
from ANNUAL_PeakSnowDepth_ALL 
where DataValue > 0;





















GO

