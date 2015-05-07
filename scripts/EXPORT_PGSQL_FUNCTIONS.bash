#! /bin/bash -x
#
#------------------------------------------------------------------------
# ******************* FUNCTION DEFINITIONS   *********************
#------------------------------------------------------------------------
	
Check_PGSQL_Status()
{
PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
   Print_Blank_Line  
   echo "** ERROR: PGSQL FAILED for Database: " $POSTGRES_SID  >> $LOG_FILE  
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


Check_PG_Privs()
{
        
$PSQL_COMMAND_LINE=$PSQL_COMMAND_LINE_c	
echo "******************* DATABASE  *****************************"              >> $LOG_FILE
DB_PRIVS=`$PSQL_COMMAND_LINE "\l+"`                         >> $LOG_FILE
$PSQL_COMMAND_LINE "\l+"                                    >> $LOG_FILE

Print_Blank_Line  
if [ $POSTGRES_SID == $CLUSTER ]; then   
     $PSQL_COMMAND_LINE=$PSQL_COMMAND_LINE_c_DBA
fi

echo "******************* USERS/ROLES  *****************************"           >> $LOG_FILE
USER_PRIVS=`$PSQL_COMMAND_LINE "\du+"`                      >> $LOG_FILE
$PSQL_COMMAND_LINE "\du+"                                   >> $LOG_FILE
Print_Blank_Line  

echo "******************* SCHEMA  *****************************"                >> $LOG_FILE
SCHEMA_PRIVS=`$PSQL_COMMAND_LINE "\dn+"`                    >> $LOG_FILE
$PSQL_COMMAND_LINE "\dn+"                                   >> $LOG_FILE
Print_Blank_Line  

Print_Blank_Line
echo "******************* TABLE/SEQUENCE  *****************************"        >> $LOG_FILE
TABLE_SEQUENCE_PRIVS=`$PSQL_COMMAND_LINE "\dp+"`            >> $LOG_FILE
$PSQL_COMMAND_LINE "\dp+"                                  >> $LOG_FILE
Print_Star_Line

Print_Blank_Line
echo "******************* INDEX  *****************************"                 >> $LOG_FILE
INDEX_PRIVS=`$PSQL_COMMAND_LINE "\di"`                      >> $LOG_FILE
$PSQL_COMMAND_LINE "\di"                                  >> $LOG_FILE
Print_Star_Line

Print_Blank_Line
echo "******************* VIEWS  *****************************"                 >> $LOG_FILE
VIEW_PRIVS=`$PSQL_COMMAND_LINE "\dv"`                       >> $LOG_FILE
$PSQL_COMMAND_LINE "\dv"                                  >> $LOG_FILE
Print_Star_Line

}

Set_PG_Schema_Type()
{
SCHEMA_TYPE=$USER
if [ $SCHEMA_NAME == $GINA_METADATA ] || [ $SCHEMA_NAME == $GINA_DBA ]; then
       SCHEMA_TYPE=$DBA
fi   
}


Set_PG_DB_Type()
{   
POSTGRES="postgres"
DB_NAME=""
DB_TYPE=$PROD  
POSTGRES_USER=$POSTGRES
FROM_USER=$POSTGRES
FROM_OWNER=$POSTGRES    
if [ $POSTGRES_SID != "cluster" ]; then         
     FROM_USER=$POSTGRES     
     POSTGRES_USER=$POSTGRES_SID

#     POSTGRES_SID_DEV=$POSTGRES_SID"_dev"
#     POSTGRES_SID_TEST=$POSTGRES_SID"_test"
#     POSTGRES_SID_PROD=$POSTGRES_SID"_prod"
#     POSTGRES_SID_DBA=$POSTGRES_SID"_dba"
#     POSTGRES_SID_DEV_DBA=$POSTGRES_SID_DEV"_dba"
#     POSTGRES_SID_TEST_DBA=$POSTGRES_SID_TEST"_dba"
#     POSTGRES_SID_PROD_DBA=$POSTGRES_SID_PROD"_dba"
        
#    DB_NAME=""
     DB_NAME=$POSTGRES_SID
#     DB_TYPE=$PROD

#     DB_NAME=`$PSQL -d $POSTGRES_SID -U $POSTGRES -At -c "SELECT datname FROM pg_database WHERE datname='$POSTGRES_SID';" `       
#                $POSTGRES_SID_PROD)        DB_TYPE=$PROD ;;
#                $POSTGRES_SID_DEV)         DB_TYPE=$DEV  ;;
 #               $POSTGRES_SID_TEST)        DB_TYPE=$TEST ;;
#  	        *)                         POSTGRES_USER=$CHAASE
 #                                          FROM_USER=$CHAASE
 #                                          FROM_OWNER=$CHAASE
 #                                          DB_TYPE=$DBA  ;; 
 #            esac   
 #    fi
     
fi
}



#Get_PG_Databases()
#{
##PG_DATABASES=
#`/usr/bin/psql -l \#
 # | awk 'NF == 5 && \
#     $1 != "Name" && \
#     $1 != "template0" && \
 #    $2 == "|" && \
 #    $3 != "Owner" && \
 #    $4 == "|" && \
 #    $5 != "Encoding" \
 #    {print $1}' \
#  | sort`              
# #}

List_PG_Databases()
{

#source $HOME/tools/backup_scripts/EXPORT_GINA_HOSTS.bash
#PSQL=$PGBIN/psql


if [ $POSTGRES_SID == $CLUSTER ]; then
     PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$CLUSTER
     FROM_OWNER=$POSTGRES
#  pod DB_LIST=$(psql -l | awk '{ print $1}' | grep -vE '^-|^List|^Name|^\(|^:|template[0|1]')
     DB_LIST=`$PSQL -d gina_dba -U postgres -At -c "SELECT datname FROM pg_database WHERE datallowconn order by datname"`
     DB_LIST_USER=`$PSQL -d gina_dba -U postgres -At -c "SELECT datname FROM pg_database WHERE datallowconn and datname != 'postgres' and datname NOT LIKE 'temp%' order by datname"`
else
    
# ORIG      DB_LIST=`psql $POSTGRES  -U $POSTGRES  -At -c "SELECT datname FROM pg_database WHERE datname = '$POSTGRES_SID'"`
     DB_LIST=$POSTGRES_SID
#     PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
fi 
# pg > 8.1 then log-dir is in pgdata/log
export PG_LOG_DIR=$PGDATA/pg_log

#PostgreSQL | awk '{print $2}'`	 >> $LOG_FILE
#POSTGRES_VERSION=`echo "select version();" | psql -d gina_dba -U postgres | grep PostgreSQL | awk '{print $2}'`	
#  ORIG POSTGRES_VERSION=`psql -d $POSTGRES  -U $POSTGRES  -V | grep PostgreSQL | awk '{print $3}'`	
POSTGRES_VERSION=`$PSQL -d $POSTGRES  -U $POSTGRES  -V | grep psql | awk '{print $3}'`


case "$POSTGRES_VERSION" in   
# ====> NOTE:   < 8.4 is EOL !!!!!  
       $POSTGRES_VERSION_844)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_844_FILE   
          ;;  
       $POSTGRES_VERSION_90)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_90_FILE
           export PGBIN=$PGBIN_90
           ;;
     $POSTGRES_VERSION_902)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_902_FILE
           export PGBIN=$PGBIN_90
           ;;
       $POSTGRES_VERSION_903)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_903_FILE
           export PGBIN=$PGBIN_90
           ;;
      $POSTGRES_VERSION_91)
           export POSTGRES_VERSION_FILE==$POSTGRES_VERSION_91_FILE
           export PGBIN=$PGBIN_91
           ;;
      $POSTGRES_VERSION_911)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_911_FILE
           export PGBIN=$PGBIN_91
           ;;
       $POSTGRES_VERSION_912)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_912_FILE
           export PGBIN=$PGBIN_91
           ;;
       $POSTGRES_VERSION_913)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_913_FILE
           export PGBIN=$PGBIN_91
           ;;   
       $POSTGRES_VERSION_917)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_917_FILE
           export PGBIN=$PGBIN_91
           ;;
       $POSTGRES_VERSION_918)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_918_FILE
           export PGBIN=$PGBIN_91
           ;;
       $POSTGRES_VERSION_920)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_920_FILE
           export PGBIN=$PGBIN_92
           ;;
        $POSTGRES_VERSION_922)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_922_FILE
           export PGBIN=$PGBIN_92
           ;;          
         $POSTGRES_VERSION_925)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_925_FILE
           export PGBIN=$PGBIN_92
           ;;
        $POSTGRES_VERSION_931)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_931_FILE
           export PGBIN=$PGBIN_931
           ;;
        $POSTGRES_VERSION_932)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_932_FILE
           export PGBIN=$PGBIN_932
           ;;
         $POSTGRES_VERSION_934)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_934_FILE
           export PGBIN=$PGBIN_934
           ;;
         $POSTGRES_VERSION_935)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_935_FILE
           export PGBIN=$PGBIN_935
           ;;
         $POSTGRES_VERSION_936)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_936_FILE
           export PGBIN=$PGBIN_936
           ;;
         $POSTGRES_VERSION_940)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_940_FILE
           export PGBIN=$PGBIN_940
           ;;
         $POSTGRES_VERSION_942)
           export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_942_FILE
           export PGBIN=$PGBIN_942
           ;;

      *)  echo "What POSTGRES version are you on???" >> $LOG_FILE  ;; 
      esac
      
