USE [IARCOD]
GO

/****** Object:  View [dbo].[ODMDataValues_metric]    Script Date: 09/04/2014 11:08:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE view [dbo].[ODMDataValues_metric] as
select 
v.valueid as ValueID, 
v.datavalue as DataValue, 
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
va.VariableUnitsID as VariableUnitsID,
va.TimeUnitsID as VariableTimeUnits,
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation,  
s.GeoLocation as GeoLocation,
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* insert all metric variables and variables that do not need to be converted */
where va.VariableUnitsID in 
(1, /*percent */
2,  /* degree */
33,  /* watts per square meter */
36,  /* cubic meters per second */
39,   /* liters per second */
47,    /* centimeter   */
52,     /* meter  */
54,     /* millimeter */
80,      /* watt  */
86,      /* millimeter of mercury */
90,     /* millibar */
96,  /* DegC */
116,     /* kilometers per hour */
119,      /* meters per second */
121,   /* millimeters per hour */
137,     /* dimensionless */
143,      /* micromoles of photons per square meter per second */
168,      /* volts */
170,     /* kilopascal */
181,     /* picocuries per milliliter */
188,     /* milliliter  */
192,     /* microsiemens per centimeter */
198,     /* grams per cubic centimeter */
199,     /* milligrams per liter */
205,
221,
254,
258,
304,
309,
310,
331,
332,
333,
335,
336)
/* Degrees F to Degrees C*/
UNION ALL
select 
v.valueid as ValueID, 
(v.datavalue-32)*(.555555556) as DataValue, /*  DataValue: degF to degC   .555555556 is 5/9 */
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
96 as VariableUnitsID, /*update units to 96 */
va.TimeUnitsID as VariableTimeUnits,
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation, 
s.GeoLocation as GeoLocation, 
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* grab all degF for AIR TEMP, DEW POINT TEMP, SOILS, SNOW,INSTRUMENT */
where VariableUnitsID=97
/* PRECIPITATION, SNOW WATER EQUIVALENT and SNOWFALL: INCHES to MM */
UNION ALL
select 
v.valueid as ValueID, 
v.datavalue*25.4 as DataValue, /* DataValue * 25.4 = DataValue mm */
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
54 as VariableUnitsID, /* update new units to mm, UnitsID=54 */
va.TimeUnitsID as VariableTimeUnits, 
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation,  
s.GeoLocation as GeoLocation,
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* PRECIPITATION, SNOW WATER EQUIVALENT AND SNOWFALL: grab all inches and convert to mm*/
where VariableUnitsID=49 and (VariableName like '%precipitation%' or VariableName like '%snow water equivalent%'or VariableName like '%snowfall%')
/* SNOW DEPTH:INCHES to METERS */
UNION ALL
select 
v.valueid as ValueID, 
v.datavalue*0.0254 as DataValue, /* DataValue * 0.0245 = DataValue meters*/
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
52 as VariableUnitsID, /* update new units to m, UnitsID=52 */
va.TimeUnitsID as VariableTimeUnits,
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation,  
s.GeoLocation as GeoLocation,
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* SNOW DEPTH: grab all inches and convert to meters*/
where VariableUnitsID=49 and VariableName like '%snow depth%'
/* DISCHARGE:cfs to m3/s */
UNION ALL
select 
v.valueid as ValueID, 
v.datavalue*0.02832 as DataValue, /* DataValue * 0.02832 = DataValue m3/s */
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
36 as VariableUnitsID, /* update new units to m3/s, UnitsID=36 */
va.TimeUnitsID as VariableTimeUnits,
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation, 
s.GeoLocation as GeoLocation, 
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* Discharge: grab all cubic feet per second and convert to cubic meters per second*/
where VariableUnitsID=35 and VariableName like '%discharge%'
/* WIND SPEED:mph to m/s */
UNION ALL
select 
v.valueid as ValueID, 
v.datavalue*0.44704  as DataValue, /* DataValue * 0.44704  = DataValue m/s */
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
119 as VariableUnitsID, /* update new units to m/s, UnitsID=119 */
va.TimeUnitsID as VariableTimeUnits, 
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation,  
s.GeoLocation as GeoLocation,
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* WIND SPEED: grab all MPH and convert to meters per second*/
where VariableUnitsID=120 and VariableName like '%wind speed%'
/* RADIATION : langleys/min to W/m2 */
UNION ALL
select 
v.valueid as ValueID, 
v.datavalue*697.8  as DataValue, /* DataValue * 697.8   = DataValue m/s */
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
33 as VariableUnitsID, /* update new units to W/m2, UnitsID=33 */
va.TimeUnitsID as VariableTimeUnits,
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation,  
s.GeoLocation as GeoLocation,
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* Radiation: grab all langleys/min and convert to W/m2*/
where VariableUnitsID=29 and VariableName like '%radiation%'
/* FEET to METERS */
UNION ALL
select 
v.valueid as ValueID, 
v.datavalue*0.3048  as DataValue, /* DataValue * 0.3048   = DataValue meters */
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
52 as VariableUnitsID, /* update new units to m, UnitsID=52 */
va.TimeUnitsID as VariableTimeUnits,
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation,  
s.GeoLocation as GeoLocation,
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* FEET TO METERS: grab all FEET and convert to METERS*/
where VariableUnitsID=48 and (VariableName like '%gage height%' or VariableName like '%water depth%' or VariableName like '%distance%' 
   or VariableName like '%ice thickness%' or VariableName like '%free board%' or VariableName like '%luminescent dissolved oxygen%' or VariableName like '%snow depth%')
