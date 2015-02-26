#! /bin/bash -x
#
	
# this is actually set in EXPORT_GINA_HOSTS.bash
#export MP=/home/dba/tools/usgs/tools/bin/mp.lnx
#export MP_CONFIG_FILE_DIR=/home/dba/tools/usgs/tools/ext 


# =================> METADATA Env Vars <========================
# metadata TEMPLATE_TYPES
export FGDC="FGDC"
export DUBLIN="DUBLIN"
export ISO="ISO"
export IPY="IPY"
export MARC="MARC"

# GCMD keyword keywords
export CONTENTTYPE_UC="CONTENTTYPE"
export CONTENTTYPE_LC="contenttype"
export LOCATIONS_UC="LOCATIONS"
export LOCATIONS_LC="locations"
export INSTRUMENTS_UC="INSTRUMENTS"
export INSTRUMENTS_LC="instruments"
export PLATFORMS_UC="PLATFORMS"
export PLATFORMS_LC="platforms"
export PROJECTS_UC="PROJECTS"
export PROJECTS_LC="projects"
export PROVIDERS_UC="PROVIDERS"
export PROVIDERS_LC="providers"
export SCIENCE_UC="SCIENCE"
export SCIENCE_LC="science"
export HORIZONTAL_UC="HORIZONTAL"
export HORIZONTAL_LC="horizontal"
export TEMPORAL_UC="TEMPORAL"
export TEMPORAL_LC="temporal"
export VERTICAL_UC="VERTICAL"
export VERTICAL_LC="vertical"


# metadata HARVESTERs
export GEO="GEO"
export GOS="GOS"
export GCMD="GCMD"
export IPY="IPY"
export DIF="DIF"
export GEOPORTAL="GEOPORTAL"
export GEONET="GEONET"
export GEONETWORK="GEONETWORK"
export GOOGLE="GOOGLE"
export OIH="OIH"
export DIM="DIM"
export DIMAP="DIMAP"

# Geonetwork projects
export NSSI="NSSI"
export AOOS="AOOS"
export SDMI="SDMI"
export ION="ION"
export ADIWG="ADIWG"

export NASA="NASA"
export NOAA="NOAA"
export PROJECT_GCMD_AVHRR="AVHRR 1-KM PATHFINDER"

export SUM="SUM"
export DET="DET"
export DETAIL="DETAIL"
export SUMMARY="SUMMARY"
export FGDC_SUM="FGDC_SUM"
export FGDC_DET="FGDC_DET"
export ISO_SUM="ISO_SUM"
export ISO_DET="ISO_DET"

export THEME_TYPE=$ISO
export THEME_DIR_NAME="ImageryBaseMaps"
export THEME_KEYWORD="imageryBaseMapsEarthCover"

export BROWSEPOINTER_GOS="metadata.gina.alaska.edu"
export BROWSEPOINTER_GEONET="geonet.gina.alaska.edu"
export BROWSEPOINTER_GCMD="gcmd.gina.alaska.edu"

export GPT_HARVESTING_HISTORY="gina_metadata.gpt_harvesting_history"
export GPT_HARVESTING_JOBS_COMPLETED="gina_metadata.gpt_harvesting_jobs_completed"
export GPT_HARVESTING_JOBS_PENDING="gina_metadata.gpt_harvesting_jobs_pending"
export GPT_RESOURCE="gina_metadata.gpt_resource"
export GPT_RESOURCE_DATA="gina_metadata.gpt_resource_data"
export GPT_SERVICES="gina_metadata.gpt_services"

export BROWSEPOINTER=$BROWSEPOINTER_GOS

export METADATASHORTNAME="FGDC"
export METADATASHORTNAME_FGDC="FGDC"
export METADATASHORTNAME_ISO="ISO"
export METADATASHORTNAME_ION="ION"

