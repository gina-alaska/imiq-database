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
#   10/23/2007  C. Haase    1) Added tons of "upgrades" from other bash scripts
#                           2) Added option for a "regular" dump -Fc to feed into pg_restore
#
#----------------------------------------------------------------------------------------------------		

# Environmental variables

export THEDATE=`date +%y%m%d_%H:%M`
export THEDATE_YYMMDD=`date +%y%m%d`
export LOGDATE=`date +%Y-%m-%d_%H%M%S`
export OPTION_STRING_FILE="cOn"
export SE_SUCCESS=0
export SE_FAILURE=-1


# hostname is not evaluated the same on seaside as it is on wallace and gromit...
export SEASIDE_FULL="seaside"
export GROMIT_FULL="gromit.gina.alaska.edu"
export WALLACE_FULL="wallace.gina.alaska.edu"
export BEEF_FULL="BEEF.gina.alaska.edu"

export SEASIDE="seaside"
export GROMIT="gromit"
export WALLACE="wallace"
export BEEF="BEEF"

export POSTGRES_VERSION="813"

if [ $HOSTNAME == $GROMIT_FULL ]; then
        export HOST=$GROMIT
elif [ $HOSTNAME == $BEEF_FULL ]; then
        export HOST=$GROMIT
elif [ $HOSTNAME == $WALLACE_FULL ]; then
	export HOST=$WALLACE
elif [ $HOSTNAME == $SEASIDE_FULL ]; then
	export HOST=$SEASIDE
	export POSTGRES_VERSION="814"
# vogon which really isn't used much anymore, but just to be certain...
else
	export HOST=$HOSTNAME
	export POSTGRES_VERSION="803"
fi

export  HOST_DEV="seaside"
export  HOST_DEVTEST="vogon"
export  HOST_TEST="gromit"
export  HOST_PROD="wallace"

if [ "$#" -lt 1 | -gt 5 ]; then
	echo "Usage: $0 file 1=PostgresSID 2=Owner of DB 3=PG_RESTORE (y/n) 4=SQL_INSERTS (y/n): BLOBS (y/n): "
	exit 1
else
	export DB_NAMES=$1
	export FROM_OWNER=$2
	export PGRESTORE=$3
	export INSERTS=$4
	export BLOBS=$5
fi

if [ $DB_NAMES == "ALL" ]; then
   export OPTION_STRING="-Fc"
   export OPTION_STRING_FILE="Fc"
   export PGRESTORE="y"
   export INSERTS="n"
   export BLOBS="n"
else
   if [ $PGRESTORE == "y" ]; then
      export OPTION_STRING="-Fc"
      export OPTION_STRING_FILE="Fc"
   else
       if [ $INSERTS == "y" ]; then
  	  export OPTION_STRING="-C -D -v"
	  export OPTION_STRING_FILE="CD"
        else
           if [ $BLOB == "y" ]; then
      	      export OPTION_STRING="-b -c -F t -o -v"
	      export OPTION_STRING_FILE="bcFto"
           else 
       	      export OPTION_STRING="-c -F t -o -v" 
	      export OPTION_STRING_FILE="cFto"
	   fi
        fi
   fi
fi


#LIST=$(psql -l | awk '{ print $1}' | grep -vE '^-|^List|^Name|template[0|1]')
#for d in $LIST
#do
#  echo "database name is:  "  $d
#done



# Get the list of databases.
PG_DATABASES="`/usr/bin/psql -l \
  | awk 'NF == 5 && \
     $1 != "Name" && \
     $1 != "template0" && \
     $2 == "|" && \
     $3 != "Owner" && \
     $4 == "|" && \
     $5 != "Encoding" \
     {print $1}' \
  | sort`"

 

case "$HOST" in
      $HOST_DEV) 
      
      		export GINA_DIR=$HOME/tools/backup_scripts/POSTGRES
                export EXPORT_DIR=/ora/PostgreSQL_PostGIS/database_backups
	        export INGEST_DIR=/ora/PostgreSQL_PostGIS/database_backups
		export SOURCE_DIR=$GINA_DIR
				
		export PG_DUMP=/usr/bin/pg_dump
		export PG_DUMPALL=/usr/bin/pg_dumpall
		export PSQL=/usr/bin/psql
	
		;;
		

	*)  echo "What machine are you on???"  > $LOG_FILE ; 
	esac
	
	

------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------

export LOG_FILE=$LOG_DIR/$POSTGRES_SID.$HOST.$FROM_OWNER.$OPTION_STRING_FILE-$POSTGRES_VERSION.$LOGDATE.log


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


for CURRENT_DB in $PG_DATABASES; do
    
    if [ $DB_NAMES == "ALL" ]; then
       export POSTGRES_SID=$CURRENT_DB
    fi
    if [ $DB_NAMES == $CURRENT_DB ]; then
       export POSTGRES_SID=$CURRENT_DB

    fi
    
        echo "..Backing up postgresql database"   $POSTGRES_SID
        export DATA_DIR=$EXPORT_DIR/$POSTGRES_SID
	export LOG_DIR=$DATA_DIR
        export BUP_LOG=$LOG_DIR/$POSTGRES_SID.$HOST.$FROM_OWNER.$OPTION_STRING_FILE-$POSTGRES_VERSION.$LOGDATE.pg_dump

    else
        echo "..Backing up postgresql database"   $POSTGRES_SID
	export DATA_DIR=$EXPORT_DIR/$POSTGRES_SID
	export LOG_DIR=$DATA_DIR
        export BUP_LOG=$LOG_DIR/$POSTGRES_SID.$HOST.$FROM_OWNER.$OPTION_STRING_FILE-$POSTGRES_VERSION.$LOGDATE.pg_dump
        export LOG_FILE=$LOG_DIR/$POSTGRES_SID.$HOST.$FROM_OWNER.$OPTION_STRING_FILE-$POSTGRES_VERSION.$LOGDATE.log

     fi

done

exit

$PG_DUMP -d $POSTGRES_SID $OPTION_STRING -U $FROM_OWNER > $BUP_LOG
PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
    rm $BUP_LOG
    rm $LOG_FILE
    echo "** ERROR: PGSQL command died ==> sqlplus_status  = "  $PGSQL_STATUS  
    echo "** ERROR: ......... filename: " $BUP_LOG  $POSTGRES_SID    
    echo " " 									
    echo " " 									 
else
    echo " " 							  		   >> $LOG_FILE;
    echo "** Successful Dumping of DB:  "   $POSTGRES_SID  " Owner: " $FROM_OWNER  >> $LOG_FILE;
    echo "** ...Gzipping PG_DUMP File:  "   $BUP_LOG                               >> $LOG_FILE;
    echo " " 									   >> $LOG_FILE;

    gzip  $BUP_LOG
									 
fi

#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------

echo " "								      	>> $LOG_FILE;
echo `date '+%m/%d/%y %A %X'` "*** log END ***"                         	>> $LOG_FILE;
echo "----------------------------------------------------------------"   	>> $LOG_FILE;
echo "Script      : "$0                                                   	>> $LOG_FILE;
echo "Database    : "$TOSID                                         	        >> $LOG_FILE;
echo "Server      : "`uname -n`                                           	>> $LOG_FILE;
echo "----------------------------------------------------------------\n" 	>> $LOG_FILE;
echo " "								        >> $LOG_FILE;
   
    
 

exit
