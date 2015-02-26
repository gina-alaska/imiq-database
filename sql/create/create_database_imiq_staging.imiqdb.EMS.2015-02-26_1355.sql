-- SQL Manager for PostgreSQL 5.5.1.45206
-- ---------------------------------------
-- Host      : imiqdb.gina.alaska.edu
-- Database  : imiq_staging
-- Version   : PostgreSQL 9.1.7 on x86_64-unknown-linux-gnu, compiled by gcc (GCC) 4.4.6 20120305 (Red Hat 4.4.6-4), 64-bit



SET search_path = views, pg_catalog;
ALTER TABLE ONLY views.odmdatavalues DROP CONSTRAINT odmdatavalues_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgwinterrh DROP CONSTRAINT multiyear_annual_avgwinterrh_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgwinterprecip DROP CONSTRAINT multiyear_annual_avgwinterprecip_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgwinterairtemp DROP CONSTRAINT multiyear_annual_avgwinterairtemp_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgsummerrh DROP CONSTRAINT multiyear_annual_avgsummerrh_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgsummerprecip DROP CONSTRAINT multiyear_annual_avgsummerprecip_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgsummerdischarge DROP CONSTRAINT multiyear_annual_avgsummerdischarge_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgsummerairtemp DROP CONSTRAINT multiyear_annual_avgsummerairtemp_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgspringprecip DROP CONSTRAINT multiyear_annual_avgspringprecip_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgspringairtemp DROP CONSTRAINT multiyear_annual_avgspringairtemp_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgrh DROP CONSTRAINT multiyear_annual_avgrh_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgprecip DROP CONSTRAINT multiyear_annual_avgprecip_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgpeakswe DROP CONSTRAINT multiyear_annual_avgpeakswe_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgpeaksnowdepth DROP CONSTRAINT multiyear_annual_avgpeaksnowdepth_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgpeakdischarge DROP CONSTRAINT multiyear_annual_avgpeakdischarge_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgfallprecip DROP CONSTRAINT multiyear_annual_avgfallprecip_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgfallairtemp DROP CONSTRAINT multiyear_annual_avgfallairtemp_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgdischarge DROP CONSTRAINT multiyear_annual_avgdischarge_pkey;
ALTER TABLE ONLY views.multiyear_annual_avgairtemp DROP CONSTRAINT multiyear_annual_avgairtemp_pkey;
SET search_path = tables, pg_catalog;
ALTER TABLE ONLY tables.datavalues DROP CONSTRAINT fk_datavalues_qualifierid;
ALTER TABLE ONLY tables.datavalues DROP CONSTRAINT fk_datavalues_categoryid;
ALTER TABLE ONLY tables.datavalues DROP CONSTRAINT fk_datavalues_datastreamid;
ALTER TABLE ONLY tables.datavalues DROP CONSTRAINT fk_datavalues_offsettypes;
ALTER TABLE ONLY tables.datavalues DROP CONSTRAINT fk_datavalues_censorcodecv;
ALTER TABLE ONLY tables.datavalues DROP CONSTRAINT datavalues_valueid;
ALTER TABLE ONLY tables.verticaldatumcv DROP CONSTRAINT verticaldatumcv_term;
ALTER TABLE ONLY tables.variables DROP CONSTRAINT fk_variables_variableunitsid;
ALTER TABLE ONLY tables.variables DROP CONSTRAINT fk_variables_variablenamecv;
ALTER TABLE ONLY tables.variables DROP CONSTRAINT fk_variables_valuetypecv;
ALTER TABLE ONLY tables.variables DROP CONSTRAINT fk_variables_timeunitsid;
ALTER TABLE ONLY tables.variables DROP CONSTRAINT fk_variables_speciationcv;
ALTER TABLE ONLY tables.variables DROP CONSTRAINT fk_variables_samplemediumcv;
ALTER TABLE ONLY tables.variables DROP CONSTRAINT fk_variables_datatypecv;
ALTER TABLE ONLY tables.variables DROP CONSTRAINT variables_variableid;
ALTER TABLE ONLY tables.variablenamecv DROP CONSTRAINT variablenamecv_term;
ALTER TABLE ONLY tables.valuetypecv DROP CONSTRAINT valuetypecv_term;
ALTER TABLE ONLY tables.units DROP CONSTRAINT units_unitsid;
ALTER TABLE ONLY tables.topiccategorycv DROP CONSTRAINT topiccategorycv_term;
ALTER TABLE ONLY tables.sysdiagrams DROP CONSTRAINT sysdiagrams_diagram_id;
ALTER TABLE ONLY tables.speciationcv DROP CONSTRAINT speciationcv_term;
ALTER TABLE ONLY tables.spatialreferences DROP CONSTRAINT spatialreferences_spatialreferenceid;
ALTER TABLE ONLY tables.sources DROP CONSTRAINT sources_sourceid;
ALTER TABLE ONLY tables.sites DROP CONSTRAINT sites_siteid;
ALTER TABLE ONLY tables.siteattributes DROP CONSTRAINT fk_siteattributes_attributeid;
ALTER TABLE ONLY tables.samplemediumcv DROP CONSTRAINT samplemediumcv_term;
ALTER TABLE ONLY tables.rasterdatavalues DROP CONSTRAINT fk_rasterdatavalues_qualifierid;
ALTER TABLE ONLY tables.rasterdatavalues DROP CONSTRAINT rasterdatavalues_valueid;
ALTER TABLE ONLY tables.qualitycontrollevels DROP CONSTRAINT qualitycontrollevels_qualitycontrollevelid;
ALTER TABLE ONLY tables.qualifiers DROP CONSTRAINT qualifiers_qualifierid;
ALTER TABLE ONLY tables.processing DROP CONSTRAINT processing_processingid;
ALTER TABLE ONLY tables.organizations DROP CONSTRAINT fk_organizations_organizationid;
ALTER TABLE ONLY tables.organizationdescriptions DROP CONSTRAINT organizationdescriptions_organizationid;
ALTER TABLE ONLY tables.offsettypes DROP CONSTRAINT offsettypes_offsettypeid;
ALTER TABLE ONLY tables.nhd_huc8 DROP CONSTRAINT nhd_huc8_id;
ALTER TABLE ONLY tables.networkdescriptions DROP CONSTRAINT networkdescriptions_networkid;
ALTER TABLE ONLY tables.methods DROP CONSTRAINT methods_methodid;
ALTER TABLE ONLY tables.isometadata DROP CONSTRAINT isometadata_metadataid;
ALTER TABLE ONLY tables.incidents DROP CONSTRAINT fk_incidents_datastreams;
ALTER TABLE ONLY tables.incidents DROP CONSTRAINT incidents_incidentid;
ALTER TABLE ONLY tables.hourly_windspeeddatavalues DROP CONSTRAINT hourly_windspeeddatavalues_valueid;
ALTER TABLE ONLY tables.hourly_winddirectiondatavalues DROP CONSTRAINT hourly_winddirectiondatavalues_valueid;
ALTER TABLE ONLY tables.hourly_swedatavalues DROP CONSTRAINT hourly_swedatavalues_valueid;
ALTER TABLE ONLY tables.hourly_snowdepthdatavalues DROP CONSTRAINT hourly_snowdepthdatavalues_valueid;
ALTER TABLE ONLY tables.hourly_rhdatavalues DROP CONSTRAINT hourly_rhdatavalues_valueid;
ALTER TABLE ONLY tables.hourly_precipdatavalues DROP CONSTRAINT hourly_precipdatavalues_valueid;
ALTER TABLE ONLY tables.hourly_airtempdatavalues DROP CONSTRAINT hourly_airtempdatavalues_valueid;
ALTER TABLE ONLY tables.groups DROP CONSTRAINT fk_groups_groupdescriptions;
ALTER TABLE ONLY tables.groupdescriptions DROP CONSTRAINT groupdescriptions_groupid;
ALTER TABLE ONLY tables.generalcategorycv DROP CONSTRAINT generalcategorycv_term;
ALTER TABLE ONLY tables.ext_waterbody DROP CONSTRAINT ext_waterbody_id;
ALTER TABLE ONLY tables.ext_referencetowaterbody DROP CONSTRAINT ext_referencetowaterbody_id;
ALTER TABLE ONLY tables.ext_reference DROP CONSTRAINT ext_reference_referenceid;
ALTER TABLE ONLY tables.ext_fws_fishsample DROP CONSTRAINT ext_fws_fishsample_fishsampleid;
ALTER TABLE ONLY tables.ext_arc_point DROP CONSTRAINT ext_arc_point_id;
ALTER TABLE ONLY tables.ext_arc_arc DROP CONSTRAINT ext_arc_arc_id;
ALTER TABLE ONLY tables.devices DROP CONSTRAINT devices_deviceid;
ALTER TABLE ONLY tables.derivedfrom DROP CONSTRAINT fk_derivedfrom_datavaluesraw;
ALTER TABLE ONLY tables.derivedfrom DROP CONSTRAINT derivedfrom_derivedfromid;
ALTER TABLE ONLY tables.datavaluesraw DROP CONSTRAINT datavaluesraw_valueid;
ALTER TABLE ONLY tables.datatypecv DROP CONSTRAINT datatypecv_term;
ALTER TABLE ONLY tables.datastreams DROP CONSTRAINT datastreams_datastreamid;
ALTER TABLE ONLY tables.daily_windspeeddatavalues DROP CONSTRAINT daily_windspeeddatavalues_valueid;
ALTER TABLE ONLY tables.daily_winddirectiondatavalues DROP CONSTRAINT daily_winddirectiondatavalues_valueid;
ALTER TABLE ONLY tables.daily_watertempdatavalues DROP CONSTRAINT daily_watertempdatavalues_valueid;
ALTER TABLE ONLY tables.daily_swedatavalues DROP CONSTRAINT daily_swedatavalues_valueid;
ALTER TABLE ONLY tables.daily_snowdepthdatavalues DROP CONSTRAINT daily_snowdepthdatavalues_valueid;
ALTER TABLE ONLY tables.daily_rhdatavalues DROP CONSTRAINT daily_rhdatavalues_valueid;
ALTER TABLE ONLY tables.daily_precipdatavalues DROP CONSTRAINT daily_precipdatavalues_valueid;
ALTER TABLE ONLY tables.daily_dischargedatavalues DROP CONSTRAINT daily_dischargedatavalues_valueid;
ALTER TABLE ONLY tables.daily_airtempmindatavalues DROP CONSTRAINT daily_airtempmindatavalues_valueid;
ALTER TABLE ONLY tables.daily_airtempmaxdatavalues DROP CONSTRAINT daily_airtempmaxdatavalues_valueid;
ALTER TABLE ONLY tables.daily_airtempdatavalues DROP CONSTRAINT daily_airtempdatavalues_valueid;
ALTER TABLE ONLY tables.censorcodecv DROP CONSTRAINT censorcodecv_term;
ALTER TABLE ONLY tables.categories DROP CONSTRAINT categories_categoryid;
ALTER TABLE ONLY tables.attributes DROP CONSTRAINT attributes_attributeid;
DROP INDEX tables.pk_sites_siteid;
DROP INDEX tables.pk_variables_variableid;
DROP INDEX tables.pk_units_unitsid;
SET search_path = views, pg_catalog;
DROP INDEX views.multiyear_annual_avgwinterrh_siteid_idx;
DROP INDEX views.multiyear_annual_avgwinterprecip_siteid_idx;
DROP INDEX views.multiyear_annual_avgwinterairtemp_siteid_idx;
DROP INDEX views.multiyear_annual_avgsummerrh_siteid_idx;
DROP INDEX views.multiyear_annual_avgsummerprecip_siteid_idx;
DROP INDEX views.multiyear_annual_avgsummerdischarge_siteid_idx;
DROP INDEX views.multiyear_annual_avgsummerairtemp_siteid_idx;
DROP INDEX views.multiyear_annual_avgspringprecip_siteid_idx;
DROP INDEX views.multiyear_annual_avgspringairtemp_siteid_idx;
DROP INDEX views.multiyear_annual_avgrh_siteid_idx;
DROP INDEX views.multiyear_annual_avgprecip_siteid_idx;
DROP INDEX views.multiyear_annual_avgpeakswe_siteid_idx;
DROP INDEX views.multiyear_annual_avgpeaksnowdepth_siteid_idx;
DROP INDEX views.multiyear_annual_avgpeakdischarge_siteid_idx;
DROP INDEX views.multiyear_annual_avgfallprecip_siteid_idx;
DROP INDEX views.multiyear_annual_avgfallairtemp_siteid_idx;
DROP INDEX views.multiyear_annual_avgdischarge_siteid_idx;
DROP INDEX views.multiyear_annual_avgairtemp_siteid_idx;
DROP INDEX views.hourly_utcdatetime_siteid_idx;
DROP INDEX views.daily_utcdatetime_siteid_idx;
SET search_path = tables, pg_catalog;
DROP INDEX tables.multiyear_annual_all_avgwinterrh_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgwinterprecip_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgwinterairtemp_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgsummerrh_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgsummerprecip_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgsummerdischarge_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgsummerairtemp_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgspringprecip_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgspringairtemp_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgrh_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgprecip_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgpeakswe_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgpeaksnowdepth_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgpeakdischarge_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgfallprecip_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgfallairtemp_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgdischarge_siteid_idx;
DROP INDEX tables.multiyear_annual_all_avgairtemp_siteid_idx;
DROP INDEX tables.monthly_rh_all_siteid_idx;
DROP INDEX tables.hourly_windspeeddatavalues_siteid_idx;
DROP INDEX tables.hourly_winddirectiondatavalues_siteid_idx;
DROP INDEX tables.hourly_swedatavalues_siteid_idx;
DROP INDEX tables.hourly_swe_siteid_idx;
DROP INDEX tables.hourly_snowdepthdatavalues_siteid_idx;
DROP INDEX tables.hourly_snowdepth_siteid_idx;
DROP INDEX tables.hourly_rhdatavalues_siteid_idx;
DROP INDEX tables.hourly_precipdatavalues_siteid_idx;
DROP INDEX tables.hourly_precip_siteid_idx;
DROP INDEX tables.hourly_airtempdatavalues_siteid_idx;
DROP INDEX tables.datastreams_siteid_idx;
DROP INDEX tables.daily_windspeeddatavalues_siteid_idx;
DROP INDEX tables.daily_winddirectiondatavalues_siteid_idx;
DROP INDEX tables.daily_watertempdatavalues_siteid_idx;
DROP INDEX tables.daily_swedatavalues_siteid_idx;
DROP INDEX tables.daily_swe_siteid_idx;
DROP INDEX tables.daily_snowdepthdatavalues_siteid_idx;
DROP INDEX tables.daily_snowdepth_siteid_idx;
DROP INDEX tables.daily_rhdatavalues_siteid_idx;
DROP INDEX tables.daily_precipdatavalues_siteid_idx;
DROP INDEX tables.daily_precip_thresholds_siteid_idx;
DROP INDEX tables.daily_precip_siteid_idx;
DROP INDEX tables.daily_dischargedatavalues_siteid_idx;
DROP INDEX tables.daily_airtempmindatavalues_siteid_idx;
DROP INDEX tables.daily_airtempmaxdatavalues_siteid_idx;
DROP INDEX tables.daily_airtempdatavalues_siteid_idx;
DROP INDEX tables.annual_totalprecip_all_siteid_idx;
DROP INDEX tables.annual_peakswe_all_siteid_idx;
DROP INDEX tables.annual_peaksnowdepth_all_siteid_idx;
DROP INDEX tables.annual_peakdischarge_all_siteid_idx;
DROP INDEX tables.annual_avgwinterrh_all_siteid_idx;
DROP INDEX tables.annual_avgwinterprecip_all_siteid_idx;
DROP INDEX tables.annual_avgwinterairtemp_all_siteid_idx;
DROP INDEX tables.annual_avgrh_all_siteid_idx;
DROP INDEX tables.datavalues_datastreamid_localdatetime;
DROP INDEX tables.variables_variablecode;
DROP INDEX tables.sysdiagrams_principal_id;
DROP INDEX tables.sysdiagrams_name;
DROP INDEX tables.methods_methodname;
DROP INDEX tables.datavaluesraw_localdatetime;
DROP INDEX tables.datavaluesraw_datastreamid;
SET search_path = views, pg_catalog;
DROP TABLE views.odmdatavalues_metric;
DROP TABLE views.odmdatavalues;
DROP TABLE views.multiyear_annual_avgwinterrh;
DROP TABLE views.multiyear_annual_avgwinterprecip;
DROP TABLE views.multiyear_annual_avgwinterairtemp;
DROP TABLE views.multiyear_annual_avgsummerrh;
DROP TABLE views.multiyear_annual_avgsummerprecip;
DROP TABLE views.multiyear_annual_avgsummerdischarge;
DROP TABLE views.multiyear_annual_avgsummerairtemp;
DROP TABLE views.multiyear_annual_avgspringprecip;
DROP TABLE views.multiyear_annual_avgspringairtemp;
DROP TABLE views.multiyear_annual_avgrh;
DROP TABLE views.multiyear_annual_avgprecip;
DROP TABLE views.multiyear_annual_avgpeakswe;
DROP TABLE views.multiyear_annual_avgpeaksnowdepth;
DROP TABLE views.multiyear_annual_avgpeakdischarge;
DROP TABLE views.multiyear_annual_avgfallprecip;
DROP TABLE views.multiyear_annual_avgfallairtemp;
DROP TABLE views.multiyear_annual_avgdischarge;
DROP TABLE views.multiyear_annual_avgairtemp;
DROP TABLE views.daily_utcdatetime;
SET search_path = tables, pg_catalog;
DROP TABLE tables.datavalues;
DROP TABLE tables.verticaldatumcv;
DROP TABLE tables.variables;
DROP TABLE tables.variablenamecv;
DROP TABLE tables.valuetypecv;
DROP TABLE tables.units;
DROP TABLE tables.topiccategorycv;
DROP TABLE tables.sysdiagrams;
DROP TABLE tables.speciationcv;
DROP TABLE tables.spatialreferences;
DROP TABLE tables.sources;
DROP TABLE tables._siteswithelevations;
DROP TABLE tables._sites_summary;
DROP TABLE tables.sites;
DROP TABLE tables.siteattributes;
DROP TABLE tables.seriescatalog;
DROP TABLE tables.samplemediumcv;
DROP TABLE tables.rasterdatavalues;
DROP TABLE tables.qualitycontrollevels;
DROP TABLE tables.qualifiers;
DROP TABLE tables.processing;
DROP TABLE tables.organizations;
DROP TABLE tables.organizationdescriptions;
DROP TABLE tables.offsettypes;
DROP TABLE tables.nhd_huc8;
DROP TABLE tables.networkdescriptions;
DROP TABLE tables.multiyear_annual_all_avgwinterrh;
DROP TABLE tables.multiyear_annual_all_avgwinterprecip;
DROP TABLE tables.multiyear_annual_all_avgwinterairtemp;
DROP TABLE tables.multiyear_annual_all_avgsummerrh;
DROP TABLE tables.multiyear_annual_all_avgsummerprecip;
DROP TABLE tables.multiyear_annual_all_avgsummerdischarge;
DROP TABLE tables.multiyear_annual_all_avgsummerairtemp;
DROP TABLE tables.multiyear_annual_all_avgspringprecip;
DROP TABLE tables.multiyear_annual_all_avgspringairtemp;
DROP TABLE tables.multiyear_annual_all_avgrh;
DROP TABLE tables.multiyear_annual_all_avgprecip;
DROP TABLE tables.multiyear_annual_all_avgpeakswe;
DROP TABLE tables.multiyear_annual_all_avgpeaksnowdepth;
DROP TABLE tables.multiyear_annual_all_avgpeakdischarge;
DROP TABLE tables.multiyear_annual_all_avgfallprecip;
DROP TABLE tables.multiyear_annual_all_avgfallairtemp;
DROP TABLE tables.multiyear_annual_all_avgdischarge;
DROP TABLE tables.multiyear_annual_all_avgairtemp;
DROP TABLE tables.monthly_rh_all;
DROP TABLE tables.methods;
DROP TABLE tables.isometadata;
DROP TABLE tables.incidents;
DROP TABLE tables.imiqversion;
DROP TABLE tables.hourly_windspeeddatavalues;
DROP TABLE tables.hourly_winddirectiondatavalues;
DROP TABLE tables.hourly_swedatavalues;
DROP TABLE tables.hourly_swe;
DROP TABLE tables.hourly_snowdepthdatavalues;
DROP TABLE tables.hourly_snowdepth;
DROP TABLE tables.hourly_rhdatavalues;
DROP TABLE tables.hourly_precipdatavalues;
DROP TABLE tables.hourly_precip;
DROP TABLE tables.hourly_airtempdatavalues;
DROP TABLE tables.groups;
DROP TABLE tables.groupdescriptions;
DROP TABLE tables.generalcategorycv;
DROP TABLE tables.ext_waterbody;
DROP TABLE tables.ext_referencetowaterbody;
DROP TABLE tables.ext_reference;
DROP TABLE tables.ext_fws_fishsample;
DROP TABLE tables.ext_arc_point;
DROP TABLE tables.ext_arc_arc;
DROP TABLE tables.devices;
DROP TABLE tables.derivedfrom;
DROP TABLE tables.datavaluesraw;
DROP TABLE tables.datatypecv;
DROP TABLE tables.datastreams;
DROP TABLE tables.daily_windspeeddatavalues;
DROP TABLE tables.daily_winddirectiondatavalues;
DROP TABLE tables.daily_watertempdatavalues;
DROP TABLE tables.daily_swedatavalues;
DROP TABLE tables.daily_swe;
DROP TABLE tables.daily_snowdepthdatavalues;
DROP TABLE tables.daily_snowdepth;
DROP TABLE tables.daily_rhdatavalues;
DROP TABLE tables.daily_precip_thresholds;
DROP TABLE tables.daily_precipdatavalues;
DROP TABLE tables.daily_precip;
DROP TABLE tables.daily_dischargedatavalues;
DROP TABLE tables.daily_airtempmindatavalues;
DROP TABLE tables.daily_airtempmaxdatavalues;
DROP TABLE tables.daily_airtempdatavalues;
DROP TABLE tables.censorcodecv;
DROP TABLE tables.categories;
DROP TABLE tables.attributes;
DROP TABLE tables.annual_totalprecip_all;
DROP TABLE tables.annual_peakswe_all;
DROP TABLE tables.annual_peaksnowdepth_all;
DROP TABLE tables.annual_peakdischarge_all;
DROP TABLE tables.annual_avgwinterrh_all;
DROP TABLE tables.annual_avgwinterprecip_all;
DROP TABLE tables.annual_avgwinterairtemp_all;
DROP TABLE tables.annual_avgrh_all;
SET search_path = views, pg_catalog;
DROP TABLE views.sitesourcedescription;
DROP TABLE views.sitesource;
DROP TABLE views.sitegeography;
DROP TABLE views.siteattributesource;
DROP TABLE views.queryme;
DROP TABLE views.hourly_utcdatetime;
DROP TABLE views.datavaluesaggregate;
DROP TABLE views.datastreamvariables;
DROP TABLE views.boundarycatalog;
SET check_function_bodies = false;
--
-- Structure for table boundarycatalog (OID = 447427) : 
--
CREATE TABLE views.boundarycatalog (
    datastreamid integer NOT NULL,
    datastreamname varchar(255) NOT NULL,
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    offsetvalue double precision,
    offsettypeid integer,
    variableid integer NOT NULL,
    variablecode varchar(50) NOT NULL,
    variablename varchar(255) NOT NULL,
    speciation varchar(255) NOT NULL,
    variableunitsid integer NOT NULL,
    samplemedium varchar(255) NOT NULL,
    valuetype varchar(255) NOT NULL,
    timesupport double precision NOT NULL,
    timeunitsid integer NOT NULL,
    datatype varchar(255) NOT NULL,
    generalcategory varchar(255) NOT NULL,
    methodid integer NOT NULL,
    deviceid integer NOT NULL,
    methoddescription text NOT NULL,
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    sourcedescription text NOT NULL,
    citation text NOT NULL,
    qualitycontrollevelid integer,
    qualitycontrollevelcode varchar(50) NOT NULL,
    begindatetime varchar(100),
    enddatetime varchar(100),
    begindatetimeutc varchar(100),
    enddatetimeutc varchar(100),
    lat double precision,
    long double precision,
    elev double precision,
    geolocationtext text,
    spatialcharacteristics varchar(50) NOT NULL,
    totalvalues integer
)
WITH (oids = false);
--
-- Structure for table datastreamvariables (OID = 448130) : 
--
CREATE TABLE views.datastreamvariables (
    datastreamname varchar(255) NOT NULL,
    siteid integer NOT NULL,
    bdate varchar(10),
    edate varchar(10),
    fieldname varchar(50),
    variablename varchar(255) NOT NULL,
    variabledescription text
)
WITH (oids = false);
--
-- Structure for table datavaluesaggregate (OID = 448136) : 
--
CREATE TABLE views.datavaluesaggregate (
    datastreamid integer NOT NULL,
    offsetvalue double precision,
    offsettypeid integer,
    begindatetime varchar(100),
    enddatetime varchar(100),
    begindatetimeutc varchar(100),
    enddatetimeutc varchar(100),
    totalvalues integer
)
WITH (oids = false);
--
-- Structure for table hourly_utcdatetime (OID = 448155) : 
--
CREATE TABLE views.hourly_utcdatetime (
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone NOT NULL
)
WITH (oids = false);
--
-- Structure for table queryme (OID = 449157) : 
--
CREATE TABLE views.queryme (
    siteid integer NOT NULL,
    sitename varchar(255),
    variablename varchar(255) NOT NULL,
    variabledescription text,
    samplemedium varchar(255) NOT NULL,
    organization varchar(255) NOT NULL,
    organizationdescription text NOT NULL,
    organizationcode varchar(50) NOT NULL,
    startdate varchar(100),
    enddate varchar(100),
    citation text NOT NULL
)
WITH (oids = false);
--
-- Structure for table siteattributesource (OID = 449163) : 
--
CREATE TABLE views.siteattributesource (
    sourceid integer NOT NULL,
    siteid integer NOT NULL,
    sitename varchar(255),
    organization varchar(255) NOT NULL,
    sourcedescription text NOT NULL,
    sourcelink varchar(500),
    geographylocation bytea,
    attributevalue varchar(255) NOT NULL,
    sitecomments text,
    locationdescription text,
    sitecode varchar(50) NOT NULL
)
WITH (oids = false);
--
-- Structure for table sitegeography (OID = 450911) : 
--
CREATE TABLE views.sitegeography (
    siteid serial NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    spatialcharacteristics varchar(50) NOT NULL,
    sourceid integer NOT NULL,
    verticaldatum varchar(255),
    localprojectionid integer,
    posaccuracy_m double precision,
    state varchar(255),
    county varchar(255),
    comments text,
    latlongdatumid integer NOT NULL,
    geographylocation bytea,
    locationdescription text
)
WITH (oids = false);
--
-- Structure for table sitesource (OID = 451283) : 
--
CREATE TABLE views.sitesource (
    sourceid integer NOT NULL,
    siteid integer NOT NULL,
    sitename varchar(255),
    sitecomments text,
    organization varchar(255) NOT NULL,
    sourcedescription text NOT NULL,
    sourcelink varchar(500),
    spatialcharacteristics varchar(50) NOT NULL,
    geographylocation bytea,
    locationdescription text,
    sitecode varchar(50) NOT NULL
)
WITH (oids = false);
--
-- Structure for table sitesourcedescription (OID = 451747) : 
--
CREATE TABLE views.sitesourcedescription (
    organizationcode varchar(50) NOT NULL,
    organizationdescription text NOT NULL,
    contactname varchar(255) NOT NULL,
    sourcedescription text NOT NULL,
    sourceorg varchar(255) NOT NULL,
    sourcelink varchar(500),
    sitename varchar(255),
    geographylocation bytea,
    spatialcharacteristics varchar(50) NOT NULL,
    sitecomments text,
    siteid integer NOT NULL,
    sourceid integer NOT NULL,
    organizationid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table annual_avgrh_all (OID = 451769) : 
--
SET search_path = tables, pg_catalog;
CREATE TABLE tables.annual_avgrh_all (
    siteid integer NOT NULL,
    year integer,
    rh double precision,
    at double precision
)
WITH (oids = false);
--
-- Structure for table annual_avgwinterairtemp_all (OID = 451773) : 
--
CREATE TABLE tables.annual_avgwinterairtemp_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
)
WITH (oids = false);
--
-- Structure for table annual_avgwinterprecip_all (OID = 451777) : 
--
CREATE TABLE tables.annual_avgwinterprecip_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
)
WITH (oids = false);
--
-- Structure for table annual_avgwinterrh_all (OID = 451781) : 
--
CREATE TABLE tables.annual_avgwinterrh_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavgrh double precision,
    seasonalavgat double precision
)
WITH (oids = false);
--
-- Structure for table annual_peakdischarge_all (OID = 451785) : 
--
CREATE TABLE tables.annual_peakdischarge_all (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
)
WITH (oids = false);
--
-- Structure for table annual_peaksnowdepth_all (OID = 451789) : 
--
CREATE TABLE tables.annual_peaksnowdepth_all (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
)
WITH (oids = false);
--
-- Structure for table annual_peakswe_all (OID = 451793) : 
--
CREATE TABLE tables.annual_peakswe_all (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
)
WITH (oids = false);
--
-- Structure for table annual_totalprecip_all (OID = 451797) : 
--
CREATE TABLE tables.annual_totalprecip_all (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
)
WITH (oids = false);
--
-- Structure for table attributes (OID = 451801) : 
--
CREATE TABLE tables.attributes (
    attributeid serial NOT NULL,
    attributename varchar(255) NOT NULL
)
WITH (oids = false);
--
-- Structure for table categories (OID = 451809) : 
--
CREATE TABLE tables.categories (
    categoryid serial NOT NULL,
    variableid integer NOT NULL,
    categoryname varchar(255) NOT NULL,
    categorydescription text
)
WITH (oids = false);
--
-- Structure for table censorcodecv (OID = 451820) : 
--
CREATE TABLE tables.censorcodecv (
    term varchar(50) NOT NULL,
    definition text
)
WITH (oids = false);
--
-- Structure for table daily_airtempdatavalues (OID = 451828) : 
--
CREATE TABLE tables.daily_airtempdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table daily_airtempmaxdatavalues (OID = 451865) : 
--
CREATE TABLE tables.daily_airtempmaxdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table daily_airtempmindatavalues (OID = 451874) : 
--
CREATE TABLE tables.daily_airtempmindatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table daily_dischargedatavalues (OID = 451883) : 
--
CREATE TABLE tables.daily_dischargedatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table daily_precip (OID = 451892) : 
--
CREATE TABLE tables.daily_precip (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table daily_precipdatavalues (OID = 451898) : 
--
CREATE TABLE tables.daily_precipdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table daily_precip_thresholds (OID = 451907) : 
--
CREATE TABLE tables.daily_precip_thresholds (
    siteid integer NOT NULL,
    minthreshold integer NOT NULL,
    maxthreshold integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table daily_rhdatavalues (OID = 451911) : 
--
CREATE TABLE tables.daily_rhdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table daily_snowdepth (OID = 451920) : 
--
CREATE TABLE tables.daily_snowdepth (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table daily_snowdepthdatavalues (OID = 451924) : 
--
CREATE TABLE tables.daily_snowdepthdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table daily_swe (OID = 452834) : 
--
CREATE TABLE tables.daily_swe (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table daily_swedatavalues (OID = 452838) : 
--
CREATE TABLE tables.daily_swedatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table daily_watertempdatavalues (OID = 452847) : 
--
CREATE TABLE tables.daily_watertempdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table daily_winddirectiondatavalues (OID = 452856) : 
--
CREATE TABLE tables.daily_winddirectiondatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table daily_windspeeddatavalues (OID = 452877) : 
--
CREATE TABLE tables.daily_windspeeddatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table datastreams (OID = 452886) : 
--
CREATE TABLE tables.datastreams (
    datastreamid serial NOT NULL,
    datastreamname varchar(255) NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    fieldname varchar(50),
    deviceid integer NOT NULL,
    methodid integer NOT NULL,
    comments text,
    qualitycontrollevelid integer,
    rangemin numeric(8,2),
    rangemax numeric(8,2),
    annualtiming varchar(255),
    downloaddate date,
    bdate varchar(10),
    edate varchar(10)
)
WITH (oids = false);
--
-- Structure for table datatypecv (OID = 452898) : 
--
CREATE TABLE tables.datatypecv (
    term varchar(255) NOT NULL,
    definition text
)
WITH (oids = false);
--
-- Structure for table datavaluesraw (OID = 452955) : 
--
CREATE TABLE tables.datavaluesraw (
    valueid serial NOT NULL,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    qualifierid integer,
    datastreamid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table derivedfrom (OID = 452965) : 
--
CREATE TABLE tables.derivedfrom (
    derivedfromid integer NOT NULL,
    valueid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table devices (OID = 452980) : 
--
CREATE TABLE tables.devices (
    deviceid serial NOT NULL,
    devicename varchar(255) NOT NULL,
    serialnumber varchar(50),
    dateactivated date,
    datedeactivated date,
    comments text
)
WITH (oids = false);
--
-- Structure for table ext_arc_arc (OID = 452991) : 
--
CREATE TABLE tables.ext_arc_arc (
    id serial NOT NULL,
    stream_cod varchar(255),
    name varchar(255),
    source varchar(255),
    shape_leng real,
    geom public.geometry
)
WITH (oids = false);
--
-- Structure for table ext_arc_point (OID = 453157) : 
--
CREATE TABLE tables.ext_arc_point (
    id serial NOT NULL,
    x_coord real,
    y_coord real,
    lat real,
    long_ real,
    mtrs varchar(255),
    type varchar(255),
    plotsym integer,
    quad varchar(255),
    stream_cod varchar(255),
    name varchar(255),
    specstr varchar(255),
    midangle integer,
    geom public.geometry
)
WITH (oids = false);
--
-- Structure for table ext_fws_fishsample (OID = 453168) : 
--
CREATE TABLE tables.ext_fws_fishsample (
    fishsampleid serial NOT NULL,
    siteid integer NOT NULL,
    fishname varchar(255),
    fry varchar(50),
    juvenile varchar(50),
    adult varchar(50),
    anadromous varchar(50),
    resident varchar(50),
    occasional varchar(50),
    rearing varchar(50),
    feeding varchar(50),
    spawning varchar(50),
    overwinter varchar(50)
)
WITH (oids = false);
--
-- Structure for table ext_reference (OID = 453179) : 
--
CREATE TABLE tables.ext_reference (
    referenceid serial NOT NULL,
    referencename varchar(500),
    authors varchar(500),
    year varchar(50),
    title varchar(500),
    publication varchar(500),
    fishdatatype varchar(500),
    waterdatatype varchar(500),
    lakesreferenced integer,
    riversreferenced integer,
    springsreferenced integer,
    pdf varchar(500),
    comments varchar(500),
    ref_id varchar(50),
    geographicarea varchar(500)
)
WITH (oids = false);
--
-- Structure for table ext_referencetowaterbody (OID = 453190) : 
--
CREATE TABLE tables.ext_referencetowaterbody (
    id serial NOT NULL,
    namereference varchar(255),
    waterbodyid varchar(50)
)
WITH (oids = false);
--
-- Structure for table ext_waterbody (OID = 453198) : 
--
CREATE TABLE tables.ext_waterbody (
    id serial NOT NULL,
    waterbodid bigint,
    watername varchar(255),
    watertype varchar(255),
    citation varchar(255),
    shape_leng real,
    shape_area real,
    geoposition bytea
)
WITH (oids = false);
--
-- Structure for table generalcategorycv (OID = 453516) : 
--
CREATE TABLE tables.generalcategorycv (
    term varchar(255) NOT NULL,
    definition text
)
WITH (oids = false);
--
-- Structure for table groupdescriptions (OID = 453524) : 
--
CREATE TABLE tables.groupdescriptions (
    groupid serial NOT NULL,
    groupdescription text
)
WITH (oids = false);
--
-- Structure for table groups (OID = 453535) : 
--
CREATE TABLE tables.groups (
    groupid integer NOT NULL,
    valueid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table hourly_airtempdatavalues (OID = 453548) : 
--
CREATE TABLE tables.hourly_airtempdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table hourly_precip (OID = 453565) : 
--
CREATE TABLE tables.hourly_precip (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table hourly_precipdatavalues (OID = 453569) : 
--
CREATE TABLE tables.hourly_precipdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table hourly_rhdatavalues (OID = 453578) : 
--
CREATE TABLE tables.hourly_rhdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table hourly_snowdepth (OID = 453587) : 
--
CREATE TABLE tables.hourly_snowdepth (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table hourly_snowdepthdatavalues (OID = 453591) : 
--
CREATE TABLE tables.hourly_snowdepthdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table hourly_swe (OID = 453600) : 
--
CREATE TABLE tables.hourly_swe (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table hourly_swedatavalues (OID = 453604) : 
--
CREATE TABLE tables.hourly_swedatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table hourly_winddirectiondatavalues (OID = 453613) : 
--
CREATE TABLE tables.hourly_winddirectiondatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table hourly_windspeeddatavalues (OID = 453622) : 
--
CREATE TABLE tables.hourly_windspeeddatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer,
    insertdate timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table imiqversion (OID = 453631) : 
--
CREATE TABLE tables.imiqversion (
    versionnumber varchar(50) NOT NULL,
    creationdate timestamp without time zone,
    versiondescription text
)
WITH (oids = false);
--
-- Structure for table incidents (OID = 453637) : 
--
CREATE TABLE tables.incidents (
    incidentid serial NOT NULL,
    siteid integer,
    datastreamid integer,
    starttime timestamp without time zone,
    startprecision varchar(255),
    endtime timestamp without time zone,
    endprecision varchar(255),
    type varchar(255) NOT NULL,
    description text,
    reportedby varchar(96),
    comments text
)
WITH (oids = false);
--
-- Structure for table isometadata (OID = 453653) : 
--
CREATE TABLE tables.isometadata (
    metadataid serial NOT NULL,
    topiccategory varchar(255) DEFAULT ''::character varying NOT NULL,
    title varchar(255) DEFAULT ''::character varying NOT NULL,
    abstract text NOT NULL,
    profileversion varchar(255) DEFAULT ''::character varying NOT NULL,
    metadatalink varchar(500)
)
WITH (oids = false);
--
-- Structure for table methods (OID = 453668) : 
--
CREATE TABLE tables.methods (
    methodid serial NOT NULL,
    methodname varchar(255) NOT NULL,
    methoddescription text NOT NULL,
    methodlink varchar(500)
)
WITH (oids = false);
--
-- Structure for table monthly_rh_all (OID = 453681) : 
--
CREATE TABLE tables.monthly_rh_all (
    siteid integer NOT NULL,
    year integer,
    month integer,
    rh double precision,
    at double precision,
    total integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgairtemp (OID = 453685) : 
--
CREATE TABLE tables.multiyear_annual_all_avgairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgdischarge (OID = 453689) : 
--
CREATE TABLE tables.multiyear_annual_all_avgdischarge (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgfallairtemp (OID = 453693) : 
--
CREATE TABLE tables.multiyear_annual_all_avgfallairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgfallprecip (OID = 453697) : 
--
CREATE TABLE tables.multiyear_annual_all_avgfallprecip (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgpeakdischarge (OID = 453701) : 
--
CREATE TABLE tables.multiyear_annual_all_avgpeakdischarge (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgpeaksnowdepth (OID = 453705) : 
--
CREATE TABLE tables.multiyear_annual_all_avgpeaksnowdepth (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgpeakswe (OID = 453709) : 
--
CREATE TABLE tables.multiyear_annual_all_avgpeakswe (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgprecip (OID = 453713) : 
--
CREATE TABLE tables.multiyear_annual_all_avgprecip (
    siteid integer NOT NULL,
    avgannualtotal double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgrh (OID = 453717) : 
--
CREATE TABLE tables.multiyear_annual_all_avgrh (
    siteid integer NOT NULL,
    rh double precision,
    at double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgspringairtemp (OID = 453721) : 
--
CREATE TABLE tables.multiyear_annual_all_avgspringairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgspringprecip (OID = 453725) : 
--
CREATE TABLE tables.multiyear_annual_all_avgspringprecip (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgsummerairtemp (OID = 453729) : 
--
CREATE TABLE tables.multiyear_annual_all_avgsummerairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgsummerdischarge (OID = 453733) : 
--
CREATE TABLE tables.multiyear_annual_all_avgsummerdischarge (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgsummerprecip (OID = 453737) : 
--
CREATE TABLE tables.multiyear_annual_all_avgsummerprecip (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgsummerrh (OID = 453741) : 
--
CREATE TABLE tables.multiyear_annual_all_avgsummerrh (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgwinterairtemp (OID = 453745) : 
--
CREATE TABLE tables.multiyear_annual_all_avgwinterairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgwinterprecip (OID = 453749) : 
--
CREATE TABLE tables.multiyear_annual_all_avgwinterprecip (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_all_avgwinterrh (OID = 453753) : 
--
CREATE TABLE tables.multiyear_annual_all_avgwinterrh (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table networkdescriptions (OID = 453757) : 
--
CREATE TABLE tables.networkdescriptions (
    networkid integer NOT NULL,
    networkcode varchar(50) NOT NULL,
    networkdescription text NOT NULL
)
WITH (oids = false);
--
-- Structure for table nhd_huc8 (OID = 453765) : 
--
CREATE TABLE tables.nhd_huc8 (
    id serial NOT NULL,
    gaz_id bigint,
    area_acres real,
    area_sqkm real,
    states varchar(255),
    loaddate date,
    huc_8 varchar(255),
    hu_8_name varchar(255),
    shape_leng real,
    shape_area real,
    geoposition bytea
)
WITH (oids = false);
--
-- Structure for table offsettypes (OID = 453820) : 
--
CREATE TABLE tables.offsettypes (
    offsettypeid serial NOT NULL,
    offsetunitsid integer NOT NULL,
    offsetdescription text NOT NULL
)
WITH (oids = false);
--
-- Structure for table organizationdescriptions (OID = 453831) : 
--
CREATE TABLE tables.organizationdescriptions (
    organizationid integer NOT NULL,
    organizationcode varchar(50) NOT NULL,
    organizationdescription text NOT NULL
)
WITH (oids = false);
--
-- Structure for table organizations (OID = 453839) : 
--
CREATE TABLE tables.organizations (
    organizationid integer NOT NULL,
    sourceid integer NOT NULL,
    networkid integer
)
WITH (oids = false);
--
-- Structure for table processing (OID = 453847) : 
--
CREATE TABLE tables.processing (
    processingid serial NOT NULL,
    sourceid integer,
    siteid integer,
    metadataid integer,
    datarestrictions varchar(255),
    datapriority integer,
    processingneeds text,
    qaqcperson varchar(255),
    qaqccomments text,
    qaqcdate date
)
WITH (oids = false);
--
-- Structure for table qualifiers (OID = 453858) : 
--
CREATE TABLE tables.qualifiers (
    qualifierid serial NOT NULL,
    qualifiercode varchar(50),
    qualifierdescription text NOT NULL
)
WITH (oids = false);
--
-- Structure for table qualitycontrollevels (OID = 453869) : 
--
CREATE TABLE tables.qualitycontrollevels (
    qualitycontrollevelid serial NOT NULL,
    qualitycontrollevelcode varchar(50) NOT NULL,
    definition varchar(255) NOT NULL,
    explanation text NOT NULL
)
WITH (oids = false);
--
-- Structure for table rasterdatavalues (OID = 453880) : 
--
CREATE TABLE tables.rasterdatavalues (
    valueid serial NOT NULL,
    datavalue text,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    qualifierid integer,
    derivedfromid integer,
    datastreamid integer NOT NULL,
    censorcode varchar(50)
)
WITH (oids = false);
--
-- Structure for table samplemediumcv (OID = 453896) : 
--
CREATE TABLE tables.samplemediumcv (
    term varchar(255) NOT NULL,
    definition text
)
WITH (oids = false);
--
-- Structure for table seriescatalog (OID = 453904) : 
--
CREATE TABLE tables.seriescatalog (
    datastreamid integer NOT NULL,
    datastreamname varchar(255) NOT NULL,
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    offsetvalue double precision,
    unitsabbreviation varchar(255),
    offsettypeid integer,
    variableid integer NOT NULL,
    variablecode varchar(50) NOT NULL,
    variablename varchar(255) NOT NULL,
    speciation varchar(255) NOT NULL,
    variableunitsid integer NOT NULL,
    samplemedium varchar(255) NOT NULL,
    valuetype varchar(255) NOT NULL,
    timesupport double precision NOT NULL,
    timeunitsid integer NOT NULL,
    datatype varchar(255) NOT NULL,
    generalcategory varchar(255) NOT NULL,
    methodid integer NOT NULL,
    methoddescription text NOT NULL,
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    sourcedescription text NOT NULL,
    citation text NOT NULL,
    qualitycontrollevelid integer,
    qualitycontrollevelcode varchar(50) NOT NULL,
    begindatetime varchar(100),
    enddatetime varchar(100),
    begindatetimeutc varchar(100),
    enddatetimeutc varchar(100),
    lat double precision,
    long double precision,
    elev double precision,
    geolocationtext text,
    spatialcharacteristics varchar(50) NOT NULL,
    totalvalues integer,
    startdecade integer,
    enddecade integer,
    totalyears integer
)
WITH (oids = false);
--
-- Structure for table siteattributes (OID = 454542) : 
--
CREATE TABLE tables.siteattributes (
    siteid integer NOT NULL,
    attributeid integer NOT NULL,
    attributevalue varchar(255) NOT NULL,
    attributecomment text
)
WITH (oids = false);
--
-- Structure for table sites (OID = 454553) : 
--
CREATE TABLE tables.sites (
    siteid serial NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    spatialcharacteristics varchar(50) NOT NULL,
    sourceid integer NOT NULL,
    verticaldatum varchar(255),
    localprojectionid integer,
    posaccuracy_m double precision,
    state varchar(255),
    county varchar(255),
    comments text,
    latlongdatumid integer NOT NULL,
    geolocation text,
    locationdescription text,
    updated_at timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table _sites_summary (OID = 455060) : 
--
CREATE TABLE tables._sites_summary (
    siteid integer NOT NULL,
    geolocation text NOT NULL,
    begindate varchar(10) NOT NULL,
    enddate varchar(10) NOT NULL
)
WITH (oids = false);
--
-- Structure for table _siteswithelevations (OID = 455066) : 
--
CREATE TABLE tables._siteswithelevations (
    siteid integer,
    geolocation text,
    sourcedatum text
)
WITH (oids = false);
--
-- Structure for table sources (OID = 455072) : 
--
CREATE TABLE tables.sources (
    sourceid serial NOT NULL,
    organization varchar(255) NOT NULL,
    sourcedescription text NOT NULL,
    sourcerole varchar(50) NOT NULL,
    sourcelink varchar(500),
    contactname varchar(255) DEFAULT ''::character varying NOT NULL,
    phone varchar(255) DEFAULT ''::character varying NOT NULL,
    email varchar(255) DEFAULT ''::character varying NOT NULL,
    address varchar(255) DEFAULT ''::character varying NOT NULL,
    city varchar(255) DEFAULT ''::character varying NOT NULL,
    state varchar(255) DEFAULT ''::character varying NOT NULL,
    zipcode varchar(255) DEFAULT ''::character varying NOT NULL,
    citation text NOT NULL,
    metadataid integer NOT NULL,
    updated_at timestamp without time zone
)
WITH (oids = false);
--
-- Structure for table spatialreferences (OID = 455090) : 
--
CREATE TABLE tables.spatialreferences (
    spatialreferenceid serial NOT NULL,
    srsid integer,
    srsname varchar(255) NOT NULL,
    isgeographic boolean,
    notes text
)
WITH (oids = false);
--
-- Structure for table speciationcv (OID = 455101) : 
--
CREATE TABLE tables.speciationcv (
    term varchar(255) NOT NULL,
    definition text
)
WITH (oids = false);
--
-- Structure for table sysdiagrams (OID = 455109) : 
--
CREATE TABLE tables.sysdiagrams (
    name varchar(128) NOT NULL,
    principal_id integer NOT NULL,
    diagram_id serial NOT NULL,
    version integer,
    definition bytea
)
WITH (oids = false);
--
-- Structure for table topiccategorycv (OID = 455123) : 
--
CREATE TABLE tables.topiccategorycv (
    term varchar(255) NOT NULL,
    definition text
)
WITH (oids = false);
--
-- Structure for table units (OID = 455131) : 
--
CREATE TABLE tables.units (
    unitsid serial NOT NULL,
    unitsname varchar(255) NOT NULL,
    unitstype varchar(255) NOT NULL,
    unitsabbreviation varchar(255) NOT NULL
)
WITH (oids = false);
--
-- Structure for table valuetypecv (OID = 455142) : 
--
CREATE TABLE tables.valuetypecv (
    term varchar(255) NOT NULL,
    definition text
)
WITH (oids = false);
--
-- Structure for table variablenamecv (OID = 455150) : 
--
CREATE TABLE tables.variablenamecv (
    term varchar(255) NOT NULL,
    definition text
)
WITH (oids = false);
--
-- Structure for table variables (OID = 455158) : 
--
CREATE TABLE tables.variables (
    variableid serial NOT NULL,
    variablecode varchar(50) NOT NULL,
    variablename varchar(255) NOT NULL,
    variabledescription text,
    speciation varchar(255) DEFAULT ''::character varying NOT NULL,
    variableunitsid integer NOT NULL,
    samplemedium varchar(255) DEFAULT ''::character varying NOT NULL,
    valuetype varchar(255) DEFAULT ''::character varying NOT NULL,
    isregular boolean NOT NULL,
    timesupport double precision NOT NULL,
    timeunitsid integer NOT NULL,
    datatype varchar(255) DEFAULT ''::character varying NOT NULL,
    generalcategory varchar(255) DEFAULT ''::character varying NOT NULL,
    nodatavalue double precision NOT NULL
)
WITH (oids = false);
--
-- Structure for table verticaldatumcv (OID = 455210) : 
--
CREATE TABLE tables.verticaldatumcv (
    term varchar(255) NOT NULL,
    definition text
)
WITH (oids = false);
--
-- Structure for table datavalues (OID = 459342) : 
--
CREATE TABLE tables.datavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    qualifierid integer,
    derivedfromid integer,
    datastreamid integer NOT NULL,
    censorcode varchar(50),
    offsettypeid integer,
    offsetvalue double precision,
    categoryid integer
)
WITH (oids = false);
--
-- Structure for table daily_utcdatetime (OID = 463906) : 
--
SET search_path = views, pg_catalog;
CREATE TABLE views.daily_utcdatetime (
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgairtemp (OID = 463918) : 
--
CREATE TABLE views.multiyear_annual_avgairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgdischarge (OID = 463921) : 
--
CREATE TABLE views.multiyear_annual_avgdischarge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgfallairtemp (OID = 463924) : 
--
CREATE TABLE views.multiyear_annual_avgfallairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgfallprecip (OID = 463927) : 
--
CREATE TABLE views.multiyear_annual_avgfallprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgpeakdischarge (OID = 463930) : 
--
CREATE TABLE views.multiyear_annual_avgpeakdischarge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgpeaksnowdepth (OID = 463933) : 
--
CREATE TABLE views.multiyear_annual_avgpeaksnowdepth (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgpeakswe (OID = 463936) : 
--
CREATE TABLE views.multiyear_annual_avgpeakswe (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgprecip (OID = 463939) : 
--
CREATE TABLE views.multiyear_annual_avgprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgrh (OID = 463942) : 
--
CREATE TABLE views.multiyear_annual_avgrh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgspringairtemp (OID = 463945) : 
--
CREATE TABLE views.multiyear_annual_avgspringairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgspringprecip (OID = 463948) : 
--
CREATE TABLE views.multiyear_annual_avgspringprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgsummerairtemp (OID = 463951) : 
--
CREATE TABLE views.multiyear_annual_avgsummerairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgsummerdischarge (OID = 463954) : 
--
CREATE TABLE views.multiyear_annual_avgsummerdischarge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgsummerprecip (OID = 463957) : 
--
CREATE TABLE views.multiyear_annual_avgsummerprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgsummerrh (OID = 463960) : 
--
CREATE TABLE views.multiyear_annual_avgsummerrh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgwinterairtemp (OID = 463963) : 
--
CREATE TABLE views.multiyear_annual_avgwinterairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgwinterprecip (OID = 463966) : 
--
CREATE TABLE views.multiyear_annual_avgwinterprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table multiyear_annual_avgwinterrh (OID = 463969) : 
--
CREATE TABLE views.multiyear_annual_avgwinterrh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table odmdatavalues (OID = 471127) : 
--
CREATE TABLE views.odmdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    datetimeutc timestamp without time zone,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    offsetvalue double precision,
    offsettypeid integer,
    censorcode varchar(50),
    qualifierid integer,
    methodid integer NOT NULL,
    sourceid integer NOT NULL,
    derivedfromid integer,
    qualitycontrollevelid integer,
    geographylocation public.geography,
    spatialcharacteristics varchar(50) NOT NULL
)
WITH (oids = false);
--
-- Structure for table odmdatavalues_metric (OID = 479031) : 
--
CREATE TABLE views.odmdatavalues_metric (
    valueid integer,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone,
    utcoffset double precision,
    datetimeutc timestamp without time zone,
    siteid integer,
    originalvariableid integer,
    variablename varchar(255),
    samplemedium varchar(255),
    variableunitsid integer,
    variabletimeunits integer,
    offsetvalue double precision,
    offsettypeid integer,
    censorcode varchar(50),
    qualifierid integer,
    methodid integer,
    sourceid integer,
    derivedfromid integer,
    qualitycontrollevelid integer,
    geographylocation public.geography,
    geolocation text,
    spatialcharacteristics varchar(50)
)
WITH (oids = false);
--
-- Definition for index datavaluesraw_datastreamid (OID = 452963) : 
--
SET search_path = tables, pg_catalog;
CREATE UNIQUE INDEX datavaluesraw_datastreamid ON datavaluesraw USING btree (datastreamid);
--
-- Definition for index datavaluesraw_localdatetime (OID = 452964) : 
--
CREATE UNIQUE INDEX datavaluesraw_localdatetime ON datavaluesraw USING btree (localdatetime);
--
-- Definition for index methods_methodname (OID = 453680) : 
--
CREATE UNIQUE INDEX methods_methodname ON methods USING btree (methodname);
--
-- Definition for index sysdiagrams_name (OID = 455121) : 
--
CREATE UNIQUE INDEX sysdiagrams_name ON sysdiagrams USING btree (name);
--
-- Definition for index sysdiagrams_principal_id (OID = 455122) : 
--
CREATE UNIQUE INDEX sysdiagrams_principal_id ON sysdiagrams USING btree (principal_id);
--
-- Definition for index variables_variablecode (OID = 455174) : 
--
CREATE UNIQUE INDEX variables_variablecode ON variables USING btree (variablecode);
--
-- Definition for index datavalues_datastreamid_localdatetime (OID = 463810) : 
--
CREATE UNIQUE INDEX datavalues_datastreamid_localdatetime ON datavalues USING btree (datastreamid, localdatetime, offsetvalue);
--
-- Definition for index annual_avgrh_all_siteid_idx (OID = 464061) : 
--
CREATE INDEX annual_avgrh_all_siteid_idx ON annual_avgrh_all USING btree (siteid);
--
-- Definition for index annual_avgwinterairtemp_all_siteid_idx (OID = 464062) : 
--
CREATE INDEX annual_avgwinterairtemp_all_siteid_idx ON annual_avgwinterairtemp_all USING btree (siteid);
--
-- Definition for index annual_avgwinterprecip_all_siteid_idx (OID = 464063) : 
--
CREATE INDEX annual_avgwinterprecip_all_siteid_idx ON annual_avgwinterprecip_all USING btree (siteid);
--
-- Definition for index annual_avgwinterrh_all_siteid_idx (OID = 464064) : 
--
CREATE INDEX annual_avgwinterrh_all_siteid_idx ON annual_avgwinterrh_all USING btree (siteid);
--
-- Definition for index annual_peakdischarge_all_siteid_idx (OID = 464065) : 
--
CREATE INDEX annual_peakdischarge_all_siteid_idx ON annual_peakdischarge_all USING btree (siteid);
--
-- Definition for index annual_peaksnowdepth_all_siteid_idx (OID = 464066) : 
--
CREATE INDEX annual_peaksnowdepth_all_siteid_idx ON annual_peaksnowdepth_all USING btree (siteid);
--
-- Definition for index annual_peakswe_all_siteid_idx (OID = 464067) : 
--
CREATE INDEX annual_peakswe_all_siteid_idx ON annual_peakswe_all USING btree (siteid);
--
-- Definition for index annual_totalprecip_all_siteid_idx (OID = 464068) : 
--
CREATE INDEX annual_totalprecip_all_siteid_idx ON annual_totalprecip_all USING btree (siteid);
--
-- Definition for index daily_airtempdatavalues_siteid_idx (OID = 464069) : 
--
CREATE INDEX daily_airtempdatavalues_siteid_idx ON daily_airtempdatavalues USING btree (siteid);
--
-- Definition for index daily_airtempmaxdatavalues_siteid_idx (OID = 464070) : 
--
CREATE INDEX daily_airtempmaxdatavalues_siteid_idx ON daily_airtempmaxdatavalues USING btree (siteid);
--
-- Definition for index daily_airtempmindatavalues_siteid_idx (OID = 464071) : 
--
CREATE INDEX daily_airtempmindatavalues_siteid_idx ON daily_airtempmindatavalues USING btree (siteid);
--
-- Definition for index daily_dischargedatavalues_siteid_idx (OID = 464072) : 
--
CREATE INDEX daily_dischargedatavalues_siteid_idx ON daily_dischargedatavalues USING btree (siteid);
--
-- Definition for index daily_precip_siteid_idx (OID = 464073) : 
--
CREATE INDEX daily_precip_siteid_idx ON daily_precip USING btree (siteid);
--
-- Definition for index daily_precip_thresholds_siteid_idx (OID = 464074) : 
--
CREATE INDEX daily_precip_thresholds_siteid_idx ON daily_precip_thresholds USING btree (siteid);
--
-- Definition for index daily_precipdatavalues_siteid_idx (OID = 464075) : 
--
CREATE INDEX daily_precipdatavalues_siteid_idx ON daily_precipdatavalues USING btree (siteid);
--
-- Definition for index daily_rhdatavalues_siteid_idx (OID = 464076) : 
--
CREATE INDEX daily_rhdatavalues_siteid_idx ON daily_rhdatavalues USING btree (siteid);
--
-- Definition for index daily_snowdepth_siteid_idx (OID = 464077) : 
--
CREATE INDEX daily_snowdepth_siteid_idx ON daily_snowdepth USING btree (siteid);
--
-- Definition for index daily_snowdepthdatavalues_siteid_idx (OID = 464078) : 
--
CREATE INDEX daily_snowdepthdatavalues_siteid_idx ON daily_snowdepthdatavalues USING btree (siteid);
--
-- Definition for index daily_swe_siteid_idx (OID = 464079) : 
--
CREATE INDEX daily_swe_siteid_idx ON daily_swe USING btree (siteid);
--
-- Definition for index daily_swedatavalues_siteid_idx (OID = 464080) : 
--
CREATE INDEX daily_swedatavalues_siteid_idx ON daily_swedatavalues USING btree (siteid);
--
-- Definition for index daily_watertempdatavalues_siteid_idx (OID = 464081) : 
--
CREATE INDEX daily_watertempdatavalues_siteid_idx ON daily_watertempdatavalues USING btree (siteid);
--
-- Definition for index daily_winddirectiondatavalues_siteid_idx (OID = 464082) : 
--
CREATE INDEX daily_winddirectiondatavalues_siteid_idx ON daily_winddirectiondatavalues USING btree (siteid);
--
-- Definition for index daily_windspeeddatavalues_siteid_idx (OID = 464083) : 
--
CREATE INDEX daily_windspeeddatavalues_siteid_idx ON daily_windspeeddatavalues USING btree (siteid);
--
-- Definition for index datastreams_siteid_idx (OID = 464084) : 
--
CREATE INDEX datastreams_siteid_idx ON datastreams USING btree (siteid);
--
-- Definition for index hourly_airtempdatavalues_siteid_idx (OID = 464085) : 
--
CREATE INDEX hourly_airtempdatavalues_siteid_idx ON hourly_airtempdatavalues USING btree (siteid);
--
-- Definition for index hourly_precip_siteid_idx (OID = 464086) : 
--
CREATE INDEX hourly_precip_siteid_idx ON hourly_precip USING btree (siteid);
--
-- Definition for index hourly_precipdatavalues_siteid_idx (OID = 464087) : 
--
CREATE INDEX hourly_precipdatavalues_siteid_idx ON hourly_precipdatavalues USING btree (siteid);
--
-- Definition for index hourly_rhdatavalues_siteid_idx (OID = 464088) : 
--
CREATE INDEX hourly_rhdatavalues_siteid_idx ON hourly_rhdatavalues USING btree (siteid);
--
-- Definition for index hourly_snowdepth_siteid_idx (OID = 464089) : 
--
CREATE INDEX hourly_snowdepth_siteid_idx ON hourly_snowdepth USING btree (siteid);
--
-- Definition for index hourly_snowdepthdatavalues_siteid_idx (OID = 464090) : 
--
CREATE INDEX hourly_snowdepthdatavalues_siteid_idx ON hourly_snowdepthdatavalues USING btree (siteid);
--
-- Definition for index hourly_swe_siteid_idx (OID = 464091) : 
--
CREATE INDEX hourly_swe_siteid_idx ON hourly_swe USING btree (siteid);
--
-- Definition for index hourly_swedatavalues_siteid_idx (OID = 464092) : 
--
CREATE INDEX hourly_swedatavalues_siteid_idx ON hourly_swedatavalues USING btree (siteid);
--
-- Definition for index hourly_winddirectiondatavalues_siteid_idx (OID = 464093) : 
--
CREATE INDEX hourly_winddirectiondatavalues_siteid_idx ON hourly_winddirectiondatavalues USING btree (siteid);
--
-- Definition for index hourly_windspeeddatavalues_siteid_idx (OID = 464094) : 
--
CREATE INDEX hourly_windspeeddatavalues_siteid_idx ON hourly_windspeeddatavalues USING btree (siteid);
--
-- Definition for index monthly_rh_all_siteid_idx (OID = 464095) : 
--
CREATE INDEX monthly_rh_all_siteid_idx ON monthly_rh_all USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgairtemp_siteid_idx (OID = 464096) : 
--
CREATE INDEX multiyear_annual_all_avgairtemp_siteid_idx ON multiyear_annual_all_avgairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgdischarge_siteid_idx (OID = 464097) : 
--
CREATE INDEX multiyear_annual_all_avgdischarge_siteid_idx ON multiyear_annual_all_avgdischarge USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgfallairtemp_siteid_idx (OID = 464098) : 
--
CREATE INDEX multiyear_annual_all_avgfallairtemp_siteid_idx ON multiyear_annual_all_avgfallairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgfallprecip_siteid_idx (OID = 464099) : 
--
CREATE INDEX multiyear_annual_all_avgfallprecip_siteid_idx ON multiyear_annual_all_avgfallprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgpeakdischarge_siteid_idx (OID = 464100) : 
--
CREATE INDEX multiyear_annual_all_avgpeakdischarge_siteid_idx ON multiyear_annual_all_avgpeakdischarge USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgpeaksnowdepth_siteid_idx (OID = 464101) : 
--
CREATE INDEX multiyear_annual_all_avgpeaksnowdepth_siteid_idx ON multiyear_annual_all_avgpeaksnowdepth USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgpeakswe_siteid_idx (OID = 464102) : 
--
CREATE INDEX multiyear_annual_all_avgpeakswe_siteid_idx ON multiyear_annual_all_avgpeakswe USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgprecip_siteid_idx (OID = 464103) : 
--
CREATE INDEX multiyear_annual_all_avgprecip_siteid_idx ON multiyear_annual_all_avgprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgrh_siteid_idx (OID = 464104) : 
--
CREATE INDEX multiyear_annual_all_avgrh_siteid_idx ON multiyear_annual_all_avgrh USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgspringairtemp_siteid_idx (OID = 464105) : 
--
CREATE INDEX multiyear_annual_all_avgspringairtemp_siteid_idx ON multiyear_annual_all_avgspringairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgspringprecip_siteid_idx (OID = 464106) : 
--
CREATE INDEX multiyear_annual_all_avgspringprecip_siteid_idx ON multiyear_annual_all_avgspringprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgsummerairtemp_siteid_idx (OID = 464107) : 
--
CREATE INDEX multiyear_annual_all_avgsummerairtemp_siteid_idx ON multiyear_annual_all_avgsummerairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgsummerdischarge_siteid_idx (OID = 464108) : 
--
CREATE INDEX multiyear_annual_all_avgsummerdischarge_siteid_idx ON multiyear_annual_all_avgsummerdischarge USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgsummerprecip_siteid_idx (OID = 464109) : 
--
CREATE INDEX multiyear_annual_all_avgsummerprecip_siteid_idx ON multiyear_annual_all_avgsummerprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgsummerrh_siteid_idx (OID = 464110) : 
--
CREATE INDEX multiyear_annual_all_avgsummerrh_siteid_idx ON multiyear_annual_all_avgsummerrh USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgwinterairtemp_siteid_idx (OID = 464111) : 
--
CREATE INDEX multiyear_annual_all_avgwinterairtemp_siteid_idx ON multiyear_annual_all_avgwinterairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgwinterprecip_siteid_idx (OID = 464112) : 
--
CREATE INDEX multiyear_annual_all_avgwinterprecip_siteid_idx ON multiyear_annual_all_avgwinterprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_all_avgwinterrh_siteid_idx (OID = 464113) : 
--
CREATE INDEX multiyear_annual_all_avgwinterrh_siteid_idx ON multiyear_annual_all_avgwinterrh USING btree (siteid);
--
-- Definition for index daily_utcdatetime_siteid_idx (OID = 464145) : 
--
SET search_path = views, pg_catalog;
CREATE INDEX daily_utcdatetime_siteid_idx ON daily_utcdatetime USING btree (siteid);
--
-- Definition for index hourly_utcdatetime_siteid_idx (OID = 464149) : 
--
CREATE INDEX hourly_utcdatetime_siteid_idx ON hourly_utcdatetime USING btree (siteid);
--
-- Definition for index multiyear_annual_avgairtemp_siteid_idx (OID = 464150) : 
--
CREATE INDEX multiyear_annual_avgairtemp_siteid_idx ON multiyear_annual_avgairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_avgdischarge_siteid_idx (OID = 464151) : 
--
CREATE INDEX multiyear_annual_avgdischarge_siteid_idx ON multiyear_annual_avgdischarge USING btree (siteid);
--
-- Definition for index multiyear_annual_avgfallairtemp_siteid_idx (OID = 464152) : 
--
CREATE INDEX multiyear_annual_avgfallairtemp_siteid_idx ON multiyear_annual_avgfallairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_avgfallprecip_siteid_idx (OID = 464153) : 
--
CREATE INDEX multiyear_annual_avgfallprecip_siteid_idx ON multiyear_annual_avgfallprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_avgpeakdischarge_siteid_idx (OID = 464154) : 
--
CREATE INDEX multiyear_annual_avgpeakdischarge_siteid_idx ON multiyear_annual_avgpeakdischarge USING btree (siteid);
--
-- Definition for index multiyear_annual_avgpeaksnowdepth_siteid_idx (OID = 464155) : 
--
CREATE INDEX multiyear_annual_avgpeaksnowdepth_siteid_idx ON multiyear_annual_avgpeaksnowdepth USING btree (siteid);
--
-- Definition for index multiyear_annual_avgpeakswe_siteid_idx (OID = 464156) : 
--
CREATE INDEX multiyear_annual_avgpeakswe_siteid_idx ON multiyear_annual_avgpeakswe USING btree (siteid);
--
-- Definition for index multiyear_annual_avgprecip_siteid_idx (OID = 464157) : 
--
CREATE INDEX multiyear_annual_avgprecip_siteid_idx ON multiyear_annual_avgprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_avgrh_siteid_idx (OID = 464158) : 
--
CREATE INDEX multiyear_annual_avgrh_siteid_idx ON multiyear_annual_avgrh USING btree (siteid);
--
-- Definition for index multiyear_annual_avgspringairtemp_siteid_idx (OID = 464159) : 
--
CREATE INDEX multiyear_annual_avgspringairtemp_siteid_idx ON multiyear_annual_avgspringairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_avgspringprecip_siteid_idx (OID = 464160) : 
--
CREATE INDEX multiyear_annual_avgspringprecip_siteid_idx ON multiyear_annual_avgspringprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_avgsummerairtemp_siteid_idx (OID = 464161) : 
--
CREATE INDEX multiyear_annual_avgsummerairtemp_siteid_idx ON multiyear_annual_avgsummerairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_avgsummerdischarge_siteid_idx (OID = 464162) : 
--
CREATE INDEX multiyear_annual_avgsummerdischarge_siteid_idx ON multiyear_annual_avgsummerdischarge USING btree (siteid);
--
-- Definition for index multiyear_annual_avgsummerprecip_siteid_idx (OID = 464163) : 
--
CREATE INDEX multiyear_annual_avgsummerprecip_siteid_idx ON multiyear_annual_avgsummerprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_avgsummerrh_siteid_idx (OID = 464164) : 
--
CREATE INDEX multiyear_annual_avgsummerrh_siteid_idx ON multiyear_annual_avgsummerrh USING btree (siteid);
--
-- Definition for index multiyear_annual_avgwinterairtemp_siteid_idx (OID = 464165) : 
--
CREATE INDEX multiyear_annual_avgwinterairtemp_siteid_idx ON multiyear_annual_avgwinterairtemp USING btree (siteid);
--
-- Definition for index multiyear_annual_avgwinterprecip_siteid_idx (OID = 464166) : 
--
CREATE INDEX multiyear_annual_avgwinterprecip_siteid_idx ON multiyear_annual_avgwinterprecip USING btree (siteid);
--
-- Definition for index multiyear_annual_avgwinterrh_siteid_idx (OID = 464167) : 
--
CREATE INDEX multiyear_annual_avgwinterrh_siteid_idx ON multiyear_annual_avgwinterrh USING btree (siteid);
--
-- Definition for index pk_units_unitsid (OID = 478889) : 
--
SET search_path = tables, pg_catalog;
CREATE UNIQUE INDEX pk_units_unitsid ON units USING btree (unitsid);
ALTER TABLE units CLUSTER ON pk_units_unitsid;
--
-- Definition for index pk_variables_variableid (OID = 478890) : 
--
CREATE UNIQUE INDEX pk_variables_variableid ON variables USING btree (variableid);
ALTER TABLE variables CLUSTER ON pk_variables_variableid;
--
-- Definition for index pk_sites_siteid (OID = 478891) : 
--
CREATE UNIQUE INDEX pk_sites_siteid ON sites USING btree (siteid);
ALTER TABLE sites CLUSTER ON pk_sites_siteid;
--
-- Definition for index attributes_attributeid (OID = 451807) : 
--
ALTER TABLE ONLY attributes
    ADD CONSTRAINT attributes_attributeid
    PRIMARY KEY (attributeid);
--
-- Definition for index categories_categoryid (OID = 451818) : 
--
ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_categoryid
    PRIMARY KEY (categoryid);
--
-- Definition for index censorcodecv_term (OID = 451826) : 
--
ALTER TABLE ONLY censorcodecv
    ADD CONSTRAINT censorcodecv_term
    PRIMARY KEY (term);
--
-- Definition for index daily_airtempdatavalues_valueid (OID = 451835) : 
--
ALTER TABLE ONLY daily_airtempdatavalues
    ADD CONSTRAINT daily_airtempdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_airtempmaxdatavalues_valueid (OID = 451871) : 
--
ALTER TABLE ONLY daily_airtempmaxdatavalues
    ADD CONSTRAINT daily_airtempmaxdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_airtempmindatavalues_valueid (OID = 451880) : 
--
ALTER TABLE ONLY daily_airtempmindatavalues
    ADD CONSTRAINT daily_airtempmindatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_dischargedatavalues_valueid (OID = 451889) : 
--
ALTER TABLE ONLY daily_dischargedatavalues
    ADD CONSTRAINT daily_dischargedatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_precipdatavalues_valueid (OID = 451904) : 
--
ALTER TABLE ONLY daily_precipdatavalues
    ADD CONSTRAINT daily_precipdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_rhdatavalues_valueid (OID = 451917) : 
--
ALTER TABLE ONLY daily_rhdatavalues
    ADD CONSTRAINT daily_rhdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_snowdepthdatavalues_valueid (OID = 452465) : 
--
ALTER TABLE ONLY daily_snowdepthdatavalues
    ADD CONSTRAINT daily_snowdepthdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_swedatavalues_valueid (OID = 452844) : 
--
ALTER TABLE ONLY daily_swedatavalues
    ADD CONSTRAINT daily_swedatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_watertempdatavalues_valueid (OID = 452853) : 
--
ALTER TABLE ONLY daily_watertempdatavalues
    ADD CONSTRAINT daily_watertempdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_winddirectiondatavalues_valueid (OID = 452863) : 
--
ALTER TABLE ONLY daily_winddirectiondatavalues
    ADD CONSTRAINT daily_winddirectiondatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index daily_windspeeddatavalues_valueid (OID = 452883) : 
--
ALTER TABLE ONLY daily_windspeeddatavalues
    ADD CONSTRAINT daily_windspeeddatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index datastreams_datastreamid (OID = 452895) : 
--
ALTER TABLE ONLY datastreams
    ADD CONSTRAINT datastreams_datastreamid
    PRIMARY KEY (datastreamid);
--
-- Definition for index datatypecv_term (OID = 452904) : 
--
ALTER TABLE ONLY datatypecv
    ADD CONSTRAINT datatypecv_term
    PRIMARY KEY (term);
--
-- Definition for index datavaluesraw_valueid (OID = 452961) : 
--
ALTER TABLE ONLY datavaluesraw
    ADD CONSTRAINT datavaluesraw_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index derivedfrom_derivedfromid (OID = 452968) : 
--
ALTER TABLE ONLY derivedfrom
    ADD CONSTRAINT derivedfrom_derivedfromid
    PRIMARY KEY (derivedfromid);
--
-- Definition for index fk_derivedfrom_datavaluesraw (OID = 452975) : 
--
ALTER TABLE ONLY derivedfrom
    ADD CONSTRAINT fk_derivedfrom_datavaluesraw
    FOREIGN KEY (valueid) REFERENCES datavaluesraw(valueid);
--
-- Definition for index devices_deviceid (OID = 452989) : 
--
ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_deviceid
    PRIMARY KEY (deviceid);
--
-- Definition for index ext_arc_arc_id (OID = 453155) : 
--
ALTER TABLE ONLY ext_arc_arc
    ADD CONSTRAINT ext_arc_arc_id
    PRIMARY KEY (id);
--
-- Definition for index ext_arc_point_id (OID = 453166) : 
--
ALTER TABLE ONLY ext_arc_point
    ADD CONSTRAINT ext_arc_point_id
    PRIMARY KEY (id);
--
-- Definition for index ext_fws_fishsample_fishsampleid (OID = 453177) : 
--
ALTER TABLE ONLY ext_fws_fishsample
    ADD CONSTRAINT ext_fws_fishsample_fishsampleid
    PRIMARY KEY (fishsampleid);
--
-- Definition for index ext_reference_referenceid (OID = 453188) : 
--
ALTER TABLE ONLY ext_reference
    ADD CONSTRAINT ext_reference_referenceid
    PRIMARY KEY (referenceid);
--
-- Definition for index ext_referencetowaterbody_id (OID = 453196) : 
--
ALTER TABLE ONLY ext_referencetowaterbody
    ADD CONSTRAINT ext_referencetowaterbody_id
    PRIMARY KEY (id);
--
-- Definition for index ext_waterbody_id (OID = 453514) : 
--
ALTER TABLE ONLY ext_waterbody
    ADD CONSTRAINT ext_waterbody_id
    PRIMARY KEY (id);
--
-- Definition for index generalcategorycv_term (OID = 453522) : 
--
ALTER TABLE ONLY generalcategorycv
    ADD CONSTRAINT generalcategorycv_term
    PRIMARY KEY (term);
--
-- Definition for index groupdescriptions_groupid (OID = 453533) : 
--
ALTER TABLE ONLY groupdescriptions
    ADD CONSTRAINT groupdescriptions_groupid
    PRIMARY KEY (groupid);
--
-- Definition for index fk_groups_groupdescriptions (OID = 453543) : 
--
ALTER TABLE ONLY groups
    ADD CONSTRAINT fk_groups_groupdescriptions
    FOREIGN KEY (groupid) REFERENCES groupdescriptions(groupid);
--
-- Definition for index hourly_airtempdatavalues_valueid (OID = 453561) : 
--
ALTER TABLE ONLY hourly_airtempdatavalues
    ADD CONSTRAINT hourly_airtempdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index hourly_precipdatavalues_valueid (OID = 453575) : 
--
ALTER TABLE ONLY hourly_precipdatavalues
    ADD CONSTRAINT hourly_precipdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index hourly_rhdatavalues_valueid (OID = 453584) : 
--
ALTER TABLE ONLY hourly_rhdatavalues
    ADD CONSTRAINT hourly_rhdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index hourly_snowdepthdatavalues_valueid (OID = 453597) : 
--
ALTER TABLE ONLY hourly_snowdepthdatavalues
    ADD CONSTRAINT hourly_snowdepthdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index hourly_swedatavalues_valueid (OID = 453610) : 
--
ALTER TABLE ONLY hourly_swedatavalues
    ADD CONSTRAINT hourly_swedatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index hourly_winddirectiondatavalues_valueid (OID = 453619) : 
--
ALTER TABLE ONLY hourly_winddirectiondatavalues
    ADD CONSTRAINT hourly_winddirectiondatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index hourly_windspeeddatavalues_valueid (OID = 453628) : 
--
ALTER TABLE ONLY hourly_windspeeddatavalues
    ADD CONSTRAINT hourly_windspeeddatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index incidents_incidentid (OID = 453646) : 
--
ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_incidentid
    PRIMARY KEY (incidentid);
--
-- Definition for index fk_incidents_datastreams (OID = 453648) : 
--
ALTER TABLE ONLY incidents
    ADD CONSTRAINT fk_incidents_datastreams
    FOREIGN KEY (datastreamid) REFERENCES datastreams(datastreamid);
--
-- Definition for index isometadata_metadataid (OID = 453666) : 
--
ALTER TABLE ONLY isometadata
    ADD CONSTRAINT isometadata_metadataid
    PRIMARY KEY (metadataid);
--
-- Definition for index methods_methodid (OID = 453678) : 
--
ALTER TABLE ONLY methods
    ADD CONSTRAINT methods_methodid
    PRIMARY KEY (methodid);
--
-- Definition for index networkdescriptions_networkid (OID = 453763) : 
--
ALTER TABLE ONLY networkdescriptions
    ADD CONSTRAINT networkdescriptions_networkid
    PRIMARY KEY (networkid);
--
-- Definition for index nhd_huc8_id (OID = 453818) : 
--
ALTER TABLE ONLY nhd_huc8
    ADD CONSTRAINT nhd_huc8_id
    PRIMARY KEY (id);
--
-- Definition for index offsettypes_offsettypeid (OID = 453829) : 
--
ALTER TABLE ONLY offsettypes
    ADD CONSTRAINT offsettypes_offsettypeid
    PRIMARY KEY (offsettypeid);
--
-- Definition for index organizationdescriptions_organizationid (OID = 453837) : 
--
ALTER TABLE ONLY organizationdescriptions
    ADD CONSTRAINT organizationdescriptions_organizationid
    PRIMARY KEY (organizationid);
--
-- Definition for index fk_organizations_organizationid (OID = 453842) : 
--
ALTER TABLE ONLY organizations
    ADD CONSTRAINT fk_organizations_organizationid
    FOREIGN KEY (organizationid) REFERENCES organizationdescriptions(organizationid);
--
-- Definition for index processing_processingid (OID = 453856) : 
--
ALTER TABLE ONLY processing
    ADD CONSTRAINT processing_processingid
    PRIMARY KEY (processingid);
--
-- Definition for index qualifiers_qualifierid (OID = 453867) : 
--
ALTER TABLE ONLY qualifiers
    ADD CONSTRAINT qualifiers_qualifierid
    PRIMARY KEY (qualifierid);
--
-- Definition for index qualitycontrollevels_qualitycontrollevelid (OID = 453878) : 
--
ALTER TABLE ONLY qualitycontrollevels
    ADD CONSTRAINT qualitycontrollevels_qualitycontrollevelid
    PRIMARY KEY (qualitycontrollevelid);
--
-- Definition for index rasterdatavalues_valueid (OID = 453889) : 
--
ALTER TABLE ONLY rasterdatavalues
    ADD CONSTRAINT rasterdatavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index fk_rasterdatavalues_qualifierid (OID = 453891) : 
--
ALTER TABLE ONLY rasterdatavalues
    ADD CONSTRAINT fk_rasterdatavalues_qualifierid
    FOREIGN KEY (qualifierid) REFERENCES qualifiers(qualifierid);
--
-- Definition for index samplemediumcv_term (OID = 453902) : 
--
ALTER TABLE ONLY samplemediumcv
    ADD CONSTRAINT samplemediumcv_term
    PRIMARY KEY (term);
--
-- Definition for index fk_siteattributes_attributeid (OID = 454548) : 
--
ALTER TABLE ONLY siteattributes
    ADD CONSTRAINT fk_siteattributes_attributeid
    FOREIGN KEY (attributeid) REFERENCES attributes(attributeid);
--
-- Definition for index sites_siteid (OID = 455058) : 
--
ALTER TABLE ONLY sites
    ADD CONSTRAINT sites_siteid
    PRIMARY KEY (siteid);
--
-- Definition for index sources_sourceid (OID = 455088) : 
--
ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_sourceid
    PRIMARY KEY (sourceid);
--
-- Definition for index spatialreferences_spatialreferenceid (OID = 455099) : 
--
ALTER TABLE ONLY spatialreferences
    ADD CONSTRAINT spatialreferences_spatialreferenceid
    PRIMARY KEY (spatialreferenceid);
--
-- Definition for index speciationcv_term (OID = 455107) : 
--
ALTER TABLE ONLY speciationcv
    ADD CONSTRAINT speciationcv_term
    PRIMARY KEY (term);
--
-- Definition for index sysdiagrams_diagram_id (OID = 455119) : 
--
ALTER TABLE ONLY sysdiagrams
    ADD CONSTRAINT sysdiagrams_diagram_id
    PRIMARY KEY (diagram_id);
--
-- Definition for index topiccategorycv_term (OID = 455129) : 
--
ALTER TABLE ONLY topiccategorycv
    ADD CONSTRAINT topiccategorycv_term
    PRIMARY KEY (term);
--
-- Definition for index units_unitsid (OID = 455140) : 
--
ALTER TABLE ONLY units
    ADD CONSTRAINT units_unitsid
    PRIMARY KEY (unitsid);
--
-- Definition for index valuetypecv_term (OID = 455148) : 
--
ALTER TABLE ONLY valuetypecv
    ADD CONSTRAINT valuetypecv_term
    PRIMARY KEY (term);
--
-- Definition for index variablenamecv_term (OID = 455156) : 
--
ALTER TABLE ONLY variablenamecv
    ADD CONSTRAINT variablenamecv_term
    PRIMARY KEY (term);
--
-- Definition for index variables_variableid (OID = 455172) : 
--
ALTER TABLE ONLY variables
    ADD CONSTRAINT variables_variableid
    PRIMARY KEY (variableid);
--
-- Definition for index fk_variables_datatypecv (OID = 455175) : 
--
ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_datatypecv
    FOREIGN KEY (datatype) REFERENCES datatypecv(term);
--
-- Definition for index fk_variables_samplemediumcv (OID = 455180) : 
--
ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_samplemediumcv
    FOREIGN KEY (samplemedium) REFERENCES samplemediumcv(term);
--
-- Definition for index fk_variables_speciationcv (OID = 455185) : 
--
ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_speciationcv
    FOREIGN KEY (speciation) REFERENCES speciationcv(term);
--
-- Definition for index fk_variables_timeunitsid (OID = 455190) : 
--
ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_timeunitsid
    FOREIGN KEY (timeunitsid) REFERENCES units(unitsid);
--
-- Definition for index fk_variables_valuetypecv (OID = 455195) : 
--
ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_valuetypecv
    FOREIGN KEY (valuetype) REFERENCES valuetypecv(term);
--
-- Definition for index fk_variables_variablenamecv (OID = 455200) : 
--
ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_variablenamecv
    FOREIGN KEY (variablename) REFERENCES variablenamecv(term);
--
-- Definition for index fk_variables_variableunitsid (OID = 455205) : 
--
ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_variableunitsid
    FOREIGN KEY (variableunitsid) REFERENCES units(unitsid);
--
-- Definition for index verticaldatumcv_term (OID = 455216) : 
--
ALTER TABLE ONLY verticaldatumcv
    ADD CONSTRAINT verticaldatumcv_term
    PRIMARY KEY (term);
--
-- Definition for index datavalues_valueid (OID = 459346) : 
--
ALTER TABLE ONLY datavalues
    ADD CONSTRAINT datavalues_valueid
    PRIMARY KEY (valueid);
--
-- Definition for index fk_datavalues_censorcodecv (OID = 459451) : 
--
ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_censorcodecv
    FOREIGN KEY (censorcode) REFERENCES censorcodecv(term);
--
-- Definition for index fk_datavalues_offsettypes (OID = 459456) : 
--
ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_offsettypes
    FOREIGN KEY (offsettypeid) REFERENCES offsettypes(offsettypeid);
--
-- Definition for index fk_datavalues_datastreamid (OID = 459461) : 
--
ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_datastreamid
    FOREIGN KEY (datastreamid) REFERENCES datastreams(datastreamid);
--
-- Definition for index fk_datavalues_categoryid (OID = 459466) : 
--
ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_categoryid
    FOREIGN KEY (categoryid) REFERENCES categories(categoryid);
--
-- Definition for index fk_datavalues_qualifierid (OID = 459471) : 
--
ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_qualifierid
    FOREIGN KEY (qualifierid) REFERENCES qualifiers(qualifierid);
--
-- Definition for index multiyear_annual_avgairtemp_pkey (OID = 464025) : 
--
SET search_path = views, pg_catalog;
ALTER TABLE ONLY multiyear_annual_avgairtemp
    ADD CONSTRAINT multiyear_annual_avgairtemp_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgdischarge_pkey (OID = 464027) : 
--
ALTER TABLE ONLY multiyear_annual_avgdischarge
    ADD CONSTRAINT multiyear_annual_avgdischarge_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgfallairtemp_pkey (OID = 464029) : 
--
ALTER TABLE ONLY multiyear_annual_avgfallairtemp
    ADD CONSTRAINT multiyear_annual_avgfallairtemp_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgfallprecip_pkey (OID = 464031) : 
--
ALTER TABLE ONLY multiyear_annual_avgfallprecip
    ADD CONSTRAINT multiyear_annual_avgfallprecip_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgpeakdischarge_pkey (OID = 464033) : 
--
ALTER TABLE ONLY multiyear_annual_avgpeakdischarge
    ADD CONSTRAINT multiyear_annual_avgpeakdischarge_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgpeaksnowdepth_pkey (OID = 464035) : 
--
ALTER TABLE ONLY multiyear_annual_avgpeaksnowdepth
    ADD CONSTRAINT multiyear_annual_avgpeaksnowdepth_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgpeakswe_pkey (OID = 464037) : 
--
ALTER TABLE ONLY multiyear_annual_avgpeakswe
    ADD CONSTRAINT multiyear_annual_avgpeakswe_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgprecip_pkey (OID = 464039) : 
--
ALTER TABLE ONLY multiyear_annual_avgprecip
    ADD CONSTRAINT multiyear_annual_avgprecip_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgrh_pkey (OID = 464041) : 
--
ALTER TABLE ONLY multiyear_annual_avgrh
    ADD CONSTRAINT multiyear_annual_avgrh_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgspringairtemp_pkey (OID = 464043) : 
--
ALTER TABLE ONLY multiyear_annual_avgspringairtemp
    ADD CONSTRAINT multiyear_annual_avgspringairtemp_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgspringprecip_pkey (OID = 464045) : 
--
ALTER TABLE ONLY multiyear_annual_avgspringprecip
    ADD CONSTRAINT multiyear_annual_avgspringprecip_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgsummerairtemp_pkey (OID = 464047) : 
--
ALTER TABLE ONLY multiyear_annual_avgsummerairtemp
    ADD CONSTRAINT multiyear_annual_avgsummerairtemp_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgsummerdischarge_pkey (OID = 464049) : 
--
ALTER TABLE ONLY multiyear_annual_avgsummerdischarge
    ADD CONSTRAINT multiyear_annual_avgsummerdischarge_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgsummerprecip_pkey (OID = 464051) : 
--
ALTER TABLE ONLY multiyear_annual_avgsummerprecip
    ADD CONSTRAINT multiyear_annual_avgsummerprecip_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgsummerrh_pkey (OID = 464053) : 
--
ALTER TABLE ONLY multiyear_annual_avgsummerrh
    ADD CONSTRAINT multiyear_annual_avgsummerrh_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgwinterairtemp_pkey (OID = 464055) : 
--
ALTER TABLE ONLY multiyear_annual_avgwinterairtemp
    ADD CONSTRAINT multiyear_annual_avgwinterairtemp_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgwinterprecip_pkey (OID = 464057) : 
--
ALTER TABLE ONLY multiyear_annual_avgwinterprecip
    ADD CONSTRAINT multiyear_annual_avgwinterprecip_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index multiyear_annual_avgwinterrh_pkey (OID = 464059) : 
--
ALTER TABLE ONLY multiyear_annual_avgwinterrh
    ADD CONSTRAINT multiyear_annual_avgwinterrh_pkey
    PRIMARY KEY (valueid);
--
-- Definition for index odmdatavalues_pkey (OID = 471133) : 
--
ALTER TABLE ONLY odmdatavalues
    ADD CONSTRAINT odmdatavalues_pkey
    PRIMARY KEY (valueid);
--
-- Comments
--
COMMENT ON SCHEMA public IS 'standard public schema';
SET search_path = tables, pg_catalog;
COMMENT ON TABLE tables.attributes IS 'Describes non-numeric data values for a Site.';
COMMENT ON COLUMN tables.attributes.attributeid IS 'Unique integer ID for each attribute.';
COMMENT ON COLUMN tables.attributes.attributename IS 'The name of the attribute.';
COMMENT ON COLUMN tables.categories.categoryid IS 'Primary key for Categories.';
COMMENT ON COLUMN tables.categories.variableid IS 'Integer identifier that references the record in the Variables table.';
COMMENT ON COLUMN tables.categories.categoryname IS 'Category name that is used to describe the category.';
COMMENT ON COLUMN tables.categories.categorydescription IS 'Category definition.';
COMMENT ON TABLE tables.censorcodecv IS 'The CensorCodeCV table contains the controlled vocabulary for censor codes. Only values from the Term field in this table can be used to populate the CensorCode field of the DataValues table.';
COMMENT ON COLUMN tables.censorcodecv.term IS 'Controlled vocabulary for CensorCode.';
COMMENT ON COLUMN tables.censorcodecv.definition IS 'Definition of CensorCode controlled vocabulary term. The definition is optional if the term is self explanatory.';
COMMENT ON TABLE tables.datastreams IS 'The datasteam assigns a variable to a station.  It also includes additional information that can be used for QA/QC on the data values for this station.';
COMMENT ON COLUMN tables.datastreams.datastreamid IS 'Primary key for Datastreams.';
COMMENT ON COLUMN tables.datastreams.datastreamname IS 'Name of the datastream.  Example: SiteName_VariableName';
COMMENT ON COLUMN tables.datastreams.siteid IS 'Integer identifier that references the record in the Sites table.';
COMMENT ON COLUMN tables.datastreams.variableid IS 'Integer identifier that references the record in the Variables table.';
COMMENT ON COLUMN tables.datastreams.fieldname IS 'Name of the fieldname that is used in the data file.';
COMMENT ON COLUMN tables.datastreams.deviceid IS 'Integer identifier that references the record in the Devices table.';
COMMENT ON COLUMN tables.datastreams.methodid IS 'Integer identifier that references the record in the Methods table.';
COMMENT ON COLUMN tables.datastreams.comments IS 'Notes concerning datastream, such as flag or notes from data logger files.';
COMMENT ON COLUMN tables.datastreams.qualitycontrollevelid IS 'Integer identifier that references the record in the QualityControlLevels table.';
COMMENT ON COLUMN tables.datastreams.rangemin IS 'The acceptable range minimum for the sensor. ';
COMMENT ON COLUMN tables.datastreams.rangemax IS 'The acceptable range maximum for the sensor';
COMMENT ON COLUMN tables.datastreams.annualtiming IS 'Known range';
COMMENT ON COLUMN tables.datastreams.downloaddate IS 'Date the dataset was downloaded or acquired';
COMMENT ON TABLE tables.datatypecv IS 'The DataTypeCV table contains the controlled vocabulary for data types. Only values from the Term field in this table can be used to populate the DataType field in the Variables table.';
COMMENT ON COLUMN tables.datatypecv.term IS 'Controlled vocabulary for DataType.';
COMMENT ON COLUMN tables.datatypecv.definition IS 'Definition of DataType controlled vocabulary term. The definition is optional if the term is self explanatory.';
COMMENT ON TABLE tables.derivedfrom IS 'The DerivedFrom table contains the linkage between derived data values and the data values that they were derived from.';
COMMENT ON COLUMN tables.derivedfrom.derivedfromid IS 'Integer identifying the group of data values from which a quantity is derived.';
COMMENT ON COLUMN tables.derivedfrom.valueid IS 'Integer identifier referencing data values that comprise a group from which a quantity is derived. This corresponds to ValueID in the DataValues table.';
COMMENT ON TABLE tables.groupdescriptions IS 'The GroupDescriptions table lists the descriptions for each of the groups of data values that have been formed.';
COMMENT ON COLUMN tables.groupdescriptions.groupid IS 'Unique integer identifier for each group of data values that has been formed. This also references to GroupID in the Groups table.';
COMMENT ON COLUMN tables.groupdescriptions.groupdescription IS 'Text description of the group.';
COMMENT ON TABLE tables.groups IS 'The Groups table lists the groups of data values that have been created and the data values that are within each group.';
COMMENT ON COLUMN tables.groups.groupid IS 'Integer ID for each group of data values that has been formed.';
COMMENT ON COLUMN tables.groups.valueid IS 'Integer identifier for each data value that belongs to a group. This corresponds to ValueID in the DataValues table';
COMMENT ON TABLE tables.incidents IS 'Lists natural or anthropogenic incidents, that may have affected a site, data values or an instruments ability to collect data.';
COMMENT ON COLUMN tables.incidents.incidentid IS 'Unique integer ID for each incident.';
COMMENT ON COLUMN tables.incidents.siteid IS 'Integer identifier that references the record in the Sites table.  Enter a SiteID only when incident is relevant to the site.';
COMMENT ON COLUMN tables.incidents.datastreamid IS 'Integer identifier that references the record in the Datastreams table.  Enter a DatastreamID only when the incident is relevant to a particular sensor.';
COMMENT ON COLUMN tables.incidents.starttime IS 'When incident started -- note this does not refer to the measurement start time. ';
COMMENT ON COLUMN tables.incidents.startprecision IS 'Notes on how precise recorded incident start time is.';
COMMENT ON COLUMN tables.incidents.endtime IS 'When incident ended -- note this does not necessarily refer to the measurement end time. ';
COMMENT ON COLUMN tables.incidents.endprecision IS 'Notes on how precise recorded incident start time is.';
COMMENT ON COLUMN tables.incidents.type IS 'Type of incident that affected data collection or values. ';
COMMENT ON COLUMN tables.incidents.description IS 'Detailed description of what happened (or what state equipment was found in" and what measurements may have been affected';
COMMENT ON COLUMN tables.incidents.reportedby IS 'Person who reported incident.';
COMMENT ON COLUMN tables.incidents.comments IS 'Comments on incident that are not covered elsewhere in the table. ';
COMMENT ON TABLE tables.isometadata IS 'The ISOMetadata table contains dataset and project level metadata required by the CUAHSI HIS metadata system (http://www.cuahsi.org/his/documentation.html) for compliance with standards such as the draft ISO 19115 or ISO 8601. The mandatory fields in this table must be populated to provide a complete set of ISO compliant metadata in the database.';
COMMENT ON COLUMN tables.isometadata.metadataid IS 'Unique integer ID for each metadata record.';
COMMENT ON COLUMN tables.isometadata.topiccategory IS 'Topic category keyword that gives the broad ISO19115 metadata topic category for data from this source. The controlled vocabulary of topic category keywords is given in the TopicCategoryCV table.';
COMMENT ON COLUMN tables.isometadata.title IS 'Title of data from a specific data source.';
COMMENT ON COLUMN tables.isometadata.abstract IS 'Abstract of data from a specific data source.';
COMMENT ON COLUMN tables.isometadata.profileversion IS 'Name of metadata profile used by the data source';
COMMENT ON COLUMN tables.isometadata.metadatalink IS 'Link to additional metadata reference material.';
COMMENT ON TABLE tables.methods IS 'The Methods table lists the methods used to collect the data and any additional information about the method.';
COMMENT ON COLUMN tables.methods.methodid IS 'Unique integer ID for each method.';
COMMENT ON COLUMN tables.methods.methodname IS 'Name of method used.';
COMMENT ON COLUMN tables.methods.methoddescription IS 'Description of each method.';
COMMENT ON COLUMN tables.methods.methodlink IS 'Link to additional reference material on method.';
COMMENT ON COLUMN tables.networkdescriptions.networkid IS 'Unique integer identifier that identifies a network.';
COMMENT ON COLUMN tables.networkdescriptions.networkcode IS 'Network code used by organization that collects the data.';
COMMENT ON COLUMN tables.networkdescriptions.networkdescription IS 'Full text description of the network.';
COMMENT ON TABLE tables.offsettypes IS 'The OffsetTypes table lists full descriptive information for each of the measurement offsets.';
COMMENT ON COLUMN tables.offsettypes.offsettypeid IS 'Unique integer identifier that identifies the type of measurement offset.';
COMMENT ON COLUMN tables.offsettypes.offsetunitsid IS 'Integer identifier that references the record in the Units table giving the Units of the OffsetValue.';
COMMENT ON COLUMN tables.offsettypes.offsetdescription IS 'Full text description of the offset type.';
COMMENT ON TABLE tables.organizationdescriptions IS 'Organizations, which are associated with Sources.';
COMMENT ON COLUMN tables.organizationdescriptions.organizationid IS 'Unique integer identifier that identifies an organization.';
COMMENT ON COLUMN tables.organizationdescriptions.organizationcode IS 'Organization code used by organization that collects the data.';
COMMENT ON COLUMN tables.organizationdescriptions.organizationdescription IS 'Full text description of the organization.';
COMMENT ON TABLE tables.organizations IS 'Shows associations of a data source with multiple organizations. ';
COMMENT ON COLUMN tables.organizations.organizationid IS 'Integer identifier that references the record in the OrganizationDescriptions table.';
COMMENT ON COLUMN tables.organizations.sourceid IS 'Integer identifier that references the record in the Sources table.';
COMMENT ON TABLE tables.processing IS 'The Processing table lists Qa/Qc that was done to the Sources, ISOMetadata and Sites tables.  It also lists any known data restrictions, priority of data entry and processing needs that need to be done.';
COMMENT ON COLUMN tables.processing.processingid IS 'Unique integer ID for each processing event.';
COMMENT ON COLUMN tables.processing.sourceid IS 'Integer identifier that references the record in the Sources table.';
COMMENT ON COLUMN tables.processing.siteid IS 'Integer identifier that references the record in the Sites table.';
COMMENT ON COLUMN tables.processing.metadataid IS 'Integer identifier that references the record in the ISOMetadata table.';
COMMENT ON COLUMN tables.processing.datarestrictions IS 'Any known restrictions on data ';
COMMENT ON COLUMN tables.processing.datapriority IS 'Priority level for data entry.';
COMMENT ON COLUMN tables.processing.processingneeds IS 'What needs to be done to get the data entered';
COMMENT ON COLUMN tables.processing.qaqcperson IS 'Name of database team member who has performed the QaQc on a Sources, ISOMetadata or Sites record.';
COMMENT ON COLUMN tables.processing.qaqccomments IS 'Processing comments for QaQc data.  ';
COMMENT ON COLUMN tables.processing.qaqcdate IS 'Date that QaQc was performed.';
COMMENT ON TABLE tables.qualifiers IS 'The Qualifiers table contains data qualifying comments that accompany the data.';
COMMENT ON COLUMN tables.qualifiers.qualifierid IS 'Unique integer identifying the data qualifier.';
COMMENT ON COLUMN tables.qualifiers.qualifiercode IS 'Text code used by organization that collects the data.';
COMMENT ON COLUMN tables.qualifiers.qualifierdescription IS 'Text of the data qualifying comment.';
COMMENT ON TABLE tables.qualitycontrollevels IS 'The QualityControlLevels table contains the quality control levels that are used for versioning data within the database.';
COMMENT ON COLUMN tables.qualitycontrollevels.qualitycontrollevelid IS 'Unique integer identifying the quality control level.';
COMMENT ON COLUMN tables.qualitycontrollevels.qualitycontrollevelcode IS 'Code used to identify the level of quality control to which data values have been subjected.';
COMMENT ON COLUMN tables.qualitycontrollevels.definition IS 'Definition of Quality Control Level.';
COMMENT ON COLUMN tables.qualitycontrollevels.explanation IS 'Explanation of Quality Control Level';
COMMENT ON TABLE tables.siteattributes IS 'Lists site data values that are non-numeric.';
COMMENT ON COLUMN tables.siteattributes.siteid IS 'Integer identifier that references the record in the Sites table.';
COMMENT ON COLUMN tables.siteattributes.attributeid IS 'Integer identifier that references the record in the Attributes table.';
COMMENT ON COLUMN tables.siteattributes.attributevalue IS 'The non-numeric data value';
COMMENT ON COLUMN tables.siteattributes.attributecomment IS 'Attribute comment.';
COMMENT ON TABLE tables.sites IS 'The Sites table provides information giving the spatial location at which data values have been collected.';
COMMENT ON COLUMN tables.sites.siteid IS 'Unique identifier for each sampling location.';
COMMENT ON COLUMN tables.sites.sitecode IS 'Code used by organization that collects the data to identify the site';
COMMENT ON COLUMN tables.sites.sitename IS 'Full name of the sampling site.';
COMMENT ON COLUMN tables.sites.spatialcharacteristics IS 'Indicates whether site is a point, polygon, linestring.';
COMMENT ON COLUMN tables.sites.sourceid IS 'Integer identifier that references the record in the Sources table giving the source of the data value.';
COMMENT ON COLUMN tables.sites.verticaldatum IS 'Vertical datum of the elevation. Controlled Vocabulary from V erticalDatumCV .';
COMMENT ON COLUMN tables.sites.localprojectionid IS 'Identifier that references the Spatial Reference System of the local coordinates in the SpatialReferences table. This field is required if local coordinates are given.';
COMMENT ON COLUMN tables.sites.posaccuracy_m IS 'Value giving the accuracy with which the positional information is specified in meters.';
COMMENT ON COLUMN tables.sites.state IS 'Name of state in which the monitoring site is located.';
COMMENT ON COLUMN tables.sites.county IS 'Name of county in which the monitoring site is located.';
COMMENT ON COLUMN tables.sites.comments IS 'Comments related to the site.';
COMMENT ON COLUMN tables.sites.latlongdatumid IS 'Identifier that references the Spatial Reference System of the latitude and longitude coordinates in the SpatialReferences table.';
COMMENT ON COLUMN tables.sites.geolocation IS 'Coordinates and elevation given in a specific format for points and polygons.  Latitude and Longitude should be in decimal degrees. Elevation is in meters. If elevation is not provided it can be obtained programmatically from a DEM based on location information. Point locations are stored as "Point (long lat elevation)".  The following is an example for a polygon: 
POLYGON (-146.34425083697045 69.688296227508985, -146.34308827446938 69.688355477509049,...) 
';
COMMENT ON COLUMN tables.sites.locationdescription IS 'Description of site location';
COMMENT ON COLUMN tables.sites.updated_at IS 'The timestamp that the record was last updated.';
COMMENT ON TABLE tables.sources IS 'The Sources table lists the original sources of the data, providing information sufficient to retrieve and reconstruct the data value from the original data files if necessary.';
COMMENT ON COLUMN tables.sources.sourceid IS 'Unique integer identifier that identifies each data source.';
COMMENT ON COLUMN tables.sources.organization IS 'Name of the organization that collected the data. This should be the agency or organization that collected the data, even if it came out of a database consolidated from many sources such as STORET.';
COMMENT ON COLUMN tables.sources.sourcedescription IS 'Full text description of the source of the data.';
COMMENT ON COLUMN tables.sources.sourcerole IS 'If the source is an originator or publisher of data';
COMMENT ON COLUMN tables.sources.sourcelink IS 'Link that can be pointed at the original data file and/or associated metadata stored in the digital library or URL of data source.';
COMMENT ON COLUMN tables.sources.contactname IS 'Name of the contact person for the data source.';
COMMENT ON COLUMN tables.sources.phone IS 'Phone number for the contact person.';
COMMENT ON COLUMN tables.sources.email IS 'Email address for the contact person.';
COMMENT ON COLUMN tables.sources.address IS 'Street address for the contact person.';
COMMENT ON COLUMN tables.sources.city IS 'City in which the contact person is located.';
COMMENT ON COLUMN tables.sources.state IS 'State in which the contact person is located. Use two letter abbreviations for US. For other countries give the full country name.';
COMMENT ON COLUMN tables.sources.zipcode IS 'US Zip Code or country postal code.';
COMMENT ON COLUMN tables.sources.citation IS 'Text string that give the citation to be used when the data from each source are referenced.';
COMMENT ON COLUMN tables.sources.metadataid IS 'Integer identifier referencing the record in the ISOMetadata table for this source.';
COMMENT ON COLUMN tables.sources.updated_at IS 'The timestamp the source was last updated';
COMMENT ON TABLE tables.variables IS 'The Variables table lists the full descriptive information about what variables have been measured.';
COMMENT ON COLUMN tables.variables.variableid IS 'Unique integer identifier for each variable.';
COMMENT ON COLUMN tables.variables.variablecode IS 'Text code used by the organization that collects the data to identify the variable.';
COMMENT ON COLUMN tables.variables.variablename IS 'Full text name of the variable that was measured, observed, modeled, etc. This should be from the VariableNameCV controlled vocabulary table.';
COMMENT ON COLUMN tables.variables.variabledescription IS 'A description of the variable';
COMMENT ON COLUMN tables.variables.speciation IS 'Text code used to identify how the data value is expressed (i.e., total phosphorus concentration expressed as P). This should be from the SpeciationCV controlled vocabulary table.';
COMMENT ON COLUMN tables.variables.variableunitsid IS 'Integer identifier that references the record in the Units table giving the units of the data values associated with the variable.';
COMMENT ON COLUMN tables.variables.samplemedium IS 'The medium in which the sample or observation was taken or made. This should be from the SampleMediumCV controlled vocabulary table.';
COMMENT ON COLUMN tables.variables.valuetype IS 'Text value indicating what type of data value is being recorded. This should be from the ValueTypeCV controlled vocabulary table.';
COMMENT ON COLUMN tables.variables.isregular IS 'Value that indicates whether the data values are from a regularly sampled time series.';
COMMENT ON COLUMN tables.variables.timesupport IS 'Numerical value that indicates the time support (or temporal footprint) of the data values. 0 is used to indicate data values that are instantaneous. Other values indicate the time over which the data values are implicitly or explicitly averaged or aggregated.';
COMMENT ON COLUMN tables.variables.timeunitsid IS 'Integer identifier that references the record in the Units table giving the Units of the time support. If TimeSupport is 0, indicating an instantaneous observation, a unit needs to still be given for completeness, although it is somewhat arbitrary.';
COMMENT ON COLUMN tables.variables.datatype IS 'Text value that identifies the data values as one of several types from the DataTypeCV controlled vocabulary table.';
COMMENT ON COLUMN tables.variables.generalcategory IS 'General category of the data values from the GeneralCategoryCV controlled vocabulary table.';
COMMENT ON COLUMN tables.variables.nodatavalue IS 'Numeric value used to encode no data values for this variable.';
COMMENT ON TABLE tables.datavalues IS 'The DataValues table contains the actual data values.';
COMMENT ON COLUMN tables.datavalues.valueid IS 'Unique integer identifier for each data value.';
COMMENT ON COLUMN tables.datavalues.datavalue IS 'The numeric value of the observation. For Categorical variables, a number is stored here. The Variables table has DataType as Categorical and the Categories table maps from the DataValue onto Category Description.';
COMMENT ON COLUMN tables.datavalues.valueaccuracy IS 'Numeric value that describes the measurement accuracy of the data value. If not given, it is interpreted as unknown.';
COMMENT ON COLUMN tables.datavalues.localdatetime IS 'Local date and time at which the data value was observed. Represented in an implementation specific format.';
COMMENT ON COLUMN tables.datavalues.utcoffset IS 'Offset in hours from UTC time of the corresponding LocalDateTime value.';
COMMENT ON COLUMN tables.datavalues.qualifierid IS 'Integer identifier that references the quality of the data in the Qualifiers table.';
COMMENT ON COLUMN tables.datavalues.derivedfromid IS 'Integer identifier that references the derived data in the DerivedFrom table.';
COMMENT ON COLUMN tables.datavalues.datastreamid IS 'Integer identifier that references the datastream in the Datastreams table.';
COMMENT ON COLUMN tables.datavalues.censorcode IS 'Text indication of whether the data value is censored from the CensorCodeCV controlled vocabulary.';
COMMENT ON COLUMN tables.datavalues.offsettypeid IS 'Foreign key OffsetTypes.  The reference point from which the offset to the measurement location was measured (e.g. water surface, stream bank, snow surface)';
COMMENT ON COLUMN tables.datavalues.offsetvalue IS 'Distance from a reference point to the location at which the observation was made (e.g. 5 meters below water surface)';
COMMENT ON COLUMN tables.datavalues.categoryid IS 'FK to the Category table.  This field will contain a value if there is categorical data.';
