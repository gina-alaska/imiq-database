#! /bin/bash -x
#
#**************************************************************************************
#
# File Name:  ~dba/tools/backup_scripts/POSTGRES/create_database_imiq.RUBYRAILS-pgsql.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~dba/tools/backup_scripts/POSTGRES/create_database_imiq-pgsql.bash
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
#########################################################################################################
#


if [ "$#" -ne 6 ]; then
      echo "Usage: $0 file 1=DB_LIST(imiq_dev/prod/all): 2=CREATE_USERS(Y/N): 3=CREATE_DBS(Y/N): 4=CREATE_PRIVS(Y/N): 5=INSTALL_POSTGIS(Y/N): 6=DEBUG(Y/N): "
      exit
else  
      if [ $1 == "all" ]; then
         DB_LIST="imiq_dev imiq_prod"
      else
         DB_LIST=$1
      fi
      export POSTGRES_USER="imiq"
      export TO_HOST="imiqdb.gina.alaska.edu"
      export CREATE_USERS=$2
      export CREATE_DBS=$3
      export CREATE_PRIVS=$4
      export INSTALL_POSTGIS=$5
      if [ $INSTALL_POSTGIS == "Y" ]; then
         export TEMPLATE="template1"
      else
         export TEMPLATE="template0"
      fi
      export DEBUG=$6
fi	

#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
# EXPORT_SOURCE=$HOME/tools/backup_scripts/POSTGRES

EXPORT_SOURCE=$HOME/tools/backup_scripts
#if [ $DEBUG == $YES ]; then
#    EXPORT_SOURCE=$HOME/northpole/tools/backup_scripts/POSTGRES
#fi	
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
    echo "sourcing: "  $EXPORT_NAME
    source $EXPORT_NAME
done 


export LOG_FILE_BASENAME="`basename $0 .bash`"
export LOG_FILE=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"

#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------
#

if [ $CREATE_USERS == $YES ]; then

Print_Star_Line
Print_Star_Line
echo "=====> CREATING USERS.... "      >> $LOG_FILE 
Print_Star_Line
Print_Blank_Line  
Print_Blank_Line   
Print_Star_Line
Print_Star_Line
echo "=====> .... CREATING USER: "  $POSTGRES_USER         >> $LOG_FILE 
Print_Star_Line
Print_Blank_Line  
Print_Blank_Line  
$PGBIN/psql -d postgres  -U postgres -c "drop user IF EXISTS  imiq "  >> $LOG_FILE  
$PGBIN/psql -d postgres  -U postgres -c "create user imiq encrypted password 'TBD' createdb nocreaterole nocreateuser NOINHERIT"  >> $LOG_FILE
Print_Star_Line
Print_Star_Line
echo "=====> .... CREATING USER: "  $CHAASE        >> $LOG_FILE 
Print_Star_Line
Print_Blank_Line  
Print_Blank_Line   
if [ $ON_SEASIDE == $NO ]; then
$PGBIN/psql -d postgres  -U postgres -a -c "drop user IF EXISTS chaase;"    >> $LOG_FILE
$PGBIN/psql -d postgres  -U postgres -a -c "create user chaase encrypted password 'sqlg0d' createdb createrole createuser NOINHERIT;"    >> $LOG_FILE 
Print_Star_Line
Print_Star_Line
echo "=====> .... CREATING USER: "  $DBA       >> $LOG_FILE 
Print_Star_Line
Print_Blank_Line  
Print_Blank_Line   
$PGBIN/psql -d postgres  -U postgres -a -c "drop user IF EXISTS dba ;"    >> $LOG_FILE 
$PGBIN/psql -d postgres  -U postgres -a -c "create user dba  encrypted password 'sqlg0d' createdb createrole createuser NOINHERIT;"    >> $LOG_FILE 
fi  # ON_SEASIDE
fi  # DEBUG


for POSTGRES_SID in $DB_LIST; do

 if [ INSTALL_POSTGIS == $YES ]; then
      Print_Star_Line
		Print_Star_Line
		echo "=====> INSTALLING POSTGIS: "  $POSTGRES_SID         >> $LOG_FILE 
		Print_Star_Line
		Print_Blank_Line  
		Print_Blank_Line  
		$PSQL -d template1 -h $TO_HOST -U $POSTGRES -f /usr/pgsql-9.1/share/contrib/postgis-1.5/postgis.sql   >> $LOG_FILE 
		$PSQL -d template1 -h $TO_HOST -U $POSTGRES -f /usr/pgsql-9.1/share/contrib/postgis-1.5/spatial_ref_sys.sql   >> $LOG_FILE 
   fi

