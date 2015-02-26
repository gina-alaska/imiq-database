#! /bin/bash -x
#
#**************************************************************************************
#
# File Name:  ~dba/tools/backup_scripts/POSTGRES/dba_checks_PARMS-pgsql.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~dba/tools/backup_scripts/POSTGRES/dba_checks_PARMS-pgsql.bash
#
# Permissions: Password to the Postgres userid 'pgsql' or 'postgres'. 
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

#      
#
#----------------------------------------------------------------------------------------------------		


#if [ "$#" -eq 0 ]; then
#	echo "Usage: $0 file 1=PostgresSID"
#	exit 1
#else
#	export POSTGRES_SID=$1
#fi


export POSTGRES_SID="gina_dba"


######################################################
# INCLUDE FILES
######################################################

#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
EXPORT_SOURCE=$HOME/tools/backup_scripts
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
    source $EXPORT_NAME
done 

# Environmental variables
export MAIL_TO='cheryl@gina.alaska.edu'

# seaside ==> /mnt = df -h | grep /mnt | awk '{ print $5 } '
# yin,yang ==> /san/local/database/pgsqldata ===>  df -h | grep /san | awk '{ print $5 } '
# good.x,bad.x ==> /var/lib/mongod ===> Filesystem Size  Used Avail Use% Mounted on ==> df -h | grep /var | awk '{ print $4 } '

export LOG_DIR=$HOME/tools/backup_scripts

# set defaults to n then toggle back to y on host basis
export DO_PGSQL_CHECKS=$NO
export DO_MONGODB_CHECKS=$NO

export OOPSIE_MONGODB=$NO
export OOPSIE_PGSQL=$NO
export OOPSIE_SPACE=$NO

export DO_PGSQL_CHECKS=$YES

if [ $DF_DIR == "\mnt" ] ; then 
	line=`df -h | grep "\mnt"`
	size_percent=`df -h | grep "\mnt" | awk '{ print $5 } ' `
	size=`df -h | grep "\mnt" | awk '{ print $5 } ' | cut -d% -f1  `
elif [ $DF_DIR == "\san" ] ; then 
    line=`df -h | grep /san`
    size_percent=`df -h | grep "/san" | awk '{ print $5 } '`
    size=`df -h | grep "/san" | awk '{ print $5 } ' | cut -d% -f1 `
elif [ $DF_DIR == "\var" ] ; then 
   line=`df -h | grep "\var"`
   size_percent=df -h | grep "\var" | awk '{ print $4 } '
   size=`df -h | grep "\var" | awk '{ print $4 } ' | cut -d% -f1 `
else
   "DF_DIR:  ??????"
fi


if [ $size -gt $NINETY ]; then 
    OOPSIE_SPACE=$YES
    Print_Blank_Line  
	 echo "** WARNING:  Size overlimit :  "  $size  " % "            >> $LOG_FILE 
    Print_Blank_Line  
fi


echo "** MONOGDB SECTION "            >> $LOG_FILE 

mongo localhost/admin --eval "printjson(db.serverStatus())"  

mongo localhost/admin -eval "printjson(db.adminCommand( { "hostInfo" : 1 } ) )"  

mongo localhost/admin -eval "printjson(db.adminCommand( { "hostInfo.system.currentTime " : 1 } ) )"  

mongo localhost/admin -eval "printjson(db.runCommand({listDatabases: 1 }))"  

mongo localhost/admin -eval "printjson(db.runCommand({isMaster: 1 }))"  

mongo localhost/admin -eval "printjson(db.runCommand({buildInfo: 1 }))"  


mongo localhost/admin -eval "printjson(rs.conf())"
mongo localhost/admin -eval "printjson(rs.conf())" | grep _id | awk '{ print $3 } '
mongo localhost/admin -eval "printjson(rs.conf())" | grep host | awk '{ print $3 } '


