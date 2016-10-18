/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     11/15/2012 1:08:22 PM                        */
/*==============================================================*/


drop table PUBLIC.Categories;

drop table PUBLIC.CensorCodeCV;

drop table PUBLIC.DataTypeCV;

drop table PUBLIC.DataValues;

drop table PUBLIC.DerivedFrom;

drop table PUBLIC.GeneralCategoryCV;

drop table PUBLIC.GroupDescriptions;

drop table PUBLIC.Groups;

drop table PUBLIC.ISOMetadata;

drop table PUBLIC.LabMethods;

drop table PUBLIC.Methods;

drop table PUBLIC.ODMVersion;

drop table PUBLIC.OffsetTypes;

drop table PUBLIC.Qualifiers;

drop table PUBLIC.QualityControlLevels;

drop table PUBLIC.SampleMediumCV;

drop table PUBLIC.SampleTypeCV;

drop table PUBLIC.Samples;

drop table PUBLIC.SeriesCatalog;

drop table PUBLIC.Sites;

drop table PUBLIC.Sources;

drop table PUBLIC.SpatialReferences;

drop table PUBLIC.SpeciationCV;

drop table PUBLIC.TopicCategoryCV;

drop table PUBLIC.Units;

drop table PUBLIC.ValueTypeCV;

drop table PUBLIC.VariableNameCV;

drop table PUBLIC.Variables;

drop table PUBLIC.VerticalDatumCV;

