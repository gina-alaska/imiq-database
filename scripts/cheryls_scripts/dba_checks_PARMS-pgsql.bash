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
#  6/26/2006   C. Haase    Initial version v0  
#  12/4/2007   C. Haase    1) Added BEEF (UC !!!) and equated that to gromit
#                             while we are in transition.
#   7/8/08     C. Haase    1) Added grep of PostgreSQL log files
#                          2) Cleaned up comments after 2 years.
#  7/11/08     C. Haase    1) More cleaning up
#                          2) Added more checks:
#   8/4/08     C. Haase    1) Modified/improved the way I get the postgres server processes
#                          2) Added Active Rows for Each Active Server Process
#                          3) Added loop within DB_LIST for each db to:
#                             - List db roles
#                             - Improved tablespace listing
#   8/5/08     C. Haase    1) Added more Check_PGSQL_Status now that other stuff listed 
#                             above was added and works.
#                          2) Cleaned up messages for OOPSIE's
#                          3) Added db vs. backup dir name check since stuff goes POOF
#   9/12/08    C. Haase    Added Voodoo
#                          1) Had to change the "default" database I was using from GINA
#                             to POSTGRES.  For some silly reason I assumed that every installation
#                             would have a gina database.  DUH.
#   4/16/09    C. Haase    1) Added MOJO and VOODOO
#                          2) Updated env vars to accommodate MOJO and VOODOO
#
#                               TO_DEV_DBA="chaase@seaside.gina.alaska.edu"
#                               TO_TEST_DBA="dba@beef.gina.alaska.edu"
#                               TO_PROD_DBA="dba@wallace.gina.alaska.edu"
#                               TO_DEVTEST_DBA="dba@mojo.gina.alaska.edu"
#                               TO_TESTPROD_DBA="dba@voodoo.gina.alaska.edu"
#
#                               HOST_DEV="seaside"
#                               HOST_VOGON="vogon"
#                               HOST_DEVTEST="mojo"
#                               HOST_TESTPROD="voodoo"
#                               HOST_TEST="gromit"
#                               HOST_PROD="wallace"
#
#                           3) Fixed PG_DUMP_DIR for Seaside --> to /san/local etc...
#   5/5/09      C. Haase    1) Uncommented pg_ctl status command and added comments to indicate that if this command is run
#                              in any account other than postgres the "error" message will appear....in this case it is a permissions
#                              error, but the message itself shows that postgres is indeed running.
#                            2) Changed LOG_DIR from 
#                                         export DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups
#                                    to
#                                         export LOG_DIR=$HOME/tools/backup_scripts/POSTGRES
#
#    7/13/2010  C. Haase     1) Commented out the call to Do_ORACLE_Checks...since
#                               none of gina boxes run Oracle anymore
#
#
#
# size of the biggest tables in the database 
#    select nspname || '.' || relname as "relation", 
#    pg_size_pretty(pg_relation_size(nspname || '.' || relname)) as "size" 
#    from pg_class C
#    left join pg_namespace N on (N.oid = C.relnamespace)
#    where nspname NOT in ('pg_catalog', 'information_schema')
#    and nspname !~ '^pg_toast'
#    and pg_relation_size(nspname || '.' || relname) > 0
#    order by pg_relation_size(nspname || '.' || relname) desc
#    limit 20;
# for one table: select pg_relation_size('blah');
#                select pg_size_pretty(pg_relation_size('blah'));
# DONE: size of a complete database: select pg_size_pretty(pg_database_size('blah'));
# size of a tablespace: select spcname, pg_size_pretty(pg_tablespace_size(spcname))
#                       from pg_tablespace
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

Print_Header


# Environmental variables
export MAIL_TO='cheryl@gina.alaska.edu'


export POSTGRES_DEFAULT=$GINA_DBA
export LOG_DIR=$HOME/tools/backup_scripts/POSTGRES

#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------

# only reset these if on Seaside		
export DATA_DIR=$PGDATA
export EXPORT_DIR=$DB_EXPORT


export FROM_OWNER="postgres"

