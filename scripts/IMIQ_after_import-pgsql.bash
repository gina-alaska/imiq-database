#! /bin/bash -x
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
#  9/13/2013  C. Haase    Initial version v0  
#
#########################################################################################################
#
#----------------------------------------------------------------------------------------------------		
#

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 file 1=PostgresSID 2=Postgres user/DB owner"
	exit 1
fi
export POSTGRES_SID=$1
export POSTGRES_USER="imiq"
#export POSTGRES_USER=$2
#export SCHEMA_NAME=$2

if [ $POSTGRES_SID != "iarcod" ] && [ $POSTGRES_SID != "iarcod_current" ]; then
   echo "Incorrect database name:  iarcod iarcod_current"
   exit 1
fi

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
export IMIQ="imiq"


################################

#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------
#

export LOG_FILE="IMIQ_after_import-pgsql.bash.log"


echo "============================ DATABASE INFORMATION ============================" >> $LOG_FILE

echo "=====> DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
echo "SCHEMA_NAME: "   $SCHEMA_NAME    >> $LOG_FILE 
echo "POSTGRES_USER: " $POSTGRES_USER     >> $LOG_FILE 



psql -d $POSTGRES_SID -U postgres -Atc "alter database $POSTGRES_SID owner to $POSTGRES_USER;"   >> $LOG_FILE 
psql -d $POSTGRES_SID -U postgres -Atc "grant all on database $POSTGRES_SID to $POSTGRES_USER;"   >> $LOG_FILE  
psql -d $POSTGRES_SID -U postgres -Atc "grant usage on database $POSTGRES_SID to $AMY;"   >> $LOG_FILE  
psql -d $POSTGRES_SID -U postgres -Atc "grant all on database $POSTGRES_SID to $CHERYL;"   >> $LOG_FILE  
                                   
SCHEMA_LIST_USER=`psql -d $POSTGRES_SID -Atc "select distinct schema_name from information_schema.schemata where schema_name != 'pg_catalog' and schema_name != 'information_schema' and schema_name NOT LIKE 'pg_%';"`  >> $LOG_FILE 

for SCHEMANAME in $SCHEMA_LIST_USER; do
    psql -d $POSTGRES_SID -U postgres -Atc "alter schema $SCHEMANAME owner to $POSTGRES_USER;"      >> $LOG_FILE 
    psql -d $POSTGRES_SID -U postgres -Atc "grant all on schema $SCHEMANAME to $POSTGRES_USER;"     >> $LOG_FILE 
    psql -d $POSTGRES_SID -U postgres -Atc "grant usage on schema $SCHEMANAME to $AMY;"      >> $LOG_FILE 
    psql -d $POSTGRES_SID -U postgres -Atc "grant all on schema $SCHEMANAME to $CHERYL;"      >> $LOG_FILE 
    TABLE_LIST=`psql -d $POSTGRES_SID -U postgres -Atc "select distinct tablename from pg_tables where schemaname='$SCHEMANAME' order by tablename"` >> $LOG_FILE
    for TABLENAME in $TABLE_LIST; do  
        TABLE_NAME=$SCHEMANAME"."$TABLENAME
        psql -d $POSTGRES_SID -U postgres -Atc "alter table $TABLE_NAME owner to $POSTGRES_USER;"   >> $LOG_FILE  
        psql -d $POSTGRES_SID -U postgres -Atc "grant all on table $TABLE_NAME to $POSTGRES_USER;"   >> $LOG_FILE  
        psql -d $POSTGRES_SID -U postgres -Atc "grant all on table $TABLE_NAME to $AMY;"   >> $LOG_FILE  
        psql -d $POSTGRES_SID -U postgres -Atc "grant all on table $TABLE_NAME to $CHERYL;"   >> $LOG_FILE       
    done  # tables
done  # schemas

psql  -d $POSTGRES_SID -U postgres -Atc "grant usage on schema pg_catalog to $POSTGRES_USER;"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "grant usage on schema information_schema to $POSTGRES_USER;"    >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "grant usage on schema pg_catalog to $AMY;"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "grant usage on schema information_schema to $AMY;"    >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "grant usage on schema pg_catalog to $CHERYL;"           >> $LOG_FILE 
psql  -d $POSTGRES_SID -U postgres -Atc "grant usage on schema information_schema to $CHERYL;"    >> $LOG_FILE 



# the corresponding tables (in the tables schema) have this upon import from sql server db.
echo "When importing the following tables (views), make column "valueid" is set as the primary key "  >> $LOG_FILE 
# NOTE:  this is just for documentation purposes...the views are automatically selected out into 
#        VIEW_LIST below  1) in the schema of "views" and 2) with prefixes of "daily_" or "hourly_"
export VALUEID_TABLE_LIST="views.daily_airtemp 
                           views.daily_airtempmax 
                           views.daily_airtempmin 
                           views.daily_discharge 
                           views.daily_precip 
                           views.daily_rh
                           views.daily_snowdepth 
                           views.daily_swe 
                           views.dialy_watertemp
                           views.daily_watertempstations     
                           views.daily_winddirection 
                           views.daily_windspeed 
                           views.hourly_airtemp 
                           views.hourly_precip
                           views.hourly_rh 
                           views.hourly_snowdepth 
                           views.hourly_snowdepth 
                           views.hourly_swe 
                           views.hourly_winddirection  
                           views.hourly_windspeed"   
VIEW_LIST=`psql -d $POSTGRES_SID -U postgres -Atc "select distinct tablename from pg_tables 
                                                   where schemaname='views' 
                                                   and tablename LIKE 'daily_%' 
    																or tablename LIKE 'hourly_%' 
    																order by tablename"` >> $LOG_FILE	                                               		                                               
for VALUEID_TABLE_NAME in $VIEW_LIST; do
    psql  -d $POSTGRES_SID -U postgres -Atc "alter table views.$VALUEID_TABLE_NAME add primary key (valueid);"  >> $LOG_FILE 
done


echo "If prefix is daily, hourly, monthly, yearly or nasa make sure index set on column 'siteid' " >> $LOG_FILE
SCHEMA_LIST_USER="tables views"
for SCHEMANAME in $SCHEMA_LIST_USER; do
    TABLE_LIST=`psql -d $POSTGRES_SID -U postgres -Atc "select distinct tablename from pg_tables 
                                                        where schemaname='$SCHEMANAME' 
                                                        and (tablename LIKE 'daily_%' 
    																	  or tablename LIKE 'monthly_%' 
    																	  or tablename LIKE 'hourly_%' 
    		                                               or tablename LIKE 'yearly_%' 
    		                                               or tablename LIKE 'nasa_%'
    		                                               or  tablename = 'datastreams') order by tablename"` >> $LOG_FILE	                                               		                                               
    for TABLENAME in $TABLE_LIST; do  
        TABLE_NAME=$SCHEMANAME"."$TABLENAME
        INDEX_NAME=$TABLENAME"_siteid_idx"
        psql  -d $POSTGRES_SID -U postgres -Atc "drop index IF EXISTS $SCHEMANAME"."$INDEX_NAME cascade;"  >> $LOG_FILE 
        psql  -d $POSTGRES_SID -U postgres -Atc "create index $INDEX_NAME on $TABLE_NAME (siteid);"  >> $LOG_FILE                   
    done  # tables
done  # schemas




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



