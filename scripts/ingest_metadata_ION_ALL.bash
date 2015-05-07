#!/bin/bash -x
#
#**************************************************************************************
#
# File Name:  ingest_metadata_ION_ALL-pgsql.bash
#
# Author:     Cheryl L. Haase
#
# Date: 11/24/2006
#
#
#
# ============================================================================
#                            MODIFICATION HISTORY
# ============================================================================
#
#  Date     Initials    Modification/Reason
#  -------  ---------   -------------------------------------------------
#          
#        
#
#**************************************************************************************	
#
#

if [ "$#" -ne 9 ]; then
	echo "Usage: $0 file 1=TEMPLATE_TYPE(FGDC,ISO): 2=METADATA_LEVEL(SUM,DET):  3=SENSOR (SV SENSOR_ID): 4=SV_START_DATE: (YYYY-MM-DD):  5=SV_END_DATE: (YYYY-MM-DD): 6=RUN_TYPE:  7=COPY_TO_PROD (Y/N): 8=COPY_TO_ARCHIVE (Y/N):  9=DEBUG (Y/N): "
        echo "  TEMPLATE_TYPE:  FGDC, ISO "
        echo "  METADATA_LEVEL: SUM, DET "
        echo "  SENSOR:         AQUA1, TERRA1, AVHRR "
#       echo "  SENSOR:         AQUA1, TERRA1, AVHRR, DMSP_OLS "
        echo "  SV_START_DATE:  YYYY-MM-DD (generate metadata FROM this date) "
        echo "  SV_END_DATE:    YYYY-MM-DD (generate metadata UNTIL/INCLUDING this date) "
        echo "  RUN_TYPE:       INITIAL, NEW_SV_ID, UPDATE_KEYWORD, REINGESTED, FIX_TYPO, UPDATE_CONTACTS  "
# ORIG  echo "  HARVESTING NODE: GOS (Geospatial One-Stop), GEO (GEONETWORK)"
        echo "  COPY_TO_PROD:    Copy XMLs/TXTs to Production (/mnt/raid/NP;metadata@GEONET)  "
        echo "  COPY_TO_ARCHIVE: Copy XMLs/TXTs to Archive (/mnt/raid/NP) "
        echo "  DEBUG: Echo DEBUG messages to log "
	exit 
else
	     export TEMPLATE_TYPE=$1
        export METADATA_LEVEL=$2
        export SENSOR=$3
        export SV_START_DATE=$4
        export SV_END_DATE=$5
        export RUN_TYPE=$6
        export COPY_TO_PROD=$7
        export COPY_TO_ARCHIVE=$8
        export DEBUG=$9
fi

 

#######################################################
# INCLUDE FILES
######################################################

#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
EXPORT_SOURCE=$HOME/tools/backup_scripts
EXPORT_FILES=$EXPORT_SOURCE/EXPORT*.bash
for EXPORT_NAME in $EXPORT_FILES; do
    source $EXPORT_NAME
done 

#source $HOME/tools/backup_scripts/EXPORT_GINA_HOSTS.bash


COMMENT="TBD"
if [ $RUN_TYPE == $INITIAL ]; then
     COMMENT="Initial load of database"
elif [ $RUN_TYPE == $NEW_SV_ID ]; then
     COMMENT="New SV ID - new pass ingested"
elif [ $RUN_TYPE == $REINGESTED ] ; then
     export COMMENT="Reingested - fix XML-JSON-TXT" 
elif [ $RUN_TYPE == $FIX_TYPO ] ; then
       export  COMMENT="Fix Typo " 
elif [ $RUN_TYPE == $UPDATE_CONTACTS ]; then
       COMMENT="Update Contact information"
elif [ $RUN_TYPE == $UPDATE_KEYWORD ]; then
       COMMENT="UPDATE_KEYWORD - new or modified keywords"
else 
       COMMENT="TESTING"
fi

export LOG_DIR=/home/chaase/tools/backup_scripts/POSTGRES

   
### LEAVE IN....OVERRIDES WHAT IS SET IN EXPORT_GINA_HOSTS  !!!!
export FROM_OWNER=$CHAASE
export USERID=$CHAASE
export POSTGRES_SID=$GINA_DBA
export SCHEMA_NAME=$GINA_DBA

Print_Header


# Environmental variables
export MAIL_TO='cheryl@gina.alaska.edu'


##################################################################
#
# Processing starts here...................
#
###################################################################