export METADATA_HARVESTER_GOS=$GOS
export METADATA_HARVESTER_GCMD=$GCMD
export METADATA_HARVESTER_GEONET=$GEONET
export METADATA_HARVESTER_GEONETWORK=$GEONETWORK

export METADATASTANDARDNAME_FGDC="FGDC Content Standards for Digital Geospatial Metadata"
export METADATASTANDARDVERSION_FGDC="FGDC-STD-001-1998"
export METADATASTANDARDNAME=$METADATASTANDARDNAME_FGDC

export METADATASTANDARDNAME_ISO="ISO Geographic Information - Metadata Part 2: Extensions for imagery & gridded data"
export METADATASTANDARDVERSION_ISO="ISO 19115-2"

export METADATASTANDARDVERSION=$METADATASTANDARDVERSION_FGDC
export METADATAPROFILENAME_ESRI="ESRI Metadata Profile"
export METADATAACCESCONSTRAINTS="None."
export METADATATIMECONVENTION="local time"
export METADATASECURITYCLASSSYSTEM="None."
export METADATASECURITYCLASS="Unclassified"
export METADATASECURITYHANDDESC="None."
export METADATAPROFILENAME=$METADATAPROFILENAME_ESRI
export METADATAID=1
export METADATALEVELID=7
export DAYOFYEAR_JULIAN=999
export DELETEEFFECTIVEDATE="2525-09-13 13:13:13"     # In the year 2525 ........



#
# Metadata headers to be substituted with sed later on
#
export SV_ID_GOES_HERE="SV_ID_goes_here"
export FILENAME_GOES_HERE="FILENAME_goes_here"
export PATH_GOES_HERE="PATH_goes_here"
export TEMPLATE_GOES_HERE="TEMPLATE_goes_here"

export BROWSEGRAPHICFILETYPE="TIFF"
export TITLE_HEADER="TITLE_goes_here"
export PUBDATE_HEADER="PUBDATE_goes_here"            # today's date in YYYYMMDD format

export METADATADATE_HEADER="METADATADATE_goes_here"  # YYYYMMDD format
export TITLE_HEADER="TITLE_goes_here"
export PROCESSDATE_HEADER="PROCESSDATE_goes_here"
export FORMATVERSIONDATE_HEADER="FORMATVERSIONDATE_goes_here"
export BEGINDATE_HEADER="BEGINDATE_goes_here"
export ENDDATE_HEADER="ENDDATE_goes_here"
export BEGINTIME_HEADER="BEGINTIME_goes_here"
export ENDTIME_HEADER="ENDTIME_goes_here"

export ONLINE_LINKAGE_HEADER="ONLINE_LINKAGE_goes_here"
export BROWSE_HEADER="BROWSE_goes_here"
export THUMBNAIL_HEADER="THUMBNAIL_goes_here"
export SV_VIEW_SCENE_SID="SV_VIEW_SCENE_SID_goes_here"

export KEYWORD_THEME_THESAURUS_ISO="North American Profile (NAP) of ISO 19115: Geographic Information - Metadata"
export KEYWORD_THEME_THESAURUS_GCMD="NASA/Global Change Master Directory (GCMD) Earth Science Keywords.  Version 6.0.0.0.0"
export KEYWORD_THEME_THESAURUS_OTHER="None."
export KEYWORD_PLACE_THESAURUS_GCMD="NASA/Global Change Master Directory (GCMD) Earth Science Keywords.  Version 6.0.0.0.0"
export KEYWORD_PLACE_THESAURUS_GNIS="U.S. Geological Survey, 1981501, U.S. Geographic Names Information System (GNIS); U.S. Geological Survey, Reston, VA."
export KEYWORD_PLACE_THESAURUS_GNS="Geographic Names Database"
export KEYWORD_PLACE_THESAURUS_OTHER="None."


