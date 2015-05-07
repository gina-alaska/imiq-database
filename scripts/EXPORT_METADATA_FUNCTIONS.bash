#! /bin/bash -x 
 
 
#
#------------------------------------------------------------------------
# ******************* FUNCTION DEFINITIONS   *********************
#------------------------------------------------------------------------

All_Metadata_Files_Exist()
{	
          # ==> Assume they are there and if one is NOT found then regenerate ALL of them !!
#           ALL_METADATA_FILES_EXIST=$YES	       
           
#          if [ ! -f $PROD_METADATA_FILE_SGML ] ; then 
#             export ALL_METADATA_FILES_EXIST=$NO
#	  fi

        # FGDC xml ==>  AVHRR.N16.2002.06.16.1443.Jun.FGDC.detail.xml
    	if [ ! -f $PROD_METADATA_FILE_XML ] ; then 
	     export ALL_METADATA_FILES_EXIST=$NO 
	fi
	 # FGDC json ==> AVHRR.N16.2002.06.16.1443.Jun.FGDC.detail.json
     	if [ ! -f $PROD_METADATA_FILE_JSON ] ; then 
	     export ALL_METADATA_FILES_EXIST=$NO 
	fi
        # FGDC txt ==> AVHRR.N16.2002.06.16.1443.Jun.FGDC.detail.txt
     	if [ ! -f $PROD_METADATA_FILE_TXT ] ; then 
            export ALL_METADATA_FILES_EXIST=$NO
	fi 
	  	  
        filename=`basename $PROD_METADATA_FILE_XML`
        filepath=`dirname $PROD_METADATA_FILE_XML`
            
        OUTPUTFILE_ISO_XML="$filepath/${filename/FGDC/ISO19115}"
        OUTPUTFILE_ISO_XML_FILENAME=`basename $OUTPUTFILE_ISO_XML`
        OUTPUTFILE_ISO_JSON="${OUTPUTFILE_ISO_XML/.xml/.json}"
	  	  
	 # ISO xml ==> AVHRR.N15.2015.03.31.1813.Mar.ISO19115.detail.xml
	 if [ ! -f $OUTPUTFILE_ISO_XML ] ; then 
            export ALL_METADATA_FILES_EXIST=$NO
	 fi 	  	  
	 # ISO json ==> AVHRR.N16.2002.06.16.1443.Jun.ISO19115.detail.json
	 if [ ! -f $OUTPUTFILE_ISO_JSON ] ; then 
            export ALL_METADATA_FILES_EXIST=$NO
	 fi 
	  	  
	  # Header json file   ==> AVHRR.N16.2002.06.16.1443.Jun.HEADER.detail.json
	 if [ ! -f $PROD_METADATA_HEADER_JSON ] ; then 
            export ALL_METADATA_FILES_EXIST=$NO
	 fi 
    
}



Build_DOCUUID()
{       

#2012-01-17 13:58:32.239338-09
PSQL_NOW=`psql -d $POSTGRES_SID -U $CHAASE -At -c "select * from now()"`       

now1=`echo $PSQL_NOW | cut -d. -f1`                      
now2=`echo $PSQL_NOW | cut -d. -f2`
now3=`echo $now2 | cut -d- -f1`
now4=`echo $now2 | cut -d- -f2`
NOW=$now3""$now4

PSQL_NOW=`psql -d $POSTGRES_SID -U $CHAASE -At -c "select * from now()"`       

now5=`echo $PSQL_NOW | cut -d. -f1`                      
now6=`echo $PSQL_NOW | cut -d. -f2`
now7=`echo $now6 | cut -d- -f1`
now8=`echo $now5 | cut -d- -f2`
now9=`echo $now5 | cut -d: -f3`
now10=`echo $now5 | cut -d: -f1`
export DOCUUID_PART1=$NOW
export DOCUUID_PART2=$now9$now4
export DOCUUID_PART3=`date +%H%S`
export DOCUUID_PART4=$now8$now9
export DOCUUID_PART5=`date +%s%H`

DOCUUID=$DOCUUID_PART1"-"$DOCUUID_PART2"-"$DOCUUID_PART3"-"$DOCUUID_PART4"-"$DOCUUID_PART5
DOCUUID_MD5=`$PSQL -d gina_dba -At -U $CHAASE -c "select md5('$DOCUUID')";`
}


Build_DOCUUID_NEW()
{       

# OS method
#export UUID_OS=`uuid -v3 ns:URL http:/www.ossp.org`
export DOCUUID=`uuid -v3 ns:URL http:/www.ossp.org`

#2012-01-17 13:58:32.239338-09
PSQL_NOW=`psql -d $POSTGRES_SID -U $CHAASE -At -c "select * from now()"`       

# this step not necessary...but if choose to add this to db insert field name
#DOCUUID_MD5=`$PSQL -d gina_dba -At -U $CHAASE -c "select md5('$DOCUUID')";`

}



Build_XML_Strings()
{       
	
# set those parameter values not previously set for SQL procedure table inserts
METADATADATE=$PUBDATE
FORMATVERSIONDATE=$PUBDATE
TITLE_YEAR=`echo $YEAR_YYYY"_"`

if [ $METADATA_LEVEL == $SUM ]; then        
     BEGINDATE=$YEAR_YYYY""$MONTH_NN"01"
     ENDDATE=$YEAR_YYYY""$MONTH_NN""$DAYS_IN_MONTH
     RANGEBEGINNINGDATE=$YEAR_YYYY"/"$MONTH_NN"/01 00:00:00"
     RANGEENDINGDATE=$YEAR_YYYY"/"$MONTH_NN"/"$DAYS_IN_MONTH" 00:00:00"
    
     TITLE=`echo $SATELLITE_RPT" "$TITLE_YEAR""$MONTH_NN" ("$MONTH_ALPHA""$ONESPACE""$YEAR_YYYY")"`

     OUTPUT_METADATA_FILE=$SENSOR_ID"."$ID"."$YEAR_YYYY"."$MONTH_NN"."$MONTH_Mon"."$TEMPLATE_TYPE".summary"     
else
     TIME_FILEDATE=$DAY_YYJULIAN"."$TIME_HHMM        
     BEGINDATE=$YEAR_YYYY""$MONTH_NN""$DAY_NN
     ENDDATE=$BEGINDATE
     RANGEBEGINNINGDATE=$YEAR_YYYY"/"$MONTH_NN"/"$DAY_NN"/"$TIME_HHMM
     RANGEENDINGDATE=$RANGEBEGINNINGDATE
        
     # NOT ==> STARTTIME_HH24MMSS the colons WILL bomb in MP !!!!!!!!!!
     BEGINTIME=$TIME_HHMM
     ENDTIME=$TIME_HHMM

     TITLE_MONTH=`echo $MONTH_NN"_"`
     TITLE=`echo $SATELLITE_RPT" "$TITLE_YEAR""$TITLE_MONTH""$DAY_NN" "$TIME_HHMM" ("$MONTH_ALPHA""$ONESPACE""$MONTH_NN""$ONESPACE""$YEAR_YYYY"$ONESPACE""$START_TIME)"` 
     OUTPUT_METADATA_FILE=$SENSOR_ID"."$ID"."$YEAR_YYYY"."$MONTH_NN"."$DAY_NN"."$TIME_HHMM"."$MONTH_Mon"."$TEMPLATE_TYPE".detail"
     OUTPUT_METADATA_HEADER=$SENSOR_ID"."$ID"."$YEAR_YYYY"."$MONTH_NN"."$DAY_NN"."$TIME_HHMM"."$MONTH_Mon".HEADER.detail"

fi
}

