/* Grants of the role 'asjacobs' */

GRANT CREATE, TEMP, CONNECT
  ON DATABASE imiq_production TO asjacobs;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE imiq_staging TO asjacobs;

GRANT USAGE
  ON SCHEMA information_schema TO asjacobs;

GRANT USAGE
  ON SCHEMA pg_catalog TO asjacobs;

GRANT USAGE
  ON SCHEMA public TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.geometry_columns TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.spatial_ref_sys TO asjacobs;

GRANT CREATE, USAGE
  ON SCHEMA tables TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables._sites_summary TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables._siteswithelevations TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgrh_all TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterairtemp_all TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterprecip_all TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterrh_all TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peakdischarge_all TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peaksnowdepth_all TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peakswe_all TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_totalprecip_all TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.attributes TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.categories TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.censorcodecv TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempmaxdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempmindatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_dischargedatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precip_thresholds TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precipdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_rhdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_snowdepth TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_snowdepthdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_swe TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_swedatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_watertempdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_winddirectiondatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_windspeeddatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datastreams TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datatypecv TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datavaluesraw TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.derivedfrom TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.devices TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_arc_arc TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_arc_point TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_fws_fishsample TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_reference TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_referencetowaterbody TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_waterbody TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.generalcategorycv TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.groupdescriptions TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.groups TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_airtempdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_precip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_precipdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_rhdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_snowdepth TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_snowdepthdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_swe TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_swedatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_winddirectiondatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_windspeeddatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.imiqversion TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.incidents TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.isometadata TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.methods TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.monthly_rh_all TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgdischarge TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgfallairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgfallprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeakdischarge TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeaksnowdepth TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeakswe TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgrh TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgspringairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgspringprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerdischarge TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerrh TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterrh TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.networkdescriptions TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.nhd_huc8 TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.offsettypes TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.organizationdescriptions TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.organizations TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.processing TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.qualifiers TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.qualitycontrollevels TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.rasterdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.samplemediumcv TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.seriescatalog TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.siteattributes TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sites TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sources TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.spatialreferences TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.speciationcv TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sysdiagrams TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.topiccategorycv TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.units TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.valuetypecv TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.variablenamecv TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.variables TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.verticaldatumcv TO asjacobs;

GRANT CREATE, USAGE
  ON SCHEMA views TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.boundarycatalog TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.daily_utcdatetime TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.datastreamvariables TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.datavaluesaggregate TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.hourly_utcdatetime TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgdischarge TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgfallairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgfallprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeakdischarge TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeaksnowdepth TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeakswe TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgrh TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgspringairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgspringprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerdischarge TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerrh TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterairtemp TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterprecip TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterrh TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.odmdatavalues TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.queryme TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.siteattributesource TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitegeography TO asjacobs;

GRANT SELECT, USAGE
  ON views.sitegeography_siteid_seq TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitesource TO asjacobs;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitesourcedescription TO asjacobs;

/* Grants of the role 'chaase' */

GRANT CREATE, TEMP, CONNECT
  ON DATABASE gina_dba TO chaase;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE iarcod_staging TO chaase;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE imiq_production TO chaase;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE imiq_staging TO chaase;

GRANT USAGE
  ON SCHEMA information_schema TO chaase;

GRANT USAGE
  ON SCHEMA pg_catalog TO chaase;

GRANT CREATE, USAGE
  ON SCHEMA public TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.geometry_columns TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.pg_buffercache TO chaase;

GRANT EXECUTE
  ON FUNCTION public.pg_buffercache_pages() TO chaase;

GRANT EXECUTE
  ON FUNCTION public.pg_freespace(pg_catalog.regclass, bigint) TO chaase;

GRANT EXECUTE
  ON FUNCTION public.pg_freespace(rel pg_catalog.regclass, out blkno bigint, out avail smallint) TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.pg_stat_statements TO chaase;

GRANT EXECUTE
  ON FUNCTION public.pg_stat_statements_reset() TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.spatial_ref_sys TO chaase;

