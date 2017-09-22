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
#  11/7/09     C. Haase    Initial version v0   
#                          ==> COPIED FROM pg_dump_PARMS_SCHEMAS.bash
#
#     
#----------------------------------------------------------------------------------------------------		
# By default, the psql script will continue to execute after an SQL error is encountered. You may wish to use the following command at the top of the script to alter that behaviour and have psql exit with an exit status of 3 if an SQL error occurs:
#
#\set ON_ERROR_STOP
#
#Either way, you will only have a partially restored dump. Alternatively, you can specify that the whole dump should be restored as a single transaction, so the restore is either fully completed or fully rolled back. This mode can be specified by passing the -1 or --single-transaction command-line options to psql. When using this mode, be aware that even the smallest of errors can rollback a restore that has already run for many hours. However, that may still be preferable to manually cleaning up a complex database after a partially restored dump.
#
#The ability of pg_dump and psql to write to or read from pipes makes it possible to dump a database directly from one server to another; for example:
#
#pg_dump -h host1 dbname | psql -h host2 dbname
#
#    Important: The dumps produced by pg_dump are relative to template0. This means that any languages, procedures, etc. added to template1 will also be dumped by pg_dump. As a result, when restoring, if you are using a customized template1, you must create the empty database from template0, as in the example above. 
#
#After restoring a backup, it is wise to run ANALYZE on each database so the query optimizer has useful statistics. An easy way to do this is to run vacuumdb -a -z; this is equivalent to running VACUUM ANALYZE on each database manually. For more advice on how to load large amounts of data into PostgreSQL efficiently, refer to Section 13.4. 
#
#
# -t table
# --table=table
#
#    Dump only tables (or views or sequences) matching table. Multiple tables can be selected by writing multiple -t switches. Also, the table parameter is interpreted as a pattern according to the same rules used by psql's \d commands (see Patterns), so multiple tables can also be selected by writing wildcard characters in the pattern. When using wildcards, be careful to quote the pattern if needed to prevent the shell from expanding the wildcards.
#
#    The -n and -N switches have no effect when -t is used, because tables selected by -t will be dumped regardless of those switches, and non-table objects will not be dumped.
#
#        Note: When -t is specified, pg_dump makes no attempt to dump any other database objects that the selected table(s) may depend upon. Therefore, there is no guarantee that the results of a specific-table dump can be successfully restored by themselves into a clean database. 
#
#       Note: The behavior of the -t switch is not entirely upward compatible with pre-8.2 PostgreSQL versions. Formerly, writing -t tab would dump all tables named tab, but now it just dumps whichever one is visible in your default search path. To get the old behavior you can write -t '*.tab'. Also, you must write something like -t sch.tab to select a table in a particular schema, rather than the old locution of -n sch -t tab. 
#
# -T table
# --exclude-table=table
#
#    Do not dump any tables matching the table pattern. The pattern is interpreted according to the same rules as for -t. -T can be given more than once to exclude tables matching any of several patterns.
#
#    When both -t and -T are given, the behavior is to dump just the tables that match at least one -t switch but no -T switches. If -T appears without -t, then tables matching -T are excluded from what is otherwise a normal dump. 
###################################################################################


if [ "$#" -ne 4 ]; then
	echo "Usage: $0 file 1=Postgres SID 2=FROM_HOST  3=TARGET DATABASE 4=DEBUG(Y/N)"
	exit 1
else
        export POSTGRES_SID=$1
        export FROM_HOST=$2
        export TARGET_DATABASE=$3
        export DEBUG=$4
fi

echo "You typed:"  $POSTGRES_SID/$FROM_HOST/$TARGET_DATABASE/$DEBUG


SYNC=$YES

#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#

SOURCE=$HOME/DEV/POSTGRES
for EXPORT_NAME in $SOURCE/EXPORT*.bash; do
    source $EXPORT_NAME
done 


######################################################################### 


#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------

# same for all boxes....

export LOG_DIR=$HOME/tools/backup_scripts/POSTGRES
export LOG_FILE=$LOG_DIR/pg_dump_PARMS_DATABASE_SYNC.$HOST.$LOGDATE.log


Print_Header

case "$HOST" in
      $HOST_DEV) 
      
      
                SOURCE=$HOME/DEV/POSTGRES
                export LOG_DIR=$HOME/tools/backup_scripts/POSTGRES
 #              export FROM_OWNER=$CHAASE
 
	  ;;
	  
	$HOST_DEVTEST)  
	


	  ;;
          
          $HOST_TESTPROD)  
	

	  ;;
		
	$HOST_TEST)  
	

           ;;
		
	$HOST_PROD)  
	


		;;		
		
	*)  echo "What machine are you on???" >> $LOG_FILE  ;; 
	esac

Print_Blank_Line  
Print_Blank_Line   
echo "************************************* "   >> $LOG_FILE 
echo "=====> DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
echo "************************************* "   >> $LOG_FILE 
Print_Blank_Line  
Print_Blank_Line   

List_PG_Roles
List_PG_Schemas

export DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID

cd $PG_DUMP_DIR

