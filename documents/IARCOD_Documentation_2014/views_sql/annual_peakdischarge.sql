USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_PeakDischarge]    Script Date: 09/04/2014 10:46:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE view [dbo].[ANNUAL_PeakDischarge] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
689 as OriginalVariableID, 
712 as VariableID
from ANNUAL_PeakDischarge_ALL;





















GO

