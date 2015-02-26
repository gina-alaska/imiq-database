#! /bin/bash -x
# *************************************************************************************
#
# File Name:  ~dba/tools/pg_dump_PARMS_SCHEMAS-pgsql.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~/pgsql/tools/pg_dump_PARMS_SCHEMAS-pgsql.bash
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
#   wallace  gina:       afs_basedata
# 			afs_firepoints 
# 			alaska_mapped
# 			afs_raws 
# 			gdmp
# 			landsat_coverage
# 			public
# 			sv_linework
# 			sv_main
# 			
# 
#            gina_dba: afs_basedata, afs_firepoints, afs_raws, gdmp        g,w
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
#  6/26/2006   C. Haase    Initial version v0    
#  7/12/2006   C. Haase    For some reason the actual pg_dump command was 
#                          edited out; also, added the copy of the dump files
#                          to the shared database backup area for recovery purposes.
#  8/1/06      C. Haase    Added env var $DB_BUPS_PGSQL_SHARED so the cron would understand it.
#  8/2/06      C. Haase    Changed options so that the database is NOT created; done
#                          to allow porting to whatever db w/o having to edit out
#                          the db connect statement. Schemas and tables (and PUBLIC)
#                          are still all dropped and recreated w/ original owners !
#  9/8/06      C. Haase    Cloned from pg_dump_PARMS.bash
#  9/11/06     C. Haase    Added more dbs/schemas to gromit
#  9/15/06     C. Haase    Fixed the schema list for seaside gina_dba
#  9/18/06     C. Haase    Fixed the schema list for gromit gina_dev; 
#                          Added gzips to conserve space even though they really slow this down!
#  9/21/06     C. Haase    Added seaside db AKSWMAP for State Wide Mapping of Alaska
# 10/1/06      C. Haase    1) Added gina_banner schema to seaside/gromit db gina_dba; 
#                          2) I copied the data from a seaside/ugres db for reference.
# 10/2/06      C. Haase    Gromit only: Added swmap_dev, swmap_test, swmap_prod to the list
# 10/3/06      C. Haase    1) Added to db gina_dba schemas swmap_dev, swmap_test, swmap_prod
#                             from db's of same name.
#                          2) Added schema contact to list in g:gina_dba
# 10/6/06      C. Haase    1) Fixed a few minor problems with the echo to LOG_FILE which bombs
#                             during a cron
#                          2) Fixed the cp of the local dump file to the shared san
#                          3) Fixed a few db names on gromit
#                          4) Added failover copy to NORTHPOLE for BUPS if the copy to the 
#                             SAN fails from either Wallace/Gromit.  
#                             -- At this point, the mount from Wallace to the SAN craps 
#                               out intermittently due to temp spikes while the mount to Gromit
#                               seems to be fairly reliable and/or recovers quickly and well.
#                               Otherwise, BUP files won't routinely go to NORTHPOLE unless it
#                               the BUPS belong to NP databases.
#                          5) Removed duplicate g:swmap_test
# 10/18/06     C. Haase    1) Added schema akepic_prod to s:akepic
#                          2) Added db akepic to gromit
# 11/21/06     C. Haase    Added stuff for Seaside now that it is Pgsql 8.1.4
# 12/20/06     C. Haase    1) Added nssi, nssi_dba, nssi_dev, postgres, swmap_dev, template1 to Seaside
#                          2) Updated scheme list for S: gina_dba 
#                          3) Version from "8.1.3" to "813" and "814" ....argh
# 1/9/07       C. Haase    1) Added schema GINA_METADATA to Gromit/Wallace schemas....seems that I forgot
#                             to add this in mid-December when I ported the scripts.
# 1/12/07      C. Haase    Added mms to Wallace
# 1/17/07      C. Haase    Added swmap_prod to Seaside and Wallace
# 1/19/07      C. Haase    Added swmap_dba to S, W, G (not physically on W yet..)
# 1/29/07      C. Haase    Added sv_ion to W
# 1/30/07      C. Haase    Added gina to S
# 3/14/07      C. Haase    Added schema AFS_RAWS to gina and gina_dba dbs on S/G/W
# 4/6/07       C. Haase    Added database g:gina_arctest (AGC and TOOLIK, SV)
# 4/11/07      C. Haase    Added database w:gina_arctest (AGC and TOOLIK, SV)
# 5/4/07       C. Haase    Added database s:aerometric (AERO_SV, AERO_USER, KENGLE)
# 5/8/07       C. Haase    1) Copied this from PARM_SCHEMAS for W/G crashes....dumps were bombing
#                             when I tried to reload them (W:GINA to G:GINA). Trying to figure out
#                             the source of the bad mojo and why they are jumping the shark.....
#                             I added the check to a bunch of db's on all hosts.
#                          2) Added NSSI to Wallace
#                             - This is a copy of the db that WAS on Gromit until it got toasted
#                               and I never thought to add it to the Wallace backups.....silly me.
#  5/11/07     C. Haase    1) Added aero_dev, test, prod to S, W, G
#  5/21/07     C. Haase    1) Added aerometric_dba db to S, G, W
#  7/2/07      C. Haase    Zapped afs_raws from BUPS..
#  7/3/07      C. Haase    Added gina_dba to Wallace (may comment this out later..)
# 10/5/07      C. Haase    ====> Seaside only so far !!
#                          1) Added gina_metadata to Seaside (may comment this out later)
#                          2a) Added schemas to nssi_dba
#                             o gina_dba, gina_metadata_geonetwork, nssi_dba
#                          2b) Zapped public schema from nssi_dba
# 10/8/07      C. Haase    1) Added a few schemas to S:gina_dba
#                          2) Added schema nssi_demo to S:nssi_dba
# 10/12/07     C. Haase    1) Added BEEF (UC !!!) and equated that to gromit
#                             while we are in transition.
# 12/3/07      C. Haase    1) Added some schemas to NSSI_DEV db.
#                          2) Added some schemas to NSSI_DBA db.
# 12/17/07     C. Haase    1) Added NSSI_DEV_DBA to Seaside ONLY !!
#  1/10/08     C. Haase    1) Added NSSI_DEV_DBA to BEEF
#                          2) Added NSSI_PROD to Seaside, BEEF, Wallace
# 3/10/08      C. Haase    1) Added GINAWEB_DEV, GINAWEB_TEST, GINAWEB_PROD to Seaside, Beef
#                             and Wallace (done for Jason)
# 3/27/08      C. Haase    1) Added MMS to Seaside.
# 5/5/08       C. Haase    Added SIZONET_DEV, SIZONET_TEST, SIZONET_PROD
# 6/26/08      C. Haase    Commented out the copy to the /san/dds since they died last
#                          night for the umpteenth time.  
# 7/2/08       C. Haase    Added a GZIP status for the gzipping of the db dumps.
#                          - if the file ain't there for ANY reason this will tell me.
# 7/8/08       C. Haase    Added Grallace
# 7/14/08      C. Haase    Added scp stuff.  Here are the current rules:
#                          1) From Seaside to Beef/Gromit: all of mine
#                          2) From Beef/Gromit: 
#                          3) From Grallace/Wallace: all go to Beef/Gromit
# 7/30/08      C. Haase    1) Added database CAVM to S/G/W....
#                 =======> NOTE: This is the old ION db from Vogon....the first one that we
#                          ever did. I only took the CAVM tables and not the SV tables since
#                          they are way old and out of date in terms of structure and data.
#                          Also, Jason did not need them for this round of CAVM dev (phase 2)
# 7/31/08      C. Haase    1) Cleaned up messages for $0
#                          2) Added POSTGRES_VERSION
#                          3) Fixed the Check_PGSQL_Status function
# 8/4/08       C. Haase    1) Added AQUADP to Seaside..was there before???
#                          2) Added scp of AQUADP from Beef to Seaside....testing mostly
# 9/9/08       C. Haase    1) Added Voodoo
# 10/3/08      C. Haase    Added amis_aoos schema to nssi_dba
# 10/24/08     C. Haase    1) Added db sdetest which is an sde test db for chloe
#                          2) Added schemas to gina_sdetest: jgrimes, phickman, agc, iab
# 10/27/08     C. Haase    1) Added gozer_dev to Gromit (HOST_TEST)
# 11/13/08     C. Haase    1) Removed schemas from Voodoo (HOST_DEVTEST) GINA_SDETEST
#                             - agc_arcticgeobotatlas, toolik_arcticgeobotatlas
#                          2) Added schemas to schemas from Voodoo (HOST_DEVTEST) GINA_SDETEST
#                             - agc, chaase, gina_sdetest, jgrimes, phickman, toolik
#  1/6/09       C. Haase   Added to Gromit/Beef
#                           1) oic_dev (for Will)
#                           2) sdmi-cms_prod (for Dayne)
#  1/15/09      C. Haase   Fixed LOG_DIR etc for seaside and SEASIDE_FULL....this stuff changed when seaside got rebuilt.
#  1/21/09      C. Haase   1) Added gozer_dev, gozer to Seaside and Wallace
#                          2) Added gozer_prod to Gromit
#                          3) Added agc_dev, agc_test, agc_prod for Voodoo ONLY !!!!!!!!!!!!!!!
#  1/31/09      C. Haase   Added new schema ARLLS_ARMAP to nssi_dba 
#  2/27/09      C. Haase   Added MOJO and VOODOO
#                          - new dbs agc_dev, agc_test, agc_prod, agc_dba
#  3/3/09       C. Haase   Tweaked the SCP section at the end for Mojo/Voodoo.  Changed settings to
#                          1) DB_BUPS_PGSQL_SEASDIDE=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
#                             -- Was DB_BUPS_PGSQL_NORTHPOLE
#                          2) DB_BUPS_PGSQL_VOODOO=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
#                          3) Copying DB Dumps FROM Voodoo TO Mojo, Seaside and Wallace
#                          4) Copying DB Dumps FROM Mojo to Voodoo, Seaside and Wallace
#                             -- NOT Gromit/Beef due to frequent sa barfs and lack of space.
#   3/9/09      C. Haase   1) Tweaked some of the scp stuff at the end.
#                           - Added scp's from Seaside to Wallace and not just Gromit.  Wallace has tons of space
#                             and Gromit seems to suffer random foobar's of disks and space.
#                           2) Current SCP env vars:
#                               TO_DEV_DBA="chaase@seaside.gina.alaska.edu"
#                               TO_TEST_DBA="dba@beef.gina.alaska.edu"
#                               TO_PROD_DBA="dba@wallace.gina.alaska.edu"
#                               TO_DEVTEST_DBA="dba@mojo.gina.alaska.edu"
#                               TO_TESTPROD_DBA="dba@voodoo.gina.alaska.edu"a
#   4/2/09      C. Haase    1) Added "nssi_test" to gromit 
#   4/16/09     C. Haase    1) Added "shorezone" to gromit and seaside (BUP)...and wallace in case the world ends and somebody
#                              stills gives a crap about this db.
#   4/21/09     C. Haase    1) Added "aedi_dev", "aedi_test", "aedi_prod"
#   6/23/09     C. Haase    1) Added "redmine"
#   7/15/09     C. Haase    1) Added "nssi_dev_dba"
#                           2) Update schemas for "gina_dba"
#                           3) Added "nssi_dev_dba"
#                           4) Added "nssi_prod_dba"
#    7/17/09    C. Haase    1) Added "aquabase"
#    7/28/09    C. Haase    1) Added "gina_dba" to all machines....for the pg_config thing.
#    8/21/09    C. Haase    1) Added "geonames_dev"
#                           2) Added "geonames_prod"
#    9/10/09    C. Haase    1) Added "drmap_dev"
#                           2) Added "drmap_prod"
#                           3) Added "drmap_test"
#    9/25/09    C. Haase    For Jason (web site part) and Dayne (cms part) ...this is for Hajo for MMS SeaIce
#                           ===> Put them on Seaside, Gromit and Wallace ONLY
#                           1) Added "mms_seaice_cms_dev"
#                           2) Added "mms_seaice_cms_prod"
#                           3) Added "mms_seaice_cms_test"
#    10/9/09    C. Haase    Added "gina_test" to Wallace
#    10/13/09   C. Haase    1) Added "gina_dev" to Wallace
#                           2) Added chaase as FROM_OWNER on Seaside and various other db's such as GINA_DBA, NSSI_DBA 
#                              on all boxes.
#     11/6/09   C. Haase    Added FLOATINGICE_CMS_DEV, FLOATINGICE_CMS_TEST, and FLOATINGICE_CMS_PROD to Gromit and Wallace (Hajo, Jason)
#     11/10/09  C. Haase    Added sdmi-cms_prod to Wallace etc.
#     12/5/09   C Haase     Added  blmap_dev and blmap_prod (for Will and Dayne...BLM Aerial Mapping)
#
#     
#----------------------------------------------------------------------------------------------------		