export INITIAL="INITIAL"
export NEW_SV_ID="NEW_SV_ID"
export UPDATE_KEYWORD="UPDATE_KEYWORD"
export REINGESTED="REINGESTED"
export FIX_TYPO="FIX_TYPO"
export UPDATE_CONTACTS="UPDATE_CONTACTS"

#
# Miscellaneous
# 
export AVHRR="AVHRR"
export avhrr="avhrr"

export AQUA="AQUA"
export aqua="aqua"
export AQUA1="AQUA1"
export aqua1="aqua1"
export A1="A1"
export a1="a1"

export TERRA1="TERRA1"
export terra1="terra1"
export TERRA="TERRA"
export terra="terra"
export T1="T1"
export t1="t1"

export MODIS="MODIS"
export modis="modis"

export GOES="GOES"
export goes="goes"
export G11="G11"
export g11="g11"

export DMSP_OLS="DMSP_OLS"
export dmsp_ols="dmps_ols"
export F12="F12"
export f12="f12"
export F13="F13"
export f13="f13"
export F14="F14"
export f14="f14"
export F15="F15"
export f15="f15"
export F16="F16"
export f16="f16"
export F17="F17"
export f17="f17"
export F18="F18"
export f18="f18"



export CHANNEL_02="Channel: 02"
export CHANNEL_02_31="Channel: 02 and 31" 

export sgml="sgml"
export xml="xml"
export txt="txt"
export html="html"
export faq="faq"
export dif="dif"
export err="err"
export json="json"
export dim="dim"


# NEW
export TO_PROD_METADATA="metadata@geonet.gina.alaska.edu"
# export TO_TEST_METADATA="dba@bazinga.x.gina.alaska.edu"
export TO_TEST_METADATA="dba@doom.x.gina.alaska.edu"
export TO_DEV_METADATA="chaase@seaside.gina.alaska.edu"

export METADATA_AT_GEONET="metadata@geonet.gina.alaska.edu"
export METADATA_AT_SEASIDE="chaase@seaside.gina.alaska.edu"
export METADATA_AT_DOOM="dba@doom.x.gina.alaska.edu"
export METADATA_AT_BAZINGA="dba@bazinga.x.gina.alaska.edu"
 
#
# MP stuff
#
# =====> METADATA_CONFIG_FILE_DIR is set in EXPORT_GINA_HOSTS.bash
export METADATA_CONFIG_FILE_NAME="ion_input_txt.cfg"
export METADATA_CONFIG_FILE=$METADATA_CONFIG_FILE_DIR/$METADATA_CONFIG_FILE_NAME

# http://sv.gina.alaska.edu/metadata/aqua/2003/a1.03341.0101.browse.jpg
export SV_METADATA_BASE_URL="http://sv.gina.alaska.edu/metadata/"
export SV_METADATA_URL=$SV_METADATA_BASE_URL/$RELATIVE_PATH
export SV_BROWSE=$SV_METADATA_URL/browse.jpg
export SV_THUMBNAIL=$SV_METADATA_URL/thumbnail.jpg

export ARCHIVE_METADATA_DUMP_DIR=/home/backups/export/metadata/htdocs/ION/Content_Theme/imageryBaseMapsEarthCover


# =====> SAN_DIR_LOCAL set in EXPORT_GINA_HOSTS ...machine dependant


#if [ $DEBUG == $YES ]; then

     export PROD_EXPORT_METADATA=$HOME_METADATA/export/htdocs/ION
     export LOCAL_EXPORT_METADATA=$HOME_METADATA/local/ION
     export LOCAL_INGEST_METADATA=$HOME_METADATA/ingest/ION/$SENSOR/$YEAR_YYYY
     
     
#else
#     export PROD_EXPORT_METADATA=$SAN_DIR_LOCAL/metadata/export/htdocs/ION
#     export LOCAL_EXPORT_METADATA=$SAN_DIR_LOCAL/metadata/local/htdocs/ION
#i
export SOURCE_XML=$LOCAL_EXPORT_METADATA/xml

