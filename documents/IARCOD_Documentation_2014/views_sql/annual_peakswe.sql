USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_PeakSWE]    Script Date: 09/04/2014 10:46:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












CREATE view [dbo].[ANNUAL_PeakSWE] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
693 as OriginalVariableID, 
717 as VariableID
from ANNUAL_PeakSWE_ALL 
where DataValue > 0;






















GO