GRANT CREATE, USAGE
  ON SCHEMA tables TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables._sites_summary TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables._siteswithelevations TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgrh_all TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterairtemp_all TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterprecip_all TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterrh_all TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peakdischarge_all TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peaksnowdepth_all TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peakswe_all TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_totalprecip_all TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.attributes TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.categories TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.censorcodecv TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempmaxdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempmindatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_dischargedatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precip_thresholds TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precipdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_rhdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_snowdepth TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_snowdepthdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_swe TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_swedatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_watertempdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_winddirectiondatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_windspeeddatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datastreams TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datatypecv TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datavaluesraw TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.derivedfrom TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.devices TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_arc_arc TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_arc_point TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_fws_fishsample TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_reference TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_referencetowaterbody TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_waterbody TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.generalcategorycv TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.groupdescriptions TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.groups TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_airtempdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_precip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_precipdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_rhdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_snowdepth TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_snowdepthdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_swe TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_swedatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_winddirectiondatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_windspeeddatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.imiqversion TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.incidents TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.isometadata TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.methods TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.monthly_rh_all TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgdischarge TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgfallairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgfallprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeakdischarge TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeaksnowdepth TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeakswe TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgrh TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgspringairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgspringprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerdischarge TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerrh TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterrh TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.networkdescriptions TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.nhd_huc8 TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.offsettypes TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.organizationdescriptions TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.organizations TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.processing TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.qualifiers TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.qualitycontrollevels TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.rasterdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.samplemediumcv TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.seriescatalog TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.siteattributes TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sites TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sources TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.spatialreferences TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.speciationcv TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sysdiagrams TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.topiccategorycv TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.units TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.valuetypecv TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.variablenamecv TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.variables TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.verticaldatumcv TO chaase;

GRANT CREATE, USAGE
  ON SCHEMA views TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.boundarycatalog TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.daily_utcdatetime TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.datastreamvariables TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.datavaluesaggregate TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.hourly_utcdatetime TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgdischarge TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgfallairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgfallprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeakdischarge TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeaksnowdepth TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeakswe TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgrh TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgspringairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgspringprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerdischarge TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerrh TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterairtemp TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterprecip TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterrh TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.odmdatavalues TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.queryme TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.siteattributesource TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitegeography TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitesource TO chaase;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitesourcedescription TO chaase;

/* Grants of the role 'dba' */

GRANT CREATE, CONNECT
  ON DATABASE imiq_production TO dba;

/* Grants of the role 'imiq' */

GRANT CONNECT
  ON DATABASE gina_dba TO imiq;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE iarcod_staging TO imiq;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE imiq_map_production TO imiq;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE imiq_production TO imiq;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE imiq_staging TO imiq;

GRANT USAGE
  ON SCHEMA information_schema TO imiq;

GRANT USAGE
  ON SCHEMA pg_catalog TO imiq;

GRANT CREATE, USAGE
  ON SCHEMA public TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.geometry_columns TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.spatial_ref_sys TO imiq;

GRANT CREATE, USAGE
  ON SCHEMA tables TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables._sites_summary TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables._siteswithelevations TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgrh_all TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterairtemp_all TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterprecip_all TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterrh_all TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peakdischarge_all TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peaksnowdepth_all TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peakswe_all TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_totalprecip_all TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.attributes TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.categories TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.censorcodecv TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempmaxdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempmindatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_dischargedatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precip_thresholds TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precipdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_rhdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_snowdepth TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_snowdepthdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_swe TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_swedatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_watertempdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_winddirectiondatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_windspeeddatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datastreams TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datatypecv TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datavaluesraw TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.derivedfrom TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.devices TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_arc_arc TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_arc_point TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_fws_fishsample TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_reference TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_referencetowaterbody TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_waterbody TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.generalcategorycv TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.groupdescriptions TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.groups TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_airtempdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_precip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_precipdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_rhdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_snowdepth TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_snowdepthdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_swe TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_swedatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_winddirectiondatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_windspeeddatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.imiqversion TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.incidents TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.isometadata TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.methods TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.monthly_rh_all TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgdischarge TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgfallairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgfallprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeakdischarge TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeaksnowdepth TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeakswe TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgrh TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgspringairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgspringprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerdischarge TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerrh TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterrh TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.networkdescriptions TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.nhd_huc8 TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.offsettypes TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.organizationdescriptions TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.organizations TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.processing TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.qualifiers TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.qualitycontrollevels TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.rasterdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.samplemediumcv TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.seriescatalog TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.siteattributes TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sites TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sources TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.spatialreferences TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.speciationcv TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sysdiagrams TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.topiccategorycv TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.units TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.valuetypecv TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.variablenamecv TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.variables TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.verticaldatumcv TO imiq;