if [ $CREATE_DBS == $YES ]; then

Print_Star_Line
Print_Star_Line
echo "=====> CREATING DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
Print_Star_Line
Print_Blank_Line  
Print_Blank_Line   

$PGBIN/psql -d postgres -U postgres -a -c "drop database IF EXISTS $POSTGRES_SID;"    >> $LOG_FILE 
$PGBIN/psql -d postgres -U postgres -a -c "create database $POSTGRES_SID with owner=imiq template=template1 encoding='unicode';"    >> $LOG_FILE  
$PGBIN/psql -d postgres -U postgres -a -c "alter database $POSTGRES_SID owner to imiq;"                       >> $LOG_FILE   
$PGBIN/psql -d postgres -U postgres -a -c "grant all on database $POSTGRES_SID to imiq;"    							  >> $LOG_FILE 
$PGBIN/psql -d postgres -U postgres -a -c "grant all on database $POSTGRES_SID to chaase with grant option;"            >> $LOG_FILE 
$PGBIN/psql -d postgres -U postgres -a -c "grant all on database $POSTGRES_SID to dba with grant option;"        >> $LOG_FILE 

$PGBIN/psql -d $POSTGRES_SID -U imiq -a -c "CREATE SCHEMA imiq AUTHORIZATION imiq;"      >> $LOG_FILE 
$PGBIN/psql -d $POSTGRES_SID -U postgres   -a -c "alter user imiq set search_path=imiq, public, pg_catalog;" >> $LOG_FILE 
$PGBIN/psql -d $POSTGRES_SID -U postgres   -a -c "alter user chaase set search_path=imiq, public, pg_catalog;"      >> $LOG_FILE 
$PGBIN/psql -d $POSTGRES_SID -U postgres   -a -c "alter user dba set search_path=imiq, public, pg_catalog;"         >> $LOG_FILE 

fi

if [ $CREATE_PRIVS == $YES ]; then


Print_Star_Line
Print_Star_Line
echo "=====> ....CREATING PRIVS FOR DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
Print_Star_Line
Print_Blank_Line  
Print_Blank_Line 

# do NOT include the postgres superuser in this or things could get ugly.....................
ROLE_LIST="imiq chaase dba" >> $LOG_FILE
SCHEMA_LIST="public imiq" >> $LOG_FILE
for SCHEMA_NAME in $SCHEMA_LIST; do
    SCHEMA_TYPE=$USER 
    $PGBIN/psql -d $POSTGRES_SID  -U postgres -a -c "revoke all privileges on schema $SCHEMA_NAME from PUBLIC cascade;"   >> $LOG_FILE 
    $PGBIN/psql -d $POSTGRES_SID  -U postgres -a -c "alter schema $SCHEMA_NAME owner to imiq;"                    >> $LOG_FILE 
    $PGBIN/psql -d $POSTGRES_SID  -U postgres -a -c "grant all on schema $SCHEMA_NAME to imiq;"                   >> $LOG_FILE 
