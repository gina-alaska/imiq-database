#! /bin/bash -x
#
#**************************************************************************************
#
# File Name:  ~/pgsql/tools/$PG_DUMPALL.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~/pgsql/tools/$PG_DUMPALL.bash 
#
# Permissions: Password to the Postgres userid 'pgsql'.  
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
#	        1) the target tables within the PostgreSQL SID AFS exist
#               2) the PostgreSQL account "AFS" exists, unlocked and requires a password
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
#   5/3/2006    C. Haase    Added a bunch of things to make this comparable to the revised
#                           pg_dump.bash.
#                           NOTE: In pg_dump.bash the -d goes to $POSTGRES_SID; since this 
#                                 is the cluster dump I made this one Postgres to avoid ownership conflicts across the nodes.
#   5/10/2006   C. Haase    1) Added loop for gromit/wallace
#                           2) Added option string for export and file names
#                           3) Added PostgreSQL version to the filename
#                           4) GZIP at the end of the process
#                           5) For W/G $DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
#  5/15/2006    C. Haase    Commented out Post GIS version code; not using it yet.
#  8/1/2006     C. Haase    1) Added env vars for cron DB_BUPS_PGSQL_LOCAL, DB_BUPS_PGSQL_SHARED
#                           2) Added cron stuff for determining HOST
#
#----------------------------------------------------------------------------------------------------		




if [ "$#" -ne 8 ]; then
	echo "Usage: $0 file 1=Do Maintenance [Vacuumdb/Reindexdb] (Y/N): 2=Globals(Y/N): 3=Roles(Y/N): 4:Schemas(Y/N):  5=Tablespaces(Y/N):  6=Data(Y/N) 7=All(Y/N): 8=DEBUG(Y/N): "
	exit 1
else
	export MAINT=$1
        export GLOBALS=$2
        export ROLES=$3
        export SCHEMAS=$4
        export TABLESPACES=$5
        export DATA=$6
        export ALL=$7
        export DEBUG=$8
#	export SYNC=$2
    
fi

export POSTGRES_SID="cluster"




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


######################################################################### 


# NOTE: In pg_dump.bash the -d goes to $POSTGRES_SID; since this is the cluster dump
#       I made this one Postgres to avoid ownership conflicts across the nodes.
#
export FROM_OWNER="postgres"
	
List_PG_Databases
Set_PG_DB_Type
#   Check_PG_Privs


Print_Header


echo "LOG_FILE:  "  $LOG_FILE

#export DATA_DIR=$PGDATA
#export EXPORT_DIR=$DB_EXPORT

 
cd $PG_DUMP_DIR

echo "PG_DUMP_DIR: " $PG_DUMP_DIR


#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------

Print_Header



if [ $DEBUG == $YES ]; then
       echo "PG_DUMP_DIR:"             $PG_DUMP_DIR
       echo "POSTGRES_VERSION:"        $POSTGRES_VERSION
       echo "POSTGRES_VERSION_FILE: "  $POSTGRES_VERSION_FILE

        echo "LOG_FILE_PGDUMP_ALL_CLUSTER: "  $LOG_FILE_PGDUMP_ALL_CLUSTER
        echo "LOG_FILE_PGDUMP_ALL_GLOBAL: "   $LOG_FILE_PGDUMP_ALL_GLOBAL 
        echo "LOG_FILE_PGDUMP_ALL_ROLES: "    $LOG_FILE_PGDUMP_ALL_ROLES
        echo "LOG_FILE_PGDUMP_ALL_SCHEMA: "   $LOG_FILE_PGDUMP_ALL_SCHEMA
        echo "LOG_FILE_PGDUMP_ALL_TBLSPC: "   $LOG_FILE_PGDUMP_ALL_TBLSPC        
       echo "LOG_FILE_PGDUMP_ALL_DATA: "     $LOG_FILE_PGDUMP_ALL_DATA
fi


#OPTION_STRING_FILE="-c","-g","-r","-s","-t","-ac"
OPTION_STRING_FILE="-c"   
 
if [ $MAINT == $YES ] ;  then

     POSTGRES_SID=""
     for POSTGRES_SID in $DB_LIST ; do

