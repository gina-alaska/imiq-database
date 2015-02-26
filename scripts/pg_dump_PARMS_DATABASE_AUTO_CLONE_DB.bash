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
if [ "$#" -ne 8 ]; then
      echo "Usage: $0 file 1=PostgresSID(cluster for all): 2=Do Vaccumdb/Reindexdb (Y/N): 3)Export Schemas (Y/N):  4=Export Tables(Y/N): 5=Dump or Clone?(D/C) 6=To Host 7=To DB 8=Table List=(ALL/schema.tablename)"
      exit 1
else  
      export POSTGRES_SID=$1
      export DO_MAINT=$2   
      export EXPORT_SCHEMAS=$3
      export EXPORT_TABLES=$4 
      export DUMP_CLONE=$5
      export TO_HOST=$6
      export TO_DB=$7
      export TABLELIST=$8	 
fi	

#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#

if [ $DEBUG == $YES ]; then
     EXPORT_SOURCE=$HOME/tools/backup_scripts
else 
     EXPORT_SOURCE=$HOME/tools/backup_scripts
fi
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
    echo "sourcing: "  $EXPORT_NAME
    source $EXPORT_NAME
done



export LOG_FILE_BASENAME="`basename $0 .bash`"
export LOG_FILE=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"



export OPTION_STRING_FILE="cOn"



######################################################################### 
        
Print_Header


echo "PGDumping: " $POSTGRES_SID "  Exporting Schemas: " $EXPORT_SCHEMAS  "  Exporting Tables: " $EXPORT_TABLES "  Vacummdb/Reindexdb: " $DO_MAINT   >> $LOG_FILE


List_PG_Databases

#Set_PG_DB_Type


# ====>
# ====> SKIP FOR NOW !!!!     Check_PG_Privs
# ====>


#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------


Print_Blank_Line  
Print_Blank_Line   
echo "************************************* "   >> $LOG_FILE 
echo "=====> DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
echo "************************************* "   >> $LOG_FILE 
Print_Blank_Line  
Print_Blank_Line   


Get_Current_TimeStamp
Get_NOW_TimeStamp

Verify_Backup_Directory_Exists
cd $PG_DUMP_DIR


Print_Blank_Line        
Print_Star_Line           
echo "** PG_CONTROLDATA  "	 >>  $LOG_FILE  	
$PG_CONTROLDATA
Print_Star_Line   
Print_Blank_Line 

Print_Blank_Line        
Print_Star_Line           
echo "** PG_CONFIG  "	 >>  $LOG_FILE  	
$PG_CONFIG
Print_Star_Line   
Print_Blank_Line 