GRANT CREATE, USAGE
  ON SCHEMA views TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.boundarycatalog TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.daily_utcdatetime TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.datastreamvariables TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.datavaluesaggregate TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.hourly_utcdatetime TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgdischarge TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgfallairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgfallprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeakdischarge TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeaksnowdepth TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeakswe TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgrh TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgspringairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgspringprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerdischarge TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerrh TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterairtemp TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterprecip TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterrh TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.odmdatavalues TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.queryme TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.siteattributesource TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitegeography TO imiq;

GRANT SELECT, UPDATE, USAGE
  ON views.sitegeography_siteid_seq TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitesource TO imiq;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitesourcedescription TO imiq;

/* Grants of the role 'imiq_reader' */

GRANT CONNECT
  ON DATABASE imiq_staging TO imiq_reader;

GRANT USAGE
  ON SCHEMA information_schema TO imiq_reader;

GRANT USAGE
  ON SCHEMA pg_catalog TO imiq_reader;

GRANT USAGE
  ON SCHEMA public TO imiq_reader;

GRANT SELECT
  ON public.geometry_columns TO imiq_reader;

GRANT SELECT
  ON public.spatial_ref_sys TO imiq_reader;

GRANT USAGE
  ON SCHEMA tables TO imiq_reader;

GRANT SELECT
  ON tables._sites_summary TO imiq_reader;

GRANT SELECT
  ON tables._siteswithelevations TO imiq_reader;

GRANT SELECT
  ON tables.annual_avgrh_all TO imiq_reader;

GRANT SELECT
  ON tables.annual_avgwinterairtemp_all TO imiq_reader;

GRANT SELECT
  ON tables.annual_avgwinterprecip_all TO imiq_reader;

GRANT SELECT
  ON tables.annual_avgwinterrh_all TO imiq_reader;

GRANT SELECT
  ON tables.annual_peakdischarge_all TO imiq_reader;

GRANT SELECT
  ON tables.annual_peaksnowdepth_all TO imiq_reader;

GRANT SELECT
  ON tables.annual_peakswe_all TO imiq_reader;

GRANT SELECT
  ON tables.annual_totalprecip_all TO imiq_reader;

GRANT SELECT
  ON tables.attributes TO imiq_reader;

GRANT SELECT
  ON tables.categories TO imiq_reader;

GRANT SELECT
  ON tables.censorcodecv TO imiq_reader;

GRANT SELECT
  ON tables.daily_airtempdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_airtempmaxdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_airtempmindatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_dischargedatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_precip TO imiq_reader;

GRANT SELECT
  ON tables.daily_precip_thresholds TO imiq_reader;

GRANT SELECT
  ON tables.daily_precipdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_rhdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_snowdepth TO imiq_reader;

GRANT SELECT
  ON tables.daily_snowdepthdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_swe TO imiq_reader;

GRANT SELECT
  ON tables.daily_swedatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_watertempdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_winddirectiondatavalues TO imiq_reader;

GRANT SELECT
  ON tables.daily_windspeeddatavalues TO imiq_reader;

GRANT SELECT
  ON tables.datastreams TO imiq_reader;

GRANT SELECT
  ON tables.datatypecv TO imiq_reader;

GRANT SELECT
  ON tables.datavalues TO imiq_reader;

GRANT SELECT
  ON tables.datavaluesraw TO imiq_reader;

GRANT SELECT
  ON tables.derivedfrom TO imiq_reader;

GRANT SELECT
  ON tables.devices TO imiq_reader;

GRANT SELECT
  ON tables.ext_arc_arc TO imiq_reader;

GRANT SELECT
  ON tables.ext_arc_point TO imiq_reader;

GRANT SELECT
  ON tables.ext_fws_fishsample TO imiq_reader;

GRANT SELECT
  ON tables.ext_reference TO imiq_reader;

