USE [IARCOD]
GO

/****** Object:  View [dbo].[ANNUAL_AvgDischarge]    Script Date: 09/04/2014 10:39:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[ANNUAL_AvgDischarge] as
select ROW_NUMBER() OVER (ORDER BY SiteID,year) AS ValueID, 
AVG(MonthlyAvg) as DataValue,
SiteID, 
CAST(CAST(year AS varchar) + '-01-01'  AS DATETIME) as UTCDateTime,
700 as OriginalVariableID,
710 as VariableID
from MONTHLY_Discharge_ALL
where month in (12,1,2,3,4,5,6,7,8,9,10,11) and MonthlyAvg is not null
group by SiteID,year
having COUNT(*) = 12;





GO