Build_Metadata_Title()
{          

SENSOR_RPT=`psql  gina_dba -U postgres -AtF, -c "SELECT DISTINCT sensor_rpt from gina_metadata.metadata_rpt_info where sv_id='$ID'"`
CHANNELS=`psql  gina_dba -U postgres -AtF, -c  "SELECT DISTINCT channels from gina_metadata.metadata_rpt_info where sv_id='$ID'"`
PROVIDER_GCMD=`psql  gina_dba -U postgres -AtF, -c  "SELECT DISTINCT trim(provider_gcmd) from gina_metadata.metadata_rpt_info where sv_id='$ID'"`
PROJECT_GCMD=`psql  gina_dba -U postgres -AtF, -c  "SELECT DISTINCT trim(project_gcmd) from gina_metadata.metadata_rpt_info where sv_id='$ID'"`
PLATFORM=`psql  gina_dba -U postgres -AtF, -c  "SELECT DISTINCT platform from gina_metadata.metadata_rpt_info where sv_id='$ID'"`
PLATFORM_GCMD=`psql  gina_dba -U postgres -AtF, -c  "SELECT DISTINCT trim(platform_gcmd) from gina_metadata.metadata_rpt_info where sv_id='$ID'"`
INSTRUMENT_GCMD=`psql  gina_dba -U postgres -AtF, -c  "SELECT DISTINCT trim(instrument_gcmd) from gina_metadata.metadata_rpt_info where sv_id='$ID'"`
SATELLITE_RPT=`psql  gina_dba -U postgres -AtF, -c  "SELECT DISTINCT satellite_rpt from gina_metadata.metadata_rpt_info where sv_id='$ID'"`
TEMPLATE_FILE_NAME=`psql  gina_dba -U postgres -AtF, -c "SELECT DISTINCT template_file_name from gina_metadata.metadata_rpt_info where sv_id='$ID'"`


if [ $SENSOR_ID == "AQUA1" ]; then
     PLATFORM_GCMD=$AQUA
     INSTRUMENT_GCMD=$MODIS
     PROJECT_GCMD=$AQUA
     PROVIDER_GCMD=$NASA
elif [ $SENSOR_ID == "TERRA1" ]; then
     PLATFORM_GCMD=$TERRA
     INSTRUMENT_GCMD=$MODIS
     PROJECT_GCMD=$TERRA
     PROVIDER_GCMD=$NASA
elif [ $SENSOR_ID == $AVHRR ]; then
     PLATFORM_GCMD=$NOAA'-'$SENSOR_RPT
     INSTRUMENT_GCMD=$AVHRR
     PROJECT_GCMD=$PROJECT_GCMD_AVHRR
     PROVIDER_GCMD=$NOAA
else
     echo "ERROR ====> FOOBAR"
     PLATFORM_GCMD="FOOBAR"
     INSTRUMENT_GCMD="FOOBAR"
     PROJECT_GCMD="FOOBAR"
     PROVIDER_GCMD="FOOBAR"
fi


if [ $DEBUG == $YES ]; then 

echo "SENSOR: "      $SENSOR
#echo "AGENCY_ID:"    $AGENCY_ID
echo "ID: "          $ID
echo "PROVIDER_GCMD:   " $PROVIDER_GCMD
echo "PROJECT_GCMD:   " $PROJECT_GCMD
echo "PLATFORM_GCMD:   " $PLATFORM_GCMD
echo "INSTRUMENT_GCMD: " $INSTRUMENT_GCMD

#exit
fi

}




Blurb_Generating_Metadata_Files()
{
Print_Blank_Line
Print_Star_Line
Print_Blank_Line
echo " Generating Metadata files for : " $OUTPUT_METADATA_FILE  >> $LOG_FILE
Print_Blank_Line
Print_Star_Line
Print_Blank_Line         
}



Blurb_Metadata_Files_Exist()
{      
Print_Blank_Line	
Print_Star_Line
Print_Blank_Line
echo " ALL metadata files exist for : " $OUTPUT_METADATA_FILE    >> $LOG_FILE
Print_Blank_Line
Print_Star_Line
Print_Blank_Line             
}     




Blurb_Error_in_MP_File()
{

echo "..... ** Error in MP for file:" $TEMP_METADATA_FILE_ERR >> $LOG_FILE;  
exit 1

# echo "PROD_METADATA_FILE_ERR: "  $PROD_METADATA_FILE_ERR  >> $LOG_FILE_ERROR;  
#echo "=====> METADATA_FILE_ERR: "  $TEMP_METADATA_FILE_ERR $PROD_METADATA_FILE_ERR  >> $LOG_FILE_ERROR

# SAVE the error file by moving it BACK to TEMP area, zap rest of temp and prod files.
#echo "PROD_METADATA_FILE_ERR: "  $PROD_METADATA_FILE_ERR
#mv $PROD_METADATA_FILE_ERR $TEMP_METADATA_FILE_ERR 
#rm $TEMP_METADATA_FILE_ERR


#  Prints out ====> ./01_Jan/AVHRR.N12.2000.01.11.0316.January.FGDC.detail.err:Error
# one line with just the err file for the xml 
#grep  Error ./*/*err |  awk '{print $1}'  > GOS_2011_updates_AVHRR_errors.lst  

#  Prints out ====> ./01_Jan/AVHRR.N12.2000.01.11.0316.January.FGDC.detail.err:Error Content+files blah blah blah
# multiple lines with all error messages
#grep  Error .$PROD_METADATA_FILE_ERR  > GOS_2011_updates_AVHRR_errors.lst  

#  cat $TEMP_METADATA_FILE_ERR               
}




