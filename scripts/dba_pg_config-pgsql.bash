#! /bin/bash -x
#
#**************************************************************************************
#
# File Name:  ~dba/tools/backup_scripts/POSTGRES/dba_pg_confg-pgsql.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~dba/tools/backup_scripts/POSTGRES/dba_pg_confg-pgsql.bash
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
#
#######################################################################################################
#
#  NEXT 
#       
#
#    1) cat /etc/redhat-release
#       uname -a 
#    2) l -la $PGDATA and $PGTBLSPC
#
#
#
# =========================================================================================================
#
# MODIFICATION HISTORY
# =======================
#
#  Date        Initials    Modification/Reason
#  =======     ========    ============================================================================
#
#  7/23/09   C. Haase    Initial version v0  
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
#  
#eval ./configure `pg_config --configure`
#
#
#----------------------------------------------------------------------------------------------------		


if [ "$#" -eq 0 ]; then
	echo "Usage: $0 file 1=PostgresSID 2=USERID 3=SCHEMA_NAME 4=DEBUG"
	exit 1
else
	export POSTGRES_SID=$1
        export USERID=$2
        export SCHEMA_NAME=$3
        export DEBUG=$4
fi


#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#

SOURCE=$HOME/DEV/POSTGRES
for EXPORT_NAME in $SOURCE/EXPORT*.bash; do
    source $EXPORT_NAME
done 

######################################################################### 


# =================> PostgreSQL PG Env vars  <========================
# export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
export DATA_DIR=$PGDATA
export EXPORT_DIR=$DB_EXPORT
export DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups
export DB_BUPS_PGSQL_SHARED=/san/dds/projects/database/shared/pgsqldata/database_backups
export FROM_OWNER="chaase"

export PG_LOG_DIR=$PGDATA


export OOPSIE='n'



#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------

	
# only reset these if on Seaside		
export DATA_DIR=$PGDATA
export EXPORT_DIR=$DB_EXPORT

export PG_DUMP_DIR=/san/local/database/pgsqldata/database_backups/$POSTGRES_SID	
export DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups
export DB_BUPS_PGSQL_SHARED=/san/dds/projects/database/shared/pgsqldata/database_backups
export FROM_OWNER="postgres"

export LOG_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
#export LOG_DIR=$HOME/tools/backup_scripts/POSTGRES
export LOG_FILE=$LOG_DIR/dba_pg_confg-pgsql.$HOST.$LOGDATE.log
export LOG_FILE_SQL=$LOG_DIR/dba_pg_confg-pgsql.$HOST.$LOGDATE.sql_log

Print_Header

#############################  DEBUG  ############################################# 
#if [ $DEBUG = $YES ]; then
#     Print_Hash_Line
#     echo "PSQL_CURRENT_TIMESTAMP: " echo $PSQL_CURRENT_TIMESTAMP    >> $LOG_FILE
#     echo "PSQL_NOW: " $PSQL_NOW                                     >> $LOG_FILE
#     Print_Hash_Line
#fi
#############################  DEBUG  ############################################# 

	
# set defaults to n then toggle back to y on host basis
export DO_PGSQL_CHECKS=$YES
export OOPSIE_PGSQL=$NO
export ON_SEASIDE=$NO

case "$HOST" in
      $HOST_DEV)                 
                export LOG_DIR=/home/chaase/tools/backup_scripts/POSTGRES
	        export DB_BUPS_PGSQL_SHARED=$DB_BUPS_PGSQL_LOCAL
                export FROM_OWNER=$CHAASE
                export ON_SEASIDE=$YES
	  ;;
	$HOST_DEVTEST)  
	        export DO_PGSQL_CHECKS=$YES               
           ;;	             
	$HOST_TESTPROD)  
	        export DO_PGSQL_CHECKS=$YES                
           ;;	  
	$HOST_TEST)  
	        export DO_PGSQL_CHECKS=$YES
           ;;		
	$HOST_PROD)  
	        export DO_PGSQL_CHECKS=$YES
	;;			
	*)  echo "What machine are you on???" >> $LOG_FILE  ;; 
	esac
	
#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------
#
#######################################################################
# THIS SECTION DOES THE POSTGRES STUFF .....................
#######################################################################
 
Print_Blank_Line 
Print_Blank_Line
echo "============================ DATABASE INFORMATION ============================" >> $LOG_FILE
Print_Blank_Line         
Print_Blank_Line  

