#! /bin/bash -x
#
#------------------------------------------------------------------------
# ******************* FUNCTION DEFINITIONS   *********************
#------------------------------------------------------------------------
	


	
Check_MONGO_Status()
{
MONGO_STATUS=$?
if [ $MONGO_STATUS -ne $SE_SUCCESS ]; then
   Print_Blank_Line  
   echo "** ERROR: MONGO FAILED for Database: " $MONGO_SID  >> $LOG_FILE  
   Print_Blank_Line    
   SUBJECT="**ERROR: MONGO DIED: " $0"_"$HOST"_"$LOGDATE
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

Logrotate_MONGODB()
{
mongo localhost/admin -eval "db.runCommand({logRotate:1})"
}

#Get_MONGO_Databases()
#{
##MONGO_DATABASES=
#`/usr/bin/mongodb -l \#
 # | awk 'NF == 5 && \
#     $1 != "Name" && \
#     $1 != "template0" && \
 #    $2 == "|" && \
 #    $3 != "Owner" && \
 #    $4 == "|" && \
 #    $5 != "Encoding" \
 #    {print $1}' \
#  | sort`              
# 
#}

List_MONGO_Databases()
{

     MONGO_DUMP_DIR=$DB_BUPS_MONGO_LOCAL
     FROM_OWNER=$MONGODB
     
# WORKS      DB_LIST=echo 'show dbs' | $MONGO | awk '{print $1}'

# WORKS at command line:  mongo metadata --eval 'db.getCollectionNames()'
# WORKS at command line:  mongo metadata --eval 'db.getCollectionNames()' | sed 's/,/ /g'
# WORKS MOSTLY DB_LIST=`$MONGO --quiet -d $MONGO_SID --eval 'db.getCollectionNames()' | sed 's/,/ /g'`

DB_LIST=echo 'show dbs' | mongo | awk '{print $1}'
echo $DB_LIST

COLLECTION_LIST=echo 'show collections' | mongo metadata 


#for DB_NAME in $DB_LIST do
#    echo 'show collections' | mongo $DB_NAME 
    COLLECTION_LIST=echo 'show collections' | mongo metadata 
#done


# NOPE
#for COLLECTION_NAME in `$MONGO --quiet -d $MONGO_SID --eval
##'db.getCollectionNames()' | sed 's/,/ /g'`
#do   
#    mongoexport -d $MONGO_SID -c $COLLECTION_NAME > $COLLECTION_NAME.json
#done
 
#echo 'show collections' | mongo <dbname> --quiet

MONGOEXPORT_VERSION=`mongoexport --version | awk '{print $3}'`
MONGODB_VERSION=`mongo --version  | awk '{print $4}'`	


case "$MONGODB_VERSION" in     
      $MONGODB_VERSION_182) 
           export MONGODB_VERSION_FILE=$MONGODB_VERSION_182_FILE 
           ;;
      $MONGODB_VERSION_207)
            export MONGODB_VERSION_FILE=$MONGODB_VERSION_207_FILE
            ;;
      $MONGODB_VERSION_220)
            export MONGODB_VERSION_FILE=$MONGODB_VERSION_220_FILE
            ;;
      $MONGODB_VERSION_246)
            export MONGODB_VERSION_FILE=$MONGODB_VERSION_246_FILE
            ;;
      $MONGODB_VERSION_2413)
            export MONGODB_VERSION_FILE=$MONGODB_VERSION_2413_FILE
            ;;
  
      *)  echo "What MONGODB version are you on???" >> $LOG_FILE  
            ;; 
      esac
 
#echo " ** OUT List_MONGO_Databases "
}