#      POSTGIS_VERSION=`$PSQL -d $POSTGRES_SID  -U $POSTGRES -At -c "select postgis_full_version();"` >> $LOG_FILE 

#POSTGIS_VERSION=`$PGBIN/psql -d $POSTGRES_SID  -At -c "select postgis_full_version();"` >> $LOG_FILE 


}


List_PG_Roles()
{
# do NOT include the postgres superuser in this or things could get ugly.....................
export ROLE_LIST=`$PSQL_COMMAND_LINE_Atc "$SELECT_ROLNAME from $PG_ROLES where $ROLNAME_NOT_POSTGRES $ORDER_BY_ROLNAME;"` >> $LOG_FILE
export ROLE_LIST_ALL=`$PSQL_COMMAND_LINE_Atc "$SELECT_ROLNAME from $PG_ROLES where $ROLNAME_NOT_POSTGRES $ORDER_BY_ROLNAME;"` >> $LOG_FILE
export ROLE_LIST_USER=`$PSQL_COMMAND_LINE_Atc "$SELECT_ROLNAME from $PG_ROLES where $ROLNAME_NOT_POSTGRES and $ROLNAME_NOT_SDE and $ROLNAME_NOT_DATA and $ROLNAME_NOT_PUBLIC and $ROLNAME_NOT_ADMIN $ORDER_BY_ROLNAME;"` >> $LOG_FILE
export ROLE_LIST_USER_SDE=`$PSQL_COMMAND_LINE_Atc "$SELECT_ROLNAME from $PG_ROLES where $ROLNAME_NOT_POSTGRES and $ROLNAME_NOT_DATA and $ROLNAME_NOT_ADMIN $ORDER_BY_ROLNAME;"` >> $LOG_FILE
}


