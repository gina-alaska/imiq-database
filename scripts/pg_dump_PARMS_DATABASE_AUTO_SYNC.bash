#! /bin/bash -x
#
# *************************************************************************************
#
# File Name:  ~dba/tools/pg_dump_PARMS_DATABASE-pgsql.bash
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
#
#     
#----------------------------------------------------------------------------------------------------		



# owner is assumed to be postgres; this will be overwritten later on if host is seaside 
if [ "$#" -ne 5 ]; then
      echo "Usage: $0 file 1=PostgresSID(cluster for all):  2=Do Vaccumdb/Reindexdb (Y/N): 3)Export Schemas (Y/N):  4=Export Tables(Y/N):   5=TO Host Name (TO_HOST): "
      exit 1
else  
      export POSTGRES_SID=$1
      export DO_MAINT=$2   
      export EXPORT_SCHEMAS=$3
      export EXPORT_TABLES=$4  
      export FROM_HOST=$HOST
      export TO_HOST=$5
fi	


##########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
EXPORT_SOURCE=$HOME/tools/backup_scripts
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
  echo "sourcing: "  $EXPORT_NAME
  source $EXPORT_NAME
done 

export LOG_FILE_BASENAME="`basename $0 .bash`"
export LOG_FILE=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"

export OPTION_STRING_FILE="cOn"


#########################################
        
Print_Header


echo "PGDumping: " $POSTGRES_SID "  Exporting Schemas: " $EXPORT_SCHEMAS  "  Exporting Tables: " $EXPORT_TABLES "  Vacummdb/Reindexdb: " $DO_MAINT   >> $LOG_FILE


List_PG_Databases

#Set_PG_DB_Type
# BUSTED subroutine =====> Check_PG_Privs


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


PGDUMPFILES_SCHEMAS=PGDUMPFILES.SCHEMAS.$HOST.$LOGDATE.lst
PGDUMPFILES_TABLES=PGDUMPFILES.TABLES.$HOST.$LOGDATE.lst
PGDUMPFILES_TABLES_TAR=PGDUMPFILES.TABLES.$HOST.TAR.$LOGDATE.lst


for POSTGRES_SID in $DB_LIST ; do

    Print_Blank_Line    
    echo "***** Database size: pg_database_size *****"     >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "select pg_size_pretty(pg_database_size('$POSTGRES_SID'))" >> $LOG_FILE
    Check_PGSQL_Status

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
             TABLE_LIST=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_name from information_schema.tables where table_schema='$SCHEMA_NAME' order by table_name"` >> $LOG_FILE
             Print_Blank_Line  
             for TABLENAME in $TABLE_LIST; do   
                 TABLE_NAME_FULL=$SCHEMA_NAME"."$TABLENAME     
                 LOG_FILE_PGDUMP_TABLE=$POSTGRES_SID.$TABLE_NAME_FULL.TABLE.$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dump
                 echo "LOG_FILE_PGDUMP_TABLE: " $LOG_FILE_PGDUMP_TABLE
                 $PG_DUMP $POSTGRES_SID -U $POSTGRES -c -t $TABLE_NAME_FULL > $LOG_FILE_PGDUMP_TABLE
             done 

             ls -1 $PG_DUMP_DIR/*TABLE.$HOST*$LOGDATE*.pg_dump > $PGDUMPFILES_TABLES
             for PGDUMP_FILE_TABLE in $(cat $PGDUMPFILES_TABLES); do  
                 echo "Ingesting: " $PGDUMP_FILE_TABLE " TO: " $POSTGRES_SID " @ " $TO_HOST    >> $LOG_FILE                   
                $PSQL -d $POSTGRES_SID -h $TO_HOST -f $PGDUMP_FILE_TABLE
             done
           
             TAR_FILE=$POSTGRES_SID.$SCHEMA_NAME".TABLE."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE".tar"
             tar -cvf   $TAR_FILE  $POSTGRES_SID.$SCHEMA_NAME*".TABLE."$HOST*$LOGDATE.pg_dump 
      
             rm *$HOST*$LOGDATE.pg_dump    >> $LOG_FILE  

             gzip  $TAR_FILE

             REMOTE_SCP_PGDUMP
        fi
        if [ $EXPORT_SCHEMAS == $YES ] ; then
              LOG_FILE_PGDUMP_SCHEMA=$POSTGRES_SID.$SCHEMA_NAME".SCHEMA."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dump
              echo " LOG_FILE_PGDUMP_SCHEMA: " $LOG_FILE_PGDUMP_SCHEMA  >> $LOG_FILE
              Print_Blank_Line      
              $PG_DUMP $POSTGRES_SID -U $POSTGRES  -c -O -n $SCHEMA_NAME > $LOG_FILE_PGDUMP_SCHEMA

#              if [ $SCHEMA_NAME == $TO_SCHEMA ] ; then
 #                echo " DO NOTHING STUPID "
 #             else 
 #                echo " Redirecting Schema Name FROM: " $SCHEMA_NAME " TO " $TO_SCHEMA
#                 perl -pi -e $LOG_FILE_PGDUMP_SCHEMA
 #             fi 
 #             echo "Ingesting: " $PGDUMP_FILE_TABLE " TO: " $POSTGRES_SID " @ " $TO_HOST  " : " $TO_DB " . " $TO_SCHEMA  >> $LOG_FILE                
#               $PSQL -d $POSTGRES_SID -h $TO_HOST -f $LOG_FILE_PGDUMP_SCHEMA

              REMOTE_SCP_PGDUMP
              gzip  *$HOST*$LOGDATE.pg_dump  
              rm *$HOST*$LOGDATE.pg_dump    >> $LOG_FILE 
         fi           
    done     
done       
    

Print_Footer 

Send_Email_To_DBA

exit
