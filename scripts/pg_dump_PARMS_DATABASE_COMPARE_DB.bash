#! /bin/bash -x
# *************************************************************************************
#
# File Name:  ~dba/tools/pg_dump_PARMS_DATABASE-IMIQDB.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~/pgsql/tools/pg_dump_PARMS_DATABASE-pgsql.bash
#
# Permissions: Password to the Postgres userid 'pgsql' or 'postgres'. 
#
# TO RESTORE: pg_restore-d  <target db name> <restore file name>
#             Example: pg_restore -d ion_restore pg_dump.chaase.ion.backup.seaside-2005-11-14_130828.sql 
#
#
# Processing:  
#
#  Input data files:  
#
#  Data file naming convention:  
#                              
# NOTE: 
#
#		
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
#  3/22/11     C. Haase    Initial version v0   
#                          ==> COPIED FROM pg_dump_PARMS_DATABASE.bash
#  12/8/2014   C. Haase    Split this one out so that each table pg_dump file is gizipped alone instead
#                          of tarring all and then gzipping into one uber big file.....done for space
#                          considerations.
#
#     
#----------------------------------------------------------------------------------------------------		

#
# owner is assumed to be postgres; this will be overwritten later on if host is seaside 
if [ "$#" -ne 7 ]; then
      echo "Usage: $0 file 1=PostgresSID(cluster for all): 2=Do Vaccumdb/Reindexdb (Y/N): 3)=Export Tables(Y/N): 4=Compare Clone?(Y/N) 5=To Host 6=To DB 7=Table List=(ALL/schema.tablename)"
      exit 1
else  
      export POSTGRES_SID=$1
      export DO_MAINT=$2   
      export EXPORT_TABLES=$3 
      export COMPARE_CLONE=$4
      export TO_HOST=$5
      export TO_DB=$6
      export TABLELIST=$7	 
fi	

#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#


EXPORT_SOURCE=$HOME/tools/backup_scripts
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
    echo "sourcing: "  $EXPORT_NAME
    source $EXPORT_NAME
done

if [ $COMPARE_CLONE == "N" ]; then 
      export TO_HOST = $HOST
      export TO_DB = $POSTGRES_SID
fi


export LOG_FILE_BASENAME="`basename $0 .bash`"
export LOG_FILE=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"
export LOG_FILE_SQL=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".sql_log"

export OPTION_STRING_FILE="cOn"



######################################################################### 
        
Print_Header


List_PG_Databases



#Set_PG_DB_Type


#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------


Print_Blank_Line  
Print_Blank_Line   
echo "************************************* "   > $LOG_FILE 
echo "=====> DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
echo "************************************* "   >> $LOG_FILE 
Print_Blank_Line  
Print_Blank_Line   


echo "Comparing DBs/CLONES for SOURCE_HOST/DB: " $HOST   $POSTGRES_SID " TARGET_HOST/DB: "   $TO_HOST   $TO_DB  >> $LOG_FILE_SQL


Get_Current_TimeStamp
Get_NOW_TimeStamp

Verify_Backup_Directory_Exists
cd $PG_DUMP_DIR

