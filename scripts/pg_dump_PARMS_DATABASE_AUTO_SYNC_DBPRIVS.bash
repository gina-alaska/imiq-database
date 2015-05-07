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
if [ "$#" -ne 3 ]; then
      echo "Usage: $0 file 1=PostgresSID: 2=TO_OWNER: 3=DEBUG(Y/N): "
      exit
else  
      export POSTGRES_SID=$1
      export FROM_HOST=$HOST
      export TO_OWNER=$2
      export POSTGRES_USER=$TO_OWNER
      export DEBUG=$3
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


export LOG_FILE_BASENAME="`basename $0 .bash`"
export LOG_FILE=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"

export OPTION_STRING_FILE="cOn"


#########################################
        
Print_Header


DB_LIST=$POSTGRES_SID
List_PG_Databases
Set_PG_DB_Type



#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------


Get_Current_TimeStamp
Get_NOW_TimeStamp

List_PG_Databases

echo "============================ DATABASE INFORMATION ============================" > $LOG_FILE
Print_Blank_Line  
Print_Blank_Line   
echo "************************************* "   >> $LOG_FILE 
echo "=====> DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
echo "=====> POSTGRES_USER: " $POSTGRES_USER     >> $LOG_FILE 
echo "************************************* "   >> $LOG_FILE 
Print_Blank_Line  
Print_Blank_Line   


psql -d $POSTGRES_SID -U postgres -Atc "alter database $POSTGRES_SID owner to $POSTGRES_USER;"   >> $LOG_FILE 
psql -d $POSTGRES_SID -U postgres -Atc "grant all on database $POSTGRES_SID to $POSTGRES_USER;"   >> $LOG_FILE psql -d $POSTGRES_SID -U postgres -Atc "grant all on database $POSTGRES_SID to $CHERYL;"   >> $LOG_FILE  
                                   
SCHEMA_LIST_USER=`psql -d $POSTGRES_SID -Atc "select distinct schema_name from information_schema.schemata where schema_name != 'pg_catalog' and schema_name != 'information_schema' and schema_name NOT LIKE 'pg_%';"`  >> $LOG_FILE 

for POSTGRES_SID in $DB_LIST ; do

    Print_Blank_Line 
    echo "***** Schema Names: \dn+ *****"                       >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "\dn+"            >> $LOG_FILE

    export POSTGRES_USER=$TO_OWNER

    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter database $POSTGRES_SID owner to $POSTGRES_USER;"                       >> $LOG_FILE   

    List_PG_Schemas

    # broke out the pg schemas into separate loop because don't want to loop through each system table and grant privs on them! 
    for SCHEMA_NAME in $SCHEMA_LIST_PG; do
       List_PG_Roles
       # just in case......
       if [ $SCHEMA_NAME == $PG_CATALOG ] || [ $SCHEMA_NAME == $INFORMATION_SCHEMA ]; then    
            SCHEMA_TYPE=$SYSTEM
            # the DBA taketh away..............
            $PSQL_COMMAND_LINE_ac "$REVOKE_ALL privileges on schema $SCHEMA_NAME from $PUBLIC_GROUP cascade;"  >> $LOG_FILE 
            for ROLE_NAME in $ROLE_LIST_ALL; do 
                $PSQL_COMMAND_LINE_ac "$REVOKE_ALL privileges on schema $SCHEMA_NAME FROM $ROLE_NAME CASCADE;"     >> $LOG_FILE 
            done
            # and the DBA giveth to the worthy..............
            $PSQL_COMMAND_LINE_ac "$GRANT_USAGE on schema $SCHEMA_NAME to $POSTGRES_USER;"         >> $LOG_FILE  
            $PSQL_COMMAND_LINE_ac "$GRANT_USAGE on schema $SCHEMA_NAME to $DBA;"                   >> $LOG_FILE  
            $PSQL_COMMAND_LINE_ac "$GRANT_USAGE on schema $SCHEMA_NAME to $CHAASE;"                >> $LOG_FILE  
        fi
    done # schemas_pg_system

    for SCHEMA_NAME in $SCHEMA_LIST_USER_PUBLIC; do  
        SCHEMA_TYPE="user"
 #         the DBA taketh away..............
         $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "revoke all privileges on schema $SCHEMA_NAME from $PUBLIC_GROUP cascade;"  >> $LOG_FILE 
         for ROLE_NAME in $ROLE_LIST_ALL; do
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "REVOKE all privileges on SCHEMA $SCHEMA_NAME FROM $ROLE_NAME CASCADE;"  >> $LOG_FILE    
         done
         if [ $SCHEMA_NAME == $GINA_METADATA ] || [ $SCHEMA_NAME == $GINA_DBA ]; then
              SCHEMA_TYPE=$DBA
 #            POSTGRES_USER=$DBA
              $PSQL_COMMAND_LINE_ac "$ALTER_SCHEMA $SCHEMA_NAME owner to dba;"                    >> $LOG_FILE   
              $PSQL_COMMAND_LINE_ac "$GRANT_ALL on schema $SCHEMA_NAME to dba;"                   >> $LOG_FILE 
