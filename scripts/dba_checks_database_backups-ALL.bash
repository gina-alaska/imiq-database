#!/bin/bash -x

#
# Environmental variables ==> SOURCE INCLUDE FILES
#
EXPORT_SOURCE=$HOME/tools/backup_scripts
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
  echo "sourcing: "  $EXPORT_NAME
  source $EXPORT_NAME
done 
# FORCE the per host env vars !!!!!!!!!!!!!!!!!!
source $EXPORT_SOURCE/EXPORT_GINA_HOSTS.bash



exit



# ==> mongodb.log.????-??-??T??-??-?? ==> mongodb.log.2014-04-07T12:01:00
for f in $MONGO_LOG_DIR/mongodb.log.????-??-??T??-??-??;
do
      gzip "$f.gz" "$f"
      rm -f "$f"
done


if [ $DAYS_TO_KEEP -gt "14" ] ; then
    log "performing archiving functions..."
    TO_DELETE=`find $BACKUP_PATH -name "*dump.tar*" -type f -mtime +$DAYS_TO_KEEP`
      if [ ! -z "$TO_DELETE" ] ; then
        log "deleting files older than $DAYS_TO_KEEP days:"       
        find $BACKUP_PATH -name "*dump.tar*" -type f -mtime +$DAYS_TO_KEEP -exec du -hs {} \; >> $LOG_FILE
        find $BACKUP_PATH -name "*dump.tar*" -type f -mtime +$DAYS_TO_KEEP -exec rm {} \;
      fi			"name" : "iarcod_current",

  else
    find $BACKUP_PATH -name "dump.tar" -exec rm {} \;
  fi