# set defaults to n then toggle back to y on host basis
#export DO_ORACLE_CHECKS=$NO
export DO_PGSQL_CHECKS=$NO

export OOPSIE_ORACLE=$NO
export OOPSIE_PGSQL=$NO
export OOPSIE_SPACE=$NO

export DO_PGSQL_CHECKS=$YES


#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------
#

Print_Header

# if seaside do this otherwise dirs are the same
if [ $HOST == $HOST_DEV  ]; then

   #######################################################################
   # THIS SECTION DOES THE DISK SPACE STUFF .....................
   #######################################################################
   status=`df -h |awk '/ilesystem/ {next}
   {
        if ( $6 == "/" ) {
                cap = $5
                len = length(cap)
                cap = substr(cap,1,len-1)
                if( cap > 90 ){
                        print $6 " overlimit  : " cap "%"            >> $LOG_FILE 
                }
        }

   }
   END { }'` 
   if [ -n "$status" ];
   then
 	  export OOPSIE_SPACE=$YES
          Print_Blank_Line  
	  echo "** WARNING: " $status                >> $LOG_FILE
          Print_Blank_Line  
   fi

   
   status=`df -h |awk '/ilesystem/ {next}
   {	
	if ( $6 == "/ora" ) {
                cap = $5
                len = length(cap)
                cap = substr(cap,1,len-1)
                if( cap > 95 ){
                        print $6 " overlimit  : " cap "%"          >> $LOG_FILE    
                }
        }
   }
   END { }'`  
   
   # something BAD has happened.....
   if [ -n "$status" ];
   then
 	  export OOPSIE_SPACE=$YES
          Print_Blank_Line  
	  echo "** WARNING: " $status                             >> $LOG_FILE
          Print_Blank_Line  
   fi

   #######################################################################
   # THIS SECTION DOES THE POSTGRES STUFF .....................
   #######################################################################
   Do_PGSQL_Checks


else

   # test & prod

   status=`df -h |awk '/ilesystem/ {next}
   {
        if ( $6 == "/" ) {
		dir = $6
                cap = $5
                len = length(cap)
                cap = substr(cap,1,len-1)
                if( cap > 90 ){
			print $6 " overlimit  : " cap "%"       
                }
        }
    }
   END { }'` 
   if [ -n "$status" ];
   then
 	  export OOPSIE_SPACE=$YES
          Print_Blank_Line  
	  echo "** WARNING: " $status           >> $LOG_FILE
	  Print_Blank_Line  
   fi

   status=`df -h |awk '/ilesystem/ {next}
   {	
	if ( $5 == "/san/local" ) {
                cap = $4
                len = length(cap)
                cap = substr(cap,1,len-1)
                if( cap > 90){
                        print $5 " overlimit  : " cap "%"  >> $LOG_FILE
                }
        }
   }
   END { }'` 
   if [ -n "$status" ];
   then
 	  export OOPSIE_SPACE=$YES
	  Print_Blank_Line  
	  echo "** WARNING: " $status              >> $LOG_FILE
	  Print_Blank_Line  
   fi

   


   #######################################################################
   # THIS SECTION DOES THE POSTGRES STUFF .....................
   #######################################################################
  Do_PGSQL_Checks

   
fi # which HOST ?


Print_Star_Line
if [ $OOPSIE_SPACE == $NO ]; then	
   Print_Blank_Line   
   echo "** SUCCESS: Space seems to be OK          **"  >> $LOG_FILE
   Print_Blank_Line
else
   Print_Blank_Line
   echo "** WARNING: Space is a problem !!         **"  >> $LOG_FILE
   Print_Blank_Line
fi
if [ $OOPSIE_PGSQL == $NO ]; then	
   Print_Blank_Line
   echo "** SUCCESS: Postgres appears to be running **"  >> $LOG_FILE
   Print_Blank_Line
fi


Print_Blank_Line                             
echo "**** df -h ****"                               >> $LOG_FILE 
$DF_H                                               >> $LOG_FILE 
Print_Star_Blank_Line


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



