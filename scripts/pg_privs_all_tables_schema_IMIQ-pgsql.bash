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
	echo "Usage: $0 file 1=PostgresSID 2=Postgres user/DB owner"
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

export LOG_FILE="pg_privs_all_tables_schema_IMIQ-pgsql.bash.log"


echo "============================ DATABASE INFORMATION ============================" >> $LOG_FILE

echo "=====> DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
echo "SCHEMA_NAME: "   $SCHEMA_NAME   
echo "POSTGRES_USER: " $POSTGRES_USER

psql -d $POSTGRES_SID -U postgres -Atc "alter database $POSTGRES_SID owner to $POSTGRES_USER;"   >> $LOG_FILE 
psql -d $POSTGRES_SID -U postgres -Atc "grant all on database $POSTGRES_SID to $POSTGRES_USER;"   >> $LOG_FILE  
psql -d $POSTGRES_SID -U postgres -Atc "grant usage on database $POSTGRES_SID to $AMY;"   >> $LOG_FILE  
psql -d $POSTGRES_SID -U postgres -Atc "grant all on database $POSTGRES_SID to $CHERYL;"   >> $LOG_FILE  

#List_PG_Schemas
SCHEMA_LIST_ALL=`psql -d $POSTGRES_SID -Atc  "select distinct schema_name from information_schema.schemata;"`     >> $LOG_FILE
SCHEMA_LIST_PG=`psql -d $POSTGRES_SID -Atc  "select distinct schema_name from information_schema.schemata where schema_name = 'pg_catalog' or schema_name = 'information_schema';"`                                                         >> $LOG_FILE
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



