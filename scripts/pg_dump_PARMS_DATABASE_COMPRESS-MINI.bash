#! /bin/bash  -x
# *************************************************************************************
#
# File Name:  ~dba/tools/pg_dump_PARMS_DATABASE_COMPRESS-MINI.bash
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
#  3/12/15     C. Haase    Initial version v0   
#                          ==> COPIED FROM pg_dump_PARMS_DATABASE.bash
#
#     
#----------------------------------------------------------------------------------------------------		

#
# this will be overwritten later on if host is seaside 
if [ "$#" -ne 5 ]; then
      echo "Usage: $0 file 1=PostgreSID(cluster for all): 2=Schema_List(tables,views,all):  3=Table_List(table(s),all): 4=Compress Individually(Y/N): 5=SKIP_ODM* (Y/N): "
      echo " To dump entire database:  database_name all all Y "
      echo " To dump all tables in one schema:  database_name schema_name all Y  "
      echo " To dump all tables in one schema:  database_name schema_name table(s) Y   "
      exit 1
else  
      export POSTGRES_SID=$1 
      export SCHEMA_LIST_USER_PUBLIC=$2  
      export EXPORT_TABLE_LIST=$3
      export COMPRESS_TABLES=$4
      export SKIP_ODM=$5
fi	


#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#


EXPORT_SOURCE=$HOME/gina-alaska/dba-tools/backup_scripts
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
    echo "sourcing: "  $EXPORT_NAME
    source $EXPORT_NAME
done


export LOG_FILE_BASENAME="`basename $0 .bash`"
export LOG_FILE=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"

export OPTION_STRING_FILE="cOn"


######################################################################### 
        
Print_Header

echo "PGDumping: " $POSTGRES_SID "  Schema_List: " $SCHEMA_LIST_USER_PUBLIC  "  Exporting Tables: " $EXPORT_TABLES   " Compress Tables: "  $COMPRESS_TABLES >> $LOG_FILE


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

# if want all schemas then get all of the schemas from the system tables
if [ $SCHEMA_LIST_USER_PUBLIC == "all" ]; then
    SCHEMA_LIST_USER_PUBLIC=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_schema from information_schema.tables where table_schema not similar to 'pg_*' and table_schema != 'information_schema';"`  >> $LOG_FILE
fi
# loop over schema list  
for SCHEMA_NAME in $SCHEMA_LIST_USER_PUBLIC; do
    # if want all of the tables within a schema then get all of the tables for current schema from the system tables
    if [ $EXPORT_TABLE_LIST == "all" ]; then
       # want ALL tables 
       if [ $SKIP_ODM == "N" ]; then
         TABLE_LIST=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_name from information_schema.tables where table_schema='$SCHEMA_NAME' order by table_name"` >> $LOG_FILE
       # want ALL tables EXCEPT odms !!
       else
         TABLE_LIST=`$PSQL -d $POSTGRES_SID -U $POSTGRES $PSQL_Atc "$SELECT_DISTINCT table_name from information_schema.tables where table_schema='$SCHEMA_NAME' and table_name NOT LIKE 'odm%' order by table_name"` >> $LOG_FILE
       fi
	 # if NOT all tables, but specific list then make this the list of tables to pg_dump    
    else
         TABLE_LIST=$EXPORT_TABLE_LIST
    fi
    Print_Blank_Line  
    # now loop over list of tables to be pg_dump ed
    for TABLENAME in $TABLE_LIST; do   
        TABLE_NAME_FULL=$SCHEMA_NAME"."$TABLENAME
        LOG_FILE_PGDUMP_TABLE=$POSTGRES_SID.$TABLE_NAME_FULL".TABLE."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dump        
        echo "LOG_FILE_PGDUMP_TABLE: " $LOG_FILE_PGDUMP_TABLE    >> $LOG_FILE 
        $PG_DUMP $POSTGRES_SID -U $POSTGRES -t $TABLE_NAME_FULL > $LOG_FILE_PGDUMP_TABLE
        if [ $COMPRESS_TABLES == $YES ]; then
             gzip *.pg_dump
             rm *$HOST*$LOGDATE.pg_dump >> $LOG_FILE
        fi
    done 
    # if NOT compressing each table individually then create a tar gzipped file to hold the pg_dumped tables
    if [ $COMPRESS_TABLES == $NO ]; then
		   TAR_FILE=$POSTGRES_SID.$SCHEMA_NAME".TABLE."$HOST.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE".tar"
		   tar -cvf   $TAR_FILE  $POSTGRES_SID.$SCHEMA_NAME*".TABLE."$HOST*$LOGDATE.pg_dump         
         rm *$HOST*$LOGDATE.pg_dump    >> $LOG_FILE  
         gzip  $TAR_FILE
    fi  
done     
    
    
exit
#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------


cd $PG_DUMP_DIR

REMOTE_SCP_PGDUMP

Check_SCP_Status
	
Print_Footer 

Send_Email_To_DBA


exit
