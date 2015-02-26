#! /bin/bash -x
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
      echo "Usage: $0 file 1=PostgresSID(cluster for all):  2=Do Vaccumdb/Reindexdb (Y/N): 3=TO_HOST: 4=To DB: 5=DEBUG(Y/N):"
      exit 1
else  
      export POSTGRES_SID=$1
      export DO_MAINT=$2   
 #     export EXPORT_SCHEMAS=$3
 #     export EXPORT_TABLES=$4  
#      export EXPORT_TABLES="N"
      export TO_HOST=$3
      export TO_POSTGRES_SID=$4
      export DEBUG=$5
 #     export TO_SCHEMA=$7
fi	
 export FROM_HOST=$HOST


##########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
##EXPORT_SOURCE=$HOME/tools/backup_scripts/POSTGRES

if [ $DEBUG == $YES ]; then
     EXPORT_SOURCE=$HOME/northpole/Dropbox/Cheryls_Sandbox/tools/backup_scripts/POSTGRES
else 
     EXPORT_SOURCE=$HOME/tools/backup_scripts/POSTGRES
fi
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
    echo "sourcing: "  $EXPORT_NAME
    source $EXPORT_NAME
done

export LOG_FILE_BASENAME="`basename $0 .bash`"
export LOG_FILE=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"

export OPTION_STRING_FILE="cOn"


#########################################
        
Print_Header


echo "PGDumping: " $POSTGRES_SID  >> $LOG_FILE


List_PG_Databases
Set_PG_DB_Type

# Check_PG_Privs


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
PGDUMPFILES_TABLES_TAR=PGDUMPFILES.TABLES.HOST.TAR.$LOGDATE.lst


for POSTGRES_SID in $DB_LIST ; do

    Print_Blank_Line    
    echo "***** Database size: pg_database_size *****"     >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "select pg_size_pretty(pg_database_size('$POSTGRES_SID'))" >> $LOG_FILE
    Check_PGSQL_Status

    Print_Blank_Line 
    echo "***** Schema Names: \dn+ *****"                       >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "\dn+"            >> $LOG_FILE

    List_PG_Schemas

     if [ $POSTGRES_SID == $GINA_DBA ]; then
              SCHEMA_TYPE=$DBA
              POSTGRES_USER="dba"
              SCHEMA_LIST=$SCHEMA_LIST_DBA_PUBLIC
     else 
              SCHEMA_LIST=$SCHEMA_LIST_USER_PUBLIC
     fi

    for SCHEMA_NAME in $SCHEMA_LIST; do

        TABLE_LIST_TO_HOST=`$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST $PSQL_Atc "$SELECT_DISTINCT table_name from information_schema.tables where table_schema='$SCHEMA_NAME' order by table_name"` >> $LOG_FILE
        for TABLENAME in $TABLE_LIST_TO_HOST; do   
            TABLE_NAME_FULL=$SCHEMA_NAME"."$TABLENAME
            $PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST -a -c "drop table $TABLE_NAME_FULL cascade;"                       >> $LOG_FILE   
 #           $PSQL_COMMAND_LINE_ac -h $TO_HOST "$DROP_TABLE $TABLE_NAME_FULL cascade;"                    >> $LOG_FILE    
        done 

        TABLE_LIST=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_name from information_schema.tables where table_schema='$SCHEMA_NAME' order by table_name"` >> $LOG_FILE
        if [ $EXPORT_TABLES == $YES ]; then
             Print_Blank_Line  
             for TABLENAME in $TABLE_LIST; do   
                 TABLE_NAME_FULL=$SCHEMA_NAME"."$TABLENAME
                 LOG_FILE_PGDUMP_TABLE=$POSTGRES_SID.$TABLE_NAME_FULL".TABLE."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dump
                 echo "LOG_FILE_PGDUMP_TABLE: " $LOG_FILE_PGDUMP_TABLE
                 if [ $POSTGRES_VERSION == $POSTGRES_VERSION_8111 ]; then      
                      $PG_DUMP $POSTGRES_SID -U $POSTGRES -c -n $SCHEMA_NAME -c -t $TABLENAME > $LOG_FILE_PGDUMP_TABLE                                
                 else
                      $PG_DUMP $POSTGRES_SID -U $POSTGRES -c -t $TABLE_NAME_FULL > $LOG_FILE_PGDUMP_TABLE
                 fi          
             done 

             if [ $HOST == $SVPROD ]; then
                  ls -1 $SOURCE_DIR/*TABLE.$HOST*$LOGDATE*.pg_dump > $PGDUMPFILES_TABLES
                  USR=$METADATA
             else
                  ls -1 $PG_DUMP_DIR/*TABLE.$HOST*$LOGDATE*.pg_dump > $PGDUMPFILES_TABLES
 #                 USR=$DBA
                  USR="dba"
             fi

             for PGDUMP_FILE_TABLE in $(cat $PGDUMPFILES_TABLES); do  
                 echo "Ingesting: " $PGDUMP_FILE_TABLE " TO: " $TO_POSTGRES_SID " @ " $TO_HOST    >> $LOG_FILE                
                 $PSQL -d $TO_POSTGRES_SID -U $USR -h $TO_HOST -f $PGDUMP_FILE_TABLE
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
              $PG_DUMP $POSTGRES_SID -U $POSTGRES -c -O -n $SCHEMA_NAME > $LOG_FILE_PGDUMP_SCHEMA

 #             $PSQL -d $TO_POSTGRES_SID -U postgres -h $TO_HOST  -f $LOG_FILE_PGDUMP_SCHEMA



            gzip  *$HOST*$LOGDATE.pg_dump   
             rm *$HOST*$LOGDATE.pg_dump    >> $LOG_FILE 

             REMOTE_SCP_PGDUMP

         fi           
    done     
done       
    

Print_Footer 

Send_Email_To_DBA

exit