# Environmental variables


export THEDATE=`date +%y%m%d_%H:%M`
export THEDATE_YYMMDD=`date +%y%m%d`
export LOGDATE=`date +%Y-%m-%d_%H%M%S`
export OPTION_STRING_FILE="cOn"
export SE_SUCCESS=0
export SE_FAILURE=-1

export MAIL_TO="cheryl@gina.alaska.edu"


###########################################################################
# This will need to be fixed when I get back from vacation. I need this
# to run in cron until then ...........
###########################################################################

# hostname is not evaluated the same on seaside as it is on wallace and gromit...
export SEASIDE_FULL="seaside.gina.alaska.edu"
export GROMIT_FULL="gromit.gina.alaska.edu"
export WALLACE_FULL="wallace.gina.alaska.edu"
export BEEF_FULL="BEEF.gina.alaska.edu"
export GRALLACE_FULL="Grallace"
export VOODOO_FULL="voodoo.gina.alaska.edu"
export MOJO_FULL="mojo.gina.alaska.edu"

# used in the scp's at the end
export TO_DEV_DBA="chaase@seaside.gina.alaska.edu"
export TO_TEST_DBA="dba@beef.gina.alaska.edu"
export TO_PROD_DBA="dba@wallace.gina.alaska.edu"
export TO_DEVTEST_DBA="dba@mojo.gina.alaska.edu"
export TO_TESTPROD_DBA="dba@voodoo.gina.alaska.edu"

export LOG_DIR=/home/dba/tools/backup_scripts/POSTGRES
if [ $HOSTNAME == $GROMIT_FULL ]; then
        export HOST="gromit"
elif [ $HOSTNAME == $BEEF_FULL ]; then
        export HOST="gromit"
elif [ $HOSTNAME == $WALLACE_FULL ]; then
	export HOST="wallace"
elif [ $HOSTNAME == $GRALLACE_FULL ]; then
	export HOST="wallace"
elif [ $HOSTNAME == $MOJO_FULL ]; then
        export HOST="mojo"
elif [ $HOSTNAME == $VOODOO_FULL ]; then
        export HOST="voodoo"