/*==============================================================*/
/* User: PUBLIC                                                 */
/*==============================================================*/
/*==============================================================*/
/* Table: Categories                                            */
/*==============================================================*/
create table PUBLIC.Categories (
   VariableID           INT                  not null,
   DataValue            DOUBLE               not null,
   CategoryDescription  TEXT                 not null
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: CensorCodeCV                                          */
/*==============================================================*/
create table PUBLIC.CensorCodeCV (
   Term                 VARCHAR(50)          not null,
   Definition           TEXT                 null,
   constraint PK_CENSORCODECV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: DataTypeCV                                            */
/*==============================================================*/
create table PUBLIC.DataTypeCV (
   Term                 VARCHAR(255)         not null,
   Definition           TEXT                 null,
   constraint PK_DATATYPECV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: DataValues                                            */
/*==============================================================*/
create table PUBLIC.DataValues (
   ValueID              INT                  not null,
   DataValue            DOUBLE               not null,
   ValueAccuracy        DOUBLE               null default NULL,
   LocalDateTime        DATETIME             not null,
   UTCOffset            DOUBLE               not null,
   DateTimeUTC          DATETIME             not null,
   SiteID               INT                  not null,
   VariableID           INT                  not null,
   OffsetValue          DOUBLE               null default NULL,
   OffsetTypeID         INT                  null default NULL,
   CensorCode           VARCHAR(50)          not null default 'nc',
   QualifierID          INT                  null default NULL,
   MethodID             INT                  not null default '0',
   SourceID             INT                  not null,
   SampleID             INT                  null default NULL,
   DerivedFromID        INT                  null default NULL,
   QualityControlLevelID INT                  not null default '0',
   "UNIQUE"             KEY `DataValues_UNIQUE_DataValues` (`DataValue` ASC,`ValueAccuracy` ASC,`LocalDateTime` ASC,`UTCOffset` ASC,`DateTimeUTC` ASC,`SiteID` ASC,`VariableID` ASC,`OffsetValue` ASC,`OffsetTypeID` ASC,`CensorCode`(50) ASC,`QualifierID` ASC,`MethodID` ASC,`Source null,
   constraint PK_DATAVALUES primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: DerivedFrom                                           */
/*==============================================================*/
create table PUBLIC.DerivedFrom (
   DerivedFromID        INT                  not null,
   ValueID              INT                  not null
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: GeneralCategoryCV                                     */
/*==============================================================*/
create table PUBLIC.GeneralCategoryCV (
   Term                 VARCHAR(255)         not null,
   Definition           TEXT                 null,
   constraint PK_GENERALCATEGORYCV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: GroupDescriptions                                     */
/*==============================================================*/
create table PUBLIC.GroupDescriptions (
   GroupID              INT                  not null,
   GroupDescription     TEXT                 null,
   constraint PK_GROUPDESCRIPTIONS primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: Groups                                                */
/*==============================================================*/
create table PUBLIC.Groups (
   GroupID              INT                  not null,
   ValueID              INT                  not null
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: ISOMetadata                                           */
/*==============================================================*/
create table PUBLIC.ISOMetadata (
   MetadataID           INT                  not null,
   TopicCategory        VARCHAR(255)         not null default 'Unknown',
   Title                VARCHAR(255)         not null default 'Unknown',
   Abstract             TEXT                 not null,
   ProfileVersion       VARCHAR(255)         not null default 'Unknown',
   MetadataLink         TEXT                 null,
   constraint PK_ISOMETADATA primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: LabMethods                                            */
/*==============================================================*/
create table PUBLIC.LabMethods (
   LabMethodID          INT                  not null,
   LabName              VARCHAR(255)         not null default 'Unknown',
   LabOrganization      VARCHAR(255)         not null default 'Unknown',
   LabMethodName        VARCHAR(255)         not null default 'Unknown',
   LabMethodDescription TEXT                 not null,
   LabMethodLink        TEXT                 null,
   constraint PK_LABMETHODS primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: Methods                                               */
/*==============================================================*/
create table PUBLIC.Methods (
   MethodID             INT                  not null,
   MethodDescription    TEXT                 not null,
   MethodLink           TEXT                 null,
   constraint PK_METHODS primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: ODMVersion                                            */
/*==============================================================*/
create table PUBLIC.ODMVersion (
   VersionNumber        VARCHAR(50)          not null
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: OffsetTypes                                           */
/*==============================================================*/
create table PUBLIC.OffsetTypes (
   OffsetTypeID         INT                  not null,
   OffsetUnitsID        INT                  not null,
   OffsetDescription    TEXT                 not null,
   constraint PK_OFFSETTYPES primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: Qualifiers                                            */
/*==============================================================*/
create table PUBLIC.Qualifiers (
   QualifierID          INT                  not null,
   QualifierCode        VARCHAR(50)          null default NULL,
   QualifierDescription TEXT                 not null,
   constraint PK_QUALIFIERS primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: QualityControlLevels                                  */
/*==============================================================*/
create table PUBLIC.QualityControlLevels (
   QualityControlLevelID INT                  not null,
   QualityControlLevelCode VARCHAR(50)          not null,
   Definition           VARCHAR(255)         not null,
   Explanation          TEXT                 not null,
   constraint PK_QUALITYCONTROLLEVELS primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: SampleMediumCV                                        */
/*==============================================================*/
create table PUBLIC.SampleMediumCV (
   Term                 VARCHAR(255)         not null,
   Definition           TEXT                 null,
   constraint PK_SAMPLEMEDIUMCV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: SampleTypeCV                                          */
/*==============================================================*/
create table PUBLIC.SampleTypeCV (
   Term                 VARCHAR(255)         not null,
   Definition           TEXT                 null,
   constraint PK_SAMPLETYPECV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: Samples                                               */
/*==============================================================*/
create table PUBLIC.Samples (
   SampleID             INT                  not null,
   SampleType           VARCHAR(255)         not null default 'Unknown',
   LabSampleCode        VARCHAR(50)          not null,
   LabMethodID          INT                  not null default '0',
   constraint PK_SAMPLES primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: SeriesCatalog                                         */
/*==============================================================*/
create table PUBLIC.SeriesCatalog (
   SeriesID             INT                  not null,
   SiteID               INT                  null default NULL,
   SiteCode             VARCHAR(50)          null default NULL,
   SiteName             VARCHAR(255)         null default NULL,
   VariableID           INT                  null default NULL,
   VariableCode         VARCHAR(50)          null default NULL,
   VariableName         VARCHAR(255)         null default NULL,
   Speciation           VARCHAR(255)         null default NULL,
   VariableUnitsID      INT                  null default NULL,
   VariableUnitsName    VARCHAR(255)         null default NULL,
   SampleMedium         VARCHAR(255)         null default NULL,
   ValueType            VARCHAR(255)         null default NULL,
   TimeSupport          DOUBLE               null default NULL,
   TimeUnitsID          INT                  null default NULL,
   TimeUnitsName        VARCHAR(255)         null default NULL,
   DataType             VARCHAR(255)         null default NULL,
   GeneralCategory      VARCHAR(255)         null default NULL,
   MethodID             INT                  null default NULL,
   MethodDescription    TEXT                 null,
   SourceID             INT                  null default NULL,
   Organization         VARCHAR(255)         null default NULL,
   SourceDescription    TEXT                 null,
   Citation             TEXT                 null,
   QualityControlLevelID INT                  null default NULL,
   QualityControlLevelCode VARCHAR(50)          null default NULL,
   BeginDateTime        DATETIME             null default NULL,
   EndDateTime          DATETIME             null default NULL,
   BeginDateTimeUTC     DATETIME             null default NULL,
   EndDateTimeUTC       DATETIME             null default NULL,
   ValueCount           INT                  null default NULL,
   constraint PK_SERIESCATALOG primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: Sites                                                 */
/*==============================================================*/
create table PUBLIC.Sites (
   SiteID               INT                  not null,
   SiteCode             VARCHAR(50)          not null,
   SiteName             VARCHAR(255)         not null,
   Latitude             DOUBLE               not null,
   Longitude            DOUBLE               not null,
   LatLongDatumID       INT                  not null default '0',
   Elevation_m          DOUBLE               null default NULL,
   VerticalDatum        VARCHAR(255)         null default NULL,
   LocalX               DOUBLE               null default NULL,
   LocalY               DOUBLE               null default NULL,
   LocalProjectionID    INT                  null default NULL,
   PosAccuracy_m        DOUBLE               null default NULL,
   State                VARCHAR(255)         null default NULL,
   County               VARCHAR(255)         null default NULL,
   Comments             TEXT                 null,
   "UNIQUE"             KEY `AK_Sites_SiteCode` (`SiteCode`(50) ASC) null,
   constraint PK_SITES primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: Sources                                               */
/*==============================================================*/
create table PUBLIC.Sources (
   SourceID             INT                  not null,
   Organization         VARCHAR(255)         not null,
   SourceDescription    TEXT                 not null,
   SourceLink           TEXT                 null,
   ContactName          VARCHAR(255)         not null default 'Unknown',
   Phone                VARCHAR(255)         not null default 'Unknown',
   Email                VARCHAR(255)         not null default 'Unknown',
   Address              VARCHAR(255)         not null default 'Unknown',
   City                 VARCHAR(255)         not null default 'Unknown',
   State                VARCHAR(255)         not null default 'Unknown',
   ZipCode              VARCHAR(255)         not null default 'Unknown',
   Citation             TEXT                 not null,
   MetadataID           INT                  not null default '0',
   constraint PK_SOURCES primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: SpatialReferences                                     */
/*==============================================================*/
create table PUBLIC.SpatialReferences (
   SpatialReferenceID   INT                  not null,
   SRSID                INT                  null default NULL,
   SRSName              VARCHAR(255)         not null,
   IsGeographic         BOOL                 null default NULL,
   Notes                TEXT                 null,
   constraint PK_SPATIALREFERENCES primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: SpeciationCV                                          */
/*==============================================================*/
create table PUBLIC.SpeciationCV (
   Term                 VARCHAR(255)         not null,
   Definition           TEXT                 null,
   constraint PK_SPECIATIONCV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: TopicCategoryCV                                       */
/*==============================================================*/
create table PUBLIC.TopicCategoryCV (
   Term                 VARCHAR(255)         not null,
   Definition           TEXT                 null,
   constraint PK_TOPICCATEGORYCV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: Units                                                 */
/*==============================================================*/
create table PUBLIC.Units (
   UnitsID              INT                  not null,
   UnitsName            VARCHAR(255)         not null,
   UnitsType            VARCHAR(255)         not null,
   UnitsAbbreviation    VARCHAR(255)         not null,
   constraint PK_UNITS primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: ValueTypeCV                                           */
/*==============================================================*/
create table PUBLIC.ValueTypeCV (
   Term                 VARCHAR(255)         not null,
   Definition           TEXT                 null,
   constraint PK_VALUETYPECV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: VariableNameCV                                        */
/*==============================================================*/
create table PUBLIC.VariableNameCV (
   Term                 VARCHAR(255)         not null,
   Definition           TEXT                 null,
   constraint PK_VARIABLENAMECV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: Variables                                             */
/*==============================================================*/
create table PUBLIC.Variables (
   VariableID           INT                  not null,
   VariableCode         VARCHAR(50)          not null,
   VariableName         VARCHAR(255)         not null,
   Speciation           VARCHAR(255)         not null default 'Not Applicable',
   VariableUnitsID      INT                  not null,
   SampleMedium         VARCHAR(255)         not null default 'Unknown',
   ValueType            VARCHAR(255)         not null default 'Unknown',
   IsRegular            BOOL                 not null default 0,
   TimeSupport          DOUBLE               not null default '0',
   TimeUnitsID          INT                  not null default '0',
   DataType             VARCHAR(255)         not null default 'Unknown',
   GeneralCategory      VARCHAR(255)         not null default 'Unknown',
   NoDataValue          DOUBLE               not null default '0',
   "UNIQUE"             KEY `AK_Variables_VariableCode` (`VariableCode`(50) ASC) null,
   constraint PK_VARIABLES primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

/*==============================================================*/
/* Table: VerticalDatumCV                                       */
/*==============================================================*/
create table PUBLIC.VerticalDatumCV (
   Term                 VARCHAR(255)         not null,
   Definition           TEXT                 null,
   constraint PK_VERTICALDATUMCV primary key ()
)
DEFAULT CHARSET=utf8 ENGINE=InnoDB;

