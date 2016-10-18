-- SQL Manager for PostgreSQL 5.1.1.1
-- ---------------------------------------
-- Host      : imiqdb.gina.alaska.edu
-- Database  : iarcod
-- Version   : PostgreSQL 9.1.7 on x86_64-unknown-linux-gnu, compiled by gcc (GCC) 4.4.6 20120305 (Red Hat 4.4.6-4), 64-bit



SET search_path = tables, pg_catalog;
DROP TABLE tables.yearly_winterrhs_avg;
DROP TABLE tables.yearly_winterprecips_avg;
DROP TABLE tables.yearly_winterairtemps_avg;
DROP TABLE tables.yearly_summerrhs_avg;
DROP TABLE tables.yearly_summerprecips_avg;
DROP TABLE tables.yearly_summerdischarges_avg;
DROP TABLE tables.yearly_summerairtemps_avg;
DROP TABLE tables.yearly_springprecips_avg;
DROP TABLE tables.yearly_springairtemps_avg;
DROP TABLE tables.yearly_peakswes;
DROP TABLE tables.yearly_peaksnowdepths;
DROP TABLE tables.yearly_peakdischarges;
DROP TABLE tables.yearly_fallprecips_avg;
DROP TABLE tables.yearly_fallairtemps_avg;
DROP TABLE tables.yearly_avgwinterrhs;
DROP TABLE tables.yearly_avgwinterprecips;
DROP TABLE tables.yearly_avgwinterairtemps;
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
DROP TABLE tables.sites;
DROP TABLE tables.siteattributes;
DROP TABLE tables.seriescatalog_62;
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
DROP TABLE tables.monthly_rh;
DROP TABLE tables.methods;
DROP TABLE tables.isometadata;
DROP TABLE tables.incidents;
DROP TABLE tables.imiqversion;
DROP TABLE tables.hourly_windspeeddatavalues;
DROP TABLE tables.hourly_winddirectiondatavalues;
DROP TABLE tables.hourly_swedatavalues;
DROP TABLE tables.hourly_snowdepthdatavalues;
DROP TABLE tables.hourly_rhdatavalues;
DROP TABLE tables.hourly_precipdatavalues;
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
DROP TABLE tables.datavalues;
DROP TABLE tables.datatypecv;
DROP TABLE tables.datastreams;
DROP TABLE tables.daily_windspeeddatavalues;
DROP TABLE tables.daily_winddirectiondatavalues;
DROP TABLE tables.daily_swedatavalues;
DROP TABLE tables.daily_snowdepthdatavalues;
DROP TABLE tables.daily_rhdatavalues;
DROP TABLE tables.daily_precipdatavalues;
DROP TABLE tables.daily_dischargedatavalues;
DROP TABLE tables.daily_airtempmindatavalues;
DROP TABLE tables.daily_airtempmaxdatavalues;
DROP TABLE tables.daily_airtempdatavalues;
DROP TABLE tables.censorcodecv;
DROP TABLE tables.categories;
DROP TABLE tables.attributes;
DROP TABLE tables.annual_winterprecips;
DROP TABLE tables.annual_peakmayjunedischargedatavalues;
DROP SCHEMA tables;
CREATE SCHEMA tables AUTHORIZATION imiq;
SET check_function_bodies = false;
--
-- Structure for table annual_peakmayjunedischargedatavalues (OID = 221478) :
--
CREATE TABLE tables.annual_peakmayjunedischargedatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    year integer NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table annual_winterprecips (OID = 221497) :
--
CREATE TABLE tables.annual_winterprecips (
    siteid integer NOT NULL,
    year integer,
    seasonalvalue double precision
) WITHOUT OIDS;
--
-- Structure for table attributes (OID = 221508) :
--
CREATE TABLE tables.attributes (
    attributeid serial NOT NULL,
    attributename varchar(255) NOT NULL
) WITHOUT OIDS;
--
-- Structure for table categories (OID = 221523) :
--
CREATE TABLE tables.categories (
    categoryid serial NOT NULL,
    variableid integer NOT NULL,
    categoryname varchar(255) NOT NULL,
    categorydescription text
) WITHOUT OIDS;
--
-- Structure for table censorcodecv (OID = 221536) :
--
CREATE TABLE tables.censorcodecv (
    term varchar(50) NOT NULL,
    definition text
) WITHOUT OIDS;
--
-- Structure for table daily_airtempdatavalues (OID = 221553) :
--
CREATE TABLE tables.daily_airtempdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_airtempmaxdatavalues (OID = 221562) :
--
CREATE TABLE tables.daily_airtempmaxdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_airtempmindatavalues (OID = 221574) :
--
CREATE TABLE tables.daily_airtempmindatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_dischargedatavalues (OID = 221583) :
--
CREATE TABLE tables.daily_dischargedatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_precipdatavalues (OID = 221595) :
--
CREATE TABLE tables.daily_precipdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_rhdatavalues (OID = 221604) :
--
CREATE TABLE tables.daily_rhdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_snowdepthdatavalues (OID = 221616) :
--
CREATE TABLE tables.daily_snowdepthdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_swedatavalues (OID = 221625) :
--
CREATE TABLE tables.daily_swedatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table daily_winddirectiondatavalues (OID = 221637) :
--
CREATE TABLE tables.daily_winddirectiondatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer
) WITHOUT OIDS;
--
-- Structure for table daily_windspeeddatavalues (OID = 221646) :
--
CREATE TABLE tables.daily_windspeeddatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer
) WITHOUT OIDS;
--
-- Structure for table datastreams (OID = 221658) :
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
    startdate date,
    enddate date,
    annualtiming varchar(255),
    downloaddate date
) WITHOUT OIDS;
--
-- Structure for table datatypecv (OID = 221668) :
--
CREATE TABLE tables.datatypecv (
    term varchar(255) NOT NULL,
    definition text
) WITHOUT OIDS;
--
-- Structure for table datavalues (OID = 221691) :
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
) WITHOUT OIDS;
--
-- Structure for table datavaluesraw (OID = 221700) :
--
CREATE TABLE tables.datavaluesraw (
    valueid serial NOT NULL,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    qualifierid integer,
    datastreamid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table derivedfrom (OID = 221710) :
--
CREATE TABLE tables.derivedfrom (
    derivedfromid integer NOT NULL,
    valueid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table devices (OID = 221715) :
--
CREATE TABLE tables.devices (
    deviceid serial NOT NULL,
    devicename varchar(255) NOT NULL,
    serialnumber varchar(50),
    dateactivated date,
    datedeactivated date,
    comments text
) WITHOUT OIDS;
--
-- Structure for table ext_arc_arc (OID = 221727) :
--
CREATE TABLE tables.ext_arc_arc (
    id serial NOT NULL,
    stream_cod varchar(255),
    name varchar(255),
    source varchar(255),
    shape_leng real,
    geom public.geometry
) WITHOUT OIDS;
--
-- Structure for table ext_arc_point (OID = 221742) :
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
) WITHOUT OIDS;
--
-- Structure for table ext_fws_fishsample (OID = 221754) :
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
) WITHOUT OIDS;
--
-- Structure for table ext_reference (OID = 221769) :
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
) WITHOUT OIDS;
--
-- Structure for table ext_referencetowaterbody (OID = 221781) :
--
CREATE TABLE tables.ext_referencetowaterbody (
    id serial NOT NULL,
    namereference varchar(255),
    waterbodyid varchar(50)
) WITHOUT OIDS;
--
-- Structure for table ext_waterbody (OID = 221793) :
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
) WITHOUT OIDS;
--
-- Structure for table generalcategorycv (OID = 221806) :
--
CREATE TABLE tables.generalcategorycv (
    term varchar(255) NOT NULL,
    definition text
) WITHOUT OIDS;
--
-- Structure for table groupdescriptions (OID = 221820) :
--
CREATE TABLE tables.groupdescriptions (
    groupid serial NOT NULL,
    groupdescription text
) WITHOUT OIDS;
--
-- Structure for table groups (OID = 221827) :
--
CREATE TABLE tables.groups (
    groupid integer NOT NULL,
    valueid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table hourly_airtempdatavalues (OID = 221832) :
--
CREATE TABLE tables.hourly_airtempdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table hourly_precipdatavalues (OID = 221838) :
--
CREATE TABLE tables.hourly_precipdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table hourly_rhdatavalues (OID = 221844) :
--
CREATE TABLE tables.hourly_rhdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table hourly_snowdepthdatavalues (OID = 221850) :
--
CREATE TABLE tables.hourly_snowdepthdatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table hourly_swedatavalues (OID = 221856) :
--
CREATE TABLE tables.hourly_swedatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table hourly_winddirectiondatavalues (OID = 221862) :
--
CREATE TABLE tables.hourly_winddirectiondatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer
) WITHOUT OIDS;
--
-- Structure for table hourly_windspeeddatavalues (OID = 221868) :
--
CREATE TABLE tables.hourly_windspeeddatavalues (
    valueid serial NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer
) WITHOUT OIDS;
--
-- Structure for table imiqversion (OID = 221872) :
--
CREATE TABLE tables.imiqversion (
    versionnumber varchar(50) NOT NULL
) WITHOUT OIDS;
--
-- Structure for table incidents (OID = 221877) :
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
) WITHOUT OIDS;
--
-- Structure for table isometadata (OID = 221886) :
--
CREATE TABLE tables.isometadata (
    metadataid serial NOT NULL,
    topiccategory varchar(255) DEFAULT ''::character varying NOT NULL,
    title varchar(255) DEFAULT ''::character varying NOT NULL,
    abstract text NOT NULL,
    profileversion varchar(255) DEFAULT ''::character varying NOT NULL,
    metadatalink varchar(500)
) WITHOUT OIDS;
--
-- Structure for table methods (OID = 221898) :
--
CREATE TABLE tables.methods (
    methodid serial NOT NULL,
    methodname varchar(255) NOT NULL,
    methoddescription text NOT NULL,
    methodlink varchar(500)
) WITHOUT OIDS;
--
-- Structure for table monthly_rh (OID = 221905) :
--
CREATE TABLE tables.monthly_rh (
    siteid integer NOT NULL,
    sitename varchar(255),
    geolocation text,
    year integer,
    month integer,
    rh double precision,
    at double precision,
    total integer
) WITHOUT OIDS;
--
-- Structure for table nhd_huc8 (OID = 221913) :
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
) WITHOUT OIDS;
--
-- Structure for table offsettypes (OID = 221922) :
--
CREATE TABLE tables.offsettypes (
    offsettypeid serial NOT NULL,
    offsetunitsid integer NOT NULL,
    offsetdescription text NOT NULL
) WITHOUT OIDS;
--
-- Structure for table organizationdescriptions (OID = 221929) :
--
CREATE TABLE tables.organizationdescriptions (
    organizationid integer NOT NULL,
    organizationcode varchar(50) NOT NULL,
    organizationdescription text NOT NULL
) WITHOUT OIDS;
--
-- Structure for table organizations (OID = 221935) :
--
CREATE TABLE tables.organizations (
    organizationid integer NOT NULL,
    sourceid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table processing (OID = 221940) :
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
) WITHOUT OIDS;
--
-- Structure for table qualifiers (OID = 221949) :
--
CREATE TABLE tables.qualifiers (
    qualifierid serial NOT NULL,
    qualifiercode varchar(50),
    qualifierdescription text NOT NULL
) WITHOUT OIDS;
--
-- Structure for table qualitycontrollevels (OID = 221958) :
--
CREATE TABLE tables.qualitycontrollevels (
    qualitycontrollevelid serial NOT NULL,
    qualitycontrollevelcode varchar(50) NOT NULL,
    definition varchar(255) NOT NULL,
    explanation text NOT NULL
) WITHOUT OIDS;
--
-- Structure for table rasterdatavalues (OID = 221967) :
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
) WITHOUT OIDS;
--
-- Structure for table samplemediumcv (OID = 221974) :
--
CREATE TABLE tables.samplemediumcv (
    term varchar(255) NOT NULL,
    definition text
) WITHOUT OIDS;
--
-- Structure for table seriescatalog (OID = 221980) :
--
CREATE TABLE tables.seriescatalog (
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
    geolocation bytea,
    spatialcharacteristics varchar(50) NOT NULL,
    totalvalues integer,
    startdecade integer,
    enddecade integer,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table seriescatalog_62 (OID = 221986) :
--
CREATE TABLE tables.seriescatalog_62 (
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
    geolocation bytea,
    spatialcharacteristics varchar(50) NOT NULL,
    totalvalues integer,
    startdecade integer,
    enddecade integer,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table siteattributes (OID = 221992) :
--
CREATE TABLE tables.siteattributes (
    siteid integer NOT NULL,
    attributeid integer NOT NULL,
    attributevalue varchar(255) NOT NULL,
    attributecomment text
) WITHOUT OIDS;
--
-- Structure for table sites (OID = 222000) :
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
    locationdescription text
) WITHOUT OIDS;
--
-- Structure for table sources (OID = 222009) :
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
    metadataid integer NOT NULL
) WITHOUT OIDS;
--
-- Structure for table spatialreferences (OID = 222025) :
--
CREATE TABLE tables.spatialreferences (
    spatialreferenceid serial NOT NULL,
    srsid integer,
    srsname varchar(255) NOT NULL,
    isgeographic boolean,
    notes text
) WITHOUT OIDS;
--
-- Structure for table speciationcv (OID = 222032) :
--
CREATE TABLE tables.speciationcv (
    term varchar(255) NOT NULL,
    definition text
) WITHOUT OIDS;
--
-- Structure for table sysdiagrams (OID = 222040) :
--
CREATE TABLE tables.sysdiagrams (
    name varchar(128) NOT NULL,
    principal_id integer NOT NULL,
    diagram_id serial NOT NULL,
    version integer,
    definition bytea
) WITHOUT OIDS;
--
-- Structure for table topiccategorycv (OID = 222047) :
--
CREATE TABLE tables.topiccategorycv (
    term varchar(255) NOT NULL,
    definition text
) WITHOUT OIDS;
--
-- Structure for table units (OID = 222055) :
--
CREATE TABLE tables.units (
    unitsid serial NOT NULL,
    unitsname varchar(255) NOT NULL,
    unitstype varchar(255) NOT NULL,
    unitsabbreviation varchar(255) NOT NULL
) WITHOUT OIDS;
--
-- Structure for table valuetypecv (OID = 222062) :
--
CREATE TABLE tables.valuetypecv (
    term varchar(255) NOT NULL,
    definition text
) WITHOUT OIDS;
--
-- Structure for table variablenamecv (OID = 222068) :
--
CREATE TABLE tables.variablenamecv (
    term varchar(255) NOT NULL,
    definition text
) WITHOUT OIDS;
--
-- Structure for table variables (OID = 222076) :
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
) WITHOUT OIDS;
--
-- Structure for table verticaldatumcv (OID = 222088) :
--
CREATE TABLE tables.verticaldatumcv (
    term varchar(255) NOT NULL,
    definition text
) WITHOUT OIDS;
--
-- Structure for table yearly_avgwinterairtemps (OID = 222094) :
--
CREATE TABLE tables.yearly_avgwinterairtemps (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgwinterprecips (OID = 222097) :
--
CREATE TABLE tables.yearly_avgwinterprecips (
    siteid integer NOT NULL,
    year integer,
    monthlyavg double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_avgwinterrhs (OID = 222100) :
--
CREATE TABLE tables.yearly_avgwinterrhs (
    siteid integer NOT NULL,
    year integer,
    seasonalavgrh double precision,
    seasonalavgat double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_fallairtemps_avg (OID = 222103) :
--
CREATE TABLE tables.yearly_fallairtemps_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_fallprecips_avg (OID = 222106) :
--
CREATE TABLE tables.yearly_fallprecips_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_peakdischarges (OID = 222109) :
--
CREATE TABLE tables.yearly_peakdischarges (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_peaksnowdepths (OID = 222112) :
--
CREATE TABLE tables.yearly_peaksnowdepths (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_peakswes (OID = 222115) :
--
CREATE TABLE tables.yearly_peakswes (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
) WITHOUT OIDS;
--
-- Structure for table yearly_springairtemps_avg (OID = 222118) :
--
CREATE TABLE tables.yearly_springairtemps_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_springprecips_avg (OID = 222121) :
--
CREATE TABLE tables.yearly_springprecips_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_summerairtemps_avg (OID = 222124) :
--
CREATE TABLE tables.yearly_summerairtemps_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_summerdischarges_avg (OID = 222127) :
--
CREATE TABLE tables.yearly_summerdischarges_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_summerprecips_avg (OID = 222130) :
--
CREATE TABLE tables.yearly_summerprecips_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_summerrhs_avg (OID = 222133) :
--
CREATE TABLE tables.yearly_summerrhs_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_winterairtemps_avg (OID = 222136) :
--
CREATE TABLE tables.yearly_winterairtemps_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_winterprecips_avg (OID = 222139) :
--
CREATE TABLE tables.yearly_winterprecips_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Structure for table yearly_winterrhs_avg (OID = 222142) :
--
CREATE TABLE tables.yearly_winterrhs_avg (
    siteid integer NOT NULL,
    avg double precision,
    totalyears integer
) WITHOUT OIDS;
--
-- Comments
--
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
COMMENT ON COLUMN tables.datastreams.startdate IS 'Start date for the data';
COMMENT ON COLUMN tables.datastreams.enddate IS 'Last known date for the data.  If ongoing, enter in 12-31-9999.';
COMMENT ON COLUMN tables.datastreams.annualtiming IS 'Known range';
COMMENT ON COLUMN tables.datastreams.downloaddate IS 'Date the dataset was downloaded or acquired';
COMMENT ON TABLE tables.datatypecv IS 'The DataTypeCV table contains the controlled vocabulary for data types. Only values from the Term field in this table can be used to populate the DataType field in the Variables table.';
COMMENT ON COLUMN tables.datatypecv.term IS 'Controlled vocabulary for DataType.';
COMMENT ON COLUMN tables.datatypecv.definition IS 'Definition of DataType controlled vocabulary term. The definition is optional if the term is self explanatory.';
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