elif [ $HOSTNAME == $SEASIDE_FULL ]; then
	export HOST="seaside"
	export LOG_DIR=/home/chaase/tools/backup_scripts/POSTGRES
#	export POSTGRES_VERSION="814"
# vogon which really isn't used much anymore, but just to be certain...
else
	export HOST=$HOSTNAME
	export POSTGRES_VERSION="803"
fi

export  HOST_DEV="seaside"
export  HOST_VOGON="vogon"
export  HOST_DEVTEST="mojo"
export  HOST_TESTPROD="voodoo"
export  HOST_TEST="gromit"
export  HOST_PROD="wallace"

if [ "$#" -eq 0 ]; then
	echo "Usage: $0 file 1=PostgresSID"
	exit 1
else
	export POSTGRES_SID=$1
fi

	

#------------------------------------------------------------------------
# ******************* FUNCTION DEFINITIONS   *********************
#------------------------------------------------------------------------
	

Print_Header()
{

echo " "							                 > $LOG_FILE	      	
echo "*** log BEGIN ***"   `date '+%m/%d/%y %A %X'`                       >> $LOG_FILE  	
echo "----------------------------------------------------------------"   >> $LOG_FILE 	
echo "Script      : "$0                                                   >> $LOG_FILE
echo "Database    : "$POSTGRES_SID                                        >> $LOG_FILE
echo "Server      : "`uname -n`                                           >> $LOG_FILE
echo "----------------------------------------------------------------"   >> $LOG_FILE	
Print_Blank_Line     

}

Print_Footer()
{

    echo " "								   >> $LOG_FILE
    echo "*** log END  ***"  `date '+%m/%d/%y %A %X'`                         >> $LOG_FILE
    echo "----------------------------------------------------------------"   >> $LOG_FILE
    echo "Script      : "$0                                                   >> $LOG_FILE
    echo "Database    : "$POSTGRES_SID                                        >> $LOG_FILE
    echo "Server      : "`uname -n`                                           >> $LOG_FILE
    echo "----------------------------------------------------------------"   >> $LOG_FILE
    echo " "								   >> $LOG_FILE

}

Print_Blank_Line()
{
   echo " " >> $LOG_FILE
}

Print_Dash_Line()
{
    echo "----------------------------------------------------------------"   >> $LOG_FILE
}

Print_Star_Line()
{
   echo "**********************************************************************" >> $LOG_FILE  
}


Check_GZIP_Status()
{	
Print_Blank_Line 	
echo "** GZIPing of DB Dump for Database: "  $POSTGRES_SID   >> $LOG_FILE	
Print_Blank_Line 
GZIP_STATUS=$?
if [ $GZIP_STATUS -ne $SE_SUCCESS ]; then
   echo "** ERROR: GZIP to /san/local FAILED for Database: "  $POSTGRES_SID   >> $LOG_FILE   
   SUBJECT="**ERROR GZIP:" $0"_"$HOST"_"$LOGDATE
   echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
   if [ "$status" == " " ]; then	
       echo " "                                                            >> $LOG_FILE  
       echo "** ERROR: DBA Email Bombing from DBA@" $HOST                  >> $LOG_FILE
       echo " "                                                            >> $LOG_FILE
    fi  
   exit 1 ;
else   
     echo "** Successful GZIPing of DB Dump file: "   $POSTGRES_SID  " Owner: " $FROM_OWNER >> $LOG_FILE
fi
Print_Blank_Line
}

Check_PGSQL_Status()
{
Print_Blank_Line 
PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
   Print_Blank_Line  
   echo "** ERROR: PGSQL DIED ==> "  $PGSQL_STATUS " db/schema: " $POSTGRES_SID $SCHEMA_NAME >> $LOG_FILE  
   Print_Blank_Line    
   SUBJECT="**ERROR: PGSQL DIED: " $0"_"$HOST"_"$LOGDATE
   echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
   if [ "$status" == " " ]; then	
      echo " "                                                  >> $LOG_FILE  
      echo "** ERROR: DBA Email Bombing from DBA@" $HOST        >> $LOG_FILE
      echo " "                                                  >> $LOG_FILE
    fi
   exit 1 ;
fi 
Print_Blank_Line
}

Check_PG_DUMP_Status()
{
$PG_DUMP -d $POSTGRES_SID -U $FROM_OWNER -c -O -n $SCHEMA_NAME > $PG_DUMP_DIR/$POSTGRES_SID.$SCHEMA_NAME.ALL.$HOST.$FROM_OWNER.$OPTION_STRING_FILE-$POSTGRES_VERSION.$LOGDATE.pg_dump
PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
   echo "** ERROR: PG DUMP Died for Database: "  $POSTGRES_SID " Schema: " $SCHEMA_NAME  >> $LOG_FILE
   Print_Blank_Line    
   SUBJECT="**ERROR PG DUMP: " $0"_"$HOST"_"$LOGDATE
   echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
   if [ "$status" == " " ]; then	
      echo " "                                                          >> $LOG_FILE  
      echo "** ERROR: DBA Email Bombing from DBA@" $HOST                 >> $LOG_FILE
      echo " "                                                           >> $LOG_FILE
    fi
   exit 1 ;
else   
       echo "** Successful Dumping of DB: " $POSTGRES_SID  " Schema: " $SCHEMA_NAME " To: " $PG_DUMP_DIR >> $LOG_FILE  
fi
Print_Blank_Line 
}
	                          
Check_SCP_Status()
{
Print_Blank_Line 	
SCP_STATUS=$?
if [ $SCP_STATUS -ne $SE_SUCCESS ]; then
   echo "** ERROR: SCP Died for Database: "  $POSTGRES_SID " Schema: " $SCHEMA_NAME  >> $LOG_FILE   
   SUBJECT="**ERROR SCP: " $0"_"$HOST"_"$LOGDATE
   echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
   if [ "$status" == " " ]; then	
       echo " "                                                            >> $LOG_FILE  
       echo "** ERROR: DBA Email Bombing from DBA@" $HOST                  >> $LOG_FILE
       echo " "                                                            >> $LOG_FILE
    fi  
   exit 1 ;
else   
    echo "** Successful SCP of : " *$LOGDATE*  " To: " $TO_HOST:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID >> $LOG_FILE    
fi
Print_Blank_Line       
}

#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------

# same for all boxes....
export LOG_FILE=$LOG_DIR/pg_dump_PARMS_SCHEMAS.$HOST.$LOGDATE.log

# only reset if on Seaside
export DATA_DIR=$PGDATA
export EXPORT_DIR=$DB_EXPORT

#
export POSTGRES="postgres"
export CHAASE="chaase"
export DBA="dba"
export GINA="gina"


# export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
export DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups
export DB_BUPS_PGSQL_SHARED=/san/dds/projects/database/shared/pgsqldata/database_backups
export FROM_OWNER="postgres"
export PG_DUMP=/usr/bin/pg_dump
export PG_DUMPALL=/usr/bin/pg_dumpall
export PSQL=/usr/bin/psql
export PG_DUMP_DIR=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID		
export PG_LOG_DIR=$PGDATA

Print_Header

                                                   
#echo '\a \\select version();' | psql -d gina          
#POSTGRES_VERSION=`psql -d gina_dba -U postgres -At -c "select version();"`	            >> $LOG_FILE   
#Check_PGSQL_Status
#Print_Blank_Line                                                                              >> $LOG_FILE
#echo "**** Postgres VERSION: "  $POSTGRES_VERSION  >> $LOG_FILE   
#Print_Blank_Line    

#Print_Blank_Line  
#echo '\a \\select version();' | psql -d gina          
#POSTGRES_VERSION=`psql -d gina -U postgres -At -c "select version();"`  >> $LOG_FILE   
Check_PGSQL_Status
 

