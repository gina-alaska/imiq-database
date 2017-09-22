#! /bin/bash -x
#
#**************************************************************************************
#
# File Name:  ~$DBA/tools/backup_scripts/POSTGRES/create_database_USERNAME.RUBYRAILS-pgsql.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~$DBA/tools/backup_scripts/POSTGRES/create_database_USERNAME-pgsql.bash
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
####################################
#  
#    TBD
#
#  add creation of backup directies on pod1, yin or yang, seaside
#  add prompting for secret word of new user:
#
#
#
#########################################################################################################
#


if [ "$#" -ne 9 ]; then
      echo "Usage: $0 file 1=TO_HOST:  2=DBPREFIX(for dev/prod): 3=CREATE_USERS(Y/N): 4=USERNAME:  5=CREATE_DBS(Y/N): 6=CREATE_PRIVS(Y/N): 7=INSTALL_POSTGIS(Y/N): 8=TBDWORD: 9=DEBUG(Y/N): "
      exit
else  
      export TO_HOST=$1
      #      export TO_HOST="gina1.arsc.edu"
      export DBPREFIX=$2
      export DB_DEV=$DBPREFIX"_dev"
      export DB_PROD=$DBPREFIX"_prod"
      export DB_LIST="$DB_DEV $DB_PROD"
      export CREATE_USERS=$3
      export USERNAME=$4
#      export POSTGRES_USER="junkee"
      export CREATE_DBS=$5
      export CREATE_PRIVS=$6
      export INSTALL_POSTGIS=$7
      if [ $INSTALL_POSTGIS == "Y" ]; then
         export TEMPLATE="template1"
      else
         export TEMPLATE="template0"
      fi
       export TBDWORD=$8
      export DEBUG=$9
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
	
	echo "=====> .... CREATING USER: "  USERNAME         >> $LOG_FILE 
	Print_Star_Line
	Print_Blank_Line  
	Print_Blank_Line  
	$PSQL -d postgres  -U $POSTGRES -h $TO_HOST -c "drop user IF EXISTS $USERNAME "  >> $LOG_FILE  
	$PSQL -d postgres  -U $POSTGRES -h $TO_HOST -c "create user $USERNAME encrypted password 'TBD' createdb nocreaterole nocreateuser NOINHERIT"  >> $LOG_FILE
	Print_Star_Line
	Print_Star_Line
	   #  just in case !!!
		if [ $ON_SEASIDE == $NO ]; then
			echo "=====> .... CREATING USER: "  $CHAASE        >> $LOG_FILE 
			Print_Star_Line
			Print_Blank_Line  
			Print_Blank_Line   
			$PSQL -d postgres  -U $POSTGRES -h $TO_HOST -a -c "drop user IF EXISTS $CHAASE;"    >> $LOG_FILE
			$PSQL -d postgres  -U $POSTGRES -h $TO_HOST -a -c "create user $CHAASE encrypted password 'TBD' createdb createrole createuser NOINHERIT;"    >> $LOG_FILE 
			Print_Star_Line
			Print_Star_Line
			echo "=====> .... CREATING USER: "  $DBA       >> $LOG_FILE 
			Print_Star_Line
			Print_Blank_Line  
			Print_Blank_Line   
			$PSQL -d postgres  -U $POSTGRES -h $TO_HOST -a -c "drop user IF EXISTS $DBA ;"    >> $LOG_FILE 
			$PSQL -d postgres  -U $POSTGRES -h $TO_HOST -a -c "create user $DBA  encrypted password 'TBD' createdb createrole createuser NOINHERIT;"    >> $LOG_FILE 
	fi  # ON_SEASIDE
fi  # CREATE_USERS