#         LOG_FILE_PGDUMP_DATABASE=$POSTGRES_SID.$HOST.FULL.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dump

         Print_Blank_Line 
         echo "***** oid2name -d -x *****"    >> $LOG_FILE
         oid2name -d $POSTGRES_SID -x         >> $LOG_FILE
                  
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
#        $PG_DUMP -d $POSTGRES_SID -c -U $FROM_OWNER > $LOG_FILE_PGDUMP_DATABASE
#        PG_DUMP_STATUS=$?
#        if [ $PG_DUMP_STATUS -ne $SE_SUCCESS ]; then
#             echo "** ERROR: PG_DUMP DIED ==> " $PG_DUMP_STATUS " db: " $POSTGRES_SID        >> $LOG_FILE		 
#             exit 1                    
#        fi
#        echo "** Successful Dumping of DB: " $POSTGRES_SID  " Owner: " $FROM_OWNER            >> $LOG_FILE	
#        $GZIP  *.pg_dump    >> $LOG_FILE
#        GZIP_STATUS=$?
#        if [ $GZIP_STATUS -ne $SE_SUCCESS ]; then
#             echo "** ERROR: GZIP from /san/local FAILED! : "  $GZIP_STATUS                  >> $LOG_FILE	
#             exit 1
#        fi
#        echo "** Successful GZIPing of DB Dump file: "   $POSTGRES_SID  " Owner: " $FROM_OWNER	>> $LOG_FILE	
   
    done
    

exit
    
    
fi

Get_PG_CONTROLDATA
Get_PG_CONFIG

# 1) did not use the -f because it is invalid for 8.3 and under so went with the generic thing.
# 2) went ahead and use -r and -t even though they aren't legal until 8.3 or higher.  
      
# crappy but it works.
if [ $GLOBALS == $YES ] ;  then
	echo "Dumping GLOBALS:"  
	OPTION_STRING_FILE="-g"   
	$PG_DUMPALL -g -U $FROM_OWNER > $LOG_FILE_PGDUMP_ALL_GLOBAL
	gzip *.pg_dumpall
fi

if [ $ROLES == $YES ] ;  then
        echo "Dumping ROLES:" 
        OPTION_STRING_FILE="-r" 
	$PG_DUMPALL -r -U $FROM_OWNER > $LOG_FILE_PGDUMP_ALL_ROLES
	gzip *.pg_dumpall
fi

if [ $SCHEMAS == $YES ] ;  then
	echo "Dumping SCHEMAS:" 
	OPTION_STRING_FILE="-s" 
	$PG_DUMPALL -s -U $FROM_OWNER > $LOG_FILE_PGDUMP_ALL_SCHEMA
	gzip *.pg_dumpall
fi

if [ $TABLESPACES == $YES ];  then
	echo "Dumping TABLESPACES:  " 
	OPTION_STRING_FILE="-t" 
	$PG_DUMPALL -t -U $FROM_OWNER > $LOG_FILE_PGDUMP_ALL_TBLSPC
	gzip *.pg_dumpall
fi

if [ $DATA == $YES ];  then
      echo "Dumping -ac :  " 
      OPTION_STRING_FILE="-ac" 
      $PG_DUMPALL -ac -U $FROM_OWNER > $LOG_FILE_PGDUMP_ALL_DATA
      gzip *.pg_dumpall
fi

if [ $ALL == $YES ];  then
	echo " Dumping ???:  " 
	OPTION_STRING_FILE="-c" 
	$PG_DUMPALL -c -U $FROM_OWNER > $LOG_FILE_PGDUMP_ALL_CLUSTER
	gzip *.pg_dumpall
fi

REMOTE_SCP_PGDUMP

Print_Footer

exit

PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
    rm $BUP_LOG
    rm $LOG_FILE
#   echo "** ERROR: PGSQL command died ==> sqlplus_status  = "  $PGSQL_STATUS  
#   echo "** ERROR: ......... filename: pg_dump"  $POSTGRES_SID  $FROM_OWNER    
#   echo " " 									
#   echo " " 									 
else

#   echo " " 							  		  >> $LOG_FILE;
#   echo "** Successful Dumping of DB: "   $POSTGRES_SID  " Owner: " $FROM_OWNER  >> $LOG_FILE;
#   echo " " 									  >> $LOG_FILE;

   gzip *.pg_dumpall
  
#   cp -p $BUP_LOG.gz  $DB_BUPS_PGSQL_SHARED/$POSTGRES_SID
#   cp -p $LOG_FLE     $DB_BUPS_PGSQL_SHARED/$POSTGRES_SID
#
fi


