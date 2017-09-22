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
      echo "Usage: $0 file 1=PostgresSID: 2=TO_HOST: 3=To DB: 4=TO_SCHEMA 5=TO_OWNER: "
      exit
else  
      export POSTGRES_SID=$1
      export FROM_HOST=$HOST
      export TO_HOST=$2
      export TO_POSTGRES_SID=$3
      export TO_SCHEMA=$4
      export SCHEMA_NAME=$TO_SCHEMA
      export TO_OWNER=$5
      export POSTGRES_USER=$TO_OWNER
fi	


#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
EXPORT_SOURCE=/mnt/raid/gina-alaska/dba-tools/backup_scripts
#EXPORT_SOURCE=$HOME/tools/backup_scripts/POSTGRES
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
    echo "sourcing: "  $EXPORT_NAME
    source $EXPORT_NAME
done 


export LOG_FILE_BASENAME="`basename $0 .bash`"
export LOG_FILE=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"

export OPTION_STRING_FILE="cOn"


#########################################
        
Print_Header


echo "PGDumping: " $POSTGRES_SID     >> $LOG_FILE

DB_LIST=$POSTGRES_SID
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

List_PG_Databases

for POSTGRES_SID in $DB_LIST ; do

    Print_Blank_Line    
    echo "***** Database size: pg_database_size *****"     >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "select pg_size_pretty(pg_database_size('$POSTGRES_SID'))" >> $LOG_FILE
    Check_PGSQL_Status

    Print_Blank_Line 
    echo "***** Schema Names: \dn+ *****"                       >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "\dn+"            >> $LOG_FILE


    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter database $POSTGRES_SID owner to $TO_OWNER;"                       >> $LOG_FILE   
#    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter tablespace $POSTGRES_TABLESPACE owner to $POSTGRES_USER;"              >> $LOG_FILE   
#    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter database $POSTGRES_SID set default_tablespace = $POSTGRES_TABLESPACE;" >> $LOG_FILE    

    SCHEMA_TARGET=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_schema from information_schema.tables where table_schema='$TO_SCHEMA'"` >> $LOG_FILE
    for SCHEMA_NAME in $TO_SCHEMA; do  
        # if source OR target db schema is public then just want to load the TABLE pg_dump files        
        if [ $SCHEMA_NAME == $PUBLIC ]; then
             TABLE_LIST=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_name from information_schema.tables where table_schema='$SCHEMA_NAME' order by table_name"` >> $LOG_FILE
             Print_Blank_Line  
             for TABLENAME in $TABLE_LIST; do   
                 TABLE_NAME_FULL=$SCHEMA_NAME"."$TABLENAME
                 LOG_FILE_PGDUMP_TABLE=$POSTGRES_SID.$TABLE_NAME_FULL".TABLE."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dump
                 echo "LOG_FILE_PGDUMP_TABLE: " $LOG_FILE_PGDUMP_TABLE
                 $PG_DUMP $POSTGRES_SID -U $POSTGRES -c -t $TABLE_NAME_FULL > $LOG_FILE_PGDUMP_TABLE         
             done    
             #5=TO_HOST: 6=To DB: 7=TO_SCHEMA :
             for PGDUMP_FILE_TABLE in $(cat $PGDUMPFILES_TABLES); do  
 #            	 perl -pi -e '$SCHEMA_NAME/$TO_SCHEMA' $PGDUMP_FILE_TABLE
                 echo "Ingesting: " $PGDUMP_FILE_TABLE " TO: " $TO_POSTGRES_SID " @ " $TO_HOST    >> $LOG_FILE                
                 $PSQL -d $TO_POSTGRES_SID -h $TO_HOST -f $PGDUMP_FILE_TABLE
             done

             TAR_FILE=$POSTGRES_SID.$SCHEMA_NAME".TABLE."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE".tar"
             tar -cvf   $TAR_FILE  $POSTGRES_SID.$SCHEMA_NAME*".TABLE."$HOST*$LOGDATE.pg_dump         
             rm *$HOST*$LOGDATE.pg_dump    >> $LOG_FILE  
             gzip  $TAR_FILE
         else 
              LOG_FILE_PGDUMP_SCHEMA=$POSTGRES_SID.$SCHEMA_NAME".SCHEMA."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dump
              echo " LOG_FILE_PGDUMP_SCHEMA: " $LOG_FILE_PGDUMP_SCHEMA  >> $LOG_FILE
              Print_Blank_Line      
              $PG_DUMP $POSTGRES_SID -U $FROM_OWNER -c -O -n $SCHEMA_NAME > $LOG_FILE_PGDUMP_SCHEMA
            #  cp $LOG_FILE_PGDUMP_SCHEMA $LOG_FILE_PGDUMP_SCHEMA
