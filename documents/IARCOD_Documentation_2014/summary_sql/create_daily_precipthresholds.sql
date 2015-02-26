use IARCOD

declare @g geography select @g=geoposition from NHD_HUC8; 
SELECT @g=@g.STUnion(geoposition) FROM NHD_HUC8


select *
into DAILY_Precip_Thresholds
from
(
select 
/*SiteID as SiteID, 0 as MinThreshold, 720 as MaxThreshold */
SiteID as SiteID, 0 as MinThreshold,  254 as MaxThreshold
from Sites
where
@g.STIntersects(GeoLocation) = 0
and SiteID in (select distinct SiteID from DAILY_PrecipDataValues)
union      /* Arctic HUC threshold */

select 
SiteID as SiteID, 0 as MinThreshold, 80 as MaxThreshold
/* SiteID as SiteID, 0 as MinThreshold, 360 as MaxThreshold */
from Sites, NHD_HUC8 as Bounds
where
Bounds.geoposition.STIntersects(GeoLocation) = 1 and Bounds.ID not in (35,36,37,38,39,41,40,42,60,61,62,63)
and SiteID in (select distinct SiteID from DAILY_PrecipDataValues)
union     /* HUC 35,36,37,38,39,40,41,42 threshold */

select
SiteID as SiteID, 0 as MinThreshold, 80 as MaxThreshold
/* SiteID as SiteID, 0 as MinThreshold, 120 as MaxThreshold */
from Sites, NHD_HUC8 as Bounds
where
Bounds.geoposition.STIntersects(GeoLocation) = 1 and  Bounds.ID in (35,36,37,38,39,41,40,42)
and SiteID in (select distinct SiteID from DAILY_PrecipDataValues)
union     /* HUC 60,61,62,63 threshold */

select
/* SiteID as SiteID, 0 as MinThreshold, 60 as MaxThreshold */
SiteID as SiteID, 0 as MinThreshold, 40 as MaxThreshold
from Sites, NHD_HUC8 as Bounds
where
Bounds.geoposition.STIntersects(GeoLocation) = 1 and  Bounds.ID in (60,61,62,63)
and SiteID in (select distinct SiteID from DAILY_PrecipDataValues)

) as m