case "$HOST" in
      $HOST_DEV) 
      
      		export GINA_DIR=$HOME/DEV/POSTGRES/seaside
                export EXPORT_DIR=/pgsql/export/seaside
		export INGEST_DIR=/pgsql/ingest/seaside
		export DATA_DIR=$INGEST_DIR/ion/CAVM
		export SOURCE_DIR=$GINA_DIR/scripts
 		
		export PG_DUMP=/usr/bin/pg_dump
		export PG_DUMPALL=/usr/bin/pg_dumpall
		export PSQL=/usr/bin/psql
		
		export DATA_DIR=$PGDATA
		export PG_LOG_DIR=$PGDATA/pg_log

                 export LOG_DIR=/home/chaase/tools/backup_scripts/POSTGRES

                 export PG_DUMP_DIR=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID

		export EXPORT_DIR=$GINA_DIR/export
		export SOURCE_DIR=$GINA_DIR/scripts

		export FROM_OWNER=$CHAASE
                
		export TO_HOST=$TO_TEST_DBA
	

	case "$POSTGRES_SID" in
		aerometric)
                           for SCHEMA_NAME in aero_dev aero_test aero_prod gina_dba sv_linework sv_main ; do
                               Check_PG_DUMP_Status			      
			     done
	        ;;
		aerometric_dba)
                           for SCHEMA_NAME in aero_dev aero_test aero_prod gina_dba sv_linework sv_main ; do
                               Check_PG_DUMP_Status			      
			     done
	        ;;
		akswmap) 
			    for SCHEMA_NAME in akswmap_dev akswmap_test akswmap_prod  ; do
                               Check_PG_DUMP_Status			      
			     done
		;;									
		akepic) 
			    for SCHEMA_NAME in akepic_orig akepic_dev akepic_prod akepic_test ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		aquadp) 
			for SCHEMA_NAME in  aquadp_dev aquadp_prod aquadp_test public; do
                             Check_PG_DUMP_Status			      
			done
		;;
                	aquabase) 
			for SCHEMA_NAME in  aquabase public; do
                             Check_PG_DUMP_Status			      
			done
		;;
		cavm) 
			 for SCHEMA_NAME in cavm public ; do
                               Check_PG_DUMP_Status			      
			  done
		;;
		 blmap__dev)
	                      for SCHEMA_NAME in blmap_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                blmap_prod)
	                      for SCHEMA_NAME in blmap_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                drmap_dev)
	                      for SCHEMA_NAME in drmap_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                drmap_prod)
	                      for SCHEMA_NAME in drmap_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 drmap_test)
	                      for SCHEMA_NAME in drmap_test public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                	geonames_dev)
	                      for SCHEMA_NAME in geonames_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 geonames_prod)
	                      for SCHEMA_NAME in geonames_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		gina)
                            for SCHEMA_NAME in afs_basedata afs_firepoints  alaska_mapped gdmp gina_metadata landsat_coverage sv_linework sv_main ; do
                               Check_PG_DUMP_Status			      
			     done
	        ;;
		gina_arctest)
                            for SCHEMA_NAME in afs_basedata afs_firepoints  agc_arcticgeobotatlas alaska_mapped gdmp gina_metadata landsat_coverage toolik_arcticgeobotatlas sv_linework sv_main ; do
                               Check_PG_DUMP_Status			      
			     done
	        ;;				
		gina_dba)
                            for SCHEMA_NAME in afs_basedata afs_firepoints cesadil contact file gdmp gina_banner gina_dba gina_defaults gina_gazetteer gina_metadata gina_metadata_geonetwork landsat_coverage nssi nssi_dba nssi_demo nssi_dev nssi_prod nssi_test portal project public sv_linework sv_main swmap_dba swmap_dev swmap_dba swmap_prod swmap_test; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		gina_metadata)
	                      for SCHEMA_NAME in public ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                	gina_test)
                             for SCHEMA_NAME in alaska_mapped cesadil public ; do	                          
                              Check_PG_DUMP_Status			      
			     done
		;;
		ginaweb_dev)
	                      for SCHEMA_NAME in ginaweb_dev ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		ginaweb_test)
	                      for SCHEMA_NAME in ginaweb_test ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		ginaweb_prod)
	                      for SCHEMA_NAME in ginaweb_prod ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                gozer_dev)
	                      for SCHEMA_NAME in public ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
                 gozer_prod)
	                      for SCHEMA_NAME in public ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
		mms)
                       for SCHEMA_NAME in gina_dba mms_dev mms_prod mms_test; do	                          
                               Check_PG_DUMP_Status			      
			     done
		;;
                mms_seaice_cms_dev)
	                      for SCHEMA_NAME in mms_seaice_cms_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                mms_seaice_cms_prod)
	                      for SCHEMA_NAME in mms_seaice_cms_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                mms_seaice_cms_test)
	                      for SCHEMA_NAME in mms_seaice_cms_test; do
                               Check_PG_DUMP_Status			      
			     done
                ;;
	        nssi)
	                     for SCHEMA_NAME in public  ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
	        nssi_dba)
	                     for SCHEMA_NAME in amis_aoos arlls_armap gina_dba gina_defaults gina_metadata gina_metadata_geonetwork gozer_dev nssi nssi_dba nssi_demo nssi_dev nssi_test nssi_prod  public; do
export FROM_OWNER=$CHAASE
                             Check_PG_DUMP_Status			      
			     done
		;;
		nssi_dev_dba)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_dev public  ; do
 export FROM_OWNER=$CHAASE                            
                                 Check_PG_DUMP_Status
			done
		;;
		nssi_dev)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_dev public  ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		nssi_prod)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_prod public  ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                	nssi_prod_dba)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_prod public  ; do
 export FROM_OWNER=$CHAASE                                                                                      
                               Check_PG_DUMP_Status			      
			     done
		;;
		postgres)
	                     for SCHEMA_NAME in public  ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		shorezone)
	                      for SCHEMA_NAME in shorezone public ; do
                                  Check_PG_DUMP_Status
			     done
 		;;
		sizonet_dev)
	                      for SCHEMA_NAME in sizonet_dev ; do
                                 Check_PG_DUMP_Status 			       
		            done
 		;;
		sizonet_test)
	                      for SCHEMA_NAME in sizonet_test ; do
                                  Check_PG_DUMP_Status
			     done
 		;;
		sizonet_prod)
	                      for SCHEMA_NAME in sizonet_prod ; do
                                  Check_PG_DUMP_Status			       
			      done
 		;;
		swmap_dba)
	                  for SCHEMA_NAME in public  ; do
export FROM_OWNER=$CHAASE
                                 Check_PG_DUMP_Status
                         done 
		;;	
		swmap_dev)
	                     for SCHEMA_NAME in public  ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		swmap_test)
	                     for SCHEMA_NAME in public  ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		swmap_prod)
	                     for SCHEMA_NAME in public  ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		template1)
	                     for SCHEMA_NAME in public  ; do
                               Check_PG_DUMP_Status			      
			     done
		;;
	        *)  echo "What database are you looking for ???" >> $LOG_FILE  ;; 
	        esac	

	  ;;
	  
	$HOST_DEVTEST)  
	
	     export TO_HOST=$TO_TESTPROD_DBA
             export PG_DUMP_DIR=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID

	    case "$POSTGRES_SID" in

               agc_dev)
                       for SCHEMA_NAME in agc chaase jgrimes phickman public sde toolik ; do
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
              agc_dba)
                       for SCHEMA_NAME in agc chaase jgrimes phickman public sde toolik ; do
 export FROM_OWNER=$CHAASE                                                   
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
               agc_test)
                       for SCHEMA_NAME in agc chaase jgrimes phickman public sde toolik ; do
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
                agc_prod)
                       for SCHEMA_NAME in agc chaase jgrimes phickman public sde toolik ; do
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
                aquabase) 
			for SCHEMA_NAME in  aquabase public; do