List_PG_Schemas()
{
#  This only gives you the schemas have tables in them...NOT empty schemas: 
# use this list when I want to ignore empty schemas
SCHEMA_LIST_PGTABLES=`$PSQL_COMMAND_LINE_Atc "select distinct schemaname from pg_tables;"`     >> $LOG_FILE
SCHEMA_LIST_ALL=`$PSQL_COMMAND_LINE_Atc "$SELECT_DISTINCT_SCHEMA_NAME from $INFORMATION_SCHEMA_SCHEMATA;"`     >> $LOG_FILE
SCHEMA_LIST_PG=`$PSQL_COMMAND_LINE_Atc "$SELECT_DISTINCT_SCHEMA_NAME from $INFORMATION_SCHEMA_SCHEMATA where $SCHEMA_IS_PG or $SCHEMA_IS_INFORMATION_SCHEMA;"`                       >> $LOG_FILE
SCHEMA_LIST_USER=`$PSQL_COMMAND_LINE_Atc "$SELECT_DISTINCT_SCHEMA_NAME from $INFORMATION_SCHEMA_SCHEMATA where $SCHEMA_NOT_PG and $SCHEMA_NOT_INFORMATION_SCHEMA and $SCHEMA_NOT_SDE and $SCHEMA_NOT_PUBLIC_SCHEMA;"`  >> $LOG_FILE
SCHEMA_LIST_USER_SDE=`$PSQL_COMMAND_LINE_Atc "$SELECT_DISTINCT_SCHEMA_NAME from $INFORMATION_SCHEMA_SCHEMATA where $SCHEMA_NOT_PG and $SCHEMA_NOT_INFORMATION_SCHEMA and $SCHEMA_NOT_PUBLIC_SCHEMA;"`                  >> $LOG_FILE
SCHEMA_LIST_USER_PUBLIC=`$PSQL_COMMAND_LINE_Atc "$SELECT_DISTINCT_SCHEMA_NAME from $INFORMATION_SCHEMA_SCHEMATA where $SCHEMA_NOT_PG and $SCHEMA_NOT_INFORMATION_SCHEMA;"`                  >> $LOG_FILE
SCHEMA_LIST_DBA=`$PSQL_COMMAND_LINE_Atc "$SELECT_DISTINCT_SCHEMA_NAME from $INFORMATION_SCHEMA_SCHEMATA where $SCHEMA_IS_DBA;"`                  >> $LOG_FILE
SCHEMA_LIST_DBA_PUBLIC=`$PSQL_COMMAND_LINE_Atc "$SELECT_DISTINCT_SCHEMA_NAME from $INFORMATION_SCHEMA_SCHEMATA where $SCHEMA_IS_DBA_PUBLIC;"`   >> $LOG_FILE
}