export TEMPLATE_FILE_NAME_AVHRR_FGDC_SUM="TEMPLATE.FGDC.ION.AVHRR.SUM.txt"
export TEMPLATE_FILE_NAME_MODIS_A1_FGDC_SUM="TEMPLATE.FGDC.ION.AQUA1.SUM.txt"
export TEMPLATE_FILE_NAME_MODIS_T1_FGDC_SUM="TEMPLATE.FGDC.ION.TERRA1.SUM.txt"
export TEMPLATE_FILE_NAME_GOES_FGDC_SUM="TEMPLATE.FGDC.ION.GOES.SUM.txt"
export TEMPLATE_FILE_NAME_DMSP_OLS_FGDC_SUM="TEMPLATE.FGDC.ION.DMSP_OLS.SUM.txt"
   
export TEMPLATE_FILE_NAME_AVHRR_FGDC_DET="TEMPLATE.FGDC.ION.AVHRR.DET.txt"
export TEMPLATE_FILE_NAME_MODIS_A1_FGDC_DET="TEMPLATE.FGDC.ION.AQUA1.DET.txt"
export TEMPLATE_FILE_NAME_MODIS_T1_FGDC_DET="TEMPLATE.FGDC.ION.TERRA1.DET.txt"
export TEMPLATE_FILE_NAME_GOES_FGDC_DET="TEMPLATE.FGDC.ION.GOES.DET.txt"
export TEMPLATE_FILE_NAME_DMSP_OLS_FGDC_DET="TEMPLATE.FGDC.ION.DMSP_OLS.DET.txt"
  
export IONMETADATAGRANULES_NOMONTHLY_TXT="IONMETADATAGRANULES_NOMONTHLY.txt"
export IONMETADATAGRANULES_NODETAIL_TXT="IONMETADATAGRANULES_NODETAIL.txt"

# ====> SOURCE_DIR set in EXPORT_GINA_HOSTS
export IONMETADATAGRANULES=$SOURCE_DIR/"IONMETADATAGRANULES_"$SENSOR"_"$METADATA_CATEGORY"."$LOGDATE".txt" 


# ===> TEMPLATE_DIR set in  EXPORT_GINA_HOSTS
TEMPLATE_FILE_NAME="TEMPLATE."$TEMPLATE_TYPE".ION."$SENSOR"."$METADATA_LEVEL".txt"

export METADATATEMPLATE=$TEMPLATE_DIR/$TEMPLATE_FILE_NAME

export LOG_FILE_ERROR="ingest_metadata_ION_ALL-pgsql.bash."$SENSOR_ID"."$METADATA_LEVEL".ERR."$LOGDATE".log"

export INGEST_DIRS_SUM_LST="ingest_metadata_ION_summary_dirs_$THEDATE".lst""
export INGEST_FILES_SUM_LST="ingest_metadata_ION_summary_files_$THEDATE".lst""
export INGEST_DIRS_DET_LST="ingest_metadata_ION_detail_dirs_$THEDATE".lst""
export INGEST_FILES_DET_LST="ingest_metadata_ION_detail_files_$THEDATE".lst""

export SUMMARY_FILE_NAME="ingest_metadata_templates_summaries_$THEDATE".lst""
export DETAIL_FILE_NAME="ingest_metadata_templates_detail_$THEDATE".lst""
      
export METADATA_FILE_NAME_DETAIL="ingest_metadata_ION_metadatafiles_detail_$THEDATE".dat""
export METADATA_FILE_NAME_SUMMARY="ingest_metadata_ION_metadatafiles_summary_$THEDATE".dat""
    
export METADATA_CATEGORY_FGDC_SUM="FGDC_SUM"	
export METADATA_CATEGORY_FGDC_DET="FGDC_DET"
export METADATA_CATEGORY_ISO_SUM="ISO_SUM"
export METADATA_CATEGORY_ISO_DET="ISO_DET"