export DB_LIST=$POSTGRES_SID
for POSTGRES_SID in $DB_LIST ; do

    Print_Blank_Line    
    echo "***** Database size: pg_database_size *****"     >> $LOG_FILE 
   $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "select pg_size_pretty(pg_database_size('$POSTGRES_SID'))" >> $LOG_FILE
    
 #   Check_PGSQL_Status

    Print_Blank_Line 
    echo "***** Schema Names: \dn+ *****"                       >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "\dn+"            >> $LOG_FILE

    if [ $DO_MAINT == $YES ]; then                     
         $VACUUMDB -d $POSTGRES_SID -z -e -U $FROM_OWNER    >> $LOG_FILE
         VACUUMDB_STATUS=$?
         if [ $VACUUMDB_STATUS -ne $SE_SUCCESS ]; then
              echo "** ERROR: VACUMMDB  DIED ==> "  $VACUUMDB_STATUS " db: " $POSTGRES_SID      >> $LOG_FILE 
              exit 1                    
         fi
         echo "** Successful VACUMMDB of DB: " $POSTGRES_SID  " Owner: " $FROM_OWNER            >> $LOG_FILE	
         $REINDEXDB -d $POSTGRES_SID -U $FROM_OWNER    >> $LOG_FILE
         REINDEXDB_STATUS=$?
         if [ $REINDEXDB_STATUS -ne $SE_SUCCESS ]; then
              echo "** ERROR: REINDEXDB  DIED ==> " $REINDEXDB_STATUS " db: " $POSTGRES_SID   >> $LOG_FILE	 
              exit 1                    
         fi	
         echo "** Successful REINDEXDB of DB: " $POSTGRES_SID  " Owner: " $FROM_OWNER           >> $LOG_FILE	
    fi 
    SCHEMA_LIST_USER=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_schema from information_schema.tables where table_schema not similar to 'pg_*' and table_schema != 'information_schema' and table_schema != 'public' order by table_schema"`  >> $LOG_FILE_SQL
    for SCHEMA_NAME in $SCHEMA_LIST_USER; do
        if [ $EXPORT_TABLES == $YES ]; then
             if [ $TABLELIST == "ALL" ]; then
                TABLE_LIST=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_name from information_schema.tables where table_schema='$SCHEMA_NAME' order by table_name"` >> $LOG_FILE_SQL
              else
              	  TABLE_LIST=$TABLELIST
              fi 
              Print_Blank_Line 
             #  CLONE ==>  each table(s) to a corresponding table in target database (TO_HOST:TO_DB) 
             #            First find out how many source tables then verify when done number of target tables
             SOURCE_TABLE_COUNT=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "select count(tablename) from pg_tables where schemaname='$SCHEMA_NAME'"`  >> $LOG_FILE_SQL
             for TABLENAME in $TABLE_LIST; do   
                 TABLE_NAME_FULL=$SCHEMA_NAME"."$TABLENAME
                 SOURCE_ROW_COUNT=0
                 TARGET_ROW_COUNT=0
                 SOURCE_ROW_COUNT=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "select count(*) from $TABLE_NAME_FULL"` >> $LOG_FILE_SQL
                 if [ $COMPARE_CLONE == "Y" ] ; then
                    TARGET_ROW_COUNT=`$PSQL -d $TO_DB -h $TO_HOST -U $POSTGRES $PSQL_Atc "select count(*) from $TABLE_NAME_FULL"` >> $LOG_FILE_SQL
                    if [ $SOURCE_ROW_COUNT -ne $TARGET_ROW_COUNT ]; then
                         echo "***ERROR: SOURCE_ROW_COUNT != TARGET_ROW_COUNT "   $TABLE_NAME_FULL $SOURCE_ROW_COUNT  $TARGET_ROW_COUNT  >> $LOG_FILE_SQL
                         exit 1 
                     else
                         echo "***SOURCE_ROW_COUNT = TARGET_ROW_COUNT "   $TABLE_NAME_FULL  $SOURCE_ROW_COUNT  $TARGET_ROW_COUNT >> $LOG_FILE_SQL
                    fi # row counts                
                 else
                     echo "***SOURCE_ROW_COUNT  "   $TABLE_NAME_FULL  $SOURCE_ROW_COUNT   >> $LOG_FILE_SQL
                 fi    # clone is yes
             done  #tablename list 
             if [ $COMPARE_CLONE == "Y" ] ; then
                  # Now find out how many tables actually got loaded into the clone
                  TARGET_TABLE_COUNT=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "select count(tablename) from pg_tables where schemaname='$SCHEMA_NAME'"`  >> $LOG_FILE_SQL
                  if [ $SOURCE_TABLE_COUNT -ne $TARGET_TABLE_COUNT ]; then
                       echo "***ERROR: SOURCE_TABLE_COUNT != TARGET_TABLE_COUNT  " $POSTGRES_SID $SOURCE_TABLE_COUNT $TO_DB $TARGET_TABLE_COUNT  >> $LOG_FILE_SQL
                       exit 1
                  else
                      echo "***SOURCE_TABLE_COUNT = TARGET_TABLE_COUNT "  $POSTGRES_SID $SOURCE_TABLE_COUNT $TO_DB $TARGET_TABLE_COUNT >> $LOG_FILE_SQL
                  fi  # target and source table counts 
             fi  # compare clones is yes for target and source table counts         
        fi # export tables is yes 
    done     # schemaname list
done   # DB_LIST
    
    
#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------


	
Print_Footer 

Send_Email_To_DBA


exit