cd $PG_DUMP_DIR


#############################  DEBUG  ############################################# 
if [ $DEBUG = $YES ]; then
   Print_Hash_Line
   
#   echo " =============> EMPTYING PGSQL Tables !! <================================"
#   Truncate_PGSQL_Tables   
#   echo " =============> EMPTYING PGSQL DBA Tables !! <============================"
#   Truncate_PGSQL_DBA_Tables 
   
   echo " =============> ZAPPING PGSQL Tables !! <===================================="
   Zap_PGSQL_Tables 
   
   echo " =============> ZAPPING PGSQL DBA Tables !! <================================"
   Zap_PGSQL_DBA_Tables 
   
   Print_Hash_Line
fi
#############################  DEBUG  ############################################# 


####for TABLENAME in  $PG_DATABASE ;  do
for TABLENAME in $PG_AUTHID $PG_DATABASE $PG_LANGUAGE $PG_NAMESPACE $PG_PLTEMPLATE $PG_ROLES $PG_TABLES $PG_TABLESPACE $PG_TYPE ; do
    RECORD_COUNT=0
    RECORD_COUNT_PG=0
    RECORD_COUNT_DBA=0
    CREATE_PG_TABLES=$NO
    TABLENAME_PGCATALOG=$PG_CATALOG"."$TABLENAME 
    TABLENAME_DBA=$TABLENAME"_dba"
    TABLE_NAME=$SCHEMA_NAME"."$TABLENAME   
     # Get current record count...Does the PG table exist??????????  
    RECORD_COUNT_PG=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $TABLE_NAME"`   >> $LOG_FILE_SQL
 
#############################  DEBUG  ####################################################### 
#if [ $DEBUG = $YES ]; then
#     Print_Hash_Line
#     echo " "					 		    >> $LOG_FILE;
#     echo "******************************************************"    >> $LOG_FILE;
#     echo " "					 		    >> $LOG_FILE;
#     echo "* PostgreSQL Database:   "  $POSTGRES_SID	   	    >> $LOG_FILE;
#     echo "* Table_Name:            "  $TABLE_NAME                    >> $LOG_FILE;
#     echo "* Current Record Count:  "  $RECORD_COUNT_PG               >> $LOG_FILE;
#     echo "* Record Count:          "  $RECORD_COUNT                  >> $LOG_FILE;
#     echo " "					 		    >> $LOG_FILE;
#     echo "******************************************************"    >> $LOG_FILE;
#     echo " "					 		    >> $LOG_FILE;
#     Print_Hash_Line
#fi
#############################  DEBUG  ###################################################### 

#    if [ $RECORD_COUNT_PG -eq 0 ]; then 
   if [ $RECORD_COUNT_PG -eq $NULL]; then 
         CREATE_PG_TABLES=$YES 
   fi 
   Do_PGSQL_Updates
    
done  



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
# Set the san local env var for dev, test and prods...
export DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups
export DB_BUPS_PGSQL_EXPORT=/san/local/database/pgsqldata/export
export DB_BUPS_PGSQL_BEEF=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
export DB_BUPS_PGSQL_WALLACE=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
export DB_BUPS_PGSQL_VOODOO=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
export DB_BUPS_PGSQL_MOJO=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID


#################################################################################
# this just here for notes.....................
#
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
#################################################################################



cd $PG_DUMP_DIR

case "$HOST" in
      $HOST_DEV)
        
        echo "*** Copying DB Dumps FROM Seaside TO Beef/Gromit"                                >> $LOG_FILE
#       scp -B -p -P 22 *$LOGDATE*  $TO_TEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
#       Check_SCP_Status
        echo "*** Copying DB Dumps FROM Seaside TO Wallace"                                    >> $LOG_FILE
#       scp -B -p -P 22 *$LOGDATE*  $TO_PROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
#       Check_SCP_Status
        
