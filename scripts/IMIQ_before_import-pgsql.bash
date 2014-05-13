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

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 file 1=PostgresSID 2=Schema Name (views tables or both)"
	exit 1
fi

export POSTGRES_SID=$1
export SCHEMA_NAME=$2

if [ $POSTGRES_SID != "iarcod" ] && [ $POSTGRES_SID != "iarcod_current" ]; then
   echo "Incorrect database name:  iarcod iarcod_current"
   exit 1
fi

if [ $SCHEMA_NAME == "both" ]; then
     export SCHEMA_LIST="tables views"
elif [ $SCHEMA_NAME == "tables" ] || [ $SCHEMA_NAME == "views" ]; then
     export SCHEMA_LIST=$SCHEMA_NAME
else
	  echo "Incorrect Schema name:  tables views or both"
	  exit 1
fi


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

echo "DATABASE:      " $POSTGRES_SID 
echo "SCHEMA_LIST:   " $SCHEMA_LIST  
echo "POSTGRES_USER: " $POSTGRES_USER

for SCHEMANAME in $SCHEMA_LIST; do
	TABLE_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -At -c "select distinct tablename from pg_tables where schemaname='$SCHEMANAME' order by tablename"` >> $LOG_FILE
	for TABLENAME in $TABLE_LIST; do  
    		TABLE_NAME=$SCHEMANAME"."$TABLENAME
    		# and the Lord giveth to the worthy..............
    		echo "Dropping : "  $POSTGRES_SID " " $TABLE_NAME 
#    		$PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "drop table $TABLE_NAME cascade;" >> $LOG_FILE     
	done  # tables
done # schemas

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



