#! /bin/bash -x
#
#**************************************************************************************
#
# File Name:  ~/pgsql/tools/pg_dump.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~/pgsql/tools/pg_dump.bash 
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
#  11/01/2005   C. Haase    Initial version v0    
#  11/14/2005   C. Haase    1) Fixed the options on pg_dump command line
#                           2) Added check to determine host ==> dirs
#                           3) Rudimentary error checking if db/username combo valid
#    5/2/2006   C. Haase    1) Added loop for gromit/wallace
#                           2) Added option string for export and file names
#                           3) Added PostgreSQL version to the filename
#                           4) GZIP at the end of the process
#                           5) For W/G $DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
#
#----------------------------------------------------------------------------------------------------		

# Environmental variables



answer="n"
while [ $answer != "y" ]
do
   echo "Enter the PostgreSQL Database Name: "
   read POSTGRES_SID
   echo "Enter the User ID (Owner) of the DB: "
   read  FROM_OWNER
   echo "Export as SQL INSERT's? (y,n): "
   read INSERTS
   if [ $INSERTS == "y" ]; then
  	export OPTION_STRING="-C -D -v"
	export OPTION_STRING_FILE="CD"
   else
      echo "With Blobs/With Out Blobs? (y,n):" 
      read BLOB
      if [ $BLOB == "y" ]; then
      	  export OPTION_STRING="-b -c -F t -o -v"
	  export OPTION_STRING_FILE="bcFto"
      else 
       	  export OPTION_STRING="-c -F t -o -v" 
	  export OPTION_STRING_FILE="cFto"
      fi
   fi
   echo "you typed: " $POSTGRES_SID/$FROM_OWNER/$OPTION_STRING
   echo "type 'y' if this is correct: "
   read  answer
done


POSTGRES_VERSION=`echo "select version();" | psql -d $POSTGRES_SID -U $FROM_OWNER | grep PostgreSQL | awk '{print $2}'`
POSTGIS_VERSION=`echo "select postgis_full_version();" | psql -d $POSTGRES_SID -U $FROM_OWNER | grep POSTGIS= | awk '{print $1}' | cut -d= -f2`


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
	
		;;
	$HOST_DEVTEST)  
			
# DATA_DIR=$GINA_DIR/data/ESRI_World_NYC
# DATA_DIR=$GINA_DIR/export
		DATA_DIR=$PGDATA
		export DATA_DIR

		EXPORT_DIR=$GINA_DIR/export
		export EXPORT_DIR

		SOURCE_DIR=$GINA_DIR/scripts
		export SOURCE_DIR
				
		LOG_DIR=$DB_BUPS/$POSTGRES_SID
		export LOG_DIR
		
		FROM_OWNER="postgres"
		export FROM_OWNER

		;;
	$HOST_TEST)  
		
		DATA_DIR=$PGDATA
		export DATA_DIR

		EXPORT_DIR=$DB_EXPORT
		export EXPORT_DIR
		
		LOG_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
		export LOG_DIR
		
		FROM_OWNER="postgres"
		export FROM_OWNER

		;;	
		
	*)  echo "What machine are you on???"  >> $LOG_FILE ;; 
	esac
	
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

echo " "								      	 > $LOG_FILE;
echo `date '+%m/%d/%y %A %X'` "*** log BEGIN ***"                         	>> $LOG_FILE;
echo "----------------------------------------------------------------"   	>> $LOG_FILE;
echo "Script      : "$0                                                   	>> $LOG_FILE;
echo "Database    : "$TOSID                                          		>> $LOG_FILE;
echo "Server      : "`uname -n`                                           	>> $LOG_FILE;
echo "----------------------------------------------------------------\n" 	>> $LOG_FILE;
echo " "								        >> $LOG_FILE;

echo " "								        >> $LOG_FILE;
echo "***********************************************************"		>> $LOG_FILE;
echo "* Backup database .....  "  	                                        >> $LOG_FILE;
echo "***********************************************************"		>> $LOG_FILE;
echo " "								        >> $LOG_FILE;
pg_dump $POSTGRES_SID $OPTION_STRING -U $FROM_OWNER > $BUP_LOG

#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------
PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
    rm $BUP_LOG
    rm $LOG_FILE
    echo "** ERROR: PGSQL command died ==> sqlplus_status  = "  $PGSQL_STATUS  
    echo "** ERROR: ......... filename: pg_dump"  $POSTGRES_SID  $FROM_OWNER    
    echo " " 									
    echo " " 									 
else
    echo " " 							  		  >> $LOG_FILE;
    echo "** Successful Dumping of DB: "   $POSTGRES_SID  " Owner: " $FROM_OWNER  >> $LOG_FILE;
    echo " " 									  >> $LOG_FILE;

   gzip $BUP_LOG

echo " "								      	>> $LOG_FILE;
echo `date '+%m/%d/%y %A %X'` "*** log END ***"                         	>> $LOG_FILE;
echo "----------------------------------------------------------------"   	>> $LOG_FILE;
echo "Script      : "$0                                                   	>> $LOG_FILE;
echo "Database    : "$TOSID                                         	        >> $LOG_FILE;
echo "Server      : "`uname -n`                                           	>> $LOG_FILE;
echo "----------------------------------------------------------------\n" 	>> $LOG_FILE;
echo " "								        >> $LOG_FILE;
   
    
fi

 

exit