echo "SCHEMA_NAME: "   $SCHEMA_NAME   
echo "SCHEMA_TYPE: "   $SCHEMA_TYPE
echo "POSTGRES_USER: " $POSTGRES_USER
    # the Lord taketh away..............
    $PGBIN/psql -d $POSTGRES_SID  -U postgres -a -c "revoke all privileges on schema $SCHEMA_NAME from $PUBLIC_GROUP cascade;"  >> $LOG_FILE 
    # ===> BUG: this will only work if the role currently exists on that pg cluster....doh!
    for ROLE_NAME in $ROLE_LIST; do
        $PGBIN/psql -d $POSTGRES_SID   -U postgres -a -c "REVOKE all privileges on SCHEMA $SCHEMA_NAME FROM $ROLE_NAME CASCADE;"     
    done
    # and the Lord giveth to the worthy..............
    $PGBIN/psql -d $POSTGRES_SID  -U postgres  -a -c "alter schema $SCHEMA_NAME owner to imiq;"   >> $LOG_FILE   
    $PGBIN/psql -d $POSTGRES_SID  -U postgres  -a -c "grant all on schema $SCHEMA_NAME to imiq;"  >> $LOG_FILE 
    $PGBIN/psql -d $POSTGRES_SID  -U postgres  -a -c "grant all on schema $SCHEMA_NAME to chaase;"       >> $LOG_FILE 
    $PGBIN/psql -d $POSTGRES_SID  -U postgres  -a -c "grant all on schema $SCHEMA_NAME to dba;"          >> $LOG_FILE 
 
    $PGBIN/psql -d $POSTGRES_SID  -a -c  "$GRANT_USAGE on schema pg_catalog to imiq;"         >> $LOG_FILE 
    $PGBIN/psql -d $POSTGRES_SID  -a -c   "$GRANT_USAGE on schema information_schema to imiq;" >> $LOG_FILE  
    $PGBIN/psql -d $POSTGRES_SID   -a -c  "$GRANT_USAGE on schema pg_catalog to chaase;"               >> $LOG_FILE 
    $PGBIN/psql -d $POSTGRES_SID  -a -c   "$GRANT_USAGE on schema information_schema to chaase;"       >> $LOG_FILE  
    $PGBIN/psql -d $POSTGRES_SID   -a -c  "$GRANT_USAGE on schema pg_catalog to dba;"                 >> $LOG_FILE 
    $PGBIN/psql -d $POSTGRES_SID   -a -c  "$GRANT_USAGE on schema information_schema to dba;"         >> $LOG_FILE  
 
    Check_PGSQL_Status
    Print_Blank_Line      
    TABLE_LIST=`psql -d $POSTGRES_SID -U postgres  -At -c "select distinct tablename from pg_tables where schemaname='$SCHEMA_NAME' order by tablename"` >> $LOG_FILE
    for TABLENAME in $TABLE_LIST; do  
        TABLE_NAME=$SCHEMA_NAME".""$TABLENAME"
        # the Lord taketh away..............
        $PGBIN/psql -d $POSTGRES_SID -U postgres  -a -c "revoke all privileges on table $TABLE_NAME from $PUBLIC_GROUP cascade;"    >> $LOG_FILE 
        for ROLE_NAME in $ROLE_LIST; do
            $PGBIN/psql -d $POSTGRES_SID -U postgres  -a -c "REVOKE all privileges on schema $SCHEMA_NAME FROM $ROLE_NAME CASCADE;"     
        done
        # and the Lord giveth to the worthy..............
        $PGBIN/psql -d $POSTGRES_SID -U postgres  -a -c "alter table $TABLE_NAME owner to $POSTGRES_USER;"                   >> $LOG_FILE 
        $PGBIN/psql -d $POSTGRES_SID -U postgres  -a -c "grant all on table $TABLE_NAME to $POSTGRES_USER;"                  >> $LOG_FILE 
    done  # tables

    INDEX_LIST=`psql -d $POSTGRES_SID -U postgres  -At -c "select distinct indexname from pg_indexes where schemaname='$SCHEMA_NAME' order by indexname"` >> $LOG_FILE
    for INDEXNAME in $INDEX_LIST; do
        INDEX_NAME=$SCHEMA_NAME"."$INDEXNAME
        $PGBIN/psql -d $POSTGRES_SID -U postgres  -a -c "alter index $INDEX_NAME owner to $POSTGRES_USER;"               >> $LOG_FILE  
   done # indexes

    SEQUENCE_LIST=`psql -d $POSTGRES_SID -U postgres  -At -c "select distinct sequence_name from information_schema.sequences where sequence_catalog = '$POSTGRES_SID' and sequence_schema='$SCHEMA_NAME' order by sequence_name"` >> $LOG_FILE
    for SEQUENCENAME in $SEQUENCE_LIST; do
        SEQUENCE_NAME=$SCHEMA_NAME"."$SEQUENCENAME
        $PGBIN/psql -d $POSTGRES_SID -U postgres  -a -c "alter sequence $SEQUENCE_NAME owner to $POSTGRES_USER;"              >> $LOG_FILE  
        $PGBIN/psql -d $POSTGRES_SID -U postgres  -a -c "grant all on sequence $SEQUENCE_NAME to $POSTGRES_USER;"         >> $LOG_FILE 
    done # sequences 
    
done # schemas

fi

done  # db list

#----------------------------------------------------------------------------
# housekeeping
#----------------------------------------------------------------------------

SUBJECT=$0"_"$HOST"_"$POSTGRES_SID"_"$LOGDATE
echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
if [ "$status" == " " ]; then	
   Print_Blank_Line  
   echo "** ERROR: DBA Email Bombing from DBA@" $HOST  >> $LOG_FILE
   Print_Blank_Line  
fi

Print_Footer

exit