export METADATATEMPLATE=$TEMPLATE_DIR/$TEMPLATE_FILE_NAME
export LOG_DIR=$SOURCE_DIR
export POSTGRES_USER=$CHAASE

#---------------------------------------------------------------------------------------------------


# clean up whatever crap was left in case of foobar
# Zap_Local_Metadata_Files

cd $GINA_DIR

Check_for_MB_DBA_Table

#export TEMPLATE_DIR=$SOURCE_DIR

if [ $DEBUG == $YES ] ; then 
	echo "LOG_FILE:      "     $LOG_FILE               >> $LOG_FILE
	echo "TEMPLATE_TYPE: "     $TEMPLATE_TYPE          >> $LOG_FILE
	echo "METADATA_LEVEL:"     $METADATA_LEVEL         >> $LOG_FILE
	echo "SENSOR:        "     $SENSOR                 >> $LOG_FILE
	#echo "METADATA_CATEGORY: "  $METADATA_CATEGORY    >> $LOG_FILE
fi

Get_TemplateName

if [ $DEBUG == $YES ] ; then 
	echo "TEMPLATE_DIR"  $TEMPLATE_DIR
	echo "TEMP_ION"   $TEMP_ION
	echo "GINA_DIR"  $GINA_DIR
	echo "IONMETADATA_GRNAULES:"  $IONMETADATAGRANULES
fi

FIRST_TIME=$YES
FILES_TO_ARCHIVE=$NO
Get_Sensor_Info

for SAT_REC in $(cat $IONMETADATAGRANULES); do
             
     # parse out the satellite, sensor etc. ====>  # T1.,TERRA1,2007-09-01 00:00:00,2007,9
     Parse_Sat_Sensor
 
     # ==> this is the exception but if running multiple years want to archive them one year at a time or too many files...AVHRR
#     if [ $YEAR_YYYY -ne $YEAR_YYYY_PREVIOUS ] && [ $COPY_TO_ARCHIVE == $YES ] ; then     
 #         $YEAR_YYYY=$YEAR_YYYY_PREVIOUS 
#    	  REMOTE_SCP_METADATA_COPY_TO_ARCHIVE   
#     fi 

     SV_METADATA_PATH=$SV_DIR_METADATA/$RELATIVE_PATH
     SV_BROWSE=$RELATIVE_PATH/browse.jpg
     SV_THUMBNAIL=$RELATIVE_PATH/thumbnail.jpg

     # Need leap year for number of days in month....in header of metadata file
     Verify_Leap_Year
     #Need alpha month for the output metadata files.....	
     Get_Alpha_Month
     Build_Metadata_Title
     Build_XML_Strings
     # GOS needs XML 
     Get_Output_Metadata_File

     # ==> Assume they are there and if one is NOT found then regenerate ALL of them !!
     ALL_METADATA_FILES_EXIST=$YES	
     All_Metadata_Files_Exist


if [ $DEBUG == $YES ] ; then 
     echo "ALL_METADATA_FILES_EXIST:    "  $ALL_METADATA_FILES_EXIST >> $LOG_FILE
fi 