/* ACRE FOOT to CUBIC METERS */
UNION ALL
select 
v.valueid as ValueID, 
v.datavalue*1233.48183754752 as DataValue, /* DataValue * 1233.4818   = DataValue meters */
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
126 as VariableUnitsID, /* update new units to cubic meters, UnitsID=126 */
va.TimeUnitsID as VariableTimeUnits,
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation,  
s.GeoLocation as GeoLocation,
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* ACRE FOOT TO CUBIC METERS: grab all ACRE FOOT and convert to CUBIC METERS*/
where VariableUnitsID=48 and VariableName like '%Volume%' 
/* HECTO PASCAL to MBAR, THIS IS THE SAME VALUE */
UNION ALL
select 
v.valueid as ValueID, 
v.datavalue as DataValue, /* DataValue hPa   = DataValue mbar */
v.valueaccuracy as ValueAccuracy, 
v.localdatetime as LocalDateTime, 
v.UTCOffset as UTCOffset, 
DATEADD(Hour,-v.UTCOffset,v.localdatetime) as DateTimeUTC,
d.siteid as SiteID, 
va.VariableID as OriginalVariableID,
va.VariableName as VariableName,
va.SampleMedium as SampleMedium,
90 as VariableUnitsID, /* update new units to mbar, UnitsID=90*/
va.TimeUnitsID as VariableTimeUnits, 
v.offsetvalue as OffsetValue, 
v.offsettypeid as OffsetTypeID, 
v.CensorCode as CensorCode, 
v.QualifierID as QualifierID, 
d.MethodID as MethodID, 
s.SourceID as SourceID, 
v.DerivedFromID as DerivedFromID, 
d.qualityControlLevelID as QualityControlLevelID,
geography::STGeomFromText(s.GeoLocation, 4326) AS GeographyLocation, 
s.GeoLocation as GeoLocation,
s.SpatialCharacteristics
from datavalues v
inner join datastreams d on d.datastreamid = v.datastreamid
inner join sites s on d.siteid = s.siteid
inner join Variables va on d.VariableID=va.VariableID
/* ACRE FOOT TO CUBIC METERS: grab all ACRE FOOT and convert to CUBIC METERS*/
where VariableUnitsID=315 and (VariableName like '%sea level pressure%' OR VariableName like '%altimeter setting rate%' OR VariableName like '%barometric pressure%')
group by v.valueid, 
v.datavalue, 
v.valueaccuracy, 
v.localdatetime, 
v.UTCOffset, 
d.siteid, 
va.VariableID,
va.VariableName,
va.SampleMedium,
va.VariableUnitsID,
va.TimeUnitsID, 
v.offsetvalue, 
v.offsettypeid, 
v.CensorCode, 
v.QualifierID, 
d.MethodID, 
s.SourceID, 
v.DerivedFromID, 
d.qualityControlLevelID,
s.GeoLocation,
s.SpatialCharacteristics


















GO