export FROM_OWNER=$CHAASE
                             Check_PG_DUMP_Status			      
			done
		;;
                	gina_dba)
                         for SCHEMA_NAME in  gina_dba public; do
 export FROM_OWNER=$CHAASE                                                
                               Check_PG_DUMP_Status			      
			 done
		;;           
		gina_sdetest)
#                       for SCHEMA_NAME in agc agc_arcticgeobotatlas chaase gina_sdetest jgrimes phickman public sde toolik toolik_arcticgeobotatlas ; do
                       for SCHEMA_NAME in agc chaase gina_sdetest jgrimes phickman public sde toolik ; do
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
		postgres)
                      for SCHEMA_NAME in public sde ; do	                          
                          Check_PG_DUMP_Status			      
		      done
		;;
		sde)
                      for SCHEMA_NAME in public sde ; do	                          
                          Check_PG_DUMP_Status			      
		      done
		;;
                sdetest)
                      for SCHEMA_NAME in agc_arcticgeobotatlas public sde toolik_arcticgeobotatlas; do	                          
                          Check_PG_DUMP_Status			      
		      done
		;;
		template_postgis )
                       for SCHEMA_NAME in information_schema pg_catalog pg_temp_1 pg_toast pg_toast_temp_1 public; do	                          
                            Check_PG_DUMP_Status			      
			done
  		;;
		template1 )
                        for SCHEMA_NAME in information_schema pg_catalog pg_temp_1 pg_toast pg_toast_temp_1 public; do	                          
                            Check_PG_DUMP_Status
			done
		;;
	        *)  echo "What database are you looking for ???" >> $LOG_FILE  ;; 
	        esac	

	  ;;
          
          $HOST_TESTPROD)  
	
	     export TO_HOST=$TO_DEVTEST_DBA
#	     export PG_DUMP_DIR=/home/dba/database_backups/$POSTGRES_SID
             export PG_DUMP_DIR=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID

	    case "$POSTGRES_SID" in

               agc_dev)
                       for SCHEMA_NAME in agc chaase jgrimes phickman public sde toolik ; do
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
                agc_dba)
                       for SCHEMA_NAME in agc chaase jgrimes phickman public sde toolik ; do
export FROM_OWNER=$CHAASE
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
               agc_test)
                       for SCHEMA_NAME in agc chaase jgrimes phickman public sde toolik ; do
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
                agc_prod)
                       for SCHEMA_NAME in agc chaase jgrimes phickman public sde toolik ; do
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
                aquabase) 
			for SCHEMA_NAME in  aquabase public; do
export FROM_OWNER=$CHAASE
                             Check_PG_DUMP_Status			      
			done
		;;  
		blmap__dev)
	                      for SCHEMA_NAME in blmap_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                blmap_prod)
	                 for SCHEMA_NAME in blmap_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 drmap_dev)
	                for SCHEMA_NAME in drmap_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                drmap_prod)
	                      for SCHEMA_NAME in drmap_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 drmap_test)
	                      for SCHEMA_NAME in drmap_test public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 floatingice_cms_dev)
	                      for SCHEMA_NAME in floatingice_cms_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                floatingice_cms_prod)
	                      for SCHEMA_NAME in floatingice_cms_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 floatingice_cms_test)
	                      for SCHEMA_NAME in floatingice_cms_test public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 geonames_dev)
	                      for SCHEMA_NAME in geonames_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 geonames_prod)
	                      for SCHEMA_NAME in geonames_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                	gina_dba)
                         for SCHEMA_NAME in  gina_dba public; do
export FROM_OWNER=$CHAASE
                               Check_PG_DUMP_Status			      
			 done
		;;  
		gina_sdetest)
#                       for SCHEMA_NAME in agc agc_arcticgeobotatlas chaase gina_sdetest jgrimes phickman public sde toolik toolik_arcticgeobotatlas ; do
                       for SCHEMA_NAME in agc chaase gina_sdetest jgrimes phickman public sde toolik ; do
                       Check_PG_DUMP_Status			      
		       done   
	        ;;
		postgres)
                      for SCHEMA_NAME in public sde ; do	                          
                          Check_PG_DUMP_Status			      
		      done
		;;
		sde)
                      for SCHEMA_NAME in public sde ; do	                          
                          Check_PG_DUMP_Status			      
		      done
		;;
                sdetest)
                      for SCHEMA_NAME in agc_arcticgeobotatlas public sde toolik_arcticgeobotatlas; do	                          
                          Check_PG_DUMP_Status			      
		      done
		;;
		template_postgis )
                       for SCHEMA_NAME in information_schema pg_catalog pg_temp_1 pg_toast pg_toast_temp_1 public; do	                          
                            Check_PG_DUMP_Status			      
			done
  		;;
		template1 )
                        for SCHEMA_NAME in information_schema pg_catalog pg_temp_1 pg_toast pg_toast_temp_1 public; do	                          
                            Check_PG_DUMP_Status
			done
		;;
	        *)  echo "What database are you looking for ???" >> $LOG_FILE  ;; 
	        esac	

	  ;;

	  
#	$HOST_VOGON)  
#		export PG_DUMP_DIR=/usr/local/pgsql/database_backups/$POSTGRES_SID		
#		export FROM_OWNER="postgres"
#		export PG_DUMP=/usr/local/pgsql/bin/pg_dump
#		export PG_DUMPALL=/usr/local/pgsql/bin/pg_dumpall
#		export PSQL=/usr/local/pgsql/bin/psql
#		
#POSTGRES_VERSION=`echo "select version();" | $PSQL -d $POSTGRES_SID -U $FROM_OWNER | grep PostgreSQL | awk '{print $2}'`
#
#		;;
#		
	$HOST_TEST)  
	
	       	export TO_HOST=$TO_PROD_DBA

		case "$POSTGRES_SID" in
		  aerometric)
                           for SCHEMA_NAME in aero_dev aero_test aero_prod gina_dba sv_linework sv_main ; do
export FROM_OWNER=$CHAASE
                               Check_PG_DUMP_Status			      
			     done
	        ;;	
                	aedi_dev)
                          for SCHEMA_NAME in aedi_dev public ; do
                              Check_PG_DUMP_Status			      
			     done
	        ;;	
                aedi_prod)
                          for SCHEMA_NAME in aedi_prod public ; do
                              Check_PG_DUMP_Status			      
			     done
	        ;;
               aedi_test)
                          for SCHEMA_NAME in aedi_test public ; do
                              Check_PG_DUMP_Status			      
			     done
	        ;;				
		aerometric_dba)
                          for SCHEMA_NAME in aero_dev aero_test aero_prod gina_dba sv_linework sv_main ; do
export FROM_OWNER=$CHAASE
                              Check_PG_DUMP_Status			      
			     done
	        ;;		
		akepic) 
			    for SCHEMA_NAME in akepic_dev akepic_test akepic_orig akepic_prod ; do
export FROM_OWNER=$CHAASE
                              Check_PG_DUMP_Status			      
			     done
		;;		
		akswmap) 
			    for SCHEMA_NAME in akswmap_dev akswmap_test akswmap_prod ; do
                              Check_PG_DUMP_Status			      
			     done
		;;
		aquadp) 
                         for SCHEMA_NAME in aquadp_dev aquadp_prod aquadp_test public; do