#source $HOME/tools/backup_scripts/EXPORT_GINA_HOSTS.bash
#export PSQL=$PGBIN/psql
echo "PSQL: " $PSQL

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
    SCHEMA_LIST_USER_PUBLIC=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_schema from information_schema.tables where table_schema not similar to 'pg_*' and table_schema != 'information_schema';"`                  >> $LOG_FILE
    for SCHEMA_NAME in $SCHEMA_LIST_USER_PUBLIC; do
        if [ $EXPORT_TABLES == $YES ]; then
             if [ $TABLELIST = "ALL" ]; then
                TABLE_LIST=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_name from information_schema.tables where table_schema='$SCHEMA_NAME' order by table_name"` >> $LOG_FILE
              else
              	  TABLE_LIST=$TABLELIST
              fi 
              Print_Blank_Line  
             for TABLENAME in $TABLE_LIST; do   
                 TABLE_NAME_FULL=$SCHEMA_NAME"."$TABLENAME
                 #  DUMP  ==>  each table to a file
                 if [ $DUMP_CLONE == "D" ] ; then
                    LOG_FILE_PGDUMP_TABLE=$POSTGRES_SID.$TABLE_NAME_FULL".TABLE."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dump
                    echo "LOG_FILE_PGDUMP_TABLE: " $LOG_FILE_PGDUMP_TABLE  >> $LOG_FILE
                    SOURCE_TABLE_COUNT=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "select n_tup_ins from pg_catalog.pg_stat_user_tables where schemaname = '$SCHEMA_NAME' and relname = '$TABLE_NAME'"` >> $LOG_FILE
                    SOURCE_TABLE_COUNT=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "select n_tup_ins from pg_catalog.pg_stat_user_tables where schemaname = '$SCHEMA_NAME' and relname = '$TABLE_NAME'"` >> $LOG_FILE
                    $PG_DUMP $POSTGRES_SID -U $POSTGRES -t $TABLE_NAME_FULL > $LOG_FILE_PGDUMP_TABLE
                    gzip *.pg_dump
                 #  CLONE ==>  each table(s) to a corresponding table in target database (TO_DB)
                 else
                    TARGET_TABLE_COUNT=`$PSQL -d $TO_DB -h $TO_HOST -U $POSTGRES $PSQL_Atc "select n_tup_ins from pg_catalog.pg_stat_user_tables where schemaname = '$SCHEMA_NAME' and relname = '$TABLE_NAME'"` >> $LOG_FILE
		    $PSQL -d $TO_DB -h $TO_HOST -U $POSTGRES  -a -c "drop table IF EXISTS $TABLE_NAME_FULL cascade;"
                    $PG_DUMP $POSTGRES_SID -U $POSTGRES -t $TABLE_NAME_FULL | $PSQL -d $TO_DB -h $TO_HOST
                    TARGET_TABLE_COUNT=`$PSQL -d $TO_DB -h $TO_HOST -U $POSTGRES $PSQL_Atc "select count(*) from $TABLE_NAME_FULL"` >> $LOG_FILE
                 fi     
                 if [ $SOURCE_TABLE_COUNT -ne $TARGET_TABLE_NAME ]; then
                    echo "***ERROR: SOURCE_TABLE_COUNT != TARGET_TABLE_NAME "   $SOURCE_TABLE_COUNT  $TARGET_TABLE_NAME  >> $LOG_FILE
                    exit 1
                 else
                    echo "***SOURCE_TABLE_COUNT = TARGET_TABLE_NAME "   $SOURCE_TABLE_COUNT  $TARGET_TABLE_NAME >> $LOG_FILE
                 fi 
             done            
# ORIG       TAR_FILE=$POSTGRES_SID.$SCHEMA_NAME".TABLE."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE".tar"
# ORIG       tar -cvf   $TAR_FILE  $POSTGRES_SID.$SCHEMA_NAME*".TABLE."$HOST*$LOGDATE.pg_dump         
             rm *$HOST*$LOGDATE.pg_dump    >> $LOG_FILE  
             gzip  $TAR_FILE
        fi
        if [ $EXPORT_SCHEMAS == $YES ] ; then
              LOG_FILE_PGDUMP_SCHEMA=$POSTGRES_SID.$SCHEMA_NAME".SCHEMA."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dump
              echo " LOG_FILE_PGDUMP_SCHEMA: " $LOG_FILE_PGDUMP_SCHEMA  >> $LOG_FILE
              Print_Blank_Line  
              #  DUMP  ==>  each schema to a file 
              if [ $DUMP_CLONE == "D" ] ; then   
                 $PG_DUMP $POSTGRES_SID -U $FROM_OWNER -c -O -n $SCHEMA_NAME > $LOG_FILE_PGDUMP_SCHEMA
#                TAR_FILE=$POSTGRES_SID".DATABASE.SCHEMA."$SCHEMA_NAME.$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE".tar"
#                tar -cvf   $TAR_FILE  $POSTGRES_SID.$SCHEMA_NAME.*$HOST.$POSTGRES.*.$LOGDATE.pg_dump
#  ORIG          gzip  *$HOST*$LOGDATE.pg_dump 
                 gzip  $LOG_FILE_PGDUMP_SCHEMA 
              #  CLONE ==>  each table to a corresponding table in target database (TO_DB)
              else
                 $PSQL -d $TO_DB -h $TO_HOST -U $POSTGRES  -a -c "drop schema IF EXISTS $SCHEMA_NAME;"
                 $PG_DUMP $POSTGRES_SID -U $POSTGRES -c -O -n $SCHEMA_NAME | $PSQL -d $TO_DB -h $TO_HOST  
              fi
              rm *$HOST*$LOGDATE.pg_dump    >> $LOG_FILE 
         fi           
    done     
done       
    

#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------


# Set the san local env var for dev, test and prods...

cd $PG_DUMP_DIR

REMOTE_SCP_PGDUMP

Check_SCP_Status
	
Print_Footer 

Send_Email_To_DBA


exit