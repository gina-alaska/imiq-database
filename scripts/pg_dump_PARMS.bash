#! /bin/bash -x
#
#**************************************************************************************
#
# File Name:  ~/pgsql/tools/pg_dump_PARMS-pgsql.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~/pgsql/tools/pg_dump_PARMS-pgsql.bash
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
#  6/26/2006   C. Haase    Initial version v0    
#  7/12/2006   C. Haase    For some reason the actual pg_dump command was 
#                          edited out; also, added the copy of the dump files
#                          to the shared database backup area for recovery purposes.
#  8/1/06      C. Haase    Added env var $DB_BUPS_PGSQL_SHARED so the cron would understand it.
#  8/2/06      C. Haase    Changed options so that the database is NOT created; done
#                          to allow porting to whatever db w/o having to edit out
#                          the db connect statement. Schemas and tables (and PUBLIC)
#                          are still all dropped and recreated w/ original owners !
#
#----------------------------------------------------------------------------------------------------		

# Environmental variables


# cd /home/chaase/tools/backup_scripts/POSTGRES


if [ "$#" -eq 0 ]; then
#	echo "Usage: $0 file 1=PostgresSID 2=From_Owner 3=i (inserts) 4=b/n (blob/noblob)"
	exit 1
else
	export POSTGRES_SID=$1
	export FROM_OWNER=$2
	export THREE=$3	
	if [ $THREE == "i" ]; then
	        export INSERTS="y"
# 		export OPTION_STRING="-C -D -v"
#		export OPTION_STRING_FILE="CD"	
		export OPTION_STRING="-c -D -v"		
		export OPTION_STRING_FILE="cD"
	fi
	if [ $THREE == "b" ]; then 
		export BLOB="y"
  		export OPTION_STRING="-b -c -F t -o -v"
	        export OPTION_STRING_FILE="bcFto"
	fi
	if [ $THREE == "n" ]; then 
		export BLOB="n"
  		export OPTION_STRING="-c -F t -o -v" 
	        export OPTION_STRING_FILE="cFto"
	fi			
fi

#echo "you typed: " $POSTGRES_SID/$FROM_OWNER/$OPTION_STRING


###########################################################################
# This will need to be fixed when I get back from vacation. I need this
# to run in cron until then ...........
###########################################################################

export GROMIT_FULL="gromit.gina.alaska.edu"
export WALLACE_FULL="wallace.gina.alaska.edu"

if [ $HOSTNAME == $GROMIT_FULL ]; then
        export HOST="gromit"
elif [ $HOSTNAME == $WALLACE_FULL ]; then
	export HOST="wallace"
else
	export HOST=$HOSTNAME
fi

export  HOST_DEV="seaside"
export  HOST_DEVTEST="vogon"
export  HOST_TEST="gromit"
export  HOST_PROD="wallace"


case "$HOST" in
      $HOST_DEV) GINA_DIR=$HOME/DEV/POSTGRES/seaside
                export GINA_DIR
		
		EXPORT_DIR=/pgsql/export/seaside
		export EXPORT_DIR
		
		INGEST_DIR=/pgsql/ingest/seaside
		export INGEST_DIR
		
# DATA_DIR=$GINA_DIR/data/ESRI_World_NYC
# DATA_DIR=$GINA_DIR/export
		DATA_DIR=$INGEST_DIR/ion/CAVM
		export DATA_DIR
		
		SOURCE_DIR=$GINA_DIR/scripts
		export SOURCE_DIR
		
#		LOG_DIR=/pgsql/database_backups
		LOG_DIR=/ora/PostgreSQL_PostGIS/database_backups/$POSTGRES_SID
		export LOG_DIR
		
		PG_DUMP=/usr/local/pgsql/bin/pg_dump
		export PG_DUMP
		
		PG_DUMPALL=/usr/local/pgsql/bin/pg_dumpall
		export PG_DUMPALL
		
		PSQL=/usr/local/pgsql/bin/psql
		export PSQL
		
		POSTGRES_VERSION=`echo "select version();" | $PSQL $POSTGRES_SID $FROM_OWNER | grep PostgreSQL | awk '{print $2}'`
	
		;;
	$HOST_DEVTEST)  
			
		DATA_DIR=$PGDATA
		export DATA_DIR

		EXPORT_DIR=$GINA_DIR/export
		export EXPORT_DIR

		SOURCE_DIR=$GINA_DIR/scripts
		export SOURCE_DIR
				
#		LOG_DIR=$DB_BUPS/$POSTGRES_SID
		LOG_DIR=/usr/local/pgsql/database_backups/$POSTGRES_SID		

		export LOG_DIR
		
		FROM_OWNER="postgres"
		export FROM_OWNER
						
		PG_DUMP=/usr/local/pgsql/bin/pg_dump
		export PG_DUMP
		
		PG_DUMPALL=/usr/local/pgsql/bin/pg_dumpall
		export PG_DUMPALL
		
		PSQL=/usr/local/pgsql/bin/psql
		export PSQL
		
POSTGRES_VERSION=`echo "select version();" | $PSQL -d $POSTGRES_SID -U $FROM_OWNER | grep PostgreSQL | awk '{print $2}'`
		
		;;
	$HOST_TEST)  
		
		DATA_DIR=$PGDATA
		export DATA_DIR

		EXPORT_DIR=$DB_EXPORT
		export EXPORT_DIR
		