### OUTPUT_FILE=$PG_DUMP_DIR/$POSTGRES_SID.$TABLE_NAME.$HOST.$FROM_OWNER.$CSV.$LOGDATE.pg_dump.g
############                 gina_dba.gina_dba.pg_authid.seaside.CSV.2009-08-06_160812.pg_dump 
############                 gina_dba.gina_dba.pg_type.gromit.dba.CSV.2009-08-03_111 712.pg_dump.gz
      FILE_LIST=$POSTGRES_SID.$SCHEMA_NAME.$CSV.$LOGDATE.lst
      ls -1 *$CSV*.pg_dump* >  $FILE_LIST
      if [ ! -s $FILE_LIST ]; then
          echo " ** NO files to ingest "  >> $LOG_FILE   
      else
          # have at least 1 to suck in so loop through them 
          echo "** Beginning DBA File Ingest " >> $LOG_FILE                
          CREATE_DBA_TABLES=$NO
          CREATE_PG_TABLES=$NO
          for SOURCE_FILE in `cat $FILE_LIST`; do
              RECORD_COUNT_DBA=$NULL  
              gzip -d $SOURCE_FILE
              SOURCE_FILE_NAME=`echo $SOURCE_FILE | cut -d. -f3`          
              BASEFILENAME="`basename $SOURCE_FILE .gz`"     
              BASEFILENAME_FULL=$PG_DUMP_DIR"/"$BASEFILENAME
              SOURCE_FILE_NAME_FULL=$PG_DUMP_DIR"/"$SOURCE_FILE    
              TABLENAME_DBA=$SOURCE_FILE_NAME"_dba"
              TABLENAME_DBA_FULL=$SCHEMA_NAME"."$TABLENAME_DBA
              TABLENAME_PGCATALOG=$SOURCE_FILE_NAME
 