List_PG_Sequences()
{
#  This only gives you the schemas have tables in them...NOT empty schemas: 
# use this list when I want to ignore empty schemas
#SEQUENCE_LIST_PGTABLES=`$PSQL_COMMAND_LINE_Atc "select distinct relname from pg_statio_all_sequences order by relname;"`     >> $LOG_FILE
SEQUENCE_LIST_ALL=`$PSQL_COMMAND_LINE_Atc "select distinct relname from pg_statio_all_sequences;"`     >> $LOG_FILE
#SEQUENCE_LIST_PG=`$PSQL_COMMAND_LINE_Atc "select distinct relname from pg_statio_all_sequences where schemaname != 'public' or schemaname != 'information_schema';"`        >> $LOG_FILE
#SEQUENCE_LIST_USER=`$PSQL_COMMAND_LINE_Atc "select distinct relname from pg_statio_all_sequences where $SCHEMA_NOT_PG and $SCHEMA_NOT_INFORMATION_SCHEMA and $SCHEMA_NOT_SDE and $SCHEMA_NOT_PUBLIC_SCHEMA order by schemaname, relname;"`  >> $LOG_FILE
#SEQUENCE_LIST_USER_SDE=`$PSQL_COMMAND_LINE_Atc "select distinct relname from pg_statio_all_sequences where $SCHEMA_NOT_PG and $SCHEMA_NOT_INFORMATION_SCHEMA and $SCHEMA_NOT_PUBLIC_SCHEMA order by schemaname, relname ;"`                  >> $LOG_FILE
#SEQUENCE_LIST_USER_PUBLIC=`$PSQL_COMMAND_LINE_Atc "select distinct relname from pg_statio_all_sequences where $SCHEMA_NOT_PG and $SCHEMA_NOT_INFORMATION_SCHEMA order by schemaname,relname;"`                  >> $LOG_FILE
#SEQUENCE_LIST_DBA=`$PSQL_COMMAND_LINE_Atc "select distinct relname from pg_statio_all_sequences where $SCHEMA_IS_DBA order by schemaname, relname ;"`                  >> $LOG_FILE
#SEQUENCE_LIST_DBA_PUBLIC=`$PSQL_COMMAND_LINE_Atc "select distinct relname from pg_statio_all_sequences where $SCHEMA_IS_DBA_PUBLIC order by schemaname, relname ;"`                  >> $LOG_FILE
}


List_PG_Tables()
{
# use PG_TABLES in this select ...if there aren't any tables (empty schema) then nothing will happen and i don't have to check for NONE there.
export TABLE_LIST=`$PSQL_COMMAND_LINE_Atc "$SELECT_DISTINCT tablename from $PG_TABLES_PG where schemaname='$SCHEMA_NAME' $ORDER_BY_TABLENAME"` >> $LOG_FILE
}