#		LOG_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
		LOG_DIR=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID		
		export LOG_DIR
		
		DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups
		export DB_BUPS_PGSQL_LOCAL
		
		DB_BUPS_PGSQL_SHARED=/san/dds/projects/database/shared/pgsqldata/database_backups
		export DB_BUPS_PGSQL_SHARED
		
		FROM_OWNER="postgres"
		export FROM_OWNER
										
		PG_DUMP=/usr/bin/pg_dump
		export PG_DUMP
		
		PG_DUMPALL=/usr/bin/pg_dumpall
		export PG_DUMPALL
		
		PSQL=/usr/bin/psql
		export PSQL
		
POSTGRES_VERSION=`echo "select version();" | $PSQL -d $POSTGRES_SID -U $FROM_OWNER | grep PostgreSQL | awk '{print $2}'`
		
		;;
	$HOST_PROD)  
		
		DATA_DIR=$PGDATA
		export DATA_DIR

		EXPORT_DIR=$DB_EXPORT
		export EXPORT_DIR
		
#		LOG_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
		LOG_DIR=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID		
		export LOG_DIR		
		
		DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups
		export DB_BUPS_PGSQL_LOCAL
		
		DB_BUPS_PGSQL_SHARED=/san/dds/projects/database/shared/pgsqldata/database_backups
		export DB_BUPS_PGSQL_SHARED	
		
		FROM_OWNER="postgres"
		export FROM_OWNER
										
		PG_DUMP=/usr/bin/pg_dump
		export PG_DUMP
		
		PG_DUMPALL=/usr/bin/pg_dumpall
		export PG_DUMPALL
		
		PSQL=/usr/bin/psql
		export PSQL
		

POSTGRES_VERSION=`echo "select version();" | $PSQL -d $POSTGRES_SID -U $FROM_OWNER | grep PostgreSQL | awk '{print $2}'`
		

		;;		
		
	*)  echo "What machine are you on???" >> $LOG_FILE  ;; 
	esac


#### DEBUGGING
####echo "HOST: " $HOST
####echo "POSTGRES_VERSION: " $POSTGRES_VERSION
####exit
#### DEBUGGING


#if [ $POSTGRES_VERSION != $POSTGRES_VERSION_804 ]; then
#	POSTGIS_VERSION=`echo "select postgis_full_version();" | $PSQL -d $POSTGRES_DB -U $FROM_OWNER | grep POSTGIS= | awk '{print $1}' | cut -d= -f2`
#fi
	
	
SE_SUCCESS=0
export SE_SUCCESS

SE_FAILURE=-1
export SE_FAILURE

THEDATE=`date +%y%m%d_%H:%M`
export THEDATE

THEDATE_YYMMDD=`date +%y%m%d`
export THEDATE_YYMMDD

LOGDATE=`date +%Y-%m-%d_%H%M%S`
export LOGDATE

BUP_LOG=$LOG_DIR/$POSTGRES_SID.$HOST.$FROM_OWNER.$OPTION_STRING_FILE-$POSTGRES_VERSION-$LOGDATE.pg_dump
export BUP_LOG

LOG_FILE=$LOG_DIR/$POSTGRES_SID.$HOST.$FROM_OWNER.$OPTION_STRING_FILE-$POSTGRES_VERSION-$LOGDATE.pg_dump_log
export LOG_FILE


#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------

#echo " "								      	 > $LOG_FILE;
#echo `date '+%m/%d/%y %A %X'` "*** log BEGIN ***"                         	>> $LOG_FILE;
#echo "----------------------------------------------------------------"   	>> $LOG_FILE;
#echo "Script      : "$0                                                   	>> $LOG_FILE;
#echo "Database    : "$TOSID                                          		>> $LOG_FILE;
#echo "Server      : "`uname -n`                                           	>> $LOG_FILE;
#echo "----------------------------------------------------------------\n" 	>> $LOG_FILE;
#echo " "								        >> $LOG_FILE;

#echo " "								        >> $LOG_FILE;
#echo "***********************************************************"		>> $LOG_FILE;
#echo "* Backup database .....  "  	                                        >> $LOG_FILE;
#echo "***********************************************************"		>> $LOG_FILE;
#echo " "								        >> $LOG_FILE;

$PG_DUMP -d $POSTGRES_SID -U $FROM_OWNER $OPTION_STRING  >  $BUP_LOG
echo  "\\select schemaname,tablename,tableowner from pg_tables;"  | psql -d gina -U chaase


#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------
PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
    rm $BUP_LOG
    rm $LOG_FILE
#echo "** ERROR: PGSQL command died ==> sqlplus_status  = "  $PGSQL_STATUS  
#echo "** ERROR: ......... filename: pg_dump"  $POSTGRES_SID  $FROM_OWNER    
#echo " " 									
#echo " " 									 
else
#echo " " 							  		  >> $LOG_FILE;
#echo "** Successful Dumping of DB: "   $POSTGRES_SID  " Owner: " $FROM_OWNER  >> $LOG_FILE;
#echo " " 									  >> $LOG_FILE;

   gzip $BUP_LOG
   
   cp -p $BUP_LOG.gz  $DB_BUPS_PGSQL_SHARED/$POSTGRES_SID
#   cp -p $LOG_FLE     $DB_BUPS_PGSQL_SHARED/$POSTGRES_SID

#echoecho " "								      	>> $LOG_FILE;
#echoecho `date '+%m/%d/%y %A %X'` "*** log END ***"                         	>> $LOG_FILE;
#echoecho "----------------------------------------------------------------"   	>> $LOG_FILE;
#echoecho "Script      : "$0                                                   	>> $LOG_FILE;
#echoecho "Database    : "$TOSID                                         	        >> $LOG_FILE;
#echoecho "Server      : "`uname -n`                                           	>> $LOG_FILE;
#echoecho "----------------------------------------------------------------\n" 	>> $LOG_FILE;
#echoecho " "								        >> $LOG_FILE;
   
    
fi

 

exit