export FROM_OWNER=$CHAASE
                              Check_PG_DUMP_Status			      
			     done
		;;
	        blmap__dev)
	                      for SCHEMA_NAME in blmap_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                blmap_prod)
	                 for SCHEMA_NAME in blmap_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		cavm) 
		      for SCHEMA_NAME in cavm public ; do
                          Check_PG_DUMP_Status			      
		      done
		;;
                 drmap_dev)
	                      for SCHEMA_NAME in drmap_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                drmap_prod)
	                      for SCHEMA_NAME in drmap_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 drmap_test)
	                      for SCHEMA_NAME in drmap_test public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                               floatingice_cms_dev)
	                      for SCHEMA_NAME in floatingice_cms_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                floatingice_cms_prod)
	                      for SCHEMA_NAME in floatingice_cms_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 floatingice_cms_test)
	                      for SCHEMA_NAME in floatingice_cms_test public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 geonames_dev)
	                      for SCHEMA_NAME in geonames_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 geonames_prod)
	                      for SCHEMA_NAME in geonames_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		gina)
                             for SCHEMA_NAME in pulic afs_basedata afs_firepoints alaska_mapped gdmp gina_metadata landsat_coverage sv_linework sv_main ; do
                              Check_PG_DUMP_Status			      
			     done
	        ;;
		gina_arctest)
                             for SCHEMA_NAME in afs_basedata afs_firepoints agc_arcticgeobotatlas alaska_mapped gdmp gina_metadata landsat_coverage toolik_arcticgeobotatlas sv_linework sv_main ; do
                              Check_PG_DUMP_Status			      
			     done
   
	        ;;
 		gina_dba)
                            for SCHEMA_NAME in afs_basedata afs_firepoints cesadil contact file gdmp gina_banner gina_dba gina_defaults gina_gazetteer gina_metadata gina_metadata_geonetwork landsat_coverage nssi nssi_dba nssi_demo nssi_dev nssi_prod nssi_test portal project public sv_linework sv_main swmap_dba swmap_dev swmap_dba swmap_prod swmap_test; do
#                           for SCHEMA_NAME in afs_basedata afs_firepoints  cesadil contact file gdmp gina_banner gina_dba gina_defaults gina_gazetteer gina_metadata landsat_coverage nssi portal project sv_linework sv_main swmap_dev swmap_test swmap_prod toolik user; do
export FROM_OWNER=$CHAASE
                             Check_PG_DUMP_Status			      
			     done
		;;	
		gina_dev)
                             for SCHEMA_NAME in afs_basedata afs_firepoints afs_raws alaska_mapped landsat_coverage sv_linework sv_main public; do	                          
xexport FROM_OWNER=$CHAASE
                             Check_PG_DUMP_Status			      
			     done
		;;	
		gina_test)
                             for SCHEMA_NAME in alaska_mapped cesadil public ; do	                          
                              Check_PG_DUMP_Status			      
			     done
		;;
		ginaweb_dev)
	                      for SCHEMA_NAME in ginaweb_dev ; do
                              Check_PG_DUMP_Status			      
			     done
		;;
		ginaweb_prod)
	                      for SCHEMA_NAME in ginaweb_prod ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
		ginaweb_test)
	                      for SCHEMA_NAME in ginaweb_test ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
                gozer_dev)
	                      for SCHEMA_NAME in public ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
                 gozer_prod)
	                      for SCHEMA_NAME in public ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
		mms)
                       for SCHEMA_NAME in gina_dba mms_dev mms_prod mms_test; do	                          
                              Check_PG_DUMP_Status			      
			     done
		;;	
                mms_seaice_cms_dev)
	                      for SCHEMA_NAME in mms_seaice_cms_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                mms_seaice_cms_prod)
	                      for SCHEMA_NAME in mms_seaice_cms_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 mms_seaice_cms_test)
	                      for SCHEMA_NAME in mms_seaice_cms_test; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		nssi)
                            for SCHEMA_NAME in public; do	                          
                              Check_PG_DUMP_Status			      
			     done
		;;
	        nssi_dba)
	                     for SCHEMA_NAME in amis_aoos arlls_armap gina_dba gina_defaults gina_metadata gina_metadata_geonetwork gozer_dev nssi nssi_dba nssi_demo nssi_dev nssi_test nssi_prod  public; do
export FROM_OWNER=$CHAASE
                             Check_PG_DUMP_Status			      
			     done
		;;
		nssi_dev)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_dev public  ; do
                                  Check_PG_DUMP_Status			      
			     done
		;;
		nssi_dev_dba)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_dev public  ; do
export FROM_OWNER=$CHAASE
                             Check_PG_DUMP_Status			      
			     done
		;;
		nssi_prod)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_prod public  ; do
                                  Check_PG_DUMP_Status			      
			     done
 		;;
                	nssi_prod_dba)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_prod public  ; do
export FROM_OWNER=$CHAASE
                                  Check_PG_DUMP_Status			      
			     done
 		;;
                nssi_test)
                             for SCHEMA_NAME in gina_dba gina_metadata nssi_test public  ; do
                                  Check_PG_DUMP_Status
                             done
                ;;
                oic_dev)
	                     for SCHEMA_NAME in public  ; do
                                  Check_PG_DUMP_Status			      
			     done
 		;;
		postgres)
                            for SCHEMA_NAME in contact file portal project user; do	                          
                                 Check_PG_DUMP_Status			      
			    done
		;;
                redmine)
	                      for SCHEMA_NAME in public ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
                sdmi-cms_prod)
	                     for SCHEMA_NAME in public  ; do
                                 Check_PG_DUMP_Status			      
			     done
 		;;
                	shorezone)
	                      for SCHEMA_NAME in shorezone public ; do
                                  Check_PG_DUMP_Status
			     done
 		;;
		sizonet_dev)
	                      for SCHEMA_NAME in sizonet_dev ; do
                                   Check_PG_DUMP_Status			      
			     done
 		;;
		sizonet_test)
	                      for SCHEMA_NAME in sizonet_test ; do
                                  Check_PG_DUMP_Status			      
			     done
 		;;
		sizonet_prod)
	                      for SCHEMA_NAME in sizonet_prod public ; do
                                   Check_PG_DUMP_Status			      
			     done
		;;
		sv_ion)
                             for SCHEMA_NAME in sv_dev sv_linework_dev sv_linework_prod sv_linework_test sv_prod sv_test; do	                          
                                  Check_PG_DUMP_Status			      
			     done
  		;;
		swmap_dba)
                             for SCHEMA_NAME in public; do	 
export FROM_OWNER=$CHAASE
                                 Check_PG_DUMP_Status			      
			     done
 		;;		
		swmap_dev)
                             for SCHEMA_NAME in public; do	                          
                            Check_PG_DUMP_Status			      
			     done
  		;;
		swmap_test)
                             for SCHEMA_NAME in public; do	                          
                            Check_PG_DUMP_Status			      
			     done
 		;;
		swmap_prod)
                           for SCHEMA_NAME in public; do	                          
                            Check_PG_DUMP_Status			      
			     done
  		;;
		template1)
                            for SCHEMA_NAME in information_schema pg_catalog pg_temp_1 pg_toast public; do	                          
                            Check_PG_DUMP_Status			      
			     done
  		;;
		toolik)
                           for SCHEMA_NAME in toolik_dev toolik_prod toolik_test ; do
