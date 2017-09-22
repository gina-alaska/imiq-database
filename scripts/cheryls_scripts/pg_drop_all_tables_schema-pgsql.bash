#! /bin/bash -x
#
#**************************************************************************************
#
# File Name:  ~dba/tools/backup_scripts/POSTGRES/pg_drop_all_tables_schema-pgsql.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~dba/tools/backup_scripts/POSTGRES/create_database_redmine_privs-pgsql.bash
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
#
#########################################################################################################
#
#
#----------------------------------------------------------------------------------------------------		
#

if [ "$#" -eq 0 ]; then
	echo "Usage: $0 file 1=PostgresSID 2=Schema Name"
	exit 1
fi
export POSTGRES_SID=$1
export SCHEMA_NAME=$2

#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
EXPORT_SOURCE=$HOME/tools/backup_scripts
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
    source $EXPORT_NAME
done 



Print_Blank_Line
Print_Blank_Line
Print_Star_Line
echo "============================ DATABASE INFORMATION ============================" >> $LOG_FILE
Print_Star_Line
Print_Blank_Line         
Print_Blank_Line  

Print_Star_Line
echo "=====> DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
Print_Star_Line
Print_Blank_Line  
Print_Blank_Line   

echo "SCHEMA_NAME: "   $SCHEMA_NAME   
echo "SCHEMA_TYPE: "   $SCHEMA_TYPE
echo "POSTGRES_USER: " $POSTGRES_USER

TABLE_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -At -c "select distinct tablename from pg_tables where schemaname='$SCHEMA_NAME' order by tablename"` >> $LOG_FILE
for TABLENAME in $TABLE_LIST; do  
    TABLE_NAME=$SCHEMA_NAME"."$TABLENAME
    # and the Lord giveth to the worthy..............
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "drop table $TABLE_NAME cascade;" >> $LOG_FILE     
done  # tables


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



