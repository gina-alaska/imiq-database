USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspExtractHourly]    Script Date: 01/09/2015 13:42:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[uspExtractHourly] 
	-- Add the parameters for the stored procedure here
	@SiteID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select YEAR(HR.UTCDateTime) as yyyy, MONTH(HR.UTCDateTime) as mm, DAY(HR.UTCDateTime) as dd, convert(varchar(2), datepart(hour,HR.UTCDateTime)) as hh,HR.SiteID as id,convert(varchar,(CONVERT(DECIMAL(10,3),S.Lat))) as lat, CONVERT(varchar, (CONVERT(DECIMAL(10,3),S.Long))) as long, 
CASE WHEN S.Elev is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,3),S.Elev)) END as elev_m,
CASE WHEN AT.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),AT.DataValue)) END as atemp_ave_C,
CASE WHEN RH.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),RH.DataValue)) END as rh_ave, 
CASE WHEN WS.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),WS.DataValue)) END as wspd_m_s, 
CASE WHEN WD.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,WD.DataValue) END as wdir_deg,
CASE WHEN Precip.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),Precip.DataValue)) END  as precip_mm,
CASE WHEN SnowDepth.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),SnowDepth.DataValue)) END  as snowdepth_m,
CASE WHEN SWE.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),SWE.DataValue)) END  as swe_mm
from HOURLY_UTCDateTime HR
left outer join
(select SiteID,UTCDateTime,DataValue
from HOURLY_AirTemp) AS AT
on HR.SiteID=AT.SiteID And HR.UTCDateTime=AT.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue
from HOURLY_RH) AS RH
on HR.SiteID=RH.SiteID and HR.UTCDateTime=RH.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue
from HOURLY_WindSpeed) as WS
 on HR.SiteID=WS.SiteID and HR.UTCDateTime=WS.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue
from HOURLY_WindDirection) as WD
 on HR.SiteID=WD.SiteID and HR.UTCDateTime=WD.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue
from HOURLY_Precip) AS Precip
on HR.SiteID=Precip.SiteID and HR.UTCDateTime=Precip.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue
from HOURLY_SnowDepth) as SnowDepth
 on HR.SiteID=SnowDepth.SiteID and HR.UTCDateTime=SnowDepth.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue
from HOURLY_SWE) as SWE
 on HR.SiteID=SWE.SiteID and HR.UTCDateTime=SWE.UTCDateTime
left outer join
(select SiteID,geography::STGeomFromText(GeoLocation, 4326).Lat as Lat,geography::STGeomFromText(GeoLocation, 4326).Long as Long,geography::STGeomFromText(GeoLocation, 4326).Z as Elev
from Sites ) as S
 on HR.SiteID=S.SiteID
where HR.SiteID=@SiteID and HR.UTCDateTime >= '1979-09-01 00:0:00.000' 
order by HR.UTCDateTime

END






GO

