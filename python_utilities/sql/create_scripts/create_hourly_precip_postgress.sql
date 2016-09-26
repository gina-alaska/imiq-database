Do $$
declare g geography;
begin
select ST_Union(ST_GeomFromText(tables.nhd_huc8.geoposition,4326)) into g FROM tables.nhd_huc8 
	WHERE ST_Isvalid(ST_GeomFromText(tables.nhd_huc8.geoposition,4326)) = true 
	and tables.nhd_huc8.geoposition is not null;

create table tables.HOURLY_Precip_2 as 
select distinct *
/*into tables.HOURLY_Precip_2*/
from
(
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID 
/*VariableID=678*/
from tables.HOURLY_PrecipDataValues v, tables.NHD_HUC8 as Bounds, tables.Sites as s
where (v.DataValue >= 0 and v.DataValue < 120) 
and s.SiteID=v.SiteID and ST_Intersects(ST_GeomFromText(s.geolocation,4326),g) = false 
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID
UNION ALL     /* Arctic HUC threshold */

select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID
/*VariableID=678*/
from tables.HOURLY_PrecipDataValues v, tables.NHD_HUC8 as Bounds, tables.Sites as s
where (v.DataValue >= 0 and v.DataValue < 60) 
and s.SiteID=v.SiteID and ST_Intersects(ST_GeomFromText(s.geolocation,4326),g) = true and Bounds.ID not in (35,36,37,38,39,41,40,42,60,61,62,63)
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID
UNION ALL     /* HUC 35,36,37,38,39,40,41,42 threshold */
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID
/*VariableID=678*/
from tables.HOURLY_PrecipDataValues v, tables.NHD_HUC8 as Bounds, tables.Sites as s
where (v.DataValue >= 0 and v.DataValue < 20) 
and s.SiteID=v.SiteID and ST_Intersects(ST_GeomFromText(s.geolocation,4326),g) = true and  Bounds.ID in (35,36,37,38,39,41,40,42)
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID
UNION ALL     /* HUC 60,61,62,63 threshold */
select 
v.valueid as ValueID, 
v.datavalue as DataValue,  
v.UTCDateTime as UTCDateTime, 
v.siteid as SiteID, 
v.originalvariableid as OriginalVariableID
/*VariableID=678*/
from tables.HOURLY_PrecipDataValues v, tables.NHD_HUC8 as Bounds, tables.Sites as s
where (v.DataValue >= 0 and v.DataValue < 10) 
and s.SiteID=v.SiteID and ST_Intersects(ST_GeomFromText(s.geolocation,4326),g) = true and  Bounds.ID in (60,61,62,63)
group by v.valueid, 
v.datavalue,  
v.UTCDateTime,  
v.siteid, 
v.originalvariableid, 
s.SourceID ) as m;

ALTER TABLE tables.hourly_precip_2 ADD COLUMN variableID integer NOT NULL DEFAULT 678;

end $$;