Get_Current_Record_Count()
{
export CURRENT_RECORD_COUNT=`psql -d $POSTGRES_SID -At -c "select count(*) from $TABLE_NAME"`
if [ $PSQL_STATUS != $SE_SUCCESS ]; then
     echo "** ERROR: Count not get record count for table:  " : $TABLE_NAME 
     exit 1
fi
echo "** CURRENT_RECORD_COUNT for table:  " $TABLE_NAME " is " $CURRENT_RECORD_COUNT 
}


Get_Current_TimeStamp()
{
PSQL_CURRENT_TIMESTAMP=`$PSQL  -d $POSTGRES_SID -At -c  "select * from current_timestamp"`       
}

Get_NOW_TimeStamp()
{
PSQL_NOW=`$PSQL -d $POSTGRES_SID -At -c "select * from now()"` 
       
}



BUP_Table()
{
BUP_TABLENAME=$TABLE_NAME"_"$FILEDATETIME	    	    
$PSQL_COMMAND_LINE_Atc "create table $BUP_TABLENAME as select * from $TABLE_NAME;"
#PSQL_STATUS=$status 
#if [ $PSQL_STATUS != $SE_SUCCESS ]; then
#     echo "** ERROR: Count create BUP table:  " : $BUP_TABLENAME " from " $TABLE_NAME
#     exit
#fi       
}


Do_PGSQL_Updates()
{
cd $PG_DUMP_DIR
OPTION_STRING_FILE=$CSV
OUTPUT_FILE=$POSTGRES_SID.$SCHEMA_NAME.$TABLENAME.$HOST.$OPTION_STRING_FILE.$LOGDATE.pg_dump    
OUTPUT_FILE_PARTIAL=$POSTGRES_SID.$SCHEMA_NAME.$STAR.$OPTION_STRING_FILE.$STAR.$LOGDATE
if [ $CREATE_PG_TABLES = $YES  ]; then  
         echo "** WARNING: Count not get record count for gina_dba table:  " : $TABLE_NAME                         >> $LOG_FILE_SQL
         echo "** CREATING gina_dba table: "   $TABLE_NAME                                                         >> $LOG_FILE_SQL
         $PSQL -d $POSTGRES_SID -U $USERID -c "$CREATE_TABLE $TABLE_NAME as select * from $TABLENAME_PGCATALOG;"   >> $LOG_FILE_SQL
         Check_PGSQL_Status
         echo "** CREATE_PG_TABLES table:  " $TABLE_NAME " from " $TABLENAME                             >> $LOG_FILE_SQL
         echo "** Adding DBA fields to table:  " $TABLE_NAME                                             >> $LOG_FILE_SQL
         $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $TABLE_NAME $ADD_HOST_VARCHAR10;"            >> $LOG_FILE_SQL
#         Check_PGSQL_Status
         $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $TABLE_NAME $ADD_CREATED_AT_TIMESTAMP;"      >> $LOG_FILE_SQL
#         Check_PGSQL_Status
         $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $TABLE_NAME $ADD_UPDATED_AT_TIMESTAMP;"      >> $LOG_FILE_SQL
#         Check_PGSQL_Status
#         if [ $TABLE_NAME = $GINA_DBA"."$PG_DATABASE ] ; then
#echo "** IN alter column loop.......TABLE_NAME" 
#              $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $TABLE_NAME  alter datacl type text;"
 #             Check_PGSQL_Status
#         fi 
         $PSQL -d $POSTGRES_SID -U $USERID -c "$UPDATE $TABLE_NAME set host='$HOST', created_at='$PSQL_CURRENT_TIMESTAMP', updated_at=now();"    >> $LOG_FILE_SQL
#         Check_PGSQL_Status
         RECORDS_INGESTED=`psql -d $POSTGRES_SID -At -c "$SELECT_COUNT_STAR from $TABLE_NAME;"`          >> $LOG_FILE_SQL
#         Check_PGSQL_Status
         echo "** RECORDS_INGESTED for table " $TABLE_NAME " is " $RECORDS_INGESTED                      >> $LOG_FILE_SQL
         $PSQL -d $POSTGRES_SID -U $USERID -c "\copy $TABLE_NAME to '$OUTPUT_FILE' $DELIMITER_AS_NULL"   >> $LOG_FILE_SQL
         CREATE_PG_TABLES=$NO
else
          echo "** RECORD_COUNT_PG for table:  " $TABLE_NAME " is " $RECORD_COUNT_PG                              >> $LOG_FILE_SQL
          BUP_TABLENAME=$TABLE_NAME"_"$FILEDATETIME
          $PSQL -d $POSTGRES_SID -U $USERID -c "$CREATE_TABLE $BUP_TABLENAME as $SELECT_STAR from $TABLENAME;"    >> $LOG_FILE_SQL     
#          Check_PGSQL_Status
          $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $BUP_TABLENAME $ADD_HOST_VARCHAR10;"                  >> $LOG_FILE_SQL
#          Check_PGSQL_Status
          $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $BUP_TABLENAME $ADD_CREATED_AT_TIMESTAMP;"            >> $LOG_FILE_SQL
#          Check_PGSQL_Status
          $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $BUP_TABLENAME $ADD_UPDATED_AT_TIMESTAMP;"            >> $LOG_FILE_SQL     
#          Check_PGSQL_Status
          if [ $TABLE_NAME = $GINA_DBA"."$PG_DATABASE ] ; then
 #             $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $BUP_TABLENAME alter datacl type text;"        >> $LOG_FILE
               $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $BUP_TABLENAME alter column datacl type text;"  >> $LOG_FILE_SQL    
               Check_PGSQL_Status         
echo "** IN alter column loop......BUP_TABLENAME"                                                                  >> $LOG_FILE_SQL   
          fi 
          echo "*** BUP table is: " $BUP_TABLENAME                                                                                                 >> $LOG_FILE_SQL
          $PSQL -d $POSTGRES_SID -U $USERID -c "$UPDATE $BUP_TABLENAME set host='$HOST', created_at='$PSQL_CURRENT_TIMESTAMP', updated_at=now();"  >> $LOG_FILE_SQL  
#          Check_PGSQL_Status
          $PSQL -d $POSTGRES_SID -U $USERID -c "$INSERT into $TABLE_NAME $SELECT_STAR from $BUP_TABLENAME;"     >> $LOG_FILE_SQL
#          Check_PGSQL_Status
          RECORDS_INGESTED=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $BUP_TABLENAME;"`   >> $LOG_FILE_SQL
          echo "** RECORDS_INGESTED for table " $BUP_TABLENAME " is " $RECORDS_INGESTED                          >> $LOG_FILE_SQL 
          $PSQL -d $POSTGRES_SID -U $USERID -c "\copy $BUP_TABLENAME to '$OUTPUT_FILE' $DELIMITER_AS_NULL"       >> $LOG_FILE_SQL
 #         Check_PGSQL_Status
          $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $BUP_TABLENAME;"                                     >> $LOG_FILE_SQL   
 #         Check_PGSQL_Status    
fi        

# Print_Blank_Line
# echo "** Exported INTO: " $OUTPUT_FILE " FROM " $POSTGRES_SID " Schema: " $SCHEMA_NAME " Table Name: " $TABLE_NAME >> $LOG_FILE                
        
}