export FROM_OWNER=$CHAASE
                            Check_PG_DUMP_Status			      
			     done
 		;;
		ugres)
                                for SCHEMA_NAME in ugres_dev ugres_prod ; do 
export FROM_OWNER=$CHAASE
                            Check_PG_DUMP_Status			      
			     done
 		;;
		
	        *)  echo "What database are you looking for ???" >> $LOG_FILE  ;; 
	        esac			

           ;;
		
	$HOST_PROD)  
	
		export TO_HOST=$TO_TEST_DBA
		
		case "$POSTGRES_SID" in
                 aedi_dev)
                          for SCHEMA_NAME in aedi_dev public ; do
                              Check_PG_DUMP_Status			      
			     done
	        ;;	
                aedi_prod)
                          for SCHEMA_NAME in aedi_prod public ; do
                              Check_PG_DUMP_Status			      
			     done
	        ;;
               aedi_test)
                          for SCHEMA_NAME in aedi_test public ; do
                              Check_PG_DUMP_Status			      
			     done
	        ;;			
		aerometric)
                         for SCHEMA_NAME in aero_dev aero_test aero_prod gina_dba sv_linework sv_main ; do
                             Check_PG_DUMP_Status			      
			 done
 	        ;;
		aerometric_dba)
                          for SCHEMA_NAME in aero_dev aero_test aero_prod gina_dba sv_linework sv_main ; do
export FROM_OWNER=$CHAASE
                              Check_PG_DUMP_Status			      
			   done
  	        ;;
		blmap__dev)
	                      for SCHEMA_NAME in blmap_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                blmap_prod)
	                 for SCHEMA_NAME in blmap_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		cavm) 
		      for SCHEMA_NAME in cavm public ; do
                          Check_PG_DUMP_Status			      
		      done
		;;
                 drmap_dev)
	                      for SCHEMA_NAME in drmap_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                drmap_prod)
	                      for SCHEMA_NAME in drmap_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 drmap_test)
	                      for SCHEMA_NAME in drmap_test public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 floatingice_cms_dev)
	                      for SCHEMA_NAME in floatingice_cms_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                floatingice_cms_prod)
	                      for SCHEMA_NAME in floatingice_cms_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 floatingice_cms_test)
	                      for SCHEMA_NAME in floatingice_cms_test public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 geonames_dev)
	                      for SCHEMA_NAME in geonames_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                 geonames_prod)
	                      for SCHEMA_NAME in geonames_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		gina)
                          for SCHEMA_NAME in afs_basedata afs_firepoints  alaska_mapped gdmp gina_metadata landsat_coverage sv_linework sv_main public ; do	 
                              Check_PG_DUMP_Status			      
			  done
 	        ;;		
		gina_arctest)
                          for SCHEMA_NAME in afs_basedata afs_firepoints  agc_arcticgeobotatlas alaska_mapped gdmp gina_metadata landsat_coverage toolik_arcticgeobotatlas sv_linework sv_main ; do
                              Check_PG_DUMP_Status			      
			  done
 	        ;;		
		gina_dba)
                         for SCHEMA_NAME in afs_basedata afs_firepoints cesadil contact file gdmp gina_banner gina_dba gina_defaults gina_gazetteer gina_metadata gina_metadata_geonetwork landsat_coverage nssi nssi_dba nssi_demo nssi_dev nssi_prod nssi_test portal project public sv_linework sv_main swmap_dba swmap_dev swmap_dba swmap_prod swmap_test; do
  #                        for SCHEMA_NAME in afs_basedata afs_firepoints  cesadil contact file gdmp gina_banner gina_dba gina_defaults gina_gazetteer gina_metadata landsat_coverage nssi portal project sv_linework sv_main swmap_dev swmap_test swmap_prod toolik ugres user; do
export FROM_OWNER=$CHAASE
                             Check_PG_DUMP_Status			      
			 done
  		;;
                 gina_dev)
                             for SCHEMA_NAME in afs_basedata afs_firepoints afs_raws alaska_mapped landsat_coverage sv_linework sv_main public; do	                          
                             export FROM_OWNER=$CHAASE 
                             Check_PG_DUMP_Status			      
			     done
		;;	
	
                 gina_test)
                             for SCHEMA_NAME in alaska_mapped cesadil public ; do	                          
                              Check_PG_DUMP_Status			      
			     done
		;;
		ginaweb_dev)
	                 for SCHEMA_NAME in ginaweb_dev ; do
                             Check_PG_DUMP_Status			      
			 done
  		;;
		ginaweb_prod)
	                      for SCHEMA_NAME in ginaweb_prod ; do
                            Check_PG_DUMP_Status			      
			     done
 		;;
		ginaweb_test)
	                      for SCHEMA_NAME in ginaweb_test ; do
                            Check_PG_DUMP_Status			      
			     done
  		;;
                gozer_dev)
	                      for SCHEMA_NAME in public ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
                 gozer_prod)
	                      for SCHEMA_NAME in public ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
		mms)
                              for SCHEMA_NAME in gina_dba mms_dev mms_prod mms_test; do	                          
                            Check_PG_DUMP_Status			      
			     done
  		;;
                 mms_seaice_cms_dev)
	                      for SCHEMA_NAME in mms_seaice_cms_dev public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                mms_seaice_cms_prod)
	                      for SCHEMA_NAME in mms_seaice_cms_prod public; do
                               Check_PG_DUMP_Status			      
			     done
		;;
                mms_seaice_cms_test)
	                      for SCHEMA_NAME in mms_seaice_cms_test; do
                               Check_PG_DUMP_Status			      
			     done
		;;
		nssi)
                             for SCHEMA_NAME in public; do	                          
                            Check_PG_DUMP_Status			      
			     done
 		;;
	        nssi_dba)
	                     for SCHEMA_NAME in amis_aoos arlls_armap gina_dba gina_defaults gina_metadata gina_metadata_geonetwork gozer_dev nssi nssi_dba nssi_demo nssi_dev nssi_test nssi_prod  public; do
export FROM_OWNER=$CHAASE
                             Check_PG_DUMP_Status			      
			     done
		;;
		nssi_dev)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_dev public  ; do
                            Check_PG_DUMP_Status			      
			     done
 		;;
                	nssi_dev_dba)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_dev public  ; do
export FROM_OWNER=$CHAASE
                            Check_PG_DUMP_Status			      
			     done
 		;;
		nssi_prod)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_prod public  ; do
                            Check_PG_DUMP_Status			      
			     done
 		;;
                	nssi_prod_dba)
	                     for SCHEMA_NAME in gina_dba gina_metadata nssi_prod public  ; do
export FROM_OWNER=$CHAASE
                            Check_PG_DUMP_Status			      
			     done
 		;;
                 sdmi-cms_prod)
	                     for SCHEMA_NAME in public  ; do
                                 Check_PG_DUMP_Status			      
			     done
 		;;
                 redmine)
	                      for SCHEMA_NAME in public ; do
                              Check_PG_DUMP_Status			      
			     done
 		;;
                	shorezone)
	                      for SCHEMA_NAME in shorezone public ; do
                                  Check_PG_DUMP_Status
			     done
 		;;
		sizonet_dev)
	                      for SCHEMA_NAME in sizonet_dev ; do
                            Check_PG_DUMP_Status			      
			     done
  		;;
		sizonet_test)
	                      for SCHEMA_NAME in sizonet_test ; do
                            Check_PG_DUMP_Status			      
			     done
 		;;
		sizonet_prod)
	                      for SCHEMA_NAME in sizonet_prod public ; do
                            Check_PG_DUMP_Status			      
			     done
   		;;
		sv_ion)
                            for SCHEMA_NAME in sv_dev sv_linework_dev sv_linework_prod sv_linework_test sv_prod sv_test; do	                          
                            Check_PG_DUMP_Status			      
			     done
 		;;
		swmap_dba)
                             for SCHEMA_NAME in public; do	   