echo "DB_LIST: " $DB_LIST

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

		$PSQL -d postgres -h $TO_HOST -U $POSTGRES -a -c "drop database IF EXISTS $POSTGRES_SID;"    >> $LOG_FILE 
		$PSQL -d postgres -h $TO_HOST -U $POSTGRES -a -c "create database $POSTGRES_SID with owner=$USERNAME template=$TEMPLATE encoding='unicode';"    >> $LOG_FILE  
		$PSQL -d postgres -h $TO_HOST -U $POSTGRES -a -c "alter database $POSTGRES_SID owner to $USERNAME;"                        >> $LOG_FILE   
		$PSQL -d postgres -h $TO_HOST -U $POSTGRES -a -c "grant all on database $POSTGRES_SID to $USERNAME;"    							>> $LOG_FILE 
		$PSQL -d postgres -h $TO_HOST -U $POSTGRES -a -c "grant all on database $POSTGRES_SID to $CHAASE with grant option;"       >> $LOG_FILE 
		$PSQL -d postgres -h $TO_HOST -U $POSTGRES -a -c "grant all on database $POSTGRES_SID to $DBA with grant option;"          >> $LOG_FILE 

		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $USERNAME   -a -c "CREATE SCHEMA $USERNAME AUTHORIZATION $USERNAME;"      >> $LOG_FILE 
		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES   -a -c "alter user $USERNAME set search_path=$USERNAME, public, pg_catalog;" >> $LOG_FILE 
		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES   -a -c "alter user $CHAASE set search_path=$USERNAME, public, pg_catalog;"      >> $LOG_FILE 
		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES   -a -c "alter user $DBA set search_path=$USERNAME, public, pg_catalog;"         >> $LOG_FILE 
	fi  # CREATE_DBS
	if [ $CREATE_PRIVS == $YES ]; then
		Print_Star_Line
		Print_Star_Line
		echo "=====> ....CREATING PRIVS FOR DATABASE: "  $POSTGRES_SID         >> $LOG_FILE 
		Print_Star_Line
		Print_Blank_Line  
		Print_Blank_Line 
		# do NOT include the postgres superuser in this or things could get ugly.....................
		ROLE_LIST="$USERNAME $CHAASE $DBA" >> $LOG_FILE
		SCHEMA_LIST="public $USERNAME" >> $LOG_FILE
		for SCHEMA_NAME in $SCHEMA_LIST; do
    		SCHEMA_TYPE=$USER 
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES -a -c "revoke all privileges on schema $SCHEMA_NAME from PUBLIC cascade;"   >> $LOG_FILE 
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES -a -c "alter schema $SCHEMA_NAME owner to $USERNAME;"                    >> $LOG_FILE 
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES -a -c "grant all on schema $SCHEMA_NAME to $USERNAME;"                   >> $LOG_FILE 
			echo "SCHEMA_NAME: "   $SCHEMA_NAME   >> $LOG_FILE 
			echo "SCHEMA_TYPE: "   $SCHEMA_TYPE   >> $LOG_FILE 
			echo "POSTGRES_USER: " $USERNAME   >> $LOG_FILE 
    		# the Lord taketh away..............
    		$PSQL -d $POSTGRES_SID  -h $TO_HOST -U $POSTGRES -a -c "revoke all privileges on schema $SCHEMA_NAME from $PUBLIC_GROUP cascade;"  >> $LOG_FILE 
    		# ===> BUG: this will only work if the role currently exists on that pg cluster....doh!
    		for ROLE_NAME in $ROLE_LIST; do
        		$PSQL -d $POSTGRES_SID  -h $TO_HOST -U $POSTGRES -a -c "REVOKE all privileges on SCHEMA $SCHEMA_NAME FROM $ROLE_NAME CASCADE;"   >> $LOG_FILE   
    		done # ROLES
    		# and the Lord giveth to the worthy..............
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES  -a -c "alter schema $SCHEMA_NAME owner to $USERNAME;"  >> $LOG_FILE 
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES  -a -c "grant all on schema $SCHEMA_NAME to $CHAASE;"   >> $LOG_FILE 
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES  -a -c "grant all on schema $SCHEMA_NAME to $DBA;"      >> $LOG_FILE 
 
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -a -c  "$GRANT_USAGE on schema pg_catalog to $USERNAME;"             >> $LOG_FILE 
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -a -c  "$GRANT_USAGE on schema information_schema to $USERNAME;"     >> $LOG_FILE  
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -a -c  "$GRANT_USAGE on schema pg_catalog to $CHAASE;"               >> $LOG_FILE 
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -a -c  "$GRANT_USAGE on schema information_schema to $CHAASE;"       >> $LOG_FILE  
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -a -c  "$GRANT_USAGE on schema pg_catalog to $DBA;"                  >> $LOG_FILE 
    		$PSQL -d $POSTGRES_SID -h $TO_HOST -a -c  "$GRANT_USAGE on schema information_schema to $DBA;"          >> $LOG_FILE  
 
    		Check_PGSQL_Status
    		Print_Blank_Line      
    		TABLE_LIST=`psql -d $POSTGRES_SID -h $TO_HOST -U $POSTGRES  -At -c "select distinct tablename from pg_tables where schemaname='$SCHEMA_NAME' order by tablename"` >> $LOG_FILE
    		for TABLENAME in $TABLE_LIST; do  
        		TABLE_NAME=$SCHEMA_NAME".""$TABLENAME"
        		# the Lord taketh away..............
        		$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST  -a -c "revoke all privileges on table $TABLE_NAME from $PUBLIC_GROUP cascade;"    >> $LOG_FILE 
        		for ROLE_NAME in $ROLE_LIST; do
            	$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST  -a -c "REVOKE all privileges on schema $SCHEMA_NAME FROM $ROLE_NAME CASCADE;"      >> $LOG_FILE 
        		done  # TABLENAME
        		# and the Lord giveth to the worthy..............
        		$PSQL -d $POSTGRES_SID -U $POSTGRES  -h $TO_HOST -a -c "alter table $TABLE_NAME owner to $USERNAME;"                   >> $LOG_FILE 
        		$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST  -a -c "grant all on table $TABLE_NAME to $USERNAME;"                  >> $LOG_FILE 
    		done  # TABLE_LIST
    		INDEX_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST  -At -c "select distinct indexname from pg_indexes where schemaname='$SCHEMA_NAME' order by indexname"` >> $LOG_FILE
    		for INDEXNAME in $INDEX_LIST; do
        		INDEX_NAME=$SCHEMA_NAME"."$INDEXNAME
        		$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST  -a -c "alter index $INDEX_NAME owner to $USERNAME;"               >> $LOG_FILE  
   		done # INDEX_LIST
    		SEQUENCE_LIST=`psql -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST   -At -c "select distinct sequence_name from information_schema.sequences where sequence_catalog = '$POSTGRES_SID' and sequence_schema='$SCHEMA_NAME' order by sequence_name"` >> $LOG_FILE
    		for SEQUENCENAME in $SEQUENCE_LIST; do
        		SEQUENCE_NAME=$SCHEMA_NAME"."$SEQUENCENAME
        		$PSQL -d $POSTGRES_SID -U $POSTGRES  -h $TO_HOST -a -c "alter sequence $SEQUENCE_NAME owner to $USERNAME;"              >> $LOG_FILE  
        		$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST  -a -c "grant all on sequence $SEQUENCE_NAME to $USERNAME;"         >> $LOG_FILE 
    		done # SEQUENCE_LIST
    done # schemas
	fi  # CREATE_PRIVS
	
	# now make sure backup dirs exist
	Verify_Backup_Directory_Exists
	
done  # db list


SUBJECT=$0"_"$HOST"_"$POSTGRES_SID"_"$LOGDATE
echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
if [ "$status" == " " ]; then	
   Print_Blank_Line  
   echo "** ERROR: $DBA Email Bombing from $DBA@" $HOST  >> $LOG_FILE
   Print_Blank_Line  
fi

Print_Footer

exit