Do_PGSQL_DBA_Creates()
{
cd $PG_DUMP_DIR  
echo "** WARNING: Count not get record count for gina_dba table:  " : $TABLENAME_DBA_FULL                            >> $LOG_FILE_SQL
echo "** CREATE_PG_TABLES table:  " $TABLENAME_DBA_FULL " from " $SOURCE_FILE_NAME                                   >> $LOG_FILE_SQL 
$PSQL -d $POSTGRES_SID -U $USERID -c "$CREATE_TABLE $TABLENAME_DBA_FULL as $SELECT_STAR from $SOURCE_FILE_NAME;"     >> $LOG_FILE_SQL
echo "** Adding DBA fields to table:  " $TABLENAME_DBA_FULL                                                          >> $LOG_FILE_SQL
$PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $TABLENAME_DBA_FULL $ADD_HOST_VARCHAR10;"                         >> $LOG_FILE_SQL
Check_PGSQL_Status
$PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $TABLENAME_DBA_FULL $ADD_CREATED_AT_TIMESTAMP;"                   >> $LOG_FILE_SQL
Check_PGSQL_Status
$PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $TABLENAME_DBA_FULL $ADD_UPDATED_AT_TIMESTAMP;"                   >> $LOG_FILE_SQL
Check_PGSQL_Status
if [ $TABLENAME_DBA_FULL = $PG_DATABASE_DBA ] ; then
    $PSQL -d $POSTGRES_SID -U $USERID -c "$ALTER_TABLE $TABLENAME_DBA_FULL alter column datacl type text;"           >> $LOG_FILE_SQL
    Check_PGSQL_Status
echo "** IN alter column loop.....TABLENAME_DBA_FULL"                                                                 >> $LOG_FILE_SQL
fi
$PSQL -d $POSTGRES_SID -U $USERID -c "$UPDATE $TABLENAME_DBA_FULL set host='$HOST', created_at='$PSQL_CURRENT_TIMESTAMP', updated_at=now();"  >> $LOG_FILE_SQL
#Check_PGSQL_Status
RECORDS_INGESTED=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_STAR from $TABLENAME_DBA_FULL;"`              >> $LOG_FILE_SQL
#Check_PGSQL_Status  
echo "** Successful Creation of DB: " $POSTGRES_SID  " Schema: " $SCHEMA_NAME " To: " $PG_DUMP_DIR               >> $LOG_FILE_SQL
}