GRANT SELECT
  ON tables.ext_referencetowaterbody TO imiq_reader;

GRANT SELECT
  ON tables.ext_waterbody TO imiq_reader;

GRANT SELECT
  ON tables.generalcategorycv TO imiq_reader;

GRANT SELECT
  ON tables.groupdescriptions TO imiq_reader;

GRANT SELECT
  ON tables.groups TO imiq_reader;

GRANT SELECT
  ON tables.hourly_airtempdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.hourly_precip TO imiq_reader;

GRANT SELECT
  ON tables.hourly_precipdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.hourly_rhdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.hourly_snowdepth TO imiq_reader;

GRANT SELECT
  ON tables.hourly_snowdepthdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.hourly_swe TO imiq_reader;

GRANT SELECT
  ON tables.hourly_swedatavalues TO imiq_reader;

GRANT SELECT
  ON tables.hourly_winddirectiondatavalues TO imiq_reader;

GRANT SELECT
  ON tables.hourly_windspeeddatavalues TO imiq_reader;

GRANT SELECT
  ON tables.imiqversion TO imiq_reader;

GRANT SELECT
  ON tables.incidents TO imiq_reader;

GRANT SELECT
  ON tables.isometadata TO imiq_reader;

GRANT SELECT
  ON tables.methods TO imiq_reader;

GRANT SELECT
  ON tables.monthly_rh_all TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgairtemp TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgdischarge TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgfallairtemp TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgfallprecip TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgpeakdischarge TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgpeaksnowdepth TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgpeakswe TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgprecip TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgrh TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgspringairtemp TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgspringprecip TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgsummerairtemp TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgsummerdischarge TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgsummerprecip TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgsummerrh TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgwinterairtemp TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgwinterprecip TO imiq_reader;

GRANT SELECT
  ON tables.multiyear_annual_all_avgwinterrh TO imiq_reader;

GRANT SELECT
  ON tables.networkdescriptions TO imiq_reader;

GRANT SELECT
  ON tables.nhd_huc8 TO imiq_reader;

GRANT SELECT
  ON tables.offsettypes TO imiq_reader;

GRANT SELECT
  ON tables.organizationdescriptions TO imiq_reader;

GRANT SELECT
  ON tables.organizations TO imiq_reader;

GRANT SELECT
  ON tables.processing TO imiq_reader;

GRANT SELECT
  ON tables.qualifiers TO imiq_reader;

GRANT SELECT
  ON tables.qualitycontrollevels TO imiq_reader;

GRANT SELECT
  ON tables.rasterdatavalues TO imiq_reader;

GRANT SELECT
  ON tables.samplemediumcv TO imiq_reader;

GRANT SELECT
  ON tables.seriescatalog TO imiq_reader;

GRANT SELECT
  ON tables.siteattributes TO imiq_reader;

GRANT SELECT
  ON tables.sites TO imiq_reader;

GRANT SELECT
  ON tables.sources TO imiq_reader;

GRANT SELECT
  ON tables.spatialreferences TO imiq_reader;

GRANT SELECT
  ON tables.speciationcv TO imiq_reader;

GRANT SELECT
  ON tables.sysdiagrams TO imiq_reader;

GRANT SELECT
  ON tables.topiccategorycv TO imiq_reader;

GRANT SELECT
  ON tables.units TO imiq_reader;

GRANT SELECT
  ON tables.valuetypecv TO imiq_reader;

GRANT SELECT
  ON tables.variablenamecv TO imiq_reader;

GRANT SELECT
  ON tables.variables TO imiq_reader;

GRANT SELECT
  ON tables.verticaldatumcv TO imiq_reader;

GRANT USAGE
  ON SCHEMA views TO imiq_reader;

GRANT SELECT
  ON views.boundarycatalog TO imiq_reader;

GRANT SELECT
  ON views.daily_utcdatetime TO imiq_reader;

GRANT SELECT
  ON views.datastreamvariables TO imiq_reader;

GRANT SELECT
  ON views.datavaluesaggregate TO imiq_reader;

