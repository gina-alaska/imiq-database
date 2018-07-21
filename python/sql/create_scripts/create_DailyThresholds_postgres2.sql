/* creating a precip thresholds table for all the sites */
DO $$
BEGIN
  create temp table cte as
/*select ST_GeomFromText(geoposition,4326) as geoposition from tables.nhd_huc8 into g where st_isvalid(ST_GeomFromText(geoposition,4326)) = true; */
select ST_GeomFromText(g1.geoposition,4326) as geoposition FROM tables.nhd_huc8,
  (select ST_GeomFromText(geoposition,4326) as geoposition from tables.nhd_huc8) g1 where g1.geoposition.ST_Union(ST_GeomFromText(tables.nhd_huc8.geoposition,4326))
/*select g.ST_Union(ST_GeomFromText(geoposition,4326)) FROM tables.nhd_huc8 into g where geoposition is not null; */

create table tables.daily_precip_thresholds_2 as
select *
from
(
select 
/*SiteID as SiteID, 0 as MinThreshold, 720 as MaxThreshold */
siteid as siteid, 0 as minthreshold,  254 as maxthreshold
from tables.sites, cte
where
cte.geoposition.ST_Intersects(ST_GeomFromText(tables.sites.geoposition,4326)) = 0
and siteid in (select distinct siteid from tables.daily_precipdatavalues)
union      /* Arctic HUC threshold */

select 
siteid as siteid, 0 as minthreshold, 80 as maxthreshold
/* SiteID as SiteID, 0 as MinThreshold, 360 as MaxThreshold */
from tables.sites, tables.nhd_huc8 as bounds
where
bounds.ST_Intersects(ST_GeomFromText(geoposition,4326)) = 1 and bounds.id not in (35,36,37,38,39,41,40,42,60,61,62,63)
and siteid in (select distinct siteid from tables.daily_precipdatavalues)
union     /* HUC 35,36,37,38,39,40,41,42 threshold */

select
siteid as siteid, 0 as minthreshold, 80 as maxthreshold
/* SiteID as SiteID, 0 as MinThreshold, 120 as MaxThreshold */
from tables.sites, tables.nhd_huc8 as bounds
where
bounds.ST_Intersects(ST_GeomFromText(geoposition,4326)) = 1 and  bounds.id in (35,36,37,38,39,41,40,42)
and siteid in (select distinct siteid from tables.daily_precipdatavalues)
union     /* HUC 60,61,62,63 threshold */

select
/* SiteID as SiteID, 0 as MinThreshold, 60 as MaxThreshold */
siteid as siteid, 0 as minthreshold, 40 as maxthreshold
from tables.sites, tables.nhd_huc8 as bounds
where
bounds.ST_Intersects(ST_GeomFromText(geoposition,4326)) = 1 and  bounds.id in (60,61,62,63)
and siteid in (select distinct siteid from tables.daily_precipdatavalues)

) as m;
END $$;