export FROM_OWNER=$CHAASE
                            Check_PG_DUMP_Status			      
			     done
 		;;	
		swmap_dev)
                           for SCHEMA_NAME in public ; do	 
                            Check_PG_DUMP_Status			      
			     done
 	        ;;			
		swmap_test)
                            for SCHEMA_NAME in public ; do	 
                            Check_PG_DUMP_Status			      
			     done
   	        ;;
		swmap_prod)
                            for SCHEMA_NAME in public ; do	 
                            Check_PG_DUMP_Status			      
			     done
   		;;		

	        *)  echo "What database are you looking for ???" >> $LOG_FILE  ;; 
	        esac	
		
		;;		
		
	*)  echo "What machine are you on???" >> $LOG_FILE  ;; 
	esac

	
	
#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------

#
##  THIS SHOULD ONLY BE USED FOR A SHORT DURATION OF TIME (I.E., WHILE THE SAN IS GETTING 
##  FIXED) SO THAT BUPS FOR BOTH WALLACE AND GROMIT ARE ACCESSIBLE
#
# this is to be used as a last resort for the files to be copied to the NORTHPOLE "san"
# 1) after they are copied to the host local BUP dir
# 2) IF the copy to the Gromit/Wallace SAN fails then attempt to place it on NORTHPOLE
# 
export DB_BUPS_PGSQL_SEASIDE=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
# export DB_BUPS_PGSQL_NORTHPOLE=/ora/PostgreSQL_PostGIS/database_backups/$POSTGRES_SID
export DB_BUPS_PGSQL_BEEF=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
export DB_BUPS_PGSQL_WALLACE=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
export DB_BUPS_PGSQL_VOODOO=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
export DB_BUPS_PGSQL_MOJO=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
# export DB_BUPS_PGSQL_VOODOO=/home/dba/database_backups/$POSTGRES_SID

gzip  $PG_DUMP_DIR/*.pg_dump 

Check_GZIP_Status

#################################################################################
##########  COPIED THIS OUT UNTIL THE /SAN/DDS IS FIXED !!!!!!!!!
#	cd $PG_DUMP_DIR
#	cp -p $PG_DUMP_DIR/*$LOGDATE*       $DB_BUPS_PGSQL_SHARED/$POSTGRES_SID
#	COPY_STATUS=$?
#	if [ $COPY_STATUS -ne $SE_SUCCESS ]; then
#		echo "** ERROR: COPY from local/san to DDS FAILED! : "  $COPY_STATUS  
#                echo "** Copying BUP file to NORTHPOLE !!!!"
# scp -p swmap_test.gromit.postgres.cD-8.1.3-2006-10-03_204004.pg_dump.gz chaase@northpole.gina.alaska.edu:/ora/PostgreSQL_PostGIS/database_backups/swmap_test
# scp -p $PG_DUMP_DIR/*$LOGDATE*    chaase@northpole.gina.alaska.edu:$DB_BUPS_PGSQL_NORTHPOLE/$POSTGRES_SID	
##################################################################################

# this just here for notes.....................
#    TO_DEV_DBA="chaase@seaside.gina.alaska.edu"
#    TO_TEST_DBA="dba@beef.gina.alaska.edu"
#    TO_PROD_DBA="dba@wallace.gina.alaska.edu"
#    TO_DEVTEST_DBA="dba@mojo.gina.alaska.edu"
#    TO_TESTPROD_DBA="dba@voodoo.gina.alaska.edu"
#
#       HOST_DEV="seaside"
#       HOST_VOGON="vogon"
#       HOST_DEVTEST="mojo"
#       HOST_TESTPROD="voodoo"
#       HOST_TEST="gromit"
#       HOST_PROD="wallace"

# Set the san local env var for dev, test and prods...
export DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups
cd $PG_DUMP_DIR
case "$HOST" in
      $HOST_DEV)
        
        echo "*** Copying DB Dumps FROM Seaside TO Beef/Gromit"  >> $LOG_FILE
        scp -B -p -P 22 *$LOGDATE*  $TO_TEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID

        echo "*** Copying DB Dumps FROM Seaside TO Wallace"  >> $LOG_FILE
        scp -B -p -P 22 *$LOGDATE*  $TO_PROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID	
      
 	;;
	
      $HOST_DEVTEST)
      
      	    echo "*** Copying DB Dumps FROM Mojo TO Voodoo" >> $LOG_FILE
#           scp -B -p -P 22 *$LOGDATE*  $TO_TESTPROD_DBA:$DB_BUPS_PGSQL_NORTHPOLE/$POSTGRES_SID	
            scp -B -p -P 22 *$LOGDATE*  $TO_TESTPROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
            Check_SCP_Status	 
      
            
            echo "*** Copying DB Dumps FROM Mojo TO Beef/Gromit" >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_TEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
            
            echo "*** Copying DB Dumps FROM Mojo TO Wallace" >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_PROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
            
            echo "*** Copying DB Dumps FROM Mojo TO Seaside" >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_DEV_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
	    
      
        ;;	
        
        $HOST_TESTPROD)
      
      	    echo "*** Copying DB Dumps FROM Voodoo TO Mojo" >> $LOG_FILE
#           scp -B -p -P 22 *$LOGDATE*  $TO_TESTPROD_DBA:$DB_BUPS_PGSQL_NORTHPOLE/$POSTGRES_SID	
            scp -B -p -P 22 *$LOGDATE*  $TO_DEVTEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
            Check_SCP_Status	 
              
            echo "*** Copying DB Dumps FROM Voodoo TO Beef/Gromit" >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_TEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
            
            echo "*** Copying DB Dumps FROM Voodoo TO Wallace" >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_PROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
            
            echo "*** Copying DB Dumps FROM Voodoo TO Seaside" >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_DEV_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
      
        ;;	
	
	
      $HOST_TEST)
      
            echo "*** Copying DB Dumps FROM Beef/Gromit TO Wallace/Grallace" >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_PROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
            
	    for DB_NAME in aquadp gina_dba nssi_dev nssi_dba; do	    
	         echo "*** Copying DB Dumps FROM Beef/Gromit TO Seaside" >> $LOG_FILE
                 scp -B -p -P 22 *$LOGDATE*  $TO_DEV_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID			      
                 Check_SCP_Status
	    done
	    
      
        ;;
	
      $HOST_PROD)

                echo "*** Copying DB Dumps FROM Wallace/Grallace TO Beef/Gromit" >> $LOG_FILE
                scp -B -P 22 -p *$LOGDATE*  $TO_TEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        
                echo "*** Copying DB Dumps FROM Wallace/Grallace TO Seaside" >> $LOG_FILE
                scp -B -p -P 22 *$LOGDATE*  $TO_DEV_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
                Check_SCP_Status 
	
 	;;
	
	*)  echo "What machine are you on???" >> $LOG_FILE  ;; 
	esac
   
Check_SCP_Status
	
Print_Footer 

SUBJECT=$POSTGRES_SID" pg_dump_PARMS_SCHEMAS_"$HOST"_"$LOGDATE
echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
if [ "$status" == " " ]; then	
   echo " "                                                            >> $LOG_FILE  
   echo "** ERROR: DBA Email Bombing from DBA@" $HOST                  >> $LOG_FILE
   echo " "                                                            >> $LOG_FILE
fi

exit
