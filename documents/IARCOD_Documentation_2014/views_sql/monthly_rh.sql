USE [IARCOD]
GO

/****** Object:  View [dbo].[MONTHLY_RH]    Script Date: 09/04/2014 10:53:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO













CREATE view [dbo].[MONTHLY_RH] as
select ROW_NUMBER() OVER (ORDER BY SiteID,RH) AS ValueID, 
RH as DataValue,
SiteID, 
CAST(CAST(year AS varchar) + '-' + CAST(month AS varchar) + '-01'  AS DATETIME) as UTCDateTime,
691 as OriginalVariableID,
707 as VariableID
from MONTHLY_RH_ALL












GO

