USE [IARCOD]
GO

/****** Object:  StoredProcedure [dbo].[uspExtractDaily]    Script Date: 01/09/2015 13:42:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[uspExtractDaily] 
	-- Add the parameters for the stored procedure here
	@SiteID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select YEAR(HR.UTCDateTime) as yyyy, MONTH(HR.UTCDateTime) as mm, DAY(HR.UTCDateTime) as dd, convert(varchar(2), datepart(hour,HR.UTCDateTime)) as hh,HR.SiteID as id,
convert(varchar,(CONVERT(DECIMAL(10,3),S.Lat))) as lat, CONVERT(varchar, (CONVERT(DECIMAL(10,3),S.Long))) as long, CONVERT(varchar,(CONVERT(DECIMAL(10,3),S.Elev))) as elev_m,
CASE WHEN AT.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),AT.DataValue)) END as atemp_ave_C,
CASE WHEN AT_MAX.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),AT_MAX.DataValue)) END as atemp_max_C,
CASE WHEN AT_MIN.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),AT_MIN.DataValue)) END as atemp_min_C,
CASE WHEN RH.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,RH.DataValue) END as rh_ave, 
CASE WHEN RH_MAX.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,RH_MAX.DataValue) END as rh_max, 
CASE WHEN RH_MIN.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,RH_MIN.DataValue) END  as rh_min, 
CASE WHEN WS.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),WS.DataValue)) END as wspd_m_s, 
CASE WHEN WD.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,WD.DataValue) END as wdir_deg,
CASE WHEN Precip.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),Precip.DataValue)) END  as precip_mm,
CASE WHEN SnowDepth.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),SnowDepth.DataValue)) END  as snowdepth_m,
CASE WHEN SWE.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),SWE.DataValue)) END  as swe_mm,
CASE WHEN Snowfall.DataValue is null THEN CONVERT(VARCHAR,-9999) ELSE CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),Snowfall.DataValue)) END   as snowfall_mm
from DAILY_UTCDateTime HR
left outer join
(select SiteID,UTCDateTime,DataValue,VariableID    /* AIR TEMP AVE */
from DAILY_AirTemp ) AS AT
on HR.SiteID=AT.SiteID And HR.UTCDateTime=AT.UTCDateTime
left outer join
(select SiteID,UTCDateTime, DataValue  /* AIR TEMP MAX */
from DAILY_AirTempMax) as AT_MAX
 on HR.SiteID=AT_MAX.SiteID and HR.UTCDateTime=AT_MAX.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue /* AIR TEMP MIN*/
from DAILY_AirTempMin) as AT_MIN
 on HR.SiteID=AT_MIN.SiteID and HR.UTCDateTime=AT_MIN.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue
from DAILY_RH) AS RH
on HR.SiteID=RH.SiteID and HR.UTCDateTime=RH.UTCDateTime    /* RH AVE */
left outer join
(select SiteID,DateTimeUTC,DataValue
from ODMDataValues_metric where OriginalVariableID=436) as RH_MAX  /* RH MAX */
 on HR.SiteID=RH_MAX.SiteID and HR.UTCDateTime=RH_MAX.DateTimeUTC
left outer join
(select SiteID,DateTimeUTC,DataValue
from ODMDataValues_metric where OriginalVariableID=437) as RH_MIN   /* RH MIN */
 on HR.SiteID=RH_MIN.SiteID and HR.UTCDateTime=RH_MIN.DateTimeUTC
left outer join
(select SiteID,UTCDateTime,DataValue
from DAILY_WindSpeed) as WS
 on HR.SiteID=WS.SiteID and HR.UTCDateTime=WS.UTCDateTime    /* WS */
left outer join
(select SiteID,UTCDateTime,DataValue   /* WD */
from DAILY_WindDirection) as WD
 on HR.SiteID=WD.SiteID and HR.UTCDateTime=WD.UTCDateTime
left outer join
(select SiteID,UTCDateTime, DataValue /* PRECIP */
from DAILY_Precip) AS Precip
on HR.SiteID=Precip.SiteID and HR.UTCDateTime=Precip.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue
from DAILY_SnowDepth) as SnowDepth          /* SNOW DEPTH */
 on HR.SiteID=SnowDepth.SiteID and HR.UTCDateTime=SnowDepth.UTCDateTime
left outer join
(select SiteID,UTCDateTime,DataValue
from DAILY_SWE) as SWE          /* SWE */
 on HR.SiteID=SWE.SiteID and HR.UTCDateTime=SWE.UTCDateTime
left outer join
(select SiteID,DateTimeUTC,DataValue    /* SNOWFALL */
from ODMDataValues_metric where OriginalVariableID=401) as Snowfall
 on HR.SiteID=Snowfall.SiteID and HR.UTCDateTime=Snowfall.DateTimeUTC
inner join
(select SiteID,geography::STGeomFromText(GeoLocation, 4326).Lat as Lat,geography::STGeomFromText(GeoLocation, 4326).Long as Long,geography::STGeomFromText(GeoLocation, 4326).Z as Elev
from Sites ) as S
 on HR.SiteID=S.SiteID
where HR.SiteID=@SiteID and HR.UTCDateTime >= '1979-09-01 00:0:00.000' 
order by HR.UTCDateTime

END







GO