GRANT SELECT
  ON views.hourly_utcdatetime TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgairtemp TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgdischarge TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgfallairtemp TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgfallprecip TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgpeakdischarge TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgpeaksnowdepth TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgpeakswe TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgprecip TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgrh TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgspringairtemp TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgspringprecip TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgsummerairtemp TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgsummerdischarge TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgsummerprecip TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgsummerrh TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgwinterairtemp TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgwinterprecip TO imiq_reader;

GRANT SELECT
  ON views.multiyear_annual_avgwinterrh TO imiq_reader;

GRANT SELECT
  ON views.odmdatavalues TO imiq_reader;

GRANT SELECT
  ON views.queryme TO imiq_reader;

GRANT SELECT
  ON views.siteattributesource TO imiq_reader;

GRANT SELECT
  ON views.sitegeography TO imiq_reader;

GRANT SELECT
  ON views.sitegeography_siteid_seq TO imiq_reader;

GRANT SELECT
  ON views.sitesource TO imiq_reader;

GRANT SELECT
  ON views.sitesourcedescription TO imiq_reader;

/* Grants of the role 'postgres' */

GRANT CONNECT
  ON DATABASE imiq_production TO postgres;

GRANT CREATE, USAGE
  ON SCHEMA information_schema TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.administrable_role_authorizations TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.applicable_roles TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.attributes TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.character_sets TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.check_constraint_routine_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.check_constraints TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.collation_character_set_applicability TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.collations TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.column_domain_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.column_privileges TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.column_udt_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.columns TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.constraint_column_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.constraint_table_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.data_type_privileges TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.domain_constraints TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.domain_udt_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.domains TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.element_types TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.enabled_roles TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.foreign_data_wrapper_options TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.foreign_data_wrappers TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.foreign_server_options TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.foreign_servers TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.foreign_table_options TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.foreign_tables TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.information_schema_catalog_name TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.key_column_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.parameters TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.referential_constraints TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.role_column_grants TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.role_routine_grants TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.role_table_grants TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.role_usage_grants TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.routine_privileges TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.routines TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.schemata TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.sequences TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.sql_features TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.sql_implementation_info TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.sql_languages TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.sql_packages TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.sql_sizing TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.sql_sizing_profiles TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.table_constraints TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.table_privileges TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.tables TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.triggered_update_columns TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.triggers TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.usage_privileges TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.user_mapping_options TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.user_mappings TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.view_column_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.view_routine_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.view_table_usage TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON information_schema.views TO postgres;

GRANT CREATE, USAGE
  ON SCHEMA pg_catalog TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON pg_catalog.pg_authid TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON pg_catalog.pg_settings TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON pg_catalog.pg_shadow TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON pg_catalog.pg_statistic TO postgres;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON pg_catalog.pg_user_mapping TO postgres;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE template0 TO postgres;

GRANT CREATE, TEMP, CONNECT
  ON DATABASE template1 TO postgres;

/* Grants of the role 'rwspicer' */

GRANT CREATE, TEMP, CONNECT
  ON DATABASE imiq_staging TO rwspicer;

GRANT USAGE
  ON SCHEMA information_schema TO rwspicer;

GRANT USAGE
  ON SCHEMA pg_catalog TO rwspicer;

GRANT USAGE
  ON SCHEMA public TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.geometry_columns TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON public.spatial_ref_sys TO rwspicer;

