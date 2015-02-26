#! /bin/bash 
#


#------------------------------------------------------------------------
# ******************* FUNCTION DEFINITIONS   *********************
#------------------------------------------------------------------------


Print_Header()
{
echo " "               > $LOG_FILE	  
Print_Dash_Line   
   echo "*** log BEGIN ***"   `date '+%m/%d/%y %A %X'`                       >> $LOG_FILE  	
   echo "Script      : "$0                                                   >> $LOG_FILE
   echo "Database    : "$POSTGRES_SID                                        >> $LOG_FILE	
   echo "Server      : "`uname -n`                                           >> $LOG_FILE
Print_Dash_Line
Print_Blank_Line	  
}

Print_Blank_Line()
{
   echo " " >> $LOG_FILE
}

Print_Dash_Line()
{
    echo "----------------------------------------------------------------"   >> $LOG_FILE
}

Print_Hash_Line()
{
   echo "#######################################################################" >> $LOG_FILE  
}

Print_Star_Line()
{
   echo "**********************************************************************" >> $LOG_FILE  
}
	

Print_Star_Blank_Line()
{
   echo "**                        **"                  >> $LOG_FILE 
}
	
Print_Header_SQL()
{
echo " "							                 > $LOG_FILE_SQL	      	
echo "*** log BEGIN ***"   `date '+%m/%d/%y %A %X'`                       >> $LOG_FILE_SQL 	
echo "Script      : "$0                                                   >> $LOG_FILE_SQL
echo "Database    : CLUSTER"                                              >> $LOG_FILE_SQL	
echo "Server      : "`uname -n`                                           >> $LOG_FILE_SQL	 
}


Print_Footer()
{
Print_Blank_Line
    echo "*** log END  ***"  `date '+%m/%d/%y %A %X'`                         >> $LOG_FILE
    echo "----------------------------------------------------------------"   >> $LOG_FILE
    echo "Script      : "$0                                                   >> $LOG_FILE
    echo "Database    : "$POSTGRES_SID                                        >> $LOG_FILE
    echo "Server      : "`uname -n`                                           >> $LOG_FILE
    echo "----------------------------------------------------------------"   >> $LOG_FILE
Print_Blank_Line
}


Print_Footer_SQL()
{
    echo "*** log END  ***"  `date '+%m/%d/%y %A %X'`                         >> $LOG_FILE_SQL
    echo "Script      : "$0                                                   >> $LOG_FILE_SQL
    echo "Database    : "$POSTGRES_SID                                        >> $LOG_FILE_SQL
    echo "Server      : "`uname -n`                                           >> $LOG_FILE_SQL
}


Check_GZIP_Status()
{	
Print_Blank_Line 	
echo "** GZIPing of DB Dump for Database: "  $POSTGRES_SID                   >> $LOG_FILE	
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
     echo "** Successful GZIPing of DB Dump file: "   $POSTGRES_SID  " Owner: " $FROM_OWNER      >> $LOG_FILE
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



Send_Email_To_DBA()
{
SUBJECT=$LOG_FILE
#echo $status | mailx -s "$SUBJECT"  "$MAIL_TO" < $LOG_FILE
if [ -f $LOG_FILE ]; then     
     echo $status | mailx -s "$SUBJECT" "$MAIL_TO" < $LOG_FILE
fi
if [ "$status" == " " ]; then	
   Print_Blank_Line  
   echo "** ERROR: DBA Email Bombing from DBA@" $HOST  >> $LOG_FILE
   Print_Blank_Line  
else
    echo " Sent email to : " $MAIL_TO   
fi    
}

Create_Backup_Directory()
{	
echo "***** Creating BUP DIR ... "         >> $LOG_FILE
if [ ! -d $PG_DUMP_DIR ]; then
     Print_Blank_Line 
     mkdir $PG_DUMP_DIR
     echo " ** Created dir: "           $PG_DUMP_DIR   >> $LOG_FILE
else
     Print_Blank_Line 
     echo "***** BUP DIR Exists... "    $PG_DUMP_DIR     >> $LOG_FILE
     Print_Blank_Line 

fi
}


Verify_Backup_Directory_Exists()
{	
echo "***** Verifying BUP DIR Exists... "         >> $LOG_FILE
if [ ! -d $PG_DUMP_DIR ]; then
   Print_Blank_Line 
   echo "***** ERROR: Missing DB BUP DIR: "  $POSTGRES_SID   >> $LOG_FILE
   Print_Blank_Line
   SUBJECT="** ERROR: Missing DB BUP DIR : " $0"_"$HOST"_"$LOGDATE
   Send_Email_To_DBA          

   Create_Backup_Directory

else
     Print_Blank_Line 
     echo "***** BUP DIR Exists... "/home/dba/tools/backup_scripts/POSTGRES/pg_dump_PARMS_DATABASE.bash "gina" "N" "Y" "Y"         >> $LOG_FILE
     Print_Blank_Line 
     echo "PB_DUMP_DIR = " $PG_DUMP_DIR  >> $LOG_FILE
fi
}


Check_PG_DUMP_Status()
{
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
