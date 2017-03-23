-- create_hourly_precip_materialized_view.sql
--
-- Rawser Spicer
-- version 1.0.0
-- updated 2017-02-24
--
-- changelog:
-- 1.0.0: created from old files for creating tables.hourly_precip and 
CREATE MATERIALIZED VIEW tables.hourly_precip AS 
SELECT * FROM 
(
    SELECT
        valueid AS valueid, 
        datavalue AS datavalue,  
        utcdatetime AS utcdatetime, 
        siteid AS siteid, 
        originalvariableid AS originalvariableid, 
        678 AS variableid
    FROM tables.hourly_precipdatavalues 
    where siteid not IN 
        (SELECT siteid FROM
            (SELECT id, geoposition 
             FROM tables.nhd_huc8) AS bounds,
            (SELECT siteid, geolocation FROM tables.sites
             where siteid IN (SELECT DISTINCT(siteid) 
             FROM tables.hourly_precipdatavalues)) AS sites
         where st_intersects(bounds.geoposition, sites.geolocation) = true)
    AND (datavalue >= 0 AND datavalue < 120)
 
UNION    /* Arctic HUC threshold */
    SELECT
        valueid AS valueid, 
        datavalue AS datavalue,  
        utcdatetime AS utcdatetime, 
        siteid AS siteid, 
        originalvariableid AS originalvariableid, 
        678 AS variableid
    FROM tables.hourly_precipdatavalues 
    where siteid IN 
        (SELECT siteid FROM
            (SELECT id, geoposition 
             FROM tables.nhd_huc8 
             where id not IN (35,36,37,38,39,41,40,42,60,61,62,63)) AS bounds,
            (SELECT siteid, geolocation FROM tables.sites
             where siteid IN (SELECT DISTINCT(siteid) 
             FROM tables.hourly_precipdatavalues)) AS sites
         where st_intersects(bounds.geoposition, sites.geolocation) = true)
    AND (datavalue >= 0 AND datavalue < 60)
UNION    /* HUC 35,36,37,38,39,40,41,42 threshold */
    SELECT
        valueid AS valueid, 
        datavalue AS datavalue,  
        utcdatetime AS utcdatetime, 
        siteid AS siteid, 
        originalvariableid AS originalvariableid, 
        678 AS variableid
    FROM tables.hourly_precipdatavalues 
    where siteid IN 
        (SELECT siteid FROM
            (SELECT id, geoposition 
             FROM tables.nhd_huc8 
             where id IN (35,36,37,38,39,41,40,42)) AS bounds,
            (SELECT siteid, geolocation FROM tables.sites
             where siteid IN (SELECT DISTINCT(siteid) 
             FROM tables.hourly_precipdatavalues)) AS sites
         WHERE st_intersects(bounds.geoposition, sites.geolocation) = true)
    AND (datavalue >= 0 AND datavalue < 20)
UNION    /* HUC 60,61,62,63 threshold */
    SELECT
        valueid AS valueid, 
        datavalue AS datavalue,  
        utcdatetime AS utcdatetime, 
        siteid AS siteid, 
        originalvariableid AS originalvariableid, 
        678 AS variableid
    FROM tables.hourly_precipdatavalues 
    where siteid IN 
        (SELECT siteid FROM
            (SELECT id, geoposition 
             FROM tables.nhd_huc8 
             where id IN (60,61,62,63)) AS bounds,
            (SELECT siteid, geolocation FROM tables.sites
             where siteid IN (SELECT DISTINCT(siteid) 
             FROM tables.hourly_precipdatavalues)) AS sites
         where st_intersects(bounds.geoposition, sites.geolocation) = true)
    AND (datavalue >= 0 AND datavalue < 10)
) AS summary;


CREATE INDEX hourly_precip_mv_siteid_idx
  ON tables.hourly_precip
  USING btree
  (siteid);

ALTER TABLE tables.hourly_precip
  OWNER TO imiq;