gzip *.pg_dump

PGDUMPFILES_ALL=PGDUMPFILES_ALL.$FROM_HOST.$POSTGRES_SID.$LOGDATE.lst
#PGDUMPFILES=PGDUMPFILES.$FROM_HOST.$POSTGRES_SID.$LOGDATE.lst
 
#ls -1at $POSTGRES_SID*$FROM_HOST*.pg_dump.gz > $PGDUMPFILES_ALL
#ls -1 *$FROM_SID*$FROM_HOST*$FROM_DATE*  > $INGEST_FILES
FILES_TO_FIND=$POSTGRES_SID"*"$FROM_HOST"*"$YEAR_YYYY"*pg_dump*"
ls -1t $FILES_TO_FIND > $PGDUMPFILES_ALL
#LS_STATUS=$status
#if [ $status != $SE_SUCCESS ]; then
#     echo " No PG_DUMP files to ingest.....going home...nothing to do ! "
#     exit 1
#fi 

FIRST_FILE=$NO
FILE_DATETIME=$NULL

for PGDUMP_FILE in $(cat $PGDUMPFILES_ALL); do

     #gina.afs_basedata.ALL.wallace.postgres.cOn-.2010-02-24_120032.pg_dump.gz
     SCHEMA_NAME=`echo $PGDUMP_FILE | cut -d. -f2`
     CURRENT_HOST=`echo $PGDUMP_FILE | cut -d. -f4`
     FILE_DATETIME=`echo $PGDUMP_FILE | cut -d. -f7`
     FILE_DATE=`echo $FILE_DATETIME | cut -d_ -f1`
     FILE_TIME=`echo $FILE_DATETIME | cut -d_ -f2`
     
     PGDUMP_FILE_CURRENT=$POSTGRES_SID"."$SCHEMA_NAME".ALL."$CURRENT_HOST".postgres.cOn-."$FILE_DATETIME".pg_dump"
   
     SORT_KEY1_CURRENT=$CURRENT_HOST""$POSTGRES_SID""$FILE_DATETIME  
     SORT_KEY2_CURRENT=$CURRENT_HOST""$POSTGRES_SID""$SCHEMA_NAME""$FILE_DATETIME  
  
echo " PGDUMP_FILE:   " $PGDUMP_FILE       >> $LOG_FILE
echo " SCHEMA_NAME:   " $SCHEMA_NAME       >> $LOG_FILE
echo " FILE_DATETIME: " $FILE_DATETIME     >> $LOG_FILE
echo " FILE_DATE:     " $FILE_DATE         >> $LOG_FILE
echo " FILE_TIME:     " $FILE_TIME         >> $LOG_FILE           

     if [ $FIRST_FILE == $NO ]; then
          FIRST_FILE=$YES
          FIRST_SCHEMA_NAME=`echo $PGDUMP_FILE | cut -d. -f2`
          FIRST_CURRENT_HOST=`echo $PGDUMP_FILE | cut -d. -f4`
          FIRST_FILE_DATETIME=`echo $PGDUMP_FILE | cut -d. -f7`
          FIRST_FILE_DATE=`echo $FILE_DATETIME | cut -d_ -f1`
          FIRST_FILE_TIME=`echo $FILE_DATETIME | cut -d_ -f2` 
          SORT_KEY1_FIRST=$FIRST_CURRENT_HOST""$POSTGRES_SID""$FIRST_FILE_DATETIME  
          SORT_KEY2_FIRST=$FIRST_CURRENT_HOST""$POSTGRES_SID""$FIRST_SCHEMA_NAME""$FIRST_FILE_DATETIME            
     fi  
 
echo " SORT_KEY1_CURRENT:   "   $SORT_KEY1_CURRENT     >> $LOG_FILE
echo " SORT_KEY1_FIRST:   "     $SORT_KEY1_FIRST       >> $LOG_FILE
echo " PGDUMP_FILE_CURRENT:   " $PGDUMP_FILE_CURRENT   >> $LOG_FILE

     if [ $SORT_KEY1_CURRENT == $SORT_KEY1_FIRST ]; then          
          #gina.public.ALL.wallace.postgres.cOn-.2009-12-06_190501.pg_dump.gz
          if [ $SCHEMA_NAME == $INFORMATION_SCHEMA ] || [ $SCHEMA_NAME == $PG_CATALOG ] ; then
               echo "don't do this one stupid "
          else              
               if [ -f $PGDUMP_FILE ]; then
                    echo "GZIPPing PGDUMP_FILE: " $PGDUMP_FILE  >> $LOG_FILE
                    gzip -d $PGDUMP_FILE                 
               fi
               echo "Ingesting file PGDUMP_FILE: " $PGDUMP_FILE_CURRENT        >> $LOG_FILE
               $PSQL -d $TARGET_DATABASE -U $POSTGRES -f $PGDUMP_FILE_CURRENT  >> $LOG_FILE
          fi   
     fi
done

# book'em danno
gzip  $PG_DUMP_DIR/*.pg_dump 
Check_GZIP_Status
   
Print_Footer 

Send_Email_To_DBA

exit