Cleanup_Metadata_Files()
{
                                         
# Delete temp files only when MP is fine.
rm $TEMP_ION/*tmp.*     
rm $TEMP_ION/*.tmp

rm $PROD_ION/*tmp.*     
rm $PROD_ION/*.tmp

echo "PROD_METADATA_FILE_ERR: "  $PROD_METADATA_FILE_ERR

rm $PROD_METADATA_FILE_ERR
                       
rm $TEMP_METADATA_FILE_TXT  
rm $TEMP_METADATA_FILE_HTML 
rm $TEMP_METADATA_FILE_XML  
rm $TEMP_METADATA_FILE_SGML 
rm $TEMP_METADATA_FILE_FAQ  
rm $TEMP_METADATA_FILE_ERR
rm $TEMP_METADATA_FILE_TMP
rm $TEMP_METADATA_FILE_DIF  
rm $TEMP_METADATA_FILE_JSON

      			            
}




Get_Metadata_Parser_Version()
{
METADATA_PARSER_VERSION=`grep "mp" $PROD_METADATA_FILE_ERR | awk '{print $2}'`                              
}


Get_Output_Metadata_File()
{


# =====> SAN_DIR_LOCAL set in EXPORT_GINA_HOSTS.bash -- machine dependant
export PROD_EXPORT_METADATA=$SAN_DIR_METADATA/export/htdocs/ION
export LOCAL_EXPORT_METADATA=$SAN_DIR_METADATA/local/htdocs/ION


    export LOCAL_METADATA_DUMP_DIR=$LOCAL_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
    export PROD_METADATA_DUMP_DIR=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
    export METADATA_DUMP_DIR=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
   export ARCHIVE_METADATA_DIR=/home/backups/pgdata_backups/pgsqldata/export/metadata/htdocs/ION/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY

# =====> TEMP_ION=$SAN_DIR_LOCAL/metadata/local/ION/$SENSOR set in EXPORT_GINA_HOSTS.bash -- machine dependant

    TEMP_METADATA_FILE_SGML=$TEMP_ION/$OUTPUT_METADATA_FILE".sgml"
    TEMP_METADATA_FILE_XML=$TEMP_ION/$OUTPUT_METADATA_FILE".xml"
    TEMP_METADATA_FILE_TXT=$TEMP_ION/$OUTPUT_METADATA_FILE".txt"
    TEMP_METADATA_FILE_HTML=$TEMP_ION/$OUTPUT_METADATA_FILE".html"
    TEMP_METADATA_FILE_ERR=$TEMP_ION/$OUTPUT_METADATA_FILE".err"
    TEMP_METADATA_FILE_FAQ=$TEMP_ION/$OUTPUT_METADATA_FILE".faq"
    TEMP_METADATA_FILE_DIF=$TEMP_ION/$OUTPUT_METADATA_FILE".dif" 
    TEMP_METADATA_FILE_JSON=$TEMP_ION/$OUTPUT_METADATA_FILE".json" 
        
    # (Isite needs SGML not XML, GOS needs XML) 
     OUTPUT_METADATA_FILE_SGML=$LOCAL_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".sgml"
     OUTPUT_METADATA_FILE_XML=$LOCAL_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".xml"
     OUTPUT_METADATA_FILE_TXT=$LOCAL_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".txt"
     OUTPUT_METADATA_FILE_HTML=$LOCAL_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".html"
     OUTPUT_METADATA_FILE_ERR=$LOCAL_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".err"
     OUTPUT_METADATA_FILE_JSON=$LOCAL_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".json"
     OUTPUT_METADATA_FILE_FAQ=$LOCAL_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".faq"
     OUTPUT_METADATA_FILE_DIF=$LOCAL_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".dif"
         
      PROD_METADATA_FILE_SGML=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".sgml"
      PROD_METADATA_FILE_XML=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".xml"
      PROD_METADATA_FILE_TXT=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".txt"
      PROD_METADATA_FILE_HTML=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".html"
      PROD_METADATA_FILE_ERR=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".err"
      PROD_METADATA_FILE_FAQ=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".faq"
      PROD_METADATA_FILE_DIF=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".dif"        
      PROD_METADATA_FILE_JSON=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_FILE".json"
     
      PROD_METADATA_HEADER_JSON=$PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_HEADER".json"
      
}


Get_Sensor_Info()
{

ALL="ALL"
SENSOR_LIST=$SENSOR
if [ $METADATA_LEVEL == $SUM ]; then 
     SELECT_STRING="select distinct substr(id,1,3), sensor_id, extract(year from start_time), extract(month from start_time) "
     DATE_STRING=" start_time >= '$SV_START_DATE' and end_time <= '$SV_END_DATE' "
else
     SELECT_STRING="select id, sensor_id, extract(year from start_time), extract(month from start_time), to_char(start_time,'YYYY-MM-DD'), to_char(end_time,'YYYY-MM-DD'), to_char(start_time,'HH12:MI:SS'), relative_path " 
     DATE_STRING=" start_time >= '$SV_START_DATE' and end_time <= '$SV_END_DATE' "
fi
if [ $SENSOR == $ALL ]; then
     FROM_WHERE_CLAUSE=" from public.metadata_basic_dba " 
else
#    FROM_WHERE_CLAUSE=" from gina_metadata.metadata_basic_dba where sensor_id IN ('$SENSOR') order by relative_path " 
     FROM_WHERE_CLAUSE=" from public.metadata_basic_dba where sensor_id IN ('$SENSOR') " 
     ORDER_BY_CLAUSE=" order by relative_path "   
fi

# ====> SOURCE_DIR set in EXPORT_GINA_HOSTS
export IONMETADATAGRANULES=$SOURCE_DIR/"IONMETADATAGRANULES_"$SENSOR"_"$METADATA_CATEGORY"."$LOGDATE".txt" 

echo "HOSTNAME: " $HOSTNAME
echo "HOST: " $HOST
echo "SOURCE_DIR: " $SOURCE_DIR

$PSQL $POSTGRES_SID -U $CHAASE -AtF, -c "$SELECT_STRING $FROM_WHERE_CLAUSE and substr(relative_path,1,5) NOT IN ('misc/', 'realt/') and $DATE_STRING order by relative_path; " > $IONMETADATAGRANULES

# cat $IONMETADATAGRANULES
# exit

}



Get_TemplateName()
{
 
              
METADATA_CATEGORY=$TEMPLATE_TYPE"_"$METADATA_LEVEL

# =====> GINA_DIR, TEMPLATE_DIR set in EXPORT_GINA_HOSTS.bash

# IONMETADATAGRANULES=$SOURCE_DIR/"IONMETADATAGRANULES_"$SENSOR"_"$METADATA_CATEGORY"."$LOGDATE".txt" 
        
TEMPLATE_FILE_NAME="TEMPLATE."$TEMPLATE_TYPE".ION."$SENSOR"."$METADATA_LEVEL".txt"
TEMPLATE_FILE_NAME_TXT="TEMPLATE."$TEMPLATE_TYPE".ION."$SENSOR"."$METADATA_LEVEL".txt"
TEMPLATE_FILE_NAME_JSON="TEMPLATE."$TEMPLATE_TYPE".ION."$SENSOR"."$METADATA_LEVEL".json"
TEMPLATE_FILE_NAME_XML="TEMPLATE."$TEMPLATE_TYPE".ION."$SENSOR"."$METADATA_LEVEL".xml"

TEMPLATE_FILE_NAME_JSON_ION="TEMPLATE.ION.DET.json"


METADATATEMPLATE=$TEMPLATE_DIR/$TEMPLATE_FILE_NAME
METADATATEMPLATE_TXT=$TEMPLATE_DIR/$TEMPLATE_FILE_NAME_TXT
METADATATEMPLATE_XML=$TEMPLATE_DIR/$TEMPLATE_FILE_NAME_XML
#METADATATEMPLATE_JSON=$TEMPLATE_DIR/$TEMPLATE_FILE_NAME_JSON
METADATATEMPLATE_JSON=$TEMPLATE_DIR/$TEMPLATE_FILE_NAME_JSON_ION
                	
METADATA_FILE_NAME=$SENSOR_ID"."$YEAR_YYYY"."$MONTH_NN"."$DAY_NN"."$TIME_HHMM"."$MONTH_ALPHA"."$TEMPLATE_TYPE"."$METADATA_LEVEL"."$THEDATE".dat"     

METADATA_FILES=$GINA_DIR/$METADATA_FILE_NAME

TEMPLATE_FILES_JSON=$GINA_DIR/$TEMPLATE_FILE_NAME_JSON
TEMPLATE_FILES_XML=$GINA_DIR/$TEMPLATE_FILE_NAME_XML
TEMPLATE_FILES_TXT=$GINA_DIR/$TEMPLATE_FILE_NAME_TXT
      
}



MP_Files_GEONET()
{
        
cd $TEMP_ION      
#echo "TEMP_ION:  "  $TEMP_ION
#echo "PROD_ION:   "  $PROD_ION

      TAR_METADATA_FILE=$PLATFORM"."$SENSOR"."$YEAR_YYYY"."$MONTH_NN"."$TIME_FILEDATE"."$MONTH_ALPHA"."$TEMPLATE_TYPE"."$METADATA_LEVEL	

##################### TXT files ####################################

      METADATAFILENAME_TEMP_TXT=$OUTPUT_METADATA_FILE".txt.tmp"

      cp $METADATATEMPLATE_TXT  $TEMP_ION/$METADATAFILENAME_TEMP_TXT           
             
      perl -pi -e  "s/$PUBDATE_HEADER/$PUBDATE/g"                	$METADATAFILENAME_TEMP_TXT      
      perl -pi -e  "s/$METADATADATE_HEADER/$METADATADATE/g"  		$METADATAFILENAME_TEMP_TXT    
      perl -pi -e  "s/$FORMATVERSIONDATE_HEADER/$FORMATVERSIONDATE/g"   $METADATAFILENAME_TEMP_TXT    
      perl -pi -e  "s/$PROCESSDATE_HEADER/$PUBDATE/g"        		$METADATAFILENAME_TEMP_TXT     
      perl -pi -e  "s/$TITLE_HEADER/$TITLE/g"                		$METADATAFILENAME_TEMP_TXT    
      perl -pi -e  "s/$BEGINDATE_HEADER/$BEGINDATE/g"        		$METADATAFILENAME_TEMP_TXT    
      perl -pi -e  "s/$ENDDATE_HEADER/$ENDDATE/g"            		$METADATAFILENAME_TEMP_TXT    
      perl -pi -e  "s/$BEGINTIME_HEADER/$TIME_HHMM/g"              $METADATAFILENAME_TEMP_TXT    
      perl -pi -e  "s/$ENDTIME_HEADER/$TIME_HHMM/g"        		  $METADATAFILENAME_TEMP_TXT    
      perl -pi -e "s/SV_VIEW_SCENE_SID_goes_here/http:\/\/sv.gina.alaska.edu\/view_scene.pl?sid=$SV_ID/g"  $METADATAFILENAME_TEMP_TXT    
      perl -pi -e "s/BROWSE_goes_here/http:\/\/sv.gina.alaska.edu\/metadata\/$sensor_id\/$YEAR_YYYY\/$SV_ID\/browse.jpg/g"  $METADATAFILENAME_TEMP_TXT   
        
if [ $DEBUG == $YES ]; then 
     grep "goes_here" $METADATAFILENAME_TEMP_TXT     >> $LOG_FILE;
     GREP_STATUS=$?		  
     if [ $GREP_STATUS -ne $SE_SUCCESS ]; then      >> $LOG_FILE; 
          TEMP_METADATA_FILE_ERR=$METADATAFILENAME_TEMP_TXT
          Blurb_Error_in_MP_File                                           
     fi                
fi

 cp   $METADATAFILENAME_TEMP_TXT   $PROD_METADATA_FILE_TXT
 
      ##################### Creating FGDC XML file from FGDC TXT FILE ####################################

      METADATAFILENAME_TEMP_XML=$OUTPUT_METADATA_FILE".xml.tmp"

      cp $METADATATEMPLATE_XML  $TEMP_ION/$METADATAFILENAME_TEMP_XML           
             
      perl -pi -e  "s/$PUBDATE_HEADER/$PUBDATE/g"                	$METADATAFILENAME_TEMP_XML   
      perl -pi -e  "s/$METADATADATE_HEADER/$METADATADATE/g"  		$METADATAFILENAME_TEMP_XML 
      perl -pi -e  "s/$FORMATVERSIONDATE_HEADER/$FORMATVERSIONDATE/g"   $METADATAFILENAME_TEMP_XML 
      perl -pi -e  "s/$PROCESSDATE_HEADER/$PUBDATE/g"        		$METADATAFILENAME_TEMP_XML 
      perl -pi -e  "s/$TITLE_HEADER/$TITLE/g"                		$METADATAFILENAME_TEMP_XML 
      perl -pi -e  "s/$BEGINDATE_HEADER/$BEGINDATE/g"        		$METADATAFILENAME_TEMP_XML 
      perl -pi -e  "s/$ENDDATE_HEADER/$ENDDATE/g"            		$METADATAFILENAME_TEMP_XML 
      perl -pi -e  "s/$BEGINTIME_HEADER/$TIME_HHMM/g"             $METADATAFILENAME_TEMP_XML 
      perl -pi -e  "s/$ENDTIME_HEADER/$TIME_HHMM/g"        		  $METADATAFILENAME_TEMP_XML 
      perl -pi -e "s/SV_VIEW_SCENE_SID_goes_here/http:\/\/sv.gina.alaska.edu\/view_scene.pl?sid=$SV_ID/g" $METADATAFILENAME_TEMP_XML      
      perl -pi -e "s/BROWSE_goes_here/http:\/\/sv.gina.alaska.edu\/metadata\/$sensor_id\/$YEAR_YYYY\/$SV_ID\/browse.jpg/g"  $METADATAFILENAME_TEMP_XML 
 
      cp   $METADATAFILENAME_TEMP_XML   $PROD_METADATA_FILE_XML   

      ##################### Converting FGDC XML file to ISO1995 XML file via XSLT's ####################################
     
            filename=`basename $PROD_METADATA_FILE_XML`
            filepath=`dirname $PROD_METADATA_FILE_XML`
            
            OUTPUTFILE_FGDC_JSON="$filepath/${filename/.xml/.json}"
            echo "Converting: $filename ->  $OUTPUTFILE_FGDC_JSON "
           $RUN_SAXON -s:$PROD_METADATA_FILE_XML -xsl:$XML_TO_JSON_XSL -o:$OUTPUTFILE_FGDC_JSON

            OUTPUTFILE_ISO_XML="$filepath/${filename/FGDC/ISO19115}"
            OUTPUTFILE_ISO_XML_FILENAME=`basename $OUTPUTFILE_ISO_XML`
            echo "Converting: $filename -> $OUTPUTFILE_ISO_XML"
           $RUN_SAXON  -s:$PROD_METADATA_FILE_XML -xsl:$CSDGM_TO_ISO19115_XSLT -o:$OUTPUTFILE_ISO_XML

            OUTPUTFILE_ISO_JSON="${OUTPUTFILE_ISO_XML/.xml/.json}"
            echo "Converting: $filename  -> $OUTPUTFILE_ISO_JSON"
           $RUN_SAXON  -s:$OUTPUTFILE_ISO_XML -xsl:$XML_TO_JSON_XSL  -o:$OUTPUTFILE_ISO_JSON
      
           ##################### Creating FGDC and JSON HEADER file for mongodb ####################################
 
      METADATAFILENAME_TEMP_JSON=$TEMP_ION/TEMPLATE.ION.DET.json.tmp
      cp $METADATATEMPLATE_JSON  $METADATAFILENAME_TEMP_JSON

      perl -pi -e "s/SV_SENSOR_ID_goes_here/$SENSOR/g"                          $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/SV_ID_goes_here/$SV_ID/g"                                  $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/FILENAME_FGDC_goes_here/$OUTPUT_METADATA_FILE.xml/g"       $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/FILENAME_ISO_goes_here/$OUTPUTFILE_ISO_XML_FILENAME/g"     $METADATAFILENAME_TEMP_JSON
      
      perl -pi -e "s/TEMPLATE_goes_here/$TEMPLATE_FILE_NAME_TXT/g"      $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/DOCUUID_goes_here/$DOCUUID_MD5/g"                   $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/RELATIVE_PATH_SV_goes_here/\/$sensor_id\/$YEAR_YYYY\/$SV_ID\//g" $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/RUNTYPE_goes_here/$RUN_TYPE/g"                  $METADATAFILENAME_TEMP_JSON    
      perl -pi -e "s/COMMENT_goes_here/$COMMENT/g"                   $METADATAFILENAME_TEMP_JSON 
      perl -pi -e "s/CREATEDATETIME_goes_here/$PSQL_NOW/g"           $METADATAFILENAME_TEMP_JSON 
      perl -pi -e "s/PROVIDER_GCMD_goes_here/$PROVIDER_GCMD/g"       $METADATAFILENAME_TEMP_JSON 
      perl -pi -e "s/PROJECT_GCMD_goes_here/$PROJECT_GCMD/g"         $METADATAFILENAME_TEMP_JSON 
      perl -pi -e "s/PLATFORM_GCMD_goes_here/$PLATFORM_GCMD/g"       $METADATAFILENAME_TEMP_JSON 
      perl -pi -e "s/INSTRUMENT_GCMD_goes_here/$INSTRUMENT_GCMD/g"   $METADATAFILENAME_TEMP_JSON 

      perl -pi -e  "s/$PUBDATE_HEADER/$PUBDATE/g"                	$METADATAFILENAME_TEMP_JSON     
      perl -pi -e  "s/$TITLE_HEADER/$TITLE/g"                		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/SV_VIEW_SCENE_SID_goes_here/http:\/\/sv.gina.alaska.edu\/view_scene.pl?sid=$SV_ID/g"  $METADATAFILENAME_TEMP_JSON  
      perl -pi -e  "s/$BEGINDATE_HEADER/$BEGINDATE/g"        		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$METADATADATE_HEADER/$METADATADATE/g"  		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$FORMATVERSIONDATE_HEADER/$FORMATVERSIONDATE/g"   $METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$PROCESSDATE_HEADER/$PUBDATE/g"        		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$ENDDATE_HEADER/$ENDDATE/g"            		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$BEGINTIME_HEADER/$TIME_HHMM/g"                   $METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$ENDTIME_HEADER/$TIME_HHMM/g"        		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/BROWSE_goes_here/http:\/\/sv.gina.alaska.edu\/metadata\/$sensor_id\/$YEAR_YYYY\/$SV_ID\/browse.jpg/g"  $METADATAFILENAME_TEMP_JSON 

      cp   $METADATAFILENAME_TEMP_JSON   $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_HEADER".json"

       
if [ $DEBUG == $YES ]; then       
      GREP_STATUS=$SE_SUCCESS
       grep "goes_here" $METADATAFILENAME_TEMP_XML     >> $LOG_FILE;
       GREP_STATUS=$?		  
       if [ $GREP_STATUS -ne $SE_SUCCESS ]; then      >> $LOG_FILE;  
            METADATAFILENAME_TEMP_XML=$TEMP_METADATA_FILE_ERR
            Blurb_Error_in_MP_File                                        
       fi      
fi    

    
}

Parse_Sat_Sensor()
{          
if [ $METADATA_LEVEL == $SUM ]; then   
     SENSOR_ID=`echo $SAT_REC | cut -d, -f2`                      
     if [ $SENSOR_ID == $AQUA1 ]|| [ $AGENCY_ID == $TERRA1 ]; then
          ID=`echo $SAT_REC | cut -d. -f1`                         
     else
          ID=`echo $SAT_REC | cut -d, -f1`                       
     fi
     RELATIVE_PATH=`echo $SAT_REC | cut -d, -f5`                
     id_tmp=`echo $RELATIVE_PATH | cut -d/ -f2`                  
     id1=`echo $RELATIVE_PATH  | cut -d. -f2`                   
     id2=`echo $RELATIVE_PATH | cut -d. -f1`                    
     id=`echo $id2 | cut -d/ -f3`
     sensor_id=`echo $RELATIVE_PATH | cut -d/ -f1`                
     TIME_HHMM=`echo $RELATIVE_PATH | cut -d. -f3`                    
     DAY_YYJULIAN=`echo $RELATIVE_PATH | cut -d. -f2`           
     YEAR_YYYY=`echo $SAT_REC | cut -d, -f3`                  
     MONTH_N=`echo $SAT_REC | cut -d, -f4`                     
else 
     ID=`echo $SAT_REC | cut -d. -f1`                      
     SV_ID=`echo $SAT_REC | cut -d, -f1`
     SENSOR_ID=`echo $SAT_REC | cut -d, -f2`                 
     RELATIVE_PATH=`echo $SAT_REC | cut -d, -f8`               
     id_tmp=`echo $RELATIVE_PATH | cut -d/ -f2`                
     id1=`echo $RELATIVE_PATH  | cut -d. -f2`                  
     id2=`echo $RELATIVE_PATH | cut -d. -f1`                     
     id=`echo $id2 | cut -d/ -f3`                           
     sensor_id=`echo $RELATIVE_PATH | cut -d/ -f1`               
     START_DATE=`echo $SAT_REC | cut -d, -f5`                    
     END_DATE=`echo $SAT_REC | cut -d, -f6`                     
     START_TIME=`echo $SAT_REC | cut -d, -f7`                
     END_TIME=$START_TIME                           
     MONTH_N=`echo $SAT_REC | cut -d, -f4`                
     TIME_HHMM=`echo $RELATIVE_PATH | cut -d. -f3`            
     DAY_YYJULIAN=`echo $RELATIVE_PATH | cut -d. -f2`           
     # stuff from START_DATE..month/day/year is the SAME for Start and End times.
     YEAR_YYYY=`echo $START_DATE | cut -d- -f1`          
     DAY_NN=`echo $START_DATE | cut -d- -f3`  
     
     if [ $FIRST_TIME == $YES ]; then
         YEAR_YYYY_PREVIOUS=$YEAR_YYYY
         FIRST_TIME=$NO
     fi
                 
fi

}


############################ NOT USED ANYMORE ############################################################
MP_Files()
{
        
cd $TEMP_ION      

#echo "TEMP_ION:  "  $TEMP_ION
#echo "PROD_ION:   "  $PROD_ION

      TAR_METADATA_FILE=$PLATFORM"."$SENSOR"."$YEAR_YYYY"."$MONTH_NN"."$TIME_FILEDATE"."$MONTH_ALPHA"."$TEMPLATE_TYPE"."$METADATA_LEVEL	
      METADATAFILENAME_TEMP_JSON=$OUTPUT_METADATA_FILE".tmp"

##################### XML files ####################################

      TAR_METADATA_FILE=$PLATFORM"."$SENSOR"."$YEAR_YYYY"."$MONTH_NN"."$TIME_FILEDATE"."$MONTH_ALPHA"."$TEMPLATE_TYPE"."$METADATA_LEVEL	
      METADATAFILENAME_TEMP=$OUTPUT_METADATA_FILE".tmp"

      cp $METADATATEMPLATE  $TEMP_ION/$METADATAFILENAME_TEMP           
             
      perl -pi -e  "s/$PUBDATE_HEADER/$PUBDATE/g"                	$METADATAFILENAME_TEMP     
      perl -pi -e  "s/$METADATADATE_HEADER/$METADATADATE/g"  		$METADATAFILENAME_TEMP
      perl -pi -e  "s/$FORMATVERSIONDATE_HEADER/$FORMATVERSIONDATE/g"   $METADATAFILENAME_TEMP
      perl -pi -e  "s/$PROCESSDATE_HEADER/$PUBDATE/g"        		$METADATAFILENAME_TEMP
      perl -pi -e  "s/$TITLE_HEADER/$TITLE/g"                		$METADATAFILENAME_TEMP
      perl -pi -e  "s/$BEGINDATE_HEADER/$BEGINDATE/g"        		$METADATAFILENAME_TEMP
      perl -pi -e  "s/$ENDDATE_HEADER/$ENDDATE/g"            		$METADATAFILENAME_TEMP
      perl -pi -e  "s/$BEGINTIME_HEADER/$TIME_HHMM/g"              $METADATAFILENAME_TEMP
      perl -pi -e  "s/$ENDTIME_HEADER/$TIME_HHMM/g"        		   $METADATAFILENAME_TEMP
               
      mv  $METADATAFILENAME_TEMP   $PROD_METADATA_FILE_TXT
 
# ORIG $MP -x $PROD_METADATA_FILE_XML -e $PROD_METADATA_FILE_ERR $PROD_METADATA_FILE_TXT  -c $METADATA_CONFIG_FILE >> $LOG_FILE; 
      $MP -x $PROD_METADATA_FILE_XML -e $PROD_METADATA_FILE_ERR $PROD_METADATA_FILE_TXT  >> $LOG_FILE; 


# =========> NEED TO SED HERE for correct URL online linkage
     cp $PROD_METADATA_FILE_XML $PROD_METADATA_FILE_XML.1
     cp $PROD_METADATA_FILE_TXT $PROD_METADATA_FILE_TXT.1


          # fixing xml   
           perl -pi -e "s/SV_VIEW_SCENE_SID_goes_here/http:\/\/sv.gina.alaska.edu\/view_scene.pl?sid=$SV_ID/g"  $PROD_METADATA_FILE_XML.1      
           perl -pi -e "s/BROWSE_goes_here/http:\/\/sv.gina.alaska.edu\/metadata\/$sensor_id\/$YEAR_YYYY\/$SV_ID\/browse.jpg/g"  $PROD_METADATA_FILE_XML.1
           cp   $PROD_METADATA_FILE_XML.1  $PROD_METADATA_FILE_XML
          
          # fixing txt
          perl -pi -e "s/SV_VIEW_SCENE_SID_goes_here/http:\/\/sv.gina.alaska.edu\/view_scene.pl?sid=$SV_ID/g"  $PROD_METADATA_FILE_TXT.1     
          perl -pi -e "s/BROWSE_goes_here/http:\/\/sv.gina.alaska.edu\/metadata\/$sensor_id\/$YEAR_YYYY\/$SV_ID\/browse.jpg/g"  $PROD_METADATA_FILE_TXT.1
          cp   $PROD_METADATA_FILE_TXT.1  $PROD_METADATA_FILE_TXT


#################  JSON FILES #########################################################


   cp $METADATATEMPLATE_JSON  $TEMP_ION/$METADATAFILENAME_TEMP_JSON  
   
    
      perl -pi -e "s/SV_SENSOR_ID_goes_here/$SENSOR/g"                 $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/SV_ID_goes_here/$SV_ID/g"                         $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/FILENAME_goes_here/$OUTPUT_METADATA_FILE/g"       $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/TEMPLATE_goes_here/$TEMPLATE_FILE_NAME_JSON/g"    $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/DOCUUID_goes_here/$DOCUUID_MD5/g"                   $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/RELATIVE_PATH_SV_goes_here/\/$sensor_id\/$YEAR_YYYY\/$SV_ID\//g" $METADATAFILENAME_TEMP_JSON
      perl -pi -e "s/RUNTYPE_goes_here/$RUN_TYPE/g"             $METADATAFILENAME_TEMP_JSON    
      perl -pi -e "s/COMMENT_goes_here/$COMMENT/g"             $METADATAFILENAME_TEMP_JSON 
      perl -pi -e "s/CREATEDATETIME_goes_here/$PSQL_NOW/g"    $METADATAFILENAME_TEMP_JSON 

      perl -pi -e  "s/$PUBDATE_HEADER/$PUBDATE/g"                	$METADATAFILENAME_TEMP_JSON     
      perl -pi -e  "s/$TITLE_HEADER/$TITLE/g"                		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/SV_VIEW_SCENE_SID_goes_here/http:\/\/sv.gina.alaska.edu\/view_scene.pl?sid=$SV_ID/g"  $METADATAFILENAME_TEMP_JSON  
      perl -pi -e  "s/$BEGINDATE_HEADER/$BEGINDATE/g"        		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$METADATADATE_HEADER/$METADATADATE/g"  		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$FORMATVERSIONDATE_HEADER/$FORMATVERSIONDATE/g"   $METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$PROCESSDATE_HEADER/$PUBDATE/g"        		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$ENDDATE_HEADER/$ENDDATE/g"            		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$BEGINTIME_HEADER/$TIME_HHMM/g"                   $METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/$ENDTIME_HEADER/$TIME_HHMM/g"        		$METADATAFILENAME_TEMP_JSON 
      perl -pi -e  "s/BROWSE_goes_here/http:\/\/sv.gina.alaska.edu\/metadata\/$sensor_id\/$YEAR_YYYY\/$SV_ID\/browse.jpg/g"  $METADATAFILENAME_TEMP_JSON 

          cp   $METADATAFILENAME_TEMP_JSON   $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/$OUTPUT_METADATA_HEADER

          # zap temp files
         rm $PROD_METADATA_FILE_XML.*
         rm $PROD_METADATA_FILE_TXT.*
    
}
############################ NOT USED ANYMORE ############################################################


############################ NEVER USED OR IN DEVELOPMENT  ############################################################

Insert_GPT_Resources()
{

$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_RESOURCE values ('$DOCUUID',id,$TITLE,$OWNER,$PUBDATE,$PUBDATE,$APPROVALSTATUS,$PUBMETHOD,$SITEUUID,$SOURCEURI,$FILEIDENTIFIER,$ACL,$HOST_URL,$PROTOCOL_TYPE,$PROTOCOL,$FREQUENCY,$SEND_NOTIFICATION,$FINDABLE,$SEARCHABLE,$SYNCHRONIZABLE,$LASTSYNCDATE);"


GPT_RESOURCE_DATA="gina_metadata.gpt_resource_data"
# values docuuid_text, docuuid, id. xml, xml_text,thumbnail
$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_RESOURCE_DATA values ('$SV_ID','$DOCUUID',666,'$OUTPUT_METADATA_FILE',NULL,NULL); "

GPT_HARVESTING_JOBS_COMPLETED="gina_metadata.gpt_harvesting_jobs_completed"
# values id, harvest_id,input_date, harvest_date, docuuid, job_type, job_type, service_id
$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_HARVESTING_JOBS_COMPLETED values ('$DOCUUID','$PUBDATE','$PUBDATE','$DOCUUID','GOS','999'); "

}


Insert_GPT_Records()
{

GPT_RESOURCE_DATA="gina_metadata.gpt_resource_data"
# values docuuid_text, docuuid, id. xml, xml_text,thumbnail
$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_RESOURCE_DATA values ('$SV_ID','$DOCUUID',666,'$OUTPUT_METADATA_FILE',NULL,NULL); "
PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
  Print_Blank_Line  
  echo "** ERROR: PGSQL FAILED for Database: " $POSTGRES_SID  " for table  " $GPT_RESOURCE_DATA  >> $LOG_FILE  

  export COPY_TO_PROD=$NO
  export COPY_TO_ARCHIVE=$NO

  GPT_HARVESTING_JOBS_PENDING="gina_metadata.gpt_harvesting_jobs_pending"
   # values docuuid, harvest_id,input_date, harvest_date, job_status, job_type,criteria, service_id
  $PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_HARVESTING_JOBS_PENDING values ('$DOCUUID','$DOCUUID','$PUBDATE','$PUBDATE','FAILED','GOS','FAILED ON DOCUUID TABLE INSERT','999'); "
  PGSQL_STATUS=$?
  if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
        Print_Blank_Line  
       echo "** ERROR: PGSQL FAILED Database: " $POSTGRES_SID  " for table  " $GPT_HARVESTING_JOBS_PENDING  >> $LOG_FILE  
        Print_Blank_Line    
##        exit 1
  fi
else
   GPT_HARVESTING_JOBS_COMPLETED="gina_metadata.gpt_harvesting_jobs_completed"
   # values id, harvest_id,input_date, harvest_date, docuuid, job_type, job_type, service_id
  $PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_HARVESTING_JOBS_COMPLETED values ('$DOCUUID','$PUBDATE','$PUBDATE','$DOCUUID','GOS','999'); "
fi 



#GPT_RESOURCE="gina_metadata.gpt_resource"
# values ('$DOCUUID',id,$TITLE,$OWNER,$INPUTDATE,$UPDATEDATE,$APPROVALSTATUS,$PUBMETHOD,$SITEUUID,$SOURCEURI,$FILEIDENTIFIER,$ACL,$HOST_URL,$HOST_URL,$PROTOCOL_TYPE,$PROTOCOL,$FREQUENCY,$SEND_NOTIFICATION,$FINDABLE,$SEARCHABLE,$SYNCHRONIZABLE,$LASTSYNCDATE);"
#$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_RESOURCE values ('$DOCUUID',id,$TITLE,$OWNER,$INPUTDATE,$UPDATEDATE,$APPROVALSTATUS,$PUBMETHOD,$SITEUUID,$SOURCEURI,$FILEIDENTIFIER,$ACL,$HOST_URL,$HOST_URL,$PROTOCOL_TYPE,$PROTOCOL,$FREQUENCY,$SEND_NOTIFICATION,$FINDABLE,$SEARCHABLE,$SYNCHRONIZABLE,$LASTSYNCDATE);"

# Check_PGSQL_Status

#GPT_HARVESTING_HISTORY="gina_metadata.gpt_harvesting_history"$GPT_RESOURCE_DATA
#$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_HARVESTING_HISTORY values (id,$HARVEST_ID,$HARVEST_DATE,$HARVESTED_COUNT,'$DOCUUID',$VALIDATED_COUNT,$PUBLISHED_COUNT,$HARVEST_REPORT);"

#GPT_HARVESTING_JOBS_COMPLETED="gina_metadata.gpt_harvesting_jobs_completed"
#$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_HARVESTING_JOBS_COMPLETED values (id,$HARVEST_ID,$INPUT_DATE,$HARVEST_DATE,'$DOCUUID',$JOB_TYPE,$SERVICE_ID);"

# Check_PGSQL_Status

} 

Insert_GPT_Records()
{

GPT_RESOURCE_DATA="gina_metadata.gpt_resource_data"
# values docuuid_text, docuuid, id. xml, xml_text,thumbnail
$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_RESOURCE_DATA values ('$SV_ID','$DOCUUID',666,'$OUTPUT_METADATA_FILE',NULL,NULL); "
PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
  Print_Blank_Line  
  echo "** ERROR: PGSQL FAILED for Database: " $POSTGRES_SID  " for table  " $GPT_RESOURCE_DATA  >> $LOG_FILE  

  export COPY_TO_PROD=$NO
  export COPY_TO_ARCHIVE=$NO

  GPT_HARVESTING_JOBS_PENDING="gina_metadata.gpt_harvesting_jobs_pending"
   # values docuuid, harvest_id,input_date, harvest_date, job_status, job_type,criteria, service_id
  $PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_HARVESTING_JOBS_PENDING values ('$DOCUUID','$DOCUUID','$PUBDATE','$PUBDATE','FAILED','GOS','FAILED ON DOCUUID TABLE INSERT','999'); "
  PGSQL_STATUS=$?
  if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
        Print_Blank_Line  
       echo "** ERROR: PGSQL FAILED Database: " $POSTGRES_SID  " for table  " $GPT_HARVESTING_JOBS_PENDING  >> $LOG_FILE  
        Print_Blank_Line    
##        exit 1
  fi
else
   GPT_HARVESTING_JOBS_COMPLETED="gina_metadata.gpt_harvesting_jobs_completed"
   # values id, harvest_id,input_date, harvest_date, docuuid, job_type, job_type, service_id
  $PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_HARVESTING_JOBS_COMPLETED values ('$DOCUUID','$PUBDATE','$PUBDATE','$DOCUUID','GOS','999'); "
fi 



#GPT_RESOURCE="gina_metadata.gpt_resource"
# values ('$DOCUUID',id,$TITLE,$OWNER,$INPUTDATE,$UPDATEDATE,$APPROVALSTATUS,$PUBMETHOD,$SITEUUID,$SOURCEURI,$FILEIDENTIFIER,$ACL,$HOST_URL,$HOST_URL,$PROTOCOL_TYPE,$PROTOCOL,$FREQUENCY,$SEND_NOTIFICATION,$FINDABLE,$SEARCHABLE,$SYNCHRONIZABLE,$LASTSYNCDATE);"
#$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_RESOURCE values ('$DOCUUID',id,$TITLE,$OWNER,$INPUTDATE,$UPDATEDATE,$APPROVALSTATUS,$PUBMETHOD,$SITEUUID,$SOURCEURI,$FILEIDENTIFIER,$ACL,$HOST_URL,$HOST_URL,$PROTOCOL_TYPE,$PROTOCOL,$FREQUENCY,$SEND_NOTIFICATION,$FINDABLE,$SEARCHABLE,$SYNCHRONIZABLE,$LASTSYNCDATE);"

# Check_PGSQL_Status

#GPT_HARVESTING_HISTORY="gina_metadata.gpt_harvesting_history"$GPT_RESOURCE_DATA
#$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_HARVESTING_HISTORY values (id,$HARVEST_ID,$HARVEST_DATE,$HARVESTED_COUNT,'$DOCUUID',$VALIDATED_COUNT,$PUBLISHED_COUNT,$HARVEST_REPORT);"

#GPT_HARVESTING_JOBS_COMPLETED="gina_metadata.gpt_harvesting_jobs_completed"
#$PSQL -d $POSTGRES_SID -U $CHAASE -c "INSERT into $GPT_HARVESTING_JOBS_COMPLETED values (id,$HARVEST_ID,$INPUT_DATE,$HARVEST_DATE,'$DOCUUID',$JOB_TYPE,$SERVICE_ID);"

# Check_PGSQL_Status

} 





Check_for_MB_DBA_Table()
{

# cheesey but it works
SENSORS_SV=`psql  gina_dba -U $CHAASE -AtF, -c  "SELECT DISTINCT sensor_id from public.metadata_basic"`
SENSOR_THERE=$BLANK
SENSOR_THERE=`psql  gina_dba -U $CHAASE -AtF, -c  "SELECT DISTINCT sensor_id from public.metadata_basic WHERE sensor_id IN ('$SENSOR')"`
if [ "$SENSOR_THERE" == "$BLANK" ]; then	
     Print_Blank_Line  
     echo "** ERROR: SENSOR_ID: " $SENSOR " NOT FOUND IN SWATHVIEWER "  >> $LOG_FILE  
     echo "** VALID SENSORS ARE:  " $SENSORS_SV
     exit 1 ;
fi 

TABLE_NAME="public.metadata_basic_dba"  
CURRENT_RECORD_COUNT=0

     echo "** Getting current copy of the table:  " $TABLE_NAME 
     $PSQL $POSTGRES_SID -U $CHAASE -c "DROP TABLE IF EXISTS $TABLE_NAME;"
     $PSQL $POSTGRES_SID -U $CHAASE -c "$CREATE_TABLE $TABLE_NAME as $SELECT_STAR from public.metadata_basic where start_time IS NOT NULL and sensor_id NOT IN ('NULL','MODIS_BARROW','QB')";
     $PSQL -d $POSTGRES_SID -U $CHAASE -c "$ALTER_TABLE $TABLE_NAME $DROP_COLUMN flags;"
     $PSQL -d $POSTGRES_SID -U $CHAASE -c "$ALTER_TABLE $TABLE_NAME $DROP_COLUMN tagged;"
     $PSQL -d $POSTGRES_SID -U $CHAASE -c "$ALTER_TABLE $TABLE_NAME $DROP_COLUMN tainted;"
     $PSQL -d $POSTGRES_SID -U $CHAASE -c "$ALTER_TABLE $TABLE_NAME $DROP_COLUMN has_serial_data;"
     $PSQL -d $POSTGRES_SID -U $CHAASE -c "$ALTER_TABLE $TABLE_NAME $DROP_COLUMN source_res;"
     $PSQL -d $POSTGRES_SID -U $CHAASE -c "$ALTER_TABLE $TABLE_NAME $DROP_COLUMN celestial_body;"
     CURRENT_RECORD_COUNT=`psql -d $POSTGRES_SID -U $CHAASE -At -c "select count(*) from $TABLE_NAME"`

echo "** CURRENT_RECORD_COUNT for table:  " $TABLE_NAME " is " $CURRENT_RECORD_COUNT 
}



Zap_Local_Metadata_Files()
{


cd /san/local/database/pgsqldata/metadata/local/ION/$SENSOR

export DIR_LIST="1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013"
for DIR in [ $DIR_LIST ] ; do
    ls -la ./*/*FGDC* | find *FGDC*tmp*  -exec rm {} \;  
done
exit

			            
}