echo " BASEFILENAME: "          $BASEFILENAME                 >> $LOG_FILE      
echo " BASEFILENAME_FULL: "     $BASEFILENAME_FULL            >> $LOG_FILE     
echo " SOURCE_FILE: "           $SOURCE_FILE                  >> $LOG_FILE
echo " SOURCE_FILE_NAME_FULL: " $SOURCE_FILE_NAME_FULL        >> $LOG_FILE
echo " TABLENAME_DBA: "         $TABLENAME_DBA                >> $LOG_FILE
echo " TABLENAME_DBA_FULL: "    $TABLENAME_DBA_FULL           >> $LOG_FILE     

               # Get current record count...Does the PG table exist??????????  
               RECORD_COUNT_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $TABLENAME_DBA_FULL"`    >> $LOG_FILE_SQL
               if [ $RECORD_COUNT_DBA -eq $NULL]; then 
                    CREATE_DBA_TABLES=$YES              
                    Do_PGSQL_DBA_Creates
                    Check_PGSQL_Status
               else
		    # do DB Imports into pg_dba tables ONLY if did not just create them
                    Do_DB_Imports
                    Check_PGSQL_Status
               fi            
               CREATE_DBA_TABLES=$NO          
               # $PSQL -d $POSTGRES_SID -U $USERID -c "\copy $TABLENAME_DBA to '$OUTPUT_FILE' delimiter '|' null as ''" 
               # echo "** Successful Dumping of DB: " $POSTGRES_SID  " Schema: " $SCHEMA_NAME " To: " $PG_DUMP_DIR >> $LOG_FILE   
             
               # if typnamespace=11 or 99 then zap it.....system table, those do not count for my purposes
               if [ $TABLENAME_DBA_FULL = $PG_TYPE_DBA ] ; then
                     RECORD_COUNT_PG_TYPE_DELETED=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$DELETE from $TABLENAME_DBA_FULL where $TYPNAMESPACES_TO_IGNORE"`   >> $LOG_FILE 
               fi
               
             done
      
            # book'em danno
            TAR_FILE=$POSTGRES_SID.$SCHEMA_NAME.$CSV.$LOGDATE.tar
            TAR_GZIP_FILE=$TAR_FILE.gz
            echo "* TARing files in " $FILE_LIST " to " $TAR_FILE    >> $LOG_FILE 
            tar -cf $TAR_FILE *$CSV*.pg_dump $FILE_LIST
            echo "* GZIPing files in " $TAR_FILE                     >> $LOG_FILE   
            gzip $TAR_FILE
            Check_GZIP_Status
            echo "* Moving " $TAR_GZIP_FILE " to " $DB_BUPS_PGSQL_EXPORT   >> $LOG_FILE   
            mv $TAR_GZIP_FILE  $DB_BUPS_PGSQL_EXPORT                       >> $LOG_FILE 
            rm $PG_DUMP_DIR/*$LOGDATE*                                     >> $LOG_FILE 
       fi     
 
 
       #########################################################################################################
       #
       #  This section writes out to the SQL_LOG and does the QA stuff regardless of whether there were files
       #  to ingest or not.
       #
       #########################################################################################################
       
       Print_Header_SQL
       
#       for TABLENAME in $PG_AUTHID_DBA $PG_DATABASE_DBA $PG_LANGUAGE_DBA $PG_NAMESPACE_DBA $PG_PLTEMPLATE_DBA $PG_ROLES_DBA $PG_TABLES_DBA $PG_TABLESPACE_DBA $PG_TYPE_DBA;  do
#           RECORD_COUNT_AUTHID_DBA=0
 #          RECORD_COUNT_DATABASE_DBA=0
 #          TABLE_NAME_DBA=$TABLENAME"_dba"
#            TABLE_NAME_DBA=$SCHEMA_NAME"."$TABLENAME  

           RECORD_COUNT_AUTHID_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $PG_AUTHID_DBA"`       >> $LOG_FILE_SQL    
           RECORD_COUNT_DATABASE_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $PG_DATABASE_DBA"`   >> $LOG_FILE_SQL   
           RECORD_COUNT_LANGUAGE_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $PG_LANGUAGE_DBA"`    >> $LOG_FILE_SQL 
           RECORD_COUNT_NAMESPACE_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $PG_NAMESPACE_DBA"`   >> $LOG_FILE_SQL
           RECORD_COUNT_PLTEMPLATE_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $PG_PLTEMPLATE_DBA"`  >> $LOG_FILE_SQL
           RECORD_COUNT_ROLES_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $PG_ROLES_DBA"`           >> $LOG_FILE_SQL
           RECORD_COUNT_TABLES_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $PG_TABLES_DBA"`         >> $LOG_FILE_SQL
           RECORD_COUNT_TABLESPACE_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $PG_TABLESPACE_DBA"`  >> $LOG_FILE_SQL
           RECORD_COUNT_TYPE_DBA=`psql -d $POSTGRES_SID $PSQL_CSV_OPTIONS "$SELECT_COUNT_STAR from $PG_TYPE_DBA"`              >> $LOG_FILE_SQL
	   	  	   
	    ##############################################
	     #  Q & A Section
	     ##############################################
	     # NOTE:  PG_ROLES is really a pg system view on the table PG_AUTHID
             if [ $RECORD_COUNT_AUTHID_DBA -ne $RECORD_COUNT_ROLES_DBA ]; then
                  echo "*** ERROR: AUTHOID_DBA and ROLES_DBA record count are NOT equal !!!! "  >> $LOG_FILE_SQL
             fi
             echo "*** SUCCESS: AUTHID_DBA and ROLES_DBA record count ARE equal !!!! "          >> $LOG_FILE_SQL
	   
###  exit	 
	   
           # PG_AUTHID_DBA and PG_ROLES_DBA checks
	   
	   echo "*** SUCCESS: ROLES_DBA ROLES by HOST (distinct)"  >> $LOG_FILE_SQL
	   $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT rolname,host,rolsuper,rolcreatedb,rolcanlogin from $PG_ROLES_DBA order by rolname,host;" >> $LOG_FILE_SQL
	   # PG_DATABASE_DBA checks
	    echo "*** DATABASE_DBA DATNAME by HOST (distinct)"  >> $LOG_FILE_SQL
	    $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT datname,host  from $PG_DATABASE_DBA order by datname,host;"  >> $LOG_FILE_SQL
	
	    # PG_LANGUAGE_DBA checks
	     echo "*** LANGUAGE_DBA LANNAME by HOST (distinct)"  >> $LOG_FILE_SQL
	    $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT lanname,host  from $PG_LANGUAGE_DBA order by lanname,host;"  >> $LOG_FILE_SQL
	   
	    # PG_NAMESPACE_DBA checks
	     echo "*** LANGUAGE_DBA NSPNAME by HOST (distinct)"  >> $LOG_FILE_SQL
	    $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT nspname,host  from $PG_NAMESPACE_DBA order by nspname,host;"  >> $LOG_FILE_SQL
	    
	     # PG_TEMPLNAME_DBA checks
	     echo "*** TEMPLATE_DBA NSPNAME by HOST (distinct)"  >> $LOG_FILE_SQL
	     $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT tmplname,host  from $PG_PLTEMPLATE_DBA order by tmplname,host;"  >> $LOG_FILE_SQL
	    
	    # PG_TABLES_DBA checks
	     echo "*** TABLES_DBA SCHEMA by HOST (distinct)"  >> $LOG_FILE_SQL
	     $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT schemaname,tablename,host from $PG_TABLES_DBA order by schemaname,tablename,host;" >> $LOG_FILE_SQL
	     echo "*** TABLES_DBA NSPNAME by HOST (distinct)"  >> $LOG_FILE_SQL
	     $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT schemaname,tablename,tableowner,tablespace,host from $PG_TABLES_DBA order by schemaname,tablename,tableowner,host;" >> $LOG_FILE_SQL 
	   
             echo "*** TABLES_DBA NSPNAME by HOST (distinct)"  >> $LOG_FILE_SQL
	     $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT tablename,schemaname,tableowner,tablespace,host from $PG_TABLES_DBA order by tablename,schemaname,host;" >> $LOG_FILE_SQL
	     $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT schemaname,host from $PG_TABLES_DBA order by schemaname,host;"  >> $LOG_FILE_SQL
	     
	     # PG_TABLESPACE_DBA checks
	     echo "*** TABLESPACe_DBA SCHEMA by HOST (distinct)"  >> $LOG_FILE_SQL
	     $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT spcname,spcowner,spclocation,host from $PG_TABLESPACE_DBA order by spcname,host;"  >> $LOG_FILE_SQL
	     
             echo "*** TABLESPACE_DBA SCHEMA by HOST (distinct)"  >> $LOG_FILE_SQL
	     $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT spcname,spclocation,host from $PG_TABLESPACE_DBA order by spcname,host;" >> $LOG_FILE_SQL
	     
	     echo "*** TABLESPACE_DBA SCHEMA by HOST (distinct)"  >> $LOG_FILE_SQL
	     $PSQL -d $POSTGRES_SID -U $USERID -c "$SELECT_DISTINCT spcname,host from $PG_TABLESPACE_DBA order by spcname,host;"  >> $LOG_FILE_SQL
	     
             # skip for now...............PG_TYPE_DBA checks
	     
	   #     done

 	;;
	
      $HOST_DEVTEST)
      
      	    echo "*** Copying DB Dumps FROM Mojo TO Voodoo"                                    >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_TESTPROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
            Check_SCP_Status	 
                  
            echo "*** Copying DB Dumps FROM Mojo TO Beef/Gromit"                               >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_TEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
            
            echo "*** Copying DB Dumps FROM Mojo TO Wallace"                                   >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_PROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
            
            echo "*** Copying DB Dumps FROM Mojo TO Seaside"                                  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_DEV_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
	    
      
        ;;	
        
        $HOST_TESTPROD)
      
      	    echo "*** Copying DB Dumps FROM Voodoo TO Mojo"                                       >> $LOG_FILE
#           scp -B -p -P 22 *$LOGDATE*  $TO_TESTPROD_DBA:$DB_BUPS_PGSQL_NORTHPOLE/$POSTGRES_SID	
            scp -B -p -P 22 *$LOGDATE*  $TO_DEVTEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
            Check_SCP_Status	 
              
            echo "*** Copying DB Dumps FROM Voodoo TO Beef/Gromit"                                >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_TEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
            
            echo "*** Copying DB Dumps FROM Voodoo TO Wallace"                                     >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_PROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
            
            echo "*** Copying DB Dumps FROM Voodoo TO Seaside"                                     >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_DEV_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
	    Check_SCP_Status
      
        ;;	
	
	
      $HOST_TEST)
      
            echo "*** Copying DB Dumps FROM Beef/Gromit TO Wallace/Grallace"                       >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  $TO_PROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
            
	    for DB_NAME in gina_dba; do	    
	         echo "*** Copying DB Dumps FROM Beef/Gromit TO Seaside"                          >> $LOG_FILE
                 scp -B -p -P 22 *$LOGDATE*  $TO_DEV_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID			      
                 Check_SCP_Status
	    done
	    
      
        ;;
	
      $HOST_PROD)

                echo "*** Copying DB Dumps FROM Wallace/Grallace TO Beef/Gromit"                    >> $LOG_FILE
                scp -B -P 22 -p *$LOGDATE*  $TO_TEST_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        
                echo "*** Copying DB Dumps FROM Wallace/Grallace TO Seaside"                       >> $LOG_FILE
                scp -B -p -P 22 *$LOGDATE*  $TO_DEV_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
                Check_SCP_Status 
	
 	;;
	
	*)  echo "What machine are you on???"                                                      >> $LOG_FILE  ;; 
	esac
   
Check_SCP_Status


Send_Email_To_DBA

Print_Footer

exit