Truncate_PGSQLTables()
{
   # *******************************************************************************
   # * 
   # *  ====> HARDCODED so that I don't drop the fricking system tables on ANY box !!!!
   # * 
   # ********************************************************************************
   
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_AUTHID;"           >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_DATABASE;"         >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_LANGUAGE;"         >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_NAMESPACE;"        >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_PLTEMPLATE;"       >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_ROLES;"            >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_TABLES;"           >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_TABLESPACE;"       >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_TYPE;"             >> $LOG_FILE_SQL
}

Truncate_PGSQL_Dba_Tables()
{
   # *******************************************************************************
   # * 
   # *  ====> HARDCODED so that I don't drop the fricking system tables on ANY box !!!!
   # * 
   # ********************************************************************************

   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_AUTHID_DBA;"        >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_DATABASE_DBA;"      >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_LANGUAGE_DBA;"      >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_NAMESPACE_DBA;"     >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_PLTEMPLATE_DBA;"    >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_ROLES;"             >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_TABLES_DBA;"        >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_TABLESPACE_DBA;"    >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$TRUNCATE_TABLE $PG_TYPE_DBA;"          >> $LOG_FILE_SQL
}

Zap_PGSQL_Tables()
{
   # *******************************************************************************
   # * 
   # *  ====> HARDCODED so that I don't drop the fricking system tables on ANY box !!!!
   # * 
   # ********************************************************************************
     
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_AUTHID;"       >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_DATABASE;"     >> $LOG_FILE_SQL 
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_LANGUAGE;"     >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_NAMESPACE;"    >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_PLTEMPLATE;"   >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_ROLES;"        >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_TABLES;"       >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_TABLESPACE;"   >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_TYPE;"         >> $LOG_FILE_SQL
}


Zap_PGSQL_DBA_Tables()
{
   # *******************************************************************************
   # * 
   # *  ====> HARDCODED so that I don't drop the fricking system tables on ANY box !!!!
   # * 
   # ********************************************************************************
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_AUTHID_DBA;"           >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_DATABASE_DBA;"         >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_LANGUAGE_DBA;"         >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_NAMESPACE_DBA;"        >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_PLTEMPLATE_DBA;"       >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_ROLES_DBA;"            >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_TABLES_DBA;"           >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_TABLESPACE_DBA;"       >> $LOG_FILE_SQL
   $PSQL -d $POSTGRES_SID -U $USERID -c "$DROP_TABLE $PG_TYPE_DBA;"             >> $LOG_FILE_SQL
}

Get_PG_CONFIG_Files()
{
Print_Blank_Line        
Print_Star_Line  
echo "** PG_CONFIG_Files "	  >>  $LOG_FILE  
$PG_CONFIG
ls $PGDATA/pg_*.conf               >> $PG_CONFIG_FILES            
for PG_CONFIG_FILE in $(cat $PG_CONFIG_FILES); do   
    Print_Blank_Line        
    Print_Star_Line  
    echo "PG_CONFIG_FILE: "  $PG_CONFIG_FILE     >>  $LOG_FILE  
    cat $PG_CONFIG_FILE                          >>  $LOG_FILE     
    Print_Blank_Line        
    Print_Star_Line  
done                                                                    
Print_Star_Line   
Print_Blank_Line 
}


