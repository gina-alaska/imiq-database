USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgRH]    Script Date: 09/04/2014 10:40:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










CREATE view [dbo].[ANNUAL_AvgRH] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID,
RH as DataValue,  
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
707 as OriginalVariableID, 
708 as VariableID
from ANNUAL_AvgRH_ALL ;




















GO