GRANT CREATE, USAGE
  ON SCHEMA tables TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables._sites_summary TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables._siteswithelevations TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgrh_all TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterairtemp_all TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterprecip_all TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_avgwinterrh_all TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peakdischarge_all TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peaksnowdepth_all TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_peakswe_all TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.annual_totalprecip_all TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.attributes TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.categories TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.censorcodecv TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempmaxdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_airtempmindatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_dischargedatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precip_thresholds TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_precipdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_rhdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_snowdepth TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_snowdepthdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_swe TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_swedatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_watertempdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_winddirectiondatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.daily_windspeeddatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datastreams TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datatypecv TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.datavaluesraw TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.derivedfrom TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.devices TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_arc_arc TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_arc_point TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_fws_fishsample TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_reference TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_referencetowaterbody TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.ext_waterbody TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.generalcategorycv TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.groupdescriptions TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.groups TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_airtempdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_precip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_precipdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_rhdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_snowdepth TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_snowdepthdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_swe TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_swedatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_winddirectiondatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.hourly_windspeeddatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.imiqversion TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.incidents TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.isometadata TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.methods TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.monthly_rh_all TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgdischarge TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgfallairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgfallprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeakdischarge TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeaksnowdepth TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgpeakswe TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgrh TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgspringairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgspringprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerdischarge TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgsummerrh TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.multiyear_annual_all_avgwinterrh TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.networkdescriptions TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.nhd_huc8 TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.offsettypes TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.organizationdescriptions TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.organizations TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.processing TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.qualifiers TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.qualitycontrollevels TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.rasterdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.samplemediumcv TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.seriescatalog TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.siteattributes TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sites TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sources TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.spatialreferences TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.speciationcv TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.sysdiagrams TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.topiccategorycv TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.units TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.valuetypecv TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.variablenamecv TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.variables TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON tables.verticaldatumcv TO rwspicer;

GRANT CREATE, USAGE
  ON SCHEMA views TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.boundarycatalog TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.daily_utcdatetime TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.datastreamvariables TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.datavaluesaggregate TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.hourly_utcdatetime TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgdischarge TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgfallairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgfallprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeakdischarge TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeaksnowdepth TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgpeakswe TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgrh TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgspringairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgspringprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerdischarge TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgsummerrh TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterairtemp TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterprecip TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.multiyear_annual_avgwinterrh TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.odmdatavalues TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.queryme TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.siteattributesource TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitegeography TO rwspicer;

GRANT UPDATE
  ON views.sitegeography_siteid_seq TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitesource TO rwspicer;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON views.sitesourcedescription TO rwspicer;

/* Grants of the role 'PUBLIC' */

GRANT TEMP, CONNECT
  ON DATABASE gina_dba TO PUBLIC;

GRANT TEMP, CONNECT
  ON DATABASE iarcod_staging TO PUBLIC;

GRANT TEMP, CONNECT
  ON DATABASE imiq_production TO PUBLIC;

GRANT TEMP, CONNECT
  ON DATABASE imiq_staging TO PUBLIC;

GRANT USAGE
  ON SCHEMA information_schema TO PUBLIC;

GRANT SELECT
  ON information_schema.administrable_role_authorizations TO PUBLIC;

GRANT SELECT
  ON information_schema.applicable_roles TO PUBLIC;

GRANT SELECT
  ON information_schema.attributes TO PUBLIC;

GRANT SELECT
  ON information_schema.character_sets TO PUBLIC;

GRANT SELECT
  ON information_schema.check_constraint_routine_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.check_constraints TO PUBLIC;

GRANT SELECT
  ON information_schema.collation_character_set_applicability TO PUBLIC;

GRANT SELECT
  ON information_schema.collations TO PUBLIC;

GRANT SELECT
  ON information_schema.column_domain_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.column_privileges TO PUBLIC;

GRANT SELECT
  ON information_schema.column_udt_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.columns TO PUBLIC;

GRANT SELECT
  ON information_schema.constraint_column_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.constraint_table_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.data_type_privileges TO PUBLIC;

GRANT SELECT
  ON information_schema.domain_constraints TO PUBLIC;

GRANT SELECT
  ON information_schema.domain_udt_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.domains TO PUBLIC;

GRANT SELECT
  ON information_schema.element_types TO PUBLIC;

GRANT SELECT
  ON information_schema.enabled_roles TO PUBLIC;

GRANT SELECT
  ON information_schema.foreign_data_wrapper_options TO PUBLIC;

GRANT SELECT
  ON information_schema.foreign_data_wrappers TO PUBLIC;

GRANT SELECT
  ON information_schema.foreign_server_options TO PUBLIC;

GRANT SELECT
  ON information_schema.foreign_servers TO PUBLIC;

GRANT SELECT
  ON information_schema.foreign_table_options TO PUBLIC;

GRANT SELECT
  ON information_schema.foreign_tables TO PUBLIC;

GRANT SELECT
  ON information_schema.information_schema_catalog_name TO PUBLIC;

GRANT SELECT
  ON information_schema.key_column_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.parameters TO PUBLIC;