#             $PSQL_COMMAND_LINE_ac "$ALTER_SCHEMA $SCHEMA_NAME owner to $CHAASE;"                >> $LOG_FILE   
              $PSQL_COMMAND_LINE_ac "$GRANT_ALL on schema $SCHEMA_NAME to $CHAASE;"               >> $LOG_FILE 
              $PSQL_COMMAND_LINE_ac "$GRANT_USAGE on schema $SCHEMA_NAME to $POSTGRES_USER;"      >> $LOG_FILE  
         else
              $PSQL_COMMAND_LINE_ac "$ALTER_SCHEMA $SCHEMA_NAME owner to $POSTGRES_USER;"         >> $LOG_FILE   
              $PSQL_COMMAND_LINE_ac "$GRANT_ALL on schema $SCHEMA_NAME to $POSTGRES_USER;"        >> $LOG_FILE 
              $PSQL_COMMAND_LINE_ac "$GRANT_ALL on schema $SCHEMA_NAME to $CHAASE;"               >> $LOG_FILE  
              $PSQL_COMMAND_LINE_ac "$GRANT_ALL on schema $SCHEMA_NAME to dba;"                   >> $LOG_FILE  
         fi

echo "SCHEMA_NAME: "   $SCHEMA_NAME   
echo "SCHEMA_TYPE: "   $SCHEMA_TYPE
echo "POSTGRES_USER: " $POSTGRES_USER


         Check_PGSQL_Status
         Print_Blank_Line      

         List_PG_Tables

         for TABLENAME in $TABLE_LIST; do  
             TABLE_NAME=$SCHEMA_NAME"."$TABLENAME
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "revoke all privileges on table $TABLE_NAME from $PUBLIC_GROUP cascade;"  >> $LOG_FILE 
             for ROLE_NAME in $ROLE_LIST_ALL; do
                 $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "REVOKE all privileges on table $TABLE_NAME FROM $ROLE_NAME CASCADE;"    >> $LOG_FILE   
             done
             # EXCEPTIONS are my dba and/or chaase owned schemas which nobody cares about except me anyway.....
             if [ $SCHEMA_TYPE == $DBA ]; then
                  $PSQL_COMMAND_LINE_ac "$ALTER_TABLE $TABLE_NAME $OWNER_TO chaase;"           >> $LOG_FILE  
                  $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on table $TABLE_NAME to chaase;"   >> $LOG_FILE
                  $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on table $TABLE_NAME to dba;"   >> $LOG_FILE
             else 
                  $PSQL_COMMAND_LINE_ac "$ALTER_TABLE $TABLE_NAME $OWNER_TO $POSTGRES_USER;"         >> $LOG_FILE  
                  $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on table $TABLE_NAME to $POSTGRES_USER;"  >> $LOG_FILE 
                  $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on table $TABLE_NAME to $CHAASE;"  >> $LOG_FILE 
                  $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on table $TABLE_NAME to $DBA;"  >> $LOG_FILE 
             fi
         done  # table privs loop