#             perl -pi -e '$SCHEMA_NAME/$TO_SCHEMA' $PGDUMP_FILE_TABLE
              echo "Ingesting: " $PGDUMP_FILE_TABLE " TO: " $TO_POSTGRES_SID " @ " $TO_HOST    >> $LOG_FILE                
              $PSQL -d $TO_POSTGRES_SID -h $TO_HOST -f $LOG_FILE_PGDUMP_SCHEMA
              gzip  *$HOST*$LOGDATE.pg_dump   
              rm *$HOST*$LOGDATE.pg_dump    >> $LOG_FILE 
         fi  
         if [ $SCHEMA_NAME == $GINA_METADATA ] || [ $SCHEMA_NAME == $GINA_DBA ]; then
              SCHEMA_TYPE=$DBA
              POSTGRES_USER=$CHAASE
         fi
    
         $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "revoke all privileges on schema $SCHEMA_NAME from PUBLIC cascade;"    >> $LOG_FILE 
         $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter schema $SCHEMA_NAME owner to $TO_OWNER;"                        >> $LOG_FILE 
         $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on schema $SCHEMA_NAME to $TO_OWNER;"                       >> $LOG_FILE 

echo "SCHEMA_NAME: "   $SCHEMA_NAME   
echo "SCHEMA_TYPE: "   $SCHEMA_TYPE
echo "POSTGRES_USER: " $POSTGRES_USER

         # the Lord taketh away..............
         $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "revoke all privileges on schema $SCHEMA_NAME from $PUBLIC_GROUP cascade;"  >> $LOG_FILE 
         for ROLE_NAME in $ROLE_LIST; do
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "REVOKE all privileges on SCHEMA $SCHEMA_NAME FROM $ROLE_NAME CASCADE;"     
         done
         # and the Lord giveth to the worthy..............
         $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter schema $SCHEMA_NAME owner to $POSTGRES_USER;"                    >> $LOG_FILE   
         $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on schema $SCHEMA_NAME to $POSTGRES_USER;"                   >> $LOG_FILE 
 
         Check_PGSQL_Status
         Print_Blank_Line    
        
          export POSTGRES_USER=$TO_OWNER
 
         for TABLENAME in $TABLE_LIST; do  
             TABLE_NAME=$SCHEMA_NAME"."$TABLENAME
             # EXCEPTIONS are my dba and/or chaase owned schemas which nobody cares about except me anyway.....
             if [ $SCHEMA_TYPE == $DBA ]; then
                  $PSQL_COMMAND_LINE_ac "$ALTER_SCHEMA $TO_SCHEMA $OWNER_TO $CHAASE;"           >> $LOG_FILE    
                  $PSQL_COMMAND_LINE_ac "$ALTER_TABLE $TABLE_NAME $OWNER_TO $CHAASE;"           >> $LOG_FILE  
             else 
                  $PSQL_COMMAND_LINE_ac "$ALTER_SCHEMA $SCHEMA_NAME $OWNER_TO $TO_OWNER;"       >> $LOG_FILE   
                  $PSQL_COMMAND_LINE_ac "$ALTER_TABLE $TABLE_NAME $OWNER_TO $TO_OWNER;"         >> $LOG_FILE  
#                 if [ $ON_SEASIDE == $NO ]  && [ $SCHEMA_NAME == $NSSI_PROD ]; then
                  if [ $ON_SEASIDE == $NO ]  && [ $SCHEMA_NAME == $NSSI_PROD ] && [ $DB_TYPE != $DBA ]; then
                       $PSQL_COMMAND_LINE_ac "$GRANT_SELECT on table $TABLE_NAME to $JESS;"          >> $LOG_FILE  
                  fi
             fi
         done  # table privs loop
      
   done # schemas loop


#   REMOTE_SCP_PGDUMP

done       # db loop
    

Print_Footer 

Send_Email_To_DBA

exit



         INDEX_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -At -c "select distinct indexname from pg_indexes where schemaname='$SCHEMA_NAME' order by indexname"` >> $LOG_FILE
         for INDEXNAME in $INDEX_LIST; do
             INDEX_NAME=$SCHEMA_NAME"."$INDEXNAME
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter index $INDEX_NAME owner to $POSTGRES_USER;"               >> $LOG_FILE  
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter index $INDEX_NAME set tablespace $POSTGRES_TABLESPACE;"   >> $LOG_FILE  
         done # indexes

         SEQUENCE_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -At -c "select distinct sequence_name from information_schema.sequences where sequence_catalog = '$POSTGRES_SID' and sequence_schema='$SCHEMA_NAME' order by sequence_name"` >> $LOG_FILE
         for SEQUENCENAME in $SEQUENCE_LIST; do
             SEQUENCE_NAME=$SCHEMA_NAME"."$SEQUENCENAME
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter sequence $SEQUENCE_NAME owner to $POSTGRES_USER;"              >> $LOG_FILE  
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on sequence $SEQUENCE_NAME to $POSTGRES_USER;"             >> $LOG_FILE 
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter sequence $SEQUENCE_NAME set tablespace $POSTGRES_TABLESPACE;"  >> $LOG_FILE  
         done # sequences 