GRANT SELECT
  ON information_schema.referential_constraints TO PUBLIC;

GRANT SELECT
  ON information_schema.role_column_grants TO PUBLIC;

GRANT SELECT
  ON information_schema.role_routine_grants TO PUBLIC;

GRANT SELECT
  ON information_schema.role_table_grants TO PUBLIC;

GRANT SELECT
  ON information_schema.role_usage_grants TO PUBLIC;

GRANT SELECT
  ON information_schema.routine_privileges TO PUBLIC;

GRANT SELECT
  ON information_schema.routines TO PUBLIC;

GRANT SELECT
  ON information_schema.schemata TO PUBLIC;

GRANT SELECT
  ON information_schema.sequences TO PUBLIC;

GRANT SELECT
  ON information_schema.sql_features TO PUBLIC;

GRANT SELECT
  ON information_schema.sql_implementation_info TO PUBLIC;

GRANT SELECT
  ON information_schema.sql_languages TO PUBLIC;

GRANT SELECT
  ON information_schema.sql_packages TO PUBLIC;

GRANT SELECT
  ON information_schema.sql_sizing TO PUBLIC;

GRANT SELECT
  ON information_schema.sql_sizing_profiles TO PUBLIC;

GRANT SELECT
  ON information_schema.table_constraints TO PUBLIC;

GRANT SELECT
  ON information_schema.table_privileges TO PUBLIC;

GRANT SELECT
  ON information_schema.tables TO PUBLIC;

GRANT SELECT
  ON information_schema.triggered_update_columns TO PUBLIC;

GRANT SELECT
  ON information_schema.triggers TO PUBLIC;

GRANT SELECT
  ON information_schema.usage_privileges TO PUBLIC;

GRANT SELECT
  ON information_schema.user_mapping_options TO PUBLIC;

GRANT SELECT
  ON information_schema.user_mappings TO PUBLIC;

GRANT SELECT
  ON information_schema.view_column_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.view_routine_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.view_table_usage TO PUBLIC;

GRANT SELECT
  ON information_schema.views TO PUBLIC;

GRANT USAGE
  ON SCHEMA pg_catalog TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_aggregate TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_am TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_amop TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_amproc TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_attrdef TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_attribute TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_auth_members TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_available_extension_versions TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_available_extensions TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_cast TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_class TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_collation TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_constraint TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_conversion TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_cursors TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_database TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_db_role_setting TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_default_acl TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_depend TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_description TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_enum TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_extension TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_foreign_data_wrapper TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_foreign_server TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_foreign_table TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_group TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_index TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_indexes TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_inherits TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_language TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_largeobject_metadata TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_locks TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_namespace TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_opclass TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_operator TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_opfamily TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_pltemplate TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_prepared_statements TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_prepared_xacts TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_proc TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_rewrite TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_roles TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_rules TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_seclabel TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_seclabels TO PUBLIC;

GRANT SELECT, UPDATE
  ON pg_catalog.pg_settings TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_shdepend TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_shdescription TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_activity TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_all_indexes TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_all_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_bgwriter TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_database TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_database_conflicts TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_replication TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_sys_indexes TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_sys_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_user_functions TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_user_indexes TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_user_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_xact_all_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_xact_sys_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_xact_user_functions TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stat_xact_user_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_statio_all_indexes TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_statio_all_sequences TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_statio_all_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_statio_sys_indexes TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_statio_sys_sequences TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_statio_sys_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_statio_user_indexes TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_statio_user_sequences TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_statio_user_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_stats TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_tables TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_tablespace TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_timezone_abbrevs TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_timezone_names TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_trigger TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_ts_config TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_ts_config_map TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_ts_dict TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_ts_parser TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_ts_template TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_type TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_user TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_user_mappings TO PUBLIC;

GRANT SELECT
  ON pg_catalog.pg_views TO PUBLIC;

GRANT CREATE, USAGE
  ON SCHEMA public TO PUBLIC;

GRANT SELECT
  ON public.pg_stat_statements TO PUBLIC;

GRANT CONNECT
  ON DATABASE template0 TO PUBLIC;

GRANT CONNECT
  ON DATABASE template1 TO PUBLIC;