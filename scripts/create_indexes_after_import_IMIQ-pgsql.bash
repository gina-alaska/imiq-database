#! /bin/bash 
#
#**************************************************************************************
#
# File Name:  ~dba/tools/backup_scripts/POSTGRES/pg_privs_all_tables_schema-pgsql.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~dba/tools/backup_scripts/POSTGRES/pg_privs_all_tables_schema-pgsql.bash
#
# Permissions: Password to the Postgres userid 'pgsql' or 'postgres'. 
#
#
# Processing:  
#
#  Input data files:  
#
#  Data file naming convention:  
#                              
#
# NOTE:        
#
# ASSUMPTIONS: This script assumes that:
#	        1) the target tables within the PostgreSQL SID exist
#
# =========================================================================================================
#
# MODIFICATION HISTORY
# =======================
#
#  Date        Initials    Modification/Reason
#  =======     ========    ============================================================================
#
#  9/13/2010  C. Haase    Initial version v0  
#
#########################################################################################################
#
#----------------------------------------------------------------------------------------------------		
#

if [ "$#" -eq 0 ]; then
	echo "Usage: $0 file 1=PostgresSID"
	exit 1
fi
export POSTGRES_SID=$1
export POSTGRES_USER="imiq"
#export POSTGRES_USER=$2
#export SCHEMA_NAME=$2

##########################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
EXPORT_SOURCE=$HOME/tools/backup_scripts
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
     echo "sourcing: "  $EXPORT_NAME
done 

export AMY="asjacobs"
export CHERYL="chaase"


################################

#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------
#

export LOG_FILE="create_indexes_after_import_IMIQ-pgsql.bash.log"


echo "============================ DATABASE INFORMATION ============================" >> $LOG_FILE

echo "=====> DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 

#When importing the following tables (views) into Postgres database, make sure the column "valueid" is set as the primary key

psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_airtemp add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_airtempmax add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_airtempmin add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_discharge add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_precip add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_rh add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_snowdepth add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_swe add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_winddirection add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.daily_windspeed add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.hourly_airtemp add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.hourly_precip add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.hourly_rh add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.hourly_snowdepth add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.hourly_swe add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.hourly_winddirection add primary key (valueid);"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.hourly_windspeed add primary key (valueid);"           >> $LOG_FILE 


#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------

SUBJECT=$0"_"$HOST"_"$POSTGRES_SID"_"$LOGDATE
echo $status | mailx -s "$SUBJECT"  "$MAIL_TO" < $LOG_FILE
if [ "$status" == " " ]; then	
   Print_Blank_Line  
   echo "** ERROR: DBA Email Bombing from DBA@" $HOST  >> $LOG_FILE
   Print_Blank_Line  
fi

Print_Footer

exit