echo "DONE with TABLE privs............................"

###  need to add a drop priv for each role PER sequence
         INDEX_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -At -c "select distinct indexname from pg_indexes where schemaname='$SCHEMA_NAME' order by indexname"` >> $LOG_FILE
         for INDEXNAME in $INDEX_LIST; do
             INDEX_NAME=$SCHEMA_NAME"."$INDEXNAME
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter index $INDEX_NAME owner to $POSTGRES_USER;"               >> $LOG_FILE  
         done # indexes

exit
         List_PG_Sequences
         for SEQNAME in $SEQUENCE_LIST_ALL; do  
             SEQUENCE_NAME=$SCHEMA_NAME"."$SEQNAME
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "revoke all privileges on sequence $SEQUENCE_NAME from $PUBLIC_GROUP cascade;"  >> $LOG_FILE 
             for ROLE_NAME in $ROLE_LIST_ALL; do
                 $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "REVOKE all privileges on sequence $SEQUENCE_NAME FROM $ROLE_NAME CASCADE;"   >> $LOG_FILE     
             done
             if [ $SCHEMA_TYPE == $DBA ]; then
                  $PSQL_COMMAND_LINE_ac "alter sequence $SEQUENCE_NAME $OWNER_TO dba;"           >> $LOG_FILE  
                  $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on sequence $SEQUENCE_NAME to dba;"  >> $LOG_FILE
             else 
                  $PSQL_COMMAND_LINE_ac "alter sequence $SEQUENCE_NAME $OWNER_TO $POSTGRES_USER;"         >> $LOG_FILE  
                  $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on sequence $SEQUENCE_NAME to $POSTGRES_USER;"  >> $LOG_FILE 
             fi
         done

echo "DONE with SEQUENCE privs........................."




        
   done # schemas loop

echo "DONE with SCHEMA privs..........................."
   

exit




#   REMOTE_SCP_PGDUMP

done       # db loop


   Print_Blank_Line 
    echo "***** Schema Privs: \dn+ *****"                       >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "\dn+"            >> $LOG_FILE


 Print_Blank_Line 
    echo "***** Table Privs: \dt *****"                       >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "\dt"            >> $LOG_FILE

    echo "***** Table Privs: \d+ *****"                       >> $LOG_FILE 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "\d+"            >> $LOG_FILE
    

Print_Footer 

Send_Email_To_DBA

exit


      INDEX_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -At -c "select distinct indexname from pg_indexes where schemaname='$SCHEMA_NAME' order by indexname"` >> $LOG_FILE
         for INDEXNAME in $INDEX_LIST; do
             INDEX_NAME=$SCHEMA_NAME"."$INDEXNAME
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter index $INDEX_NAME owner to $POSTGRES_USER;"               >> $LOG_FILE  
 #            $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter index $INDEX_NAME set tablespace $POSTGRES_TABLESPACE;"   >> $LOG_FILE  
         done # indexes

         SEQUENCE_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -At -c "select distinct sequence_name from information_schema.sequences where sequence_catalog = '$POSTGRES_SID' and sequence_schema='$SCHEMA_NAME' order by sequence_name"` >> $LOG_FILE
         for SEQUENCENAME in $SEQUENCE_LIST; do
             SEQUENCE_NAME=$SCHEMA_NAME"."$SEQUENCENAME
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter sequence $SEQUENCE_NAME owner to $POSTGRES_USER;"              >> $LOG_FILE  
             $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "grant all on sequence $SEQUENCE_NAME to $POSTGRES_USER;"             >> $LOG_FILE 
 #            $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "alter sequence $SEQUENCE_NAME set tablespace $POSTGRES_TABLESPACE;"  >> $LOG_FILE  
         done # sequences 
