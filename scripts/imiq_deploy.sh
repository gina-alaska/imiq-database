#!/usr/bin/env bash
# 	This Script automates the backup of the database imiq_staging and
# and the deployment of imiq_production
# 
#   can be run on the database server with any user that exists there, and
# as a user in postgres with the right permissions 
#
# ./deploy <path to create backup at> <#jobs, defaults to 8>
#
# or 
# chage to user postgres before running
#
# rawser spicer
# 2017-09-22
#

## exit on failure
set -e 

## echo lines run
set -x 

## Variables


PATH_TO_BACKUPS=$1
if [ "$2" != "" ]; then
    N_JOBS=$2
else 
   N_JOBS=8
fi


## Get date
DATE=`date +%Y%m%d`

## Main db names
PROD='imiq_production'
STAGING='imiq_staging'

## Sql to rename databases
## Replace <source> with a database, and <dest> with what to rename it 
MOVE_DB_SQL="ALTER DATABASE <source> RENAME TO <dest>"

## create backup of imiq_staging
pg_dump -d $STAGING -j $N_JOBS -f $PATH_TO_BACKUPS/$STAGING-$DATE -F d 

## 	Move production temp 'backup' of production, will be dropped 
## at end. This step is probably not necassary.
TEMP_PROD_BACKUP="imiq_production_backup_$DATE"
### Replaces <sourcs> and <dest>
MOVE_TO_BACKUP="${MOVE_DB_SQL/<source>/$PROD}"
MOVE_TO_BACKUP="${MOVE_TO_BACKUP/<dest>/$TEMP_PROD_BACKUP}"

## Terminate active connections before renames
TERM_CON="SELECT pg_terminate_backend(pid) FROM <table> WHERE datname = '<db>';"
TERM_CON="${TERM_CON/<table>/pg_stat_activity}"

TEMR_PROD="${TERM_CON/<db>/$PROD}"
psql postgres -c "$TEMR_PROD"

psql postgres -c  "$MOVE_TO_BACKUP"

## Move staging to production
STAGING_TO_PROD="${MOVE_DB_SQL/<source>/$STAGING}"
STAGING_TO_PROD="${STAGING_TO_PROD/<dest>/$PROD}"


TEMR_STAGING="${TERM_CON/<db>/$STAGING}"
psql postgres -c "$TEMR_STAGING"

psql postgres -c  "$STAGING_TO_PROD"

## Drop temp 'backup' production. New production shold be in place at this point
dropdb $TEMP_PROD_BACKUP

## Restore staging
createdb $STAGING
pg_restore -d $STAGING -j $N_JOBS $PATH_TO_BACKUPS$STAGING-$DATE

## Ensure postgres owner ship
psql postgres -c 'ALTER DATABASE $PROD OWNER TO postgres'
psql postgres -c 'ALTER DATABASE $STAGING OWNER TO postgres'
