-- SQL Manager for PostgreSQL 5.1.1.1
-- ---------------------------------------
-- Host      : imiqdb.gina.alaska.edu
-- Database  : iarcod
-- Version   : PostgreSQL 9.1.7 on x86_64-unknown-linux-gnu, compiled by gcc (GCC) 4.4.6 20120305 (Red Hat 4.4.6-4), 64-bit



SET search_path = views, pg_catalog;
DROP TABLE views.yearly_avgwinterrh;
DROP TABLE views.yearly_avgwinterprecip;
DROP TABLE views.yearly_avgwinterairtemp;
DROP TABLE views.yearly_avgsummerrhs;
DROP TABLE views.yearly_avgsummerrh;
DROP TABLE views.yearly_avgsummerprecips;
DROP TABLE views.yearly_avgsummerprecip;
DROP TABLE views.yearly_avgsummerdischarges;
DROP TABLE views.yearly_avgsummerdischarge;
DROP TABLE views.yearly_avgsummerairtemps;
DROP TABLE views.yearly_avgsummerairtemp;
DROP TABLE views.yearly_avgspringprecips;
DROP TABLE views.yearly_avgspringprecip;
DROP TABLE views.yearly_avgspringairtemps;
DROP TABLE views.yearly_avgspringairtemp;
DROP TABLE views.yearly_avgpeakswes;
DROP TABLE views.yearly_avgpeakswe;
DROP TABLE views.yearly_avgpeaksnowdepths;
DROP TABLE views.yearly_avgpeaksnowdepth;
DROP TABLE views.yearly_avgpeakdischarges;
DROP TABLE views.yearly_avgpeakdischarge;
DROP TABLE views.yearly_avgfallprecips;
DROP TABLE views.yearly_avgfallprecip;
DROP TABLE views.yearly_avgfallairtemps;
DROP TABLE views.yearly_avgfallairtemp;
DROP TABLE views.ws_totalyears;
DROP TABLE views.wd_totalyears;
DROP TABLE views.swe_totalyears;
DROP TABLE views.snowdepth_totalyears;
DROP TABLE views.sitesourcedescription;
DROP TABLE views.sitesource;
DROP TABLE views.sitegeography;
DROP TABLE views.siteattributesource;
DROP TABLE views.rh_totalyears;
DROP TABLE views.queryme;
DROP TABLE views.precip_totalyears;
DROP TABLE views.odmdatavalues_metric;
DROP TABLE views.odmdatavalues;
DROP TABLE views.monthly_snowdepth;
DROP TABLE views.monthly_precip;
DROP TABLE views.monthly_discharge;
DROP TABLE views.monthly_airtemp;
DROP TABLE views.hourly_windspeed;
DROP TABLE views.hourly_winddirection;
DROP TABLE views.hourly_utcdatetime;
DROP TABLE views.hourly_swe;
DROP TABLE views.hourly_snowdepth;
DROP TABLE views.hourly_rh;
DROP TABLE views.hourly_precip;
DROP TABLE views.hourly_airtemp;
DROP TABLE views.discharge_totalyears;
DROP TABLE views.datavaluesaggregate;
DROP TABLE views.datastreamvariables;
DROP TABLE views.daily_windspeed;
DROP TABLE views.daily_winddirection;
DROP TABLE views.daily_utcdatetime;
DROP TABLE views.daily_swe;
DROP TABLE views.daily_snowdepth;
DROP TABLE views.daily_rh;
DROP TABLE views.daily_precip;
DROP TABLE views.daily_discharge;
DROP TABLE views.daily_airtempmin;
DROP TABLE views.daily_airtempmax;
DROP TABLE views.daily_airtemp;
DROP TABLE views.currentsites;
DROP TABLE views.catalog;
DROP TABLE views.boundarycatalog_62;
DROP TABLE views.boundarycatalog;
DROP TABLE views.annual_avgwinterprecip_yearcount;
DROP TABLE views.annual_avgsummerprecips;
DROP TABLE views.annual_avgsummerprecip_yearcount;
DROP TABLE views.annual_avgpeakmayjunedischarge_yearcount;
DROP TABLE views.airtemp_totalyears;
DROP SCHEMA views;
CREATE SCHEMA views AUTHORIZATION imiq;
SET check_function_bodies = false;
--
-- Structure for table airtemp_totalyears (OID = 221260) :
--
CREATE TABLE views.airtemp_totalyears (
    siteid integer NOT NULL,
    sitename varchar(255),
    totyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table annual_avgpeakmayjunedischarge_yearcount (OID = 221263) :
--
CREATE TABLE views.annual_avgpeakmayjunedischarge_yearcount (
    siteid integer NOT NULL,
    sitename varchar(255),
    avgpeakdischarge double precision,
    totalyears integer,
    elevation double precision,
    geolocation bytea
) WITHOUT OIDS;
--
-- Structure for table annual_avgsummerprecip_yearcount (OID = 221269) :
--
CREATE TABLE views.annual_avgsummerprecip_yearcount (
    siteid integer NOT NULL,
    sitename varchar(255),
    annualavg double precision,
    totalyears integer,
    elevation double precision,
    geolocation bytea
) WITHOUT OIDS;
--
-- Structure for table annual_avgsummerprecips (OID = 221275) :
--
CREATE TABLE views.annual_avgsummerprecips (
    siteid integer NOT NULL,
    sitename varchar(255),
    year integer,
    seasonalavg double precision
) WITHOUT OIDS;
--
-- Structure for table annual_avgwinterprecip_yearcount (OID = 221278) :
--
CREATE TABLE views.annual_avgwinterprecip_yearcount (
    siteid integer NOT NULL,
    sitename varchar(255),
    annualavg double precision,
    totalyears integer,
    elevation double precision,
    geolocation bytea
) WITHOUT OIDS;
--
-- Structure for table boundarycatalog (OID = 221284) :
--
CREATE TABLE views.boundarycatalog (
    datastreamid integer NOT NULL,
    datastreamname varchar(255) NOT NULL,
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
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
    geolocation bytea,
    spatialcharacteristics varchar(50) NOT NULL,
    totalvalues integer
) WITHOUT OIDS;
--
-- Structure for table boundarycatalog_62 (OID = 221290) :
--
CREATE TABLE views.boundarycatalog_62 (
    datastreamid integer NOT NULL,
    datastreamname varchar(255) NOT NULL,
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
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
    geolocation bytea,
    spatialcharacteristics varchar(50) NOT NULL,
    totalvalues integer
) WITHOUT OIDS;
--
-- Structure for table catalog (OID = 221296) :
--
CREATE TABLE views.catalog (
    datastreamid integer NOT NULL,
    datastreamname varchar(255) NOT NULL,
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
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
    geographylocation bytea,
    spatialcharacteristics varchar(50) NOT NULL,
    totalvalues integer
) WITHOUT OIDS;
--
-- Structure for table currentsites (OID = 221302) :
--
CREATE TABLE views.currentsites (
    siteid integer NOT NULL,
    sitename varchar(255),
    organization varchar(255) NOT NULL,
    sourceid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_airtemp (OID = 221308) :
--
CREATE TABLE views.daily_airtemp (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table daily_airtempmax (OID = 221314) :
--
CREATE TABLE views.daily_airtempmax (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table daily_airtempmin (OID = 221320) :
--
CREATE TABLE views.daily_airtempmin (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table daily_discharge (OID = 221326) :
--
CREATE TABLE views.daily_discharge (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table daily_precip (OID = 221332) :
--
CREATE TABLE views.daily_precip (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table daily_rh (OID = 221338) :
--
CREATE TABLE views.daily_rh (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table daily_snowdepth (OID = 221344) :
--
CREATE TABLE views.daily_snowdepth (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table daily_swe (OID = 221350) :
--
CREATE TABLE views.daily_swe (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table daily_utcdatetime (OID = 221356) :
--
CREATE TABLE views.daily_utcdatetime (
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_winddirection (OID = 221359) :
--
CREATE TABLE views.daily_winddirection (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table daily_windspeed (OID = 221365) :
--
CREATE TABLE views.daily_windspeed (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table datastreamvariables (OID = 221371) :
--
CREATE TABLE views.datastreamvariables (
    datastreamname varchar(255) NOT NULL,
    siteid integer NOT NULL,
    startdate date,
    enddate date,
    fieldname varchar(50),
    variablename varchar(255) NOT NULL,
    variabledescription text
) WITHOUT OIDS;
--
-- Structure for table datavaluesaggregate (OID = 221377) :
--
CREATE TABLE views.datavaluesaggregate (
    datastreamid integer NOT NULL,
    begindatetime varchar(100),
    enddatetime varchar(100),
    begindatetimeutc varchar(100),
    enddatetimeutc varchar(100),
    totalvalues integer
) WITHOUT OIDS;
--
-- Structure for table discharge_totalyears (OID = 221380) :
--
CREATE TABLE views.discharge_totalyears (
    siteid integer NOT NULL,
    sitename varchar(255),
    totyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table hourly_airtemp (OID = 221383) :
--
CREATE TABLE views.hourly_airtemp (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table hourly_precip (OID = 221389) :
--
CREATE TABLE views.hourly_precip (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table hourly_rh (OID = 221395) :
--
CREATE TABLE views.hourly_rh (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table hourly_snowdepth (OID = 221401) :
--
CREATE TABLE views.hourly_snowdepth (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table hourly_swe (OID = 221407) :
--
CREATE TABLE views.hourly_swe (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table hourly_utcdatetime (OID = 221413) :
--
CREATE TABLE views.hourly_utcdatetime (
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone NOT NULL
) WITHOUT OIDS;
--
-- Structure for table hourly_winddirection (OID = 221416) :
--
CREATE TABLE views.hourly_winddirection (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table hourly_windspeed (OID = 221422) :
--
CREATE TABLE views.hourly_windspeed (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    sourceid integer NOT NULL,
    geographylocation bytea
) WITHOUT OIDS;
--
-- Structure for table monthly_airtemp (OID = 221428) :
--
CREATE TABLE views.monthly_airtemp (
    siteid integer NOT NULL,
    sitename varchar(255),
    geographylocation bytea,
    year integer,
    month integer,
    monthlyavg double precision,
    total integer
) WITHOUT OIDS;
--
-- Structure for table monthly_discharge (OID = 221434) :
--
CREATE TABLE views.monthly_discharge (
    siteid integer NOT NULL,
    sitename varchar(255),
    geographylocation bytea,
    year integer,
    month integer,
    monthlyavg double precision,
    total integer
) WITHOUT OIDS;
--
-- Structure for table monthly_precip (OID = 221440) :
--
CREATE TABLE views.monthly_precip (
    siteid integer NOT NULL,
    sitename varchar(255),
    geographylocation bytea,
    year integer,
    month integer,
    monthlytotal double precision,
    total integer
) WITHOUT OIDS;
--
-- Structure for table monthly_snowdepth (OID = 221446) :
--
CREATE TABLE views.monthly_snowdepth (
    siteid integer NOT NULL,
    sitename varchar(255),
    geographylocation bytea,
    year integer,
    month integer,
    monthlyavg double precision,
    total integer
) WITHOUT OIDS;
--
-- Structure for table odmdatavalues (OID = 221452) :
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
    geographylocation bytea,
    spatialcharacteristics varchar(50) NOT NULL
) WITHOUT OIDS;
--
-- Structure for table odmdatavalues_metric (OID = 221458) :
--
CREATE TABLE views.odmdatavalues_metric (
    valueid integer NOT NULL,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    datetimeutc timestamp without time zone,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variablename varchar(255) NOT NULL,
    samplemedium varchar(255) NOT NULL,
    variableunitsid integer NOT NULL,
    variabletimeunits integer NOT NULL,
    offsetvalue double precision,
    offsettypeid integer,
    censorcode varchar(50),
    qualifierid integer,
    methodid integer NOT NULL,
    sourceid integer NOT NULL,
    derivedfromid integer,
    qualitycontrollevelid integer,
    geographylocation bytea,
    geolocation text,
    spatialcharacteristics varchar(50) NOT NULL
) WITHOUT OIDS;
--
-- Structure for table precip_totalyears (OID = 221464) :
--
CREATE TABLE views.precip_totalyears (
    siteid integer NOT NULL,
    sitename varchar(255),
    totyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table queryme (OID = 221467) :
--
CREATE TABLE views.queryme (
    siteid integer NOT NULL,
    sitename varchar(255),
    variablename varchar(255) NOT NULL,
    variabledescription text,
    samplemedium varchar(255) NOT NULL,
    organization varchar(255) NOT NULL,
    organizationdescription text NOT NULL,
    startdate varchar(100),
    enddate varchar(100),
    citation text NOT NULL
) WITHOUT OIDS;
--
-- Structure for table rh_totalyears (OID = 221473) :
--
CREATE TABLE views.rh_totalyears (
    siteid integer NOT NULL,
    sitename varchar(255),
    totyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table siteattributesource (OID = 221481) :
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
) WITHOUT OIDS;
--
-- Structure for table sitegeography (OID = 221490) :
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
) WITHOUT OIDS;
--
-- Structure for table sitesource (OID = 221500) :
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
) WITHOUT OIDS;
--
-- Structure for table sitesourcedescription (OID = 221512) :
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
) WITHOUT OIDS;
--
-- Structure for table snowdepth_totalyears (OID = 221518) :
--
CREATE TABLE views.snowdepth_totalyears (
    siteid integer NOT NULL,
    sitename varchar(255),
    totyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table swe_totalyears (OID = 221530) :
--
CREATE TABLE views.swe_totalyears (
    siteid integer NOT NULL,
    sitename varchar(255),
    totyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table wd_totalyears (OID = 221533) :
--
CREATE TABLE views.wd_totalyears (
    siteid integer NOT NULL,
    sitename varchar(255),
    totyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table ws_totalyears (OID = 221542) :
--
CREATE TABLE views.ws_totalyears (
    siteid integer NOT NULL,
    sitename varchar(255),
    totyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgfallairtemp (OID = 221545) :
--
CREATE TABLE views.yearly_avgfallairtemp (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgfallairtemps (OID = 221557) :
--
CREATE TABLE views.yearly_avgfallairtemps (
    siteid integer NOT NULL,
    sitename varchar(255),
    year integer,
    seasonalavg double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgfallprecip (OID = 221566) :
--
CREATE TABLE views.yearly_avgfallprecip (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgfallprecips (OID = 221580) :
--
CREATE TABLE views.yearly_avgfallprecips (
    siteid integer NOT NULL,
    sitename varchar(255),
    year integer,
    monthlyavg double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgpeakdischarge (OID = 221587) :
--
CREATE TABLE views.yearly_avgpeakdischarge (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgpeakdischarges (OID = 221599) :
--
CREATE TABLE views.yearly_avgpeakdischarges (
    siteid integer NOT NULL,
    sitename varchar(255),
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_avgpeaksnowdepth (OID = 221608) :
--
CREATE TABLE views.yearly_avgpeaksnowdepth (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgpeaksnowdepths (OID = 221620) :
--
CREATE TABLE views.yearly_avgpeaksnowdepths (
    siteid integer NOT NULL,
    sitename varchar(255),
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_avgpeakswe (OID = 221629) :
--
CREATE TABLE views.yearly_avgpeakswe (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgpeakswes (OID = 221641) :
--
CREATE TABLE views.yearly_avgpeakswes (
    siteid integer NOT NULL,
    sitename varchar(255),
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_avgspringairtemp (OID = 221650) :
--
CREATE TABLE views.yearly_avgspringairtemp (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgspringairtemps (OID = 221665) :
--
CREATE TABLE views.yearly_avgspringairtemps (
    siteid integer NOT NULL,
    sitename varchar(255),
    year integer,
    seasonalavg double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgspringprecip (OID = 221674) :
--
CREATE TABLE views.yearly_avgspringprecip (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgspringprecips (OID = 221680) :
--
CREATE TABLE views.yearly_avgspringprecips (
    siteid integer NOT NULL,
    sitename varchar(255),
    year integer,
    monthlyavg double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgsummerairtemp (OID = 221683) :
--
CREATE TABLE views.yearly_avgsummerairtemp (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgsummerairtemps (OID = 221695) :
--
CREATE TABLE views.yearly_avgsummerairtemps (
    siteid integer NOT NULL,
    sitename varchar(255),
    year integer,
    seasonalavg double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgsummerdischarge (OID = 221704) :
--
CREATE TABLE views.yearly_avgsummerdischarge (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgsummerdischarges (OID = 221722) :
--
CREATE TABLE views.yearly_avgsummerdischarges (
    siteid integer NOT NULL,
    sitename varchar(255),
    year integer,
    seasonalavg double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgsummerprecip (OID = 221734) :
--
CREATE TABLE views.yearly_avgsummerprecip (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgsummerprecips (OID = 221749) :
--
CREATE TABLE views.yearly_avgsummerprecips (
    siteid integer NOT NULL,
    sitename varchar(255),
    year integer,
    monthlyavg double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgsummerrh (OID = 221761) :
--
CREATE TABLE views.yearly_avgsummerrh (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgsummerrhs (OID = 221776) :
--
CREATE TABLE views.yearly_avgsummerrhs (
    siteid integer NOT NULL,
    year integer,
    seasonalavgrh double precision,
    seasonalavgat double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgwinterairtemp (OID = 221785) :
--
CREATE TABLE views.yearly_avgwinterairtemp (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgwinterprecip (OID = 221800) :
--
CREATE TABLE views.yearly_avgwinterprecip (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgwinterrh (OID = 221812) :
--
CREATE TABLE views.yearly_avgwinterrh (
    siteid integer NOT NULL,
    sitecode varchar(50) NOT NULL,
    sitename varchar(255),
    sourceid integer NOT NULL,
    organization varchar(255) NOT NULL,
    avg double precision,
    totalyears integer,
    latitude double precision,
    longitude double precision,
    elevation double precision
) WITHOUT OIDS;