Get_PG_CONTROLDATA()
{
Print_Blank_Line        
Print_Star_Line           
echo "** PG_CONTROLDATA  "	 >>  $LOG_FILE  	
$PG_CONTROLDATA                    >>  $LOG_FILE      
Print_Star_Line   
Print_Blank_Line 
}


Get_PG_CONFIG()
{
Print_Blank_Line        
Print_Star_Line           
echo "** PG_CONFIG  "	 >>  $LOG_FILE  	
$PG_CONFIG                >>  $LOG_FILE       
Print_Star_Line   
Print_Blank_Line 
}


Do_DB_Imports()
{
echo "** Importing INTO: "  $POSTGRES_SID " Schema: " $SCHEMA_NAME " Table Name: " $TABLENAME_DBA " FROM " $BASEFILENAME  >> $LOG_FILE
Print_Blank_Line  
$PSQL -d $POSTGRES_SID -U $USERID -c "\copy $TABLENAME_DBA_FULL from '$BASEFILENAME_FULL' $DELIMITER_AS_NULL"             >> $LOG_FILE  
#Check_PGSQL_Status
echo "** Successful IMPORT into : " $POSTGRES_SID  " Schema: " $SCHEMA_NAME " FROM " $BASEFILENAME                        >> $LOG_FILE  
Print_Blank_Line 
}


# the DBA taketh away..............
Revoke_PUBLIC_Privs_on_Schemas()
{ 
$PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "$REVOKE_ALL privileges on schema $SCHEMA_NAME from $PUBLIC_GROUP cascade;"  >> $LOG_FILE 
for ROLE_NAME in $ROLE_LIST; do 
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "$REVOKE_ALL privileges on schema $SCHEMA_NAME FROM $ROLE_NAME;"     
done
} 

# the DBA taketh away..............
Revoke_PUBLIC_Privs_on_Tables()
{           
$PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "$REVOKE_ALL privileges on table $TABLE_NAME from $PUBLIC_GROUP cascade;"    >> $LOG_FILE 
for ROLE_NAME in $ROLE_LIST; do
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "$REVOKE_ALL privileges on table $TABLE_NAME FROM $ROLE_NAME;"           >> $LOG_FILE   
done
}   

# and the DBA giveth to the worthy..............
Grant_SV_Privs_on_Schemas()
{
# needs usage on system tables because I just revoked the group PUBLIC privs from pg tables.
for ROLE_NAME_SV in $ROLE_LIST_SWATHVIEWER; do
    $PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "$GRANT_USAGE on schema $SCHEMA_NAME to $ROLE_NAME_SV;"        >> $LOG_FILE   
done  
}  

# and the DBA giveth to the worthy..............
Grant_DBA_CHAASE_Privs_on_Schemas()
{      
# permissions for dba and me
$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST -a -c "$ALTER_SCHEMA $SCHEMA_NAME owner to dba;"               >> $LOG_FILE   
$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST -a -c "$GRANT_ALL on schema $SCHEMA_NAME to dba;"              >> $LOG_FILE 
$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST -a -c "$GRANT_ALL on schema $SCHEMA_NAME to $CHAASE;"          >> $LOG_FILE 
}
  
  
# and the DBA giveth to the worthy..............
Grant_DBA_CHAASE_Privs_on_PG_Schemas()
{        
# pg system permissions for me
$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST -a -c "$GRANT_USAGE on schema $PG_CATALOG to dba;"         >> $LOG_FILE  
$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST -a -c "$GRANT_USAGE on schema $PG_CATALOG to $CHAASE;"     >> $LOG_FILE  
$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST -a -c "$GRANT_USAGE on schema $INFORMATION_SCHEMA to dba;"     >> $LOG_FILE  
$PSQL -d $POSTGRES_SID -U $POSTGRES -h $TO_HOST -a -c "$GRANT_USAGE on schema $INFORMATION_SCHEMA to $CHAASE;"  >> $LOG_FILE  
}
  

Alter_Tablespace()
{
$PSQL -d $POSTGRES_SID -U $POSTGRES -a -c "$ALTER_TABLE $TABLE_NAME set tablespace $POSTGRES_TABLESPACE;"       >> $LOG_FILE   
}  