mongo localhost/admin -eval "db.printReplicationInfo()"
# === if true
#configured oplog size:   4657.4427734375MB
#log length start to end: 61094902secs (16970.81hrs)
#oplog first event time:  Tue May 01 2012 13:03:07 GMT-0800 (AKDT)
#oplog last event time:   Tue Apr 08 2014 15:51:29 GMT-0800 (AKDT)
#now:                     Tue Apr 08 2014 15:52:34 GMT-0800 (AKDT)
# === if NOT true
# { "errmsg" : "neither master/slave nor replica set replication detected" }





exit


Print_Star_Line
if [ $OOPSIE_SPACE == $NO ]; then	
   Print_Blank_Line   
   echo "** SUCCESS: Space seems to be OK          **"  >> $LOG_FILE
   Print_Blank_Line
else
   Print_Blank_Line
   echo "** WARNING:  Size overlimit :  "  $size  " % "            >> $LOG_FILE 
   Print_Blank_Line
fi

if [ $OOPSIE_PGSQL == $NO ]; then	
   Print_Blank_Line
   echo "** SUCCESS: Postgres appears to be running **"  >> $LOG_FILE
   Print_Blank_Line
fi

if [ $OOPSIE_MONGODB == $NO ]; then	
   Print_Blank_Line
   echo "** SUCCESS: Mongodb appears to be running **"  >> $LOG_FILE
   Print_Blank_Line
fi



exit 
 


 
==================================== MONGODB =========================================================




mongo localhost/admin -eval "db.runCommand({logRotate:1})"

mongo localhost/admin -eval "db.adminCommand({getLog: "*" })"
 



mongo localhost/admin -eval "db.runCommand( { serverStatus: 1, workingSet: 1, metrics: 0, locks: 0 } )"



 mongo gina_dba --eval "printjson(db.getCollectionNames())"
 
 exit
 
mongo --shell dbname dbnameinit.js
 load("anotherscript.js")
 
 
// usage:
// mongo localhost/foo --quiet --eval="var collection='bar';" getcollectionkeys.js
var mr = db.runCommand({
  "mapreduce":collection,
  "map":function() {
    for (var key in this) { emit(key, null); }
  },
  "reduce":function(key, stuff) { return null; },
  "out":collection + "_keys"
})
 print(db[mr.result].distinct("_id"))
db[collection+"_keys"].drop()

 
 ==================================== POSTGRES =======================================================
 

Print_Star_Blank_Line
echo "**** PostgreSQL Processes: ps auxww ****"      >> $LOG_FILE
Print_Star_Blank_Line
$PS_GREP_POSTGRES                                    >> $LOG_FILE 

   echo "**                                                   **"  >> $LOG_FILE
   echo "**** ...Active Rows for Each Active Server Process ****"  >> $LOG_FILE
   echo "**                                                   **"  >> $LOG_FILE
   psql -d $POSTGRES_DEFAULT -U $POSTGRES -c "SELECT pg_stat_get_backend_pid(s.backendid) AS procpid,pg_stat_get_backend_activity(s.backendid) AS current_query FROM (SELECT pg_stat_get_backend_idset() AS backendid) AS s;" >> $LOG_FILE
   Check_PGSQL_Status
                                                      
   Print_Blank_Line  
   echo "============================ CLUSTER INFORMATION ============================" >> $LOG_FILE
   Print_Blank_Line   
   
   Print_Blank_Line  
   echo "**** pg_ctl status ****"          >> $LOG_FILE 
   Print_Blank_Line 
   
#         
# NOTE: If this command is run in an account that is NOT postgres (dba, chaase etc.) then this "error" message will appear.
#       In this case it is a permissions error and NOT that postgres isn't running.....if you get the following message then it
#       means that postgres IS running.
#           pg_ctl: could not open PID file "/usr/local/pgsql/data/postmaster.pid": Permission denied
   pg_ctl status
   Print_Blank_Line 
   ps -ef | grep "postmaster"              >> $LOG_FILE

  
   Print_Blank_Line  
   echo "**** PG Start Time ****"                                        >> $LOG_FILE  
   psql -d $POSTGRES_DEFAULT -U $POSTGRES -At -c "select pg_postmaster_start_time();" >> $LOG_FILE
   Check_PGSQL_Status
       
   Print_Blank_Line  
   echo "**** Postgres VERSION ****"                                       >> $LOG_FILE
   #echo '\a \\select version();' | psql -d $GINA          
   POSTGRES_VERSION=`psql -d $POSTGRES_DEFAULT -U $POSTGRES -At -c "select version();"`  >> $LOG_FILE   
   Check_PGSQL_Status
   echo $POSTGRES_VERSION                                                  >> $LOG_FILE
   
   Print_Blank_Line  
   echo "**** PostGIS VERSION ****"                                            >> $LOG_FILE
