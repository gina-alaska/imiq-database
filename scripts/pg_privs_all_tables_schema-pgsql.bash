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
#  9/13/2010  C. Haase    Initial version v0  
#
#########################################################################################################
#
#----------------------------------------------------------------------------------------------------		
#

if [ "$#" -eq 0 ]; then
	echo "Usage: $0 file 1=PostgresSID 2=Schema Name 3=Postgres User"
	exit 1
fi
export POSTGRES_SID=$1
export SCHEMA_NAME=$2
export POSTGRES_USER=$3


##########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
EXPORT_SOURCE=$HOME/tools/backup_scripts/POSTGRES
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
echo "sourcing: "  $EXPORT_NAME
done 

        
Print_Header


 
#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------
#


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


echo "POSTGRES_SID: " $POSTGRES_SID  >> $LOG_FILE 
echo "SCHEMA_NAME: "   $SCHEMA_NAME    >> $LOG_FILE 
echo "POSTGRES_USER: " $POSTGRES_USER  >> $LOG_FILE 

TABLE_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -At -c "select distinct tablename from pg_tables where schemaname='$SCHEMA_NAME' order by tablename"` >> $LOG_FILE
for TABLENAME in $TABLE_LIST; do  
    TABLE_NAME=$SCHEMA_NAME"."$TABLENAME
    # and the Lord giveth to the worthy..............
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter table $TABLE_NAME owner to $POSTGRES_USER;"  >> $LOG_FILE     
    $PSQL -d $POSTGRES_SID -U $POSTGRES -Atc "grant all on table $TABLE_NAME to $POSTGRES_USER;"   >> $LOG_FILE
done  # tables

--------------------------------------------------------------------
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



