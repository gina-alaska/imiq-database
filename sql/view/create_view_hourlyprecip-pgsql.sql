
create view hourly_precip as
select
        v.valueid as valueid,
        v.datavalue as datavalue,
        v.utcdatetime as utcdatetime,
        v.siteid as siteid,
        v.originalvariableid as variableid,
        s.sourceid as sourceid
from    hourly_precipdatavalues v, nhd_huc8 as bounds, sites as s
where   (v.datavalue >= 0 and v.datavalue < 635)
and     s.siteid=v.siteid and bounds.geoposition.stintersects(geolocation) = 1 
and     bounds.id not in (35,36,37,38,39,41,40,42,60,61,62,63)
group by  v.valueid,
          v.datavalue,
          v.utcdatetime,
          v.siteid,
          v.originalvariableid,
          s.sourceid
union all /* huc 35,36,37,38,39,40,41,42 threshold */
select
    v.valueid as valueid,
    v.datavalue as datavalue,
    v.utcdatetime as utcdatetime,
    v.siteid as siteid,
    v.originalvariableid as variableid,
    s.sourceid as sourceid
from  hourly_precipdatavalues v, nhd_huc8 as bounds, sites as s
where (v.datavalue >= 0 and v.datavalue < 20)
and s.siteid=v.siteid
and bounds.geoposition.stintersects(geolocation) = 1 
and bounds.id in (35,36,37,38,39,41,40,42)
group by v.valueid,
          v.datavalue,
          v.utcdatetime,
          v.siteid,
          v.originalvariableid,
          s.sourceid
union all /* huc 60,61,62,63 threshold */
select
    v.valueid as valueid,
    v.datavalue as datavalue,
    v.utcdatetime as utcdatetime,
    v.siteid as siteid,
    v.originalvariableid as variableid,
    s.sourceid as sourceid
from hourly_precipdatavalues v, nhd_huc8 as bounds, sites as s
where (v.datavalue >= 0 and v.datavalue < 10)
and s.siteid=v.siteid
and bounds.geoposition.stintersects(geolocation) = 1  
and bounds.id in (60,61,62,63)
group by v.valueid,
          v.datavalue,
          v.utcdatetime,
          v.siteid,
          v.originalvariableid,
          s.sourceid;