########################################################################
# Here starts the actual generation of the necessary metadata files...
#########################################################################

     # If ANY of the 3 files are missing then create ALL (XML,TXT,JSON) from template
     if [ $ALL_METADATA_FILES_EXIST != $YES ]; then  
	   cd $PROD_ION
	   FILES_TO_ARCHIVE=$YES

           Blurb_Generating_Metadata_Files 
           Build_DOCUUID
           #  ORIG --> MP_Files
           MP_Files_GEONET
           # ORIG Get_Metadata_Parser_Version	              
           Cleanup_Metadata_Files         

           PSQL_NOW=`psql -d gina_dba -U $CHAASE -At -c "select * from now()"` 

           $PSQL -d gina_dba -U $CHAASE -c "INSERT into gina_metadata.gina_metadata_uuid values ('$DOCUUID_MD5','$SV_ID','$SENSOR','$RUN_TYPE','$OUTPUT_METADATA_FILE.xml','$OUTPUTFILE_ISO_XML_FILENAME','$TITLE','$PUBDATE','$BEGINDATE','$TIME_HHMM','$ENDDATE','$TIME_HHMM','$SV_VIEW_SCENE_ID','$RELATIVE_PATH','$TEMPLATE_XML','csdgm2iso19115-geonetwork.xslt','$METADATASTANDARDVERSION','$METADATASTANDARDNAME','$METADATASTANDARDVERSION_ISO','$METADATASTANDARDNAME_ISO','$KEYWORD_THEME_THESAURUS_ISO','$KEYWORD_THEME_THESAURUS_GCMD','$KEYWORD_THEME_THESAURUS_OTHER','$KEYWORD_PLACE_THESAURUS_GCMD','$KEYWORD_PLACE_THESAURUS_GNIS','$KEYWORD_PLACE_THESAURUS_GNS','$KEYWORD_PLACE_THESAURUS_OTHER','$PROJECT_GCMD','$PROVIDER_GCMD','$PLATFORM_GCMD','$INSTRUMENT_GCMD','dataset','eng; USA','utf8','ABSTRACT_goes_here','PURPOSE_goes_here','$COMMENT','$PSQL_NOW')";

           $MONGOIMPORT -d gina_dba -c gina_metadata_uuid --jsonArray $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_HEADER".json"
           $MONGOIMPORT -d gina_dba -c gina_metadata_fgdc --jsonArray $OUTPUTFILE_FGDC_JSON
           $MONGOIMPORT -d gina_dba -c gina_metadata_iso --jsonArray  $OUTPUTFILE_ISO_JSON


	   # DATETODAY ===>  Tue Oct 28 15:31:03 AKDT 2014  ===> ls -la *2015*.* include=$DATETODAY
	   # NOTE: 1) if being done by root the chown/chgrp will work
	   #       2) set this as * just in case VM crashed before and leftovers occurred
	   #       3) keep this out of SCP subroutine cuz need perms NOT to be root in production regardless of whether they are cp'd to archive @ NP 
	   # ====> AVHRR.N18.2014.11.11.1830.Nov.*
	  for file in `find $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/*$YEAR_YYYY.$MONTH_NN* -user root`;do 
	      chown metadata $file; 
	      chgrp metadata $file; 
	      chmod oug-x $file; 
	      chmod ug+rw,o+r $file; 		
	   done
	   
	  # Now copy newly generated files to PRODUCTION if COPY_TO_PROD is YES
#	  REMOTE_SCP_METADATA_COPY_TO_PROD
          if [ $COPY_TO_PROD == "Y" ] ; then 
    	      echo "*** Copying DB Dumps FROM " $HOST " TO GEONET"  >> $LOG_FILE
               if [ $HOSTNAME == $SEASIDE_FULL ]; then
                    scp -P 22 $PROD_METADATA_FILE_XML  $PROD_METADATA_FILE_TXT  $PROD_METADATA_FILE_JSON $OUTPUTFILE_ISO_JSON  $PROD_METADATA_HEADER_JSON metadata@geonet.gina.alaska.edu:/home/metadata/export/htdocs/ION/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
               else
                     mv $PROD_METADATA_FILE_XML $PROD_METADATA_FILE_TXT $PROD_METADATA_FILE_JSON $OUTPUTFILE_FGDC_JSON $OUTPUTFILE_ISO_XML $OUTPUTFILE_ISO_JSON  $PROD_METADATA_HEADER_JSON /home/metadata/export/htdocs/ION/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
 	       fi
            fi    

     else  
  	    Blurb_Metadata_Files_Exist   
  	                   
     fi # end ALL metadata files exist (JSON,XML,TXT)	


done

# Now copy newly generated files to ARCHIVE if COPY_TO_ARCHIVE is YES
# if running one year archive them now which is normally the case; if running multiple years archive the last year
#REMOTE_SCP_METADATA_COPY_TO_ARCHIVE
if [ $COPY_TO_ARCHIVE == "Y" ] && [ $FILES_TO_ARCHIVE == "Y" ] ; then 
#if [ $COPY_TO_ARCHIVE == "Y" ] ; then 
    echo "*** Rsynching METADATA files FROM " $HOST " TO SEASIDE "  >> $LOG_FILE
    rm $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/*.log
    rm $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/*.lst
    rsync -av $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/* chaase@seaside:/home/chaase/gina-alaska/dba-tools/GINA_METADATA/archive/$SENSOR/$YEAR_YYYY
fi



echo " "								      	>> $LOG_FILE;
echo `date '+%m/%d/%y %A %X'` "*** log END  ***"                         	>> $LOG_FILE;
echo "----------------------------------------------------------------"   	>> $LOG_FILE;
echo "Script      : "$0                                                   	>> $LOG_FILE;
echo "Database    : "$POSTGRES_SID                                              >> $LOG_FILE;
echo "Server      : "`uname -n`                                           	>> $LOG_FILE;
echo "----------------------------------------------------------------" 	>> $LOG_FILE;
echo " "								        >> $LOG_FILE;


exit 