# by calling postgis_full_version you get postgis(lib_build_date,lib_version), geos, proj and use_stats 
   POSTGIS_VERSION=`psql -d $POSTGRES_DEFAULT -U $POSTGRES -At -c "select postgis_full_version();"` >> $LOG_FILE
   PGSQL_STATUS=$?
   Check_PGSQL_Status
   echo $POSTGIS_VERSION  >> $LOG_FILE

   Print_Blank_Line  
   echo "**** PG DB Acl: database, data allow conn, Acl ****"                                                      >> $LOG_FILE 
   psql -d $POSTGRES_DEFAULT -U $POSTGRES -a -c "SELECT datname, datallowconn, datacl FROM pg_database order by datname"  >> $LOG_FILE     
   Check_PGSQL_Status
   Print_Blank_Line  
 
   Print_Blank_Line 
   echo "***** oid2name  All databases: Oid, Database Name, Tablespace *****" >> $LOG_FILE
   oid2name  >> $LOG_FILE
   
   Print_Blank_Line 
   echo "***** oid2name -Si  All databases: Oid, Tablespace *****" >> $LOG_FILE
   oid2name -Si  >> $LOG_FILE
  
   Print_Blank_Line   
   echo "***** Tablespace Names: \db+ *****"       >> $LOG_FILE 
   psql -d $POSTGRES_DEFAULT -U $POSTGRES -a -c "\db+"    >> $LOG_FILE
   Check_PGSQL_Status   
   
   Print_Blank_Line   
   echo "**** Roles: \dg ****"               >> $LOG_FILE 
   # NOTE: dg and du do the same damn thing.    
   psql -d $POSTGRES_DEFAULT -U $POSTGRES -a -c "\dg"     >> $LOG_FILE    
   Check_PGSQL_Status

   Print_Blank_Line 
   echo "**** Roles: pg_roles - rolname,canlogin,rolconfig  ****" >> $LOG_FILE 
   psql -d $POSTGRES_DEFAULT -U $POSTGRES -a -c "select rolname,rolcanlogin,rolconfig from pg_roles order by rolname"  >> $LOG_FILE     
   Check_PGSQL_Status
   Print_Blank_Line   
 
   Print_Blank_Line   
   echo "**** Database Backups OS Space: Total du -sh ****"     >> $LOG_FILE 
   du -shc $DB_BUPS_PGSQL_LOCAL/*    >> $LOG_FILE
   Print_Blank_Line   

 #  Print_Blank_Line 
#   echo "**** Database Backups OS Space: Per DB  du -sh ****"     >> $LOG_FILE 
#   du -sh $PG_DUMP_DIR/*    >> $LOG_FILE
   Print_Blank_Line 

    
   Print_Blank_Line   
   echo "**** PG_CONFIG ****"               >> $LOG_FILE
# ****  FUNKY UNTIL Dayne gets pg_config on Grallace/Wallace
   if [ $HOST != $HOST_PROD  ]; then
      pg_config                             >> $LOG_FILE  
   fi
   
Print_Blank_Line 
echo "***** Disk Space for every object in Database *****"
#/usr/bin/du -h $PG_DUMP_DIR/* 
# /usr/bin/du [0-9]* |
# > while read SIZE FILENODE 
# > do df 
# > echo "$SIZE   `/usr/bin/oid2name -q -d $GINA_dba -i -f $FILENODE`" 
# > done
       Print_Blank_Line
    

   Print_Blank_Line
   Print_Blank_Line
   echo "============================ DATABASE INFORMATION ============================" >> $LOG_FILE
   Print_Blank_Line         
   Print_Blank_Line  
   echo "**** PG DB_LIST ****"      >> $LOG_FILE 
   # OK i do this twice...once for the pretty print to the log, 2nd time is for the array
   psql -d $POSTGRES_DEFAULT -U $POSTGRES -At -c "SELECT datname FROM pg_database WHERE datallowconn order by datname"  >> $LOG_FILE     
   Check_PGSQL_Status
   DB_LIST=`psql -d $POSTGRES_DEFAULT -U $POSTGRES -At -c "SELECT datname FROM pg_database WHERE datallowconn order by datname"`  >> $LOG_FILE     
   Check_PGSQL_Status
   Print_Blank_Line   
   for POSTGRES_SID in $DB_LIST ; do
   
       export POSTGRES_SID

       Print_Blank_Line  
       Print_Blank_Line   
       echo "************************************* "   >> $LOG_FILE 
       echo "=====> DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
       echo "************************************* "   >> $LOG_FILE 
       Print_Blank_Line  
       Print_Blank_Line   
         
        echo "***** Verifying BUP DIR Exists... "         >> $LOG_FILE
#       Verify_Backup_Directory_Exists
        echo "PB_DUMP_DIR = " $PG_DUMP_DIR $POSTGRES_SID >> $LOG_FILE
        if [ ! -d $PG_DUMP_DIR ]; then
           Print_Blank_Line 
           echo "***** ERROR: Missing DB BUP DIR: "  $POSTGRES_SID   >> $LOG_FILE
           Print_Blank_Line
           SUBJECT="** ERROR: DB BUP DIR : "$0"_"$HOST"_"$LOGDATE
           echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
           if [ "$status" == " " ]; then	
              echo " "                                                            >> $LOG_FILE  
              echo "** ERROR: DBA Email Bombing from DBA@" $HOST                  >> $LOG_FILE
              echo " "                                                            >> $LOG_FILE
           fi  
           exit 1 ;
         else
	     Print_Blank_Line 
             echo "***** BUP DIR Exists... "         >> $LOG_FILE
             Print_Blank_Line 
	 fi

       Print_Blank_Line 
       echo "***** oid2name -d -x *****"    >> $LOG_FILE
       oid2name -d $POSTGRES_SID -x         >> $LOG_FILE
              
       Print_Blank_Line    
       echo "***** Database size: pg_database_size *****"     >> $LOG_FILE 
       psql -d $POSTGRES_SID -U $POSTGRES -a -c "select pg_size_pretty(pg_database_size('$POSTGRES_SID'))" >> $LOG_FILE
       Check_PGSQL_Status
 
       Print_Blank_Line 
       echo "***** Schema Names: \dn+ *****"                       >> $LOG_FILE 
       psql -d $POSTGRES_SID -U $POSTGRES -a -c "\dn+"            >> $LOG_FILE
       SCHEMA_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -At -c "select distinct schemaname from pg_tables"` >> $LOG_FILE
       Check_PGSQL_Status
       for SCHEMA_NAME in $SCHEMA_LIST; do
           Print_Blank_Line   
           echo "**** Table Names: pg_tables ****"                  >> $LOG_FILE 
           psql -d $POSTGRES_SID -U $POSTGRES -a -c "select * from pg_tables where schemaname='$SCHEMA_NAME' order by tablename " >> $LOG_FILE
           Check_PGSQL_Status
           echo "***** oid2name -d SID -t -f nnnn -x  *****"    >> $LOG_FILE
           psql -d $POSTGRES_SID -U $POSTGRES -a -c "\d"       >> $LOG_FILE
           psql -d $POSTGRES_SID -U $POSTGRES -a -c "\dp"      >> $LOG_FILE     
       done 
   done
 
 
#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------

SUBJECT=$0"_"$HOST"_"$LOGDATE
echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
if [ "$status" == " " ]; then	
   Print_Blank_Line  
   echo "** ERROR: DBA Email Bombing from DBA@" $HOST  >> $LOG_FILE
   Print_Blank_Line  
fi

Print_Footer

exit



