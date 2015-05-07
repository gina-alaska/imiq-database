#! /bin/bash -x
#

#==============================================================================
#
#  2015/03/27   Deleted references to mojo,voodo,pod...these VMs no longer exist
#               also removed gina.arsc.edu (gina_catalog db) no longer exists
#
#===============================================================================

export PROD="prod"
export DEV="dev"
export TEST="test"
export DEVTEST="dev_test"
export CMS="cms"

export HOST_STATUS="DEV"
export DB_STATUS="DEV"
export PRIMARY="PRIMARY"
export STANDBY="STANDBY"
export BUP="BUP"
export MASTER="MASTER"
export SLAVE="SLAVE"

export POSTGRES="postgres"
export POSTGRES_USER="postgres"
export GINA_DBA="gina_dba"
export GINA_METADATA="gina_metadata"
export METADATA="metadata"
export DBA="dba"
export MONGODB="mongodb"
export MONGOD="mongod"
export SV="sv"
export SV_LW="sv_lw"
export SVPROD="svprod"
export SVWEB="svweb"
export SVADMIN="svadmin"
export METADATA_BASIC="metadata_basic"
# ORIG export METADATA_BASIC_FULL="gina_dba.metadata_basic"
export METADATA_BASIC_FULL="gina_metadata.metadata_basic"
export METADATA_MISC="metadata_misc"
# ORIG export METADATA_MISC_FULL="gina_dba.metadata_misc"
export METADATA_MISC_FULL="gina_metadata.metadata_misc"

export WHOAMI=`/usr/bin/whoami`

# hostname is not evaluated the same on different machines so gotta check...
export SEASIDE_FULL="seaside.gina.alaska.edu"

export YIN_FULL="yin.gina.alaska.edu"
export YANG_FULL="yang.gina.alaska.edu"

export GINA1_FULL="gina1.arsc.edu"
export IMIQDB_FULL="imiqdb.gina.alaska.edu"

export SIZONET_FULL="sizonet.gina.alaska.edu"

export PACMAN_FULL="pacman-vm.gina.alaska.edu"

export BOEM_FULL="boem.gina.alaska.edu"

export AEDI_CMS_FULL="aedi.gina.alaska.edu"
export AEDI_FULL="aedi.gina.alaska.edu"

export AKEVT_CMS_FULL="akevt.gina.alaska.edu"
export AKEVT_FULL="akevt.gina.alaska.edu"

export GEONET_FULL="geonet.gina.alaska.edu"

export DOOM_FULL="doom.x.gina.alaska.edu"
export GLOOM_FULL="gloom.x.gina.alaska.edu"
export DESPAIR_FULL="despair.x.gina.alaska.edu"

export PHILLY_FULL="philly.x.gina.alaska.edu"
export BAZINGA_FULL="bazinga.x.gina.alaska.edu"

export EBB_FULL="ebb.x.gina.alaska.edu"
export FLOW_FULL="flow.x.gina.alaska.edu"
export GIGO_FULL="gigo.x.gina.alaska.edu"

export GOOD_FULL="good.x.gina.alaska.edu"
export BAD_FULL="bad.x.gina.alaska.edu"
export UGLY_FULL="ugly.x.gina.alaska.edu"

# used to be on jdb (jay db)
export OSM_FULL="osm-db.x.gina.alaska.edu"


export SEASIDE="seaside"

export BROWSE="browse" 
export BROWSE_PROD="browse-prod"
# this is hostname on this machine...chef'd
export BROWSE_PROD_FULL="browse-prod-db0.x.gina.alaska.edu"
export YIN="yin"
export YANG="yang"
export SVDEV="svdev"
export SVPROD="svprod"
export GEONET="geonet"
export AEDI_CMS="aedi"
export AEDI="aedi"
export AKEVT="akevt"
export AKEVT_CMS="akevt"
export IMIQDB="imiqdb"
export IMIQ="imiq"
export SIZONET="sizonet"
export SIZONET_VM="sizonet-vm"
export PACMAN="pacman"
export PACMAN_VM="pacman-vm"
export BOEM="boem"
export OSM="osm"
export OSM_DB="osm-db"
export OSM_DBX="osqm-db.x"

export PHILLY="philly"
export PHILLY_X="philly.x"

export BAZINGA="bazinga"
export BAZINGA_X="bazinga.x"

export EBB="ebb"
export EBB_X="ebb.x"
export FLOW="flow"
export FLOW_X="flow.x"
export GIGO="gigo"
export GIGO_X="gigo.x"

export DOOM="doom"
export DOOM_X="doom.x"
export DOOMX="doomx"
export GLOOM="gloom"
export GLOOM_X="gloom.x"
export GLOOMX="gloomx"

export DESPAIR="despair"
export DESPAIR_X="despair.x"
export DESPAIRX="despairx"
export DESPAIR_SETC="despair-setc"
export DESPAIR_SCTC="despair-sctc"
export DESPAIR_NTC="despair-ntc"

export AGONY="agony"
# OLD export AGONY_FULL="suwa-sde-database.gina.alaska.edu"
export AGONY_FULL="sde0.gina.alaska.edu"

export GOOD="good"
export GOOD_X="good.x"
export BAD="bad"
export BAD_X="bad.x"
export UGLY="ugly"
export UGLY="ugly.x"


export PGHOST=$HOST
export MONGOHOST=$HOST

export  HOST_DEV=$SEASIDE
export  TO_DEV_DBA="chaase@seaside.gina.alaska.edu"

export  HOST_DEV_SV=$SVDEV
export  TO_DEV_SV_DBA="dba@svdev.gina.alaska.edu"

export  HOST_TEST=$YANG
export  TO_TEST_DBA="dba@yang.gina.alaska.edu"

#export  HOST_TESTPROD=TBD
export HOST_DEV_METADATA="seaside"
export TO_DEV_METADATA_DBA="chaase@seaside.gina.alaska.edu"

export HOST_PROD_METADATA_GEO="geonet"
export TO_PROD_METADATA_GEO_DBA="metadata@geonet.gina.alaska.edu"

export  HOST_PROD_SV=$SVPROD
export  TO_PROD_SV_DBA="dba@svprod.gina.alaska.edu"

export  HOST_PROD="yin"
export  TO_PROD_DBA="dba@yin.gina.alaska.edu"

export HOST_AEDI_CMS="aedi"
export HOST_AEDI="aedi"
export TO_AEDI_DBA="dba@aedi.gina.alaska.edu"
export TO_AEDI_CMS_DBA="dba@aedi.gina.alaska.edu"

export HOST_AKEVT_CMS="akevt"
export HOST_AKEVT="akevt"
export TO_AKEVT_DBA="dba@akevt.gina.alaska.edu"
export TO_AKEVT_CMS_DBA="dba@akevt.gina.alaska.edu"

export HOST_BOEM="boem"
export TO_BOEM_DBA="dba@boem.gina.alaska.edu"

export HOST_DOOM="doom"
export TO_DOOM_DBA="dba@doom.x.gina.alaska.edu"

export HOST_GLOOM="gloom"
export TO_GLOOM_DBA="dba@gloom.x.gina.alaska.edu"

### ArcSDE boxes - CLONES of my despair.x

export HOST_DESPAIR="despair"
export TO_DESPAIR_DBA="dba@despair.x.gina.alaska.edu"

export HOST_OSM="osm-db"
export HOST_OSM_FULL="osm-db.x.gina.alaska.edu"

#### DESPAIR.X/FSSN-SETC clones for EPSCOR ACE #########################

# OLD agony.x which was cloned from despair.x
export HOST_SDE0_FULL="sde0.gina.alaska.edu"
export SDE0_FULL="sde0.gina.alaska.edu"
export SDE0="sde0"

export HOST_DESPAIR_SETC="despair-setc"
export TO_DESPAIR_SETC_DBA="dba@fssn-setc.gina.alaska.edu"

##### Juneau --> SETC clones  fssn-setc.gina.alaska.edu  2204/
# HOST ---> pgdev-setc
export HOST_SETC_PGDEV="pgdev-setc"
export SETC_PGDEV="pgdev-setc"
export TO_SETC_PGDEV="dba@pgdev-setc.gina.alaska.edu"
# HOST ---> pg-setc  2204/
export HOST_SETC_PG="pg-setc"
export HOST_SETC="pg-setc"
export SETC_PG="pg-setc"
export TO_SETC_PG="dba@pg-setc.gina.alaska.edu"

##### Anchorage --> SCTC clones  fssn-sctc.gina.alaska.edu  2207/
export HOST_SCTC_PGDEV="despair-sctc"
export TO_SCTC_DBA="dba@fssn-sctc.gina.alaska.edu"

export HOST_SCTC_PG="pg-sctc"
export HOST_SCTC="pg-sctc"
export SCTC_PG="pg-sctc"
export SCTC_PG_FULL="pg-sctc.gina.alaska.edu"


#  NOT LIVE YET
export HOST_DESPAIR_NCTC="despair-nctc"
export TO_DESPAIR_NCTC_DBA="dba@fssn-nctc.gina.alaska.edu"

### DESPAIR.X  clones for EPSCOR ############################


### ArcSDE boxes - CLONES of my despair.x

export HOST_BAZINGA="bazinga"
export TO_BAZINGA_DBA="dba@bazinga.x.gina.alaska.edu"

export HOST_EBB="ebb"
export TO_EBB_DBA="dba@ebb.x.gina.alaska.edu"

export HOST_FLOW="flow"
export TO_FLOW_DBA="dba@flow.x.gina.alaska.edu"

export HOST_GIGO="gigo"
export TO_GIGO_DBA="dba@gigo.x.gina.alaska.edu"

export HOST_PHILLY="philly"
export TO_PHILLY_DBA="dba@philly.x.gina.alaska.edu"

export HOST_GOOD="good"
export HOST_GOOD_X="good.x"
export TO_GOOD_DBA="dba@good.x.gina.alaska.edu"

export HOST_BAD="bad"
export HOST_BAD_X="bad.x"
export TO_BAD_DBA="dba@bad.x.gina.alaska.edu"

export HOST_UGLY="ugly"
export HOST_UGLY_X="ugly.x"
export TO_UGLY_DBA="dba@ugly.x.gina.alaska.edu"

export HOST_SIZONET="sizonet"
export HOST_PACMAN="pacman-vm"
export HOST_PACMAN_VM="pacman-vm"
export HOST_IMIQDB="imiqdb"
export HOST_OSM="osm-db.x"

####### POSTGRESQL ENV vars

export PGBIN=/usr/bin

export PG_DUMP=$PGBIN/pg_dump
export PGDUMP=$PGBIN/pg_dump
export PG_DUMPALL=$PGBIN/pg_dumpall
export PSQL=$PGBIN/psql
export PG_CONTROLDATA=$PGBIN/pg_controldata
export PG_CONFIG=pg_config
export SHP2PGSQL=$PGBIN/shp2pgsql
export PGSQL2SHP=$PGBIN/pgsql2shp
export REINDEXDB=$PGBIN/reindexdb
export VACUUMDB=$PGBIN/vacuumdb
export VACUUMDB_OPTIONS_ALL="-z -f -e -v -d"
# at least this is true for 9 and up
export POSTGISBIN=/usr/pgsql-9.1/share/contrib/postgis-1.5
export SPATIAL_REF_SYS_SQL=spatial_ref_sys.sql
export POSTGIS_SQL=postgis.sql

export POSTGRES_DEFAULT=$POSTGRES

####### MONGODB ENV vars

export MONGOBIN=/usr/bin 

# all mongos installed in same dirs so far.... 1.8.2 version
export MONGO=$MONGOBIN/mongo
export MONGODUMP=$MONGOBIN/mongodump
export MONGOD=$MONGOBIN/mongod
export MONGOEXPORT=$MONGOBIN/mongoexport
export MONGOFILES=$MONGOBIN/mongofiles
export MONGOIMPORT=$MONGOBIN/mongoimport
export MONGORESTORE=$MONGOBIN/mongorestore
export MONGOSNIFF=$MONGOBIN/mongosniff
export MONGOSTAT=$MONGOBIN/mongostat
export MONGOS=$MONGOBIN/mongos
export MONGOD=$MONGOBIN/mongod
export MONGODB_PORT=27017
export MONGODB_REST=28017
export MONGODB_LOGIN=mongo
export MONGODB_PASSWORD=haha
export MONGODB_URL=hahahahaa
export DB_IP="127.0.0.1"
export DB_PORT=27017

export PUNK="$NO"


# typically the DBA account but not on all machines:  seaside, geonet

export HOME_MOI=/home/chaase
export HOME_DBA=/home/dba
export HOME_PG=/home/postgres
export HOME_NP=$HOME_MOI/northpole
export HOME_METADATA=/home/metadata
export HOME_MONGO=/home/mongodb
export HOME_MONGODB=/home/mongodb
export HOME_MONGOD=/home/mongod
export HOME_PGSQL=/var/lib/pgsql
export HOME_PGSQL_91=/var/lib/pgsql/9.1
export HOME_PGSQL_92=/var/lib/pgsql/9.2
export HOME_PGSQL_93=/var/lib/pgsql/9.3
export HOME_PGSQL_94=/var/lib/pgsql/9.4

# MONGODB STUFF 
export MONGODIR=/var/lib/mongodb
export MONGOLOG=/var/log/mongodb/mongodb.log
export MONGODATA=/var/lib/mongodb/data

# ====> NEED TO RESET THESE PER MACHINE
#MONGODUMP_PATH="/usr/bin/mongodump"
#MONGO_HOST="doom.x.gina.alaska.edu"

export DB_BUPS_MONGO_LOCAL=/var/lib/mongodb/dump
export MONGO_DUMP_DIR=$DB_BUPS_MONGO_LOCAL/$MONGO_SID

export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
export SOURCE_DIR=$HOME_DBA/tools/backup_scripts/POSTGRES

export DB_BUPS_PGSQL_LOCAL=/san/local/database/pgsqldata/database_backups
export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID

# typically the DBA account but not on all machines:  seaside, geonet
export MP=$HOME_DBA/tools/usgs/tools/bin/mp.lnx
export MP_CONFIG_FILE_DIR=$HOME_DBA/tools/usgs/tools/ext

export TEMP_ION=/san/local/database/pgsqldata/metadata/local/ION
  
export ON_SEASIDE=$NO

# ======> EXCEPTIONS ARE LISTED BELOW !!!!!!!!!!!
if [ $HOSTNAME == $SVDEV ]; then
        export HOST=$SVDEV   
        export HOSTNAME=$SVDEV_FULL
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
#       export SOURCE_DIR=$HOME_DBA/tools/backup_scripts/POSTGRES
elif [ $HOSTNAME == $SVPROD ]; then
        export HOST=$SVPROD
        export HOSTNAME=$SVPROD_FULL
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID

elif [ $HOSTNAME == $IMIQDB_FULL ]; then
        export HOST=$IMIQDB
        export DB_BUPS_PGSQL_LOCAL=/san/postgres/9.1/database_backups
        export PG_DUMP_DIR=/san/postgres/9.1/database_backups/$POSTGRES_SID
#       export SOURCE_DIR=$HOME_PG/tools/backup_scripts/POSTGRES
        export LOG_DIR=$PG_DUMP_DIR       
        # PG stuff           
        alias psql='/usr/pgsql-9.1/bin/psql'   
        export PSQL=/usr/pgsql-9.1/bin/psql                    
        export PGBIN=/usr/pgsql-9.1/bin
        export PGDATA=/var/lib/pgsql/9.1/data
        export PGLOG=$PGDATA/pg_log
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        # true for 9 and up
        export POSTGISBIN=/usr/pgsql-9.1/share/contrib/postgis-1.5
        export SPATIAL_REF_SYS=spatial_ref_sys.sql
        export POSTGIS_SQL=postgis.sql   
elif [ $HOSTNAME == $AEDI_FULL ]; then
        export HOST=$AEDI
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR
        export PGBIN=/usr/pgsql-9.1/bin
        export PG_DUMPALL=$PGBIN/pg_dumpall
elif [ $HOSTNAME == $AKEVT_FULL ]; then
        export HOST=$AKEVT
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR
        export PGBIN=/usr/pgsql-9.1/bin
        export PG_DUMPALL=$PGBIN/
elif [ $HOSTNAME == $BROWSE_PROD_FULL ]; then 
        export HOST="browse-prod-db0" 
        export EXPORT_SOURCE=/home/postgres/tools/backup_scripts
        export DB_BUPS_PGSQL_LOCAL=/home/postgres/database_backups
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR
        export PGBIN=/usr/pgsql-9.2/bin   #  9.2.6
        export PG_DUMPALL=$PGBIN/pg_dumpall       
elif [ $HOSTNAME == $SIZONET_FULL ]; then
        export HOST=$SIZONET
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR
        export PGBIN=/usr/bin
        export PG_DUMPALL=$PGBIN/pg_dumpall
# NO DBA ACCOUNT ON THIS MACHINE !!!!!!!!!!!!!!!!!
elif [ $HOSTNAME == $PACMAN_FULL ]; then
        export HOST=$PACMAN_VM 
        export HOME=/var/lib/pgsql
        export EXPORT_SOURCE=/var/lib/pgsql/tools/backup_scripts
        export DB_BUPS_PGSQL_LOCAL=/var/lib/pgsql/database_backups
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR
        export POSTGRES_VERSION_903="9.0.3"
        export POSTGRES_VERSION_903_FILE="903"
        export POSTGRES_VERSION="9.0.3"
        export PGBIN=/usr/pgsql-9.0/bin
        export PSQL=$PGBIN/psql
        export PG_DUMP=$PGBIN/pg_dump
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
#  was on jdb (jay db vm)        
 elif [ $HOSTNAME == $OSM_FULL ]; then
        export HOST="osm-db.x"
        export PGHOME=/var/lib/pgsql/9.2
        export EXPORT_SOURCE=/var/lib/pgsql/9.2/tools/backup_scripts
 #      export DB_BUPS_PGSQL_LOCAL=$PGHOME/backups
        export DB_BUPS_PGSQL_LOCAL=$PGHOME/database_backups
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR
        export PGSRC=/usr/pgsql-9.2
        export PGBIN=/usr/pgsql-9.2/bin      
        export PGDATA=/var/lib/pgsql/9.2/data
        alias start_pg='/usr/pgsql-9.2/bin/postmaster -p 5432 -D /var/lib/pgsql/9.2/data'
        export PG_DUMP=$PGBIN/pg_dump
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        export PSQL=$PGBIN/psql
        export PG_CONTROLDATA=$PGBIN/pg_controldata
        export PG_CONFIG=pg_config
        export REINDEXDB=$PGBIN/reindexdb
        export VACUUMDB=$PGBIN/vacuumdb
        export PGSHARE=/usr/pgsql-9.2/share
elif [ $HOSTNAME == $BOEM_FULL ]; then
        export HOST=$BOEM
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR
        export PGBIN=/usr/bin
        export PG_DUMPALL=$PGBIN/pg_dumpall
elif [ $HOSTNAME == $BAZINGA_FULL ] ; then
        export HOST=$BAZINGA
        export GINA_DIR=$HOME_DBA/scripts
        export SOURCE_DIR=$GINA_DIR
        export USERID=$METADATA
        export POSTGRES_SID=$GINA_DBA
#       export SCHEMA_NAME=$GINA_DBA
        export POSTGRES_SID="gina_dba"   
        # PG stuff
        alias psql='/usr/pgsql-9.3/bin/psql'
        export PSQL=/usr/pgsql-9.3/bin/psql
        export HOME_PGSQL=$HOME_PGSQL_93
        export PGBIN=/usr/pgsql-9.3/bin
        export PGBIN91=/usr/pgsql-9.1/bin
        export PG_DUMP=$PGBIN/pg_dump
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        export PGDUMPALL=$PGBIN/pg_dumpall
        export POSTGRES_VERSION="9.3.4"
        export PGLOG=$PGDATA/pg_log
        export PGSHARE=$PGBIN/share
        export PGEXTENSION=$PGSHARE/extension
        export PGCONTRIB=$PGSHARE/contrib
        export PGBULKLOAD_DIR=$PGCONTRIB/pg_bulkload-3.1.2
        export PGBULKLOADBIN=$PGBULKLOAD_DIR/bin
        export PGROUTING=$PGCONTRIB/pgrouting-2.0
        export POSTGIS_21=$PGCONTRIB/postgis-2.1
        # MP stuff
        export MP_HOME=$HOME_DBA/tools/usgs
        export MP=$MP_HOME/bin/mp.lnx
        export METADATA_CONFIG_FILE_DIR=$MP_HOME/ext
        export METADATA_CONFIG_FILE_NAME=ion_input_txt.cfg
        export METADATA_CONFIG_FILE=$METADATA_CONFIG_FILE_DIR/$METADATA_CONFIG_FILE_NAME     
        # SAXON stuff
        export RUN_SAXON='java -jar /home/dba/tools/metadata/saxonb9-1-0-8j/saxon9.jar'
        export XML_TO_JSON_XSL=/home/dba/scripts/GINA_METADATA/templates/xsl_files/xml-to-json.xsl
        export CSDGM_TO_ISO19115_XSLT=/home/dba/scripts/GINA_METADATA/templates/xsl_files/csdgm2iso19115-geonetwork.xslt 
       # METADATA stuff
        export SAN_DIR_METADATA=/san/local/database/metadata
        export HOME_METADATA=/home/dba
        export TEMP_ION=$SAN_DIR_METADATA/local/ION/$SENSOR
        export PROD_EXPORT_METADATA=$SAN_DIR_METADATA/export/htdocs/ION
        export LOCAL_EXPORT_METADATA=$SAN_DIR_METADATA/local/htdocs/ION
        export TEMPLATE_DIR=$HOME_METADATA/scripts/GINA_METADATA/templates/xml_files
        export SAN_DIR_LOCAL=/home/dba/local/database_backups    
        export DB_BUPS_PGSQL_LOCAL=$SAN_DIR_LOCAL/$POSTGRES_SID
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL
        export LOG_DIR=$DB_BUPS_PGSQL_LOCAL

        # MONGODB stuff        
        export HOME_MONGO=/usr/bin
        export MONGOBIN=$HOME_MONGO/bin
 
        export MONGO_DUMP_DIR=/home/dba/local/mongoddata/dump
        export MONGODATA=/home/dba/local/mongoddata/data
         
#elif [ $HOSTNAME == $GEONET_FULL ]; then
elif [ $HOSTNAME == $GEONET ]; then
        export HOST=$GEONET
        export HOSTNAME=$GEONET_FULL
        export HOME_METADATA=/home/metadata
        export EXPORT_SOURCE=/home/metadata/tools/backup_scripts
        export GINA_DIR=/home/metadata/scripts
        export SOURCE_DIR=/home/metadata/scripts
        export USERID=$METADATA
        export POSTGRES_SID=$GINA_DBA
#        export SCHEMA_NAME=$GINA_DBA
        export POSTGRES_SID="gina_dba"
        # MP stuff
        export MP_HOME=/home/metadata/tools/usgs
        export MP=$MP_HOME/bin/mp.lnx
        export METADATA_CONFIG_FILE_DIR=$MP_HOME/ext
        export METADATA_CONFIG_FILE_NAME=ion_input_txt.cfg
        export METADATA_CONFIG_FILE=$METADATA_CONFIG_FILE_DIR/$METADATA_CONFIG_FILE_NAME     
        # SAXON stuff
        export RUN_SAXON='java -jar /usr/local/geonetwork/web/geonetwork/WEB-INF/lib/saxon-9.1.0.8b-patch.jar'
        export XML_TO_JSON_XSL=/home/metadata/scripts/GINA_METADATA/templates/xsl_files/xml-to-json.xsl
        export CSDGM_TO_ISO19115_XSLT=/home/metadata/scripts/GINA_METADATA/templates/xsl_files/csdgm2iso19115-geonetwork.xslt 
        # METADATA stuff
        export SAN_DIR_METADATA=/home/metadata
        export TEMP_ION=$SAN_DIR_METADATA/local/ION/$SENSOR
        export PROD_EXPORT_METADATA=$SAN_DIR_METADATA/export/htdocs/ION
        export LOCAL_EXPORT_METADATA=$SAN_DIR_METADATA/local/htdocs/ION
        export TEMPLATE_DIR=$HOME_METADATA/scripts/GINA_METADATA/templates/xml_files
        export SAN_DIR_LOCAL=/var/lib/pgsql/9.3/database_backups
# ORIG  export SAN_DIR_LOCAL=/home/metadata/local/database_backups
     
        export DB_BUPS_PGSQL_LOCAL=$SAN_DIR_LOCAL
       
        export PGDUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
#        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL
        export LOG_DIR=$DB_BUPS_PGSQL_LOCAL
        
        export DF_DIR="\var"
        
        # PG stuff
        # upgraded from 9.1 to 9.3.6  11/20/2014
        alias psql='/usr/pgsql-9.3/bin/psql'
        export PSQL=/usr/pgsql-9.3/bin/psql
        export HOME_PGSQL=$HOME_PGSQL_93
        export PGBIN=/usr/pgsql-9.3/bin
        export PG_DUMP=$PGBIN/pg_dump
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        export PGDUMPALL=$PGBIN/pg_dumpall
        export POSTGRES_VERSION="9.3.6"
        export PGLOG=$PGDATA/pg_log
        export PGSHARE=$PGBIN/share
        export PGEXTENSION=$PGSHARE/extension
        export PGCONTRIB=$PGSHARE/contrib
        export PGBULKLOAD_DIR=$PGCONTRIB/pg_bulkload-3.1.2
        export PGBULKLOADBIN=$PGBULKLOAD_DIR/bin
        export PGROUTING=$PGCONTRIB/pgrouting-2.0
        export POSTGIS_21=$PGCONTRIB/postgis-2.1
        export PGDATA=/var/lib/pgsql-9.3/data
        alias start_pg='/usr/pgsql-9.3/bin/postmaster -p 5432 -D /var/lib/pgsql/9.3/data'
        alias sudo_postgres='sudo su postgres'         
         
        # MONGODB stuff        
 # OLD 2.2       export HOME_MONGO=/home/metadata/local/mongodb-linux-x86_64-2.2.0
 
        export HOME_MONGO=/usr
        export MONGOBIN=$HOME_MONGO/bin
        export MONGOCONF=/home/metadata/mongodb.conf
        export MONGO=$MONGOBIN/mongo
        export MONGODUMP=$MONGOBIN/mongodump
        export MONGOD=$MONGOBIN/mongod
        export MONGOEXPORT=$MONGOBIN/mongoexport
        export MONGOFILES=$MONGOBIN/mongofiles
        export MONGOIMPORT=$MONGOBIN/mongoimport
        export MONGORESTORE=$MONGOBIN/mongorestore  
        
        export MONGODB_SID="gina_dba"
        
        export MONGO_DUMP_DIR=/home/metadata/local/database_backups/mongodb/dump
        export BACKUP_DIR=$MONGO_DUMP_DIR/$MONGODB_SID
        
        export MONGODATA=/home/metadata/local/mongodb/data
        export MONGOLOG=/home/metadata/local/mongodb/log/mongodb.log
        
        export BACKUP_TMP=$MONGODUMP_DIR/tmp
        export BACKUP_DEST=$MONGODUMP_DIR  
        
           
# OLD 2.2  alias start_mongo='/home/metadata/local/mongodb-linux-x86_64-2.2.0/bin/mongod -f /home/metadata/mongodb.conf run'
        # new 2.4.13 install by root yum install
        alias start_mongo='usr/bin/mongod -f /home/metadata/mongodb.conf run'

#### something changed on yin/yang...both HOST and HOSTNAME are set to yin/yang already
elif [ $HOSTNAME == $YANG ]; then
         export HOST="yang"
 #        export HOSTNAME=$YANG_FULL
         export HOME_DIR=/home/dba
         export EXPORT_SOURCE=/home/dba/tools/backup_scripts
         export PGBIN=/usr/pgsql-9.0/bin
         export PSQL=$PGBIN/psql
         export PGDUMP=$PGBIN/pg_dump
         export PG_DUMP=$PGDUMP
         export PG_DUMPALL=$PGBIN/pg_dumpall
         export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_903_FILE
         export DF_DIR="\san"
elif [ $HOSTNAME == $YIN ]; then
         export HOST="yin"
#         export HOSTNAME=$YIN_FULL
         export HOME_DIR=/home/dba
         export EXPORT_SOURCE=/home/dba/tools/backup_scripts
         export PGBIN=/usr/pgsql-9.0/bin
         export PSQL=$PGBIN/psql
         export PGDUMP=$PGBIN/pg_dump
         export PG_DUMP=$PGDUMP
         export PG_DUMPALL=$PGBIN/pg_dumpall
         export DF_DIR="\san"
         export POSTGRES_VERSION_FILE=$POSTGRES_VERSION_903_FILE
          
###   PG & MONGODB DBA machines...

elif [ $HOSTNAME == $EBB_FULL ] ; then
        export HOST=$EBB
        
     # PG stuff
        # upgraded from 9.1 to 9.3.5  11/20/2014
        alias psql='/usr/pgsql-9.3/bin/psql'
        export PSQL=/usr/pgsql-9.3/bin/psql
        export HOME_PGSQL=$HOME_PGSQL_93
        export PGBIN=/usr/pgsql-9.3/bin
        export PG_DUMP=$PGBIN/pg_dump
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        export PGDUMPALL=$PGBIN/pg_dumpall
        export POSTGRES_VERSION="9.3.5"
        export PGLOG=$PGDATA/pg_log
        export PGSHARE=$PGBIN/share
        export PGEXTENSION=$PGSHARE/extension
        export PGCONTRIB=$PGSHARE/contrib
        export PGBULKLOAD_DIR=$PGCONTRIB/pg_bulkload-3.1.2
        export PGBULKLOADBIN=$PGBULKLOAD_DIR/bin
        export PGROUTING=$PGCONTRIB/pgrouting-2.0
        export POSTGIS_21=$PGCONTRIB/postgis-2.1
        export PGDATA=/var/lib/pgsql-9.3/data
        alias start_pg='/usr/pgsql-9.3/bin/postmaster -p 5432 -D /var/lib/pgsql/9.3/data'
        alias sudo_postgres='sudo su postgres'             
        
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$DB_BUPS_PGSQL_LOCAL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        
        
        
elif [ $HOSTNAME == $GIGO_FULL ] ; then
        export HOST=$GIGO
        
     # PG stuff
        # upgraded from 9.1 to 9.3.5  11/20/2014
        alias psql='/usr/pgsql-9.3/bin/psql'
        export PSQL=/usr/pgsql-9.3/bin/psql
        export HOME_PGSQL=$HOME_PGSQL_93
        export PGBIN=/usr/pgsql-9.3/bin
        export PG_DUMP=$PGBIN/pg_dump
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        export PGDUMPALL=$PGBIN/pg_dumpall
        export POSTGRES_VERSION="9.3.5"
        export PGLOG=$PGDATA/pg_log
        export PGSHARE=$PGBIN/share
        export PGEXTENSION=$PGSHARE/extension
        export PGCONTRIB=$PGSHARE/contrib
        export PGBULKLOAD_DIR=$PGCONTRIB/pg_bulkload-3.1.2
        export PGBULKLOADBIN=$PGBULKLOAD_DIR/bin
        export PGROUTING=$PGCONTRIB/pgrouting-2.0
        export POSTGIS_21=$PGCONTRIB/postgis-2.1
        export PGDATA=/var/lib/pgsql-9.3/data
        alias start_pg='/usr/pgsql-9.3/bin/postmaster -p 5432 -D /var/lib/pgsql/9.3/data'
        alias sudo_postgres='sudo su postgres'             
        
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$DB_BUPS_PGSQL_LOCAL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID   
          
elif [ $HOSTNAME == $FLOW_FULL ] ; then
        export HOST=$FLOW
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$DB_BUPS_PGSQL_LOCAL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID

elif [ $HOSTNAME == $PHILLY_FULL ] ; then
        export HOST=$PHILLY
        export DB_BUPS_PGSQL_LOCAL=/home/dba/database_backups
        export SAN_DIR_LOCAL=$DB_BUPS_PGSQL_LOCAL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID  
        # PG crap
        export HOME_PGSQL=$HOME_PGSQL_91
        export PGBIN=/usr/pgsql-9.1/bin
        export PGDATA=/usr/pgsql-9.1/data               
        # MONGODB stuff 
        # ====> as MONGODB
        alias start_mongo='/usr/bin/mongod -f /etc/mongod.conf'
        # ====> as MONGODB
        export MONGODATA=/var/lib/mongodb/data
        export MONGOLOG=/var/lib/mongodb/log/mongodb.log
        export MONGODUMP_DIR=/var/lib/mongodb/dump  
        ##  upgraded postgres 9.1 -> 9.3.4  4/22/2014 
        ##  upgraded mongodb 2.2 --> 2.4.6  4/22/2014     
elif [ $HOSTNAME == $DOOM_FULL ] ; then
        export HOST=$DOOM
        export HOME_DIR=$HOME
        export GINA_DIR=$HOME_DBA/northpole/scripts/GINA_METADATA/scripts
        export SOURCE_DIR=$GINA_DIR
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts  
        # MP crap 
        export HOME_METADATA=$HOME_PGSQL/metadata
        export TEMP_ION=$HOME_PGSQL/metadata/local/ION
        export TEMPLATE_DIR=$HOME_DBA/northpole/Metadata/GINA_METADATA/scripts
        export MP=$HOME_DBA/tools/usgs/bin/mp.lnx
        export METADATA_CONFIG_FILE_DIR=$HOME_DBA/tools/usgs/ext
        export METADATA_CONFIG_FILE_NAME=ion_input_txt.cfg
        export METADATA_CONFIG_FILE=$METADATA_CONFIG_FILE_DIR/$METADATA_CONFIG_FILE_NAME    
#       export  SAN_DIR_METADATA=/san/local/database/pgsqldata/metadata
         # SAXON stuff
        export RUN_SAXON='java -jar /home/dba/tools/metadata/saxonb9-1-0-8j/saxon9.jar'
        export XML_TO_JSON_XSL=/home/dba/scripts/GINA_METADATA/templates/xsl_files/xml-to-json.xsl
        export CSDGM_TO_ISO19115_XSLT=/home/dba/scripts/GINA_METADATA/templates/xsl_files/csdgm2iso19115-geonetwork.xslt 
        # PG crap
        alias psql='/usr/pgsql-9.3/bin/psql'
        export PSQL=/usr/pgsql-9.3/bin/psql
        export HOME_PGSQL=$HOME_PGSQL_93
        export PGBIN=/usr/pgsql-9.3/bin
        export PGBIN91=/usr/pgsql-9.1/bin
        export PG_DUMP=$PGBIN/pg_dump
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        export PGDUMPALL=$PGBIN/pg_dumpall
        export POSTGRES_VERSION="9.3.4"
        export PGLOG=$PGDATA/pg_log
        export PGSHARE=$PGBIN/share
        export PGEXTENSION=$PGSHARE/extension
        export PGCONTRIB=$PGSHARE/contrib
        export PGBULKLOAD_DIR=$PGCONTRIB/pg_bulkload-3.1.2
        export PGBULKLOADBIN=$PGBULKLOAD_DIR/bin
        export PGROUTING=$PGCONTRIB/pgrouting-2.0
        export POSTGIS_21=$PGCONTRIB/postgis-2.1
        export PGDATA=/mnt/db/pgsql/9.3/data
        export PGDATA91=/mnt/db/pgsql/9.1/data
        export DB_BUPS_PGSQL_LOCAL=/mnt/db/pgsql/9.3/database_backups
        export SAN_DIR_LOCAL=$HOME_PGSQL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        # MONGODB stuff        
        export MONGOBIN=/usr/bin
        export MONGODUMP_DIR=/mnt/db/mongodb/dump
        export MONGOLOG=/mnt/db/mongodb/log/mongodb.log
        export MONGODATA=/mnt/db/mongodb/data
        export MONGO=$MONGOBIN/mongo
        export MONGODUMP=$MONGOBIN/mongodump
        export MONGOD=$MONGOBIN/mongod
        export MONGOEXPORT=$MONGOBIN/mongoexport
        export MONGOFILES=$MONGOBIN/mongofiles
        export MONGOIMPORT=$MONGOBIN/mongoimport
        export MONGORESTORE=$MONGOBIN/mongorestore        
        export BACKUP_TMP=$MONGODUMP_DIR/tmp
        export BACKUP_DEST=$MONGODUMP_DIR
        # ======> as MONGODB
        alias start_mongodb='/usr/bin/mongod --quiet --journal --rest -f /home/mongodb/mongodb.conf run'
        export START_MONGO='/usr/bin/mongod --quiet --rest -f /home/mongodb/mongodb.conf run'
        # ======> as MONGODB
        alias mongo='$MONGOBIN/mongo'
	alias mongodump='$MONGOBIN/mongodump'
	alias mongoexport='$MONGOBIN/mongoexport'
	alias mongofiles='$MONGBIN/mongofiles'
	alias mongoimport='$MONGOBIN/mongoimport'
	alias mongorestore='$MONGOBIN/mongorestore'
	alias mongosniff='$MONGOBIN/mongosniff'
	alias mongostat='$MONGOBIN/mongostat'
	alias mongotop='$MONGOBIN/mongotop'               
 elif [ $HOSTNAME == $GLOOM_FULL ] ; then
        export HOST=$GLOOM
        export HOME_DIR=$HOME
        export GINA_DIR=$HOME_DBA/northpole/Metadata/GINA_METADATA/scripts/json
        export SOURCE_DIR=$GINA_DIR
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts 
        # PG crap
        export HOME_PGSQL=$HOME_PGSQL_91
        export PGBIN=$HOME_PGSQL/bin
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$HOME_PGSQL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        # MONGODB stuff        
        export MONGOBIN=/usr/bin
        export MONGODUMP_DIR=/var/lib/mongodb/dump
        export MONGO=$MONGOBIN/mongo
        export MONGODUMP=$MONGOBIN/mongodump
        export MONGOD=$MONGOBIN/mongod
        export MONGOEXPORT=$MONGOBIN/mongoexport
        export MONGOFILES=$MONGOBIN/mongofiles
        export MONGOIMPORT=$MONGOBIN/mongoimport
        export MONGORESTORE=$MONGOBIN/mongorestore        
        export BACKUP_TMP=$MONGODUMP_DIR/tmp
        export BACKUP_DEST=$MONGODUMP_DIR
        # MP crap 
        export TEMP_ION=$HOME_PGSQL/metadata/local/ION
        export TEMPLATE_DIR=$HOME_DBA/northpole/Metadata/GINA_METADATA/scripts/json
        export MP=$HOME_DBA/tools/tools/bin/mp.lnx
        export METADATA_CONFIG_FILE_DIR=$HOME_DBA/tools/tools/ext
        export METADATA_CONFIG_FILE_NAME=ion_input_txt.cfg
        export METADATA_CONFIG_FILE=$METADATA_CONFIG_FILE_DIR/$METADATA_CONFIG_FILE_NAME    
#        export  SAN_DIR_METADATA=/san/local/database/pgsqldata/metadata

##################    ArcSDE testbeds  ################## 

# PETE'S PLAYGROUND
elif [ $HOSTNAME == $DESPAIR_FULL ] ; then
#  10/23/2013 despair.x upgraded from 1) 9.1 --> 9.2.5   2) postgis 1.5 --> 2.1
        export HOST=$DESPAIR
        export HOST_DESPAIR=$DESPAIR
        export HOME_DIR=$HOME
        export GINA_DIR=$HOME_DBA/GINA_METADATA/scripts
        export SOURCE_DIR=$GINA_DIR
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        # PG crap
        export HOME_PGSQL=$HOME_PGSQL_92
        export PGBIN=$HOME_PGSQL/bin
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$HOME_PGSQL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR              
        alias psql='/usr/pgsql-9.2/bin/psql'   
        export PSQL=/usr/pgsql-9.2/bin/psql                    
        export PGBIN=/usr/pgsql-9.2/bin
        export PGDATA=/var/lib/pgsql/9.2/data
        export PGLOG=$PGDATA/pg_log
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        # true for 9 and up
        export POSTGISBIN=/usr/pgsql-9.2/share/contrib/postgis-2.1
        export SPATIAL_REF_SYS=spatial_ref_sys.sql
        export POSTGIS_SQL=postgis.sql   
# LIVE
elif [ $HOSTNAME == $SDE0_FULL ] ; then
# original HOSTNAME was agony.x AGONY_FULL
# HOSTNAME now sde0.gina.alaska.edu RESOLVES to at OS as suwa-sde-database.gina.alaska.edu 
#  10/21/13 hostname is sde0.gina.alaska.edu
#  10/23/2013 agony/suwa upgraded from  1) 9.1 --> 9.2.5  2) postgis 1.5 --> 2.1
        export HOST="suwa-sde"
        export HOST_AGONY="sde0-suwa-sde-agony"
        export HOME_DIR=$HOME
        export GINA_DIR=$HOME_DBA/GINA_METADATA/scripts
        export SOURCE_DIR=$GINA_DIR
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        # PG crap
        export HOME_PGSQL=$HOME_PGSQL_92
        export PGBIN=$HOME_PGSQL/bin
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$HOME_PGSQL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR              
        alias psql='/usr/pgsql-9.2/bin/psql'   
        export PSQL=/usr/pgsql-9.2/bin/psql                    
        export PGBIN=/usr/pgsql-9.2/bin
        export PGDATA=/var/lib/pgsql/9.2/data
        export PGLOG=$PGDATA/pg_log
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        # true for 9 and up
        export POSTGISBIN=/usr/pgsql-9.2/share/contrib/postgis-2.1
        export SPATIAL_REF_SYS=spatial_ref_sys.sql
        export POSTGIS_SQL=postgis.sql   
        
        export TO_HOST=$SDE0_FULL
        export DB_LIST="suwa_consultant"
        export DB_OWNER="suwa_updator"


# obsolete ??        
#elif [ $HOSTNAME == $DESPAIR_SETC ] ; then
#        export HOST=$DESPAIR_SETC
#        export HOST_DESPAIR=$DESPAIR_SETC
##        export HOME_DIR=$HOME
#        export GINA_DIR=$HOME_DBA/GINA_METADATA/scripts
#        export SOURCE_DIR=$GINA_DIR
#        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        # PG crap
 #       export HOME_PGSQL=$HOME_PGSQL_92
 #       export PGBIN=$HOME_PGSQL/bin
#        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
#        export SAN_DIR_LOCAL=$HOME_PGSQL
 #       export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
 #       export LOG_DIR=$PG_DUMP_DIR              
#        alias psql='/usr/pgsql-9.2/bin/psql'   
 #       export PSQL=/usr/pgsql-9.2/bin/psql                    
#        export PGBIN=/usr/pgsql-9.2/bin
#        export PGDATA=/var/lib/pgsql/9.2/data
 #       export PGLOG=$PGDATA/pg_log
 #       export PGDUMP=$PGBIN/pg_dump
#        export PG_DUMP=$PGBIN/pg_dump
        # true for 9 and up
#        export POSTGISBIN=/usr/pgsql-9.2/share/contrib/postgis-2.1
 #       export SPATIAL_REF_SYS=spatial_ref_sys.sql
 #       export POSTGIS_SQL=postgis.sql   
 
#         export TO_HOST=$SDE0_FULL
#         export DB_LIST="setc_seak_hydro"
 #        export DB_OWNER="kim"

# LIVE
elif [ $HOSTNAME == $SETC_PGDEV ] ; then
        export HOST=$SETC_PGDEV
        export HOME_DIR=$HOME
        export GINA_DIR=$HOME_DBA/GINA_METADATA/scripts
        export SOURCE_DIR=$GINA_DIR
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        # PG crap
        export HOME_PGSQL=$HOME_PGSQL_92
        export PGBIN=$HOME_PGSQL/bin
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$HOME_PGSQL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR              
        alias psql='/usr/pgsql-9.2/bin/psql'   
        export PSQL=/usr/pgsql-9.2/bin/psql                    
        export PGBIN=/usr/pgsql-9.2/bin
        export PGDATA=/var/lib/pgsql/9.2/data
        export PGLOG=$PGDATA/pg_log
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        # true for 9 and up
        export POSTGISBIN=/usr/pgsql-9.2/share/contrib/postgis-2.1
        export SPATIAL_REF_SYS=spatial_ref_sys.sql
        export POSTGIS_SQL=postgis.sql         
        export TO_HOST=$SETC_PGDEV
        export DB_LIST="seak_gis_library"
        export DB_OWNER="kim"
        
# LIVE  - JUNEAU    
#HOST_SETC_PG="pg-setc"
#SETC_PG="pg-setc"
elif [ $HOSTNAME == "pg-setc" ] ; then
        export HOST="pg-setc"
        export HOME_DIR=$HOME
        export GINA_DIR=$HOME_DBA/GINA_METADATA/scripts
        export SOURCE_DIR=$GINA_DIR
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        # PG crap
        export HOME_PGSQL=$HOME_PGSQL_92
        export PGBIN=$HOME_PGSQL/bin
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$HOME_PGSQL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR              
        alias psql='/usr/pgsql-9.2/bin/psql'   
        export PSQL=/usr/pgsql-9.2/bin/psql                    
        export PGBIN=/usr/pgsql-9.2/bin
        export PGDATA=/var/lib/pgsql/9.2/data
        export PGLOG=$PGDATA/pg_log
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        # true for 9 and up
        export POSTGISBIN=/usr/pgsql-9.2/share/contrib/postgis-2.1
        export SPATIAL_REF_SYS=spatial_ref_sys.sql
        export POSTGIS_SQL=postgis.sql   
        
        export TO_HOST=$SETC_PG
        export DB_LIST="TBD"
        export DB_OWNER="TBD"
  
# LIVE 2/6/14  pg 9.2.5  ANCHORAGE
# ORIG elif [ $HOSTNAME == $SCTC_PG ] ; then
elif [ $HOSTNAME == "pg-sctc" ] ; then
        export HOST="pg-sctc"
        export HOME_DIR=$HOME
        export GINA_DIR=$HOME_DBA/GINA_METADATA/scripts
        export SOURCE_DIR=$GINA_DIR
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        # PG crap
        export HOME_PGSQL=$HOME_PGSQL_92
        export PGBIN=$HOME_PGSQL/bin
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$HOME_PGSQL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR              
        alias psql='/usr/pgsql-9.2/bin/psql'   
        export PSQL=/usr/pgsql-9.2/bin/psql                    
        export PGBIN=/usr/pgsql-9.2/bin
        export PGDATA=/var/lib/pgsql/9.2/data
        export PGLOG=$PGDATA/pg_log
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        # true for 9 and up
        export POSTGISBIN=/usr/pgsql-9.2/share/contrib/postgis-2.1
        export SPATIAL_REF_SYS=spatial_ref_sys.sql
        export POSTGIS_SQL=postgis.sql 
        
        export TO_HOST=$SCTC_PG
        export DB_LIST="TBD"
        export DB_OWNER="TBD"
          
elif [ $HOSTNAME == $DESPAIR_NTC ] ; then
        export HOST=$DESPAIR_NTC
        export HOST_DESPAIR=$DESPAIR_NTC
        export HOME_DIR=$HOME
        export GINA_DIR=$HOME_DBA/GINA_METADATA/scripts
        export SOURCE_DIR=$GINA_DIR
        export EXPORT_SOURCE=$HOME_DBA/tools/backup_scripts
        # PG crap
        export HOME_PGSQL=$HOME_PGSQL_92
        export PGBIN=$HOME_PGSQL/bin
        export DB_BUPS_PGSQL_LOCAL=$HOME_DBA/database_backups
        export SAN_DIR_LOCAL=$HOME_PGSQL
        export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
        export LOG_DIR=$PG_DUMP_DIR              
        alias psql='/usr/pgsql-9.2/bin/psql'   
        export PSQL=/usr/pgsql-9.2/bin/psql                    
        export PGBIN=/usr/pgsql-9.2/bin
        export PGDATA=/var/lib/pgsql/9.2/data
        export PGLOG=$PGDATA/pg_log
        export PGDUMP=$PGBIN/pg_dump
        export PG_DUMP=$PGBIN/pg_dump
        export PG_DUMPALL=$PGBIN/pg_dumpall
        # true for 9 and up
        export POSTGISBIN=/usr/pgsql-9.2/share/contrib/postgis-2.1
        export SPATIAL_REF_SYS=spatial_ref_sys.sql
        export POSTGIS_SQL=postgis.sql   
 # NOT LIVE YET  

##################    ArcSDE testbeds   ################## 

###   start MONGODB PROD machines...
elif [ $HOSTNAME == $GOOD_FULL ] ; then
        export HOST=$GOOD_X
        export HOME_DIR=$HOME
#        export GINA_DIR=$HOME_MONGODB/northpole/Metadata/GINA_METADATA/scripts
#        export SOURCE_DIR=$GINA_DIR
         export EXPORT_SOURCE=$HOME_MONGODB/tools/backup_scripts          
        # MONGODB stuff        
#       export HOME_MONGO=/home/mongodb
        export MONGOBIN=/usr/bin
        export MONGODUMP_DIR=/var/lib/mongodb/dump
        export MONGO_DUMP_DIR=/var/lib/mongodb/dump
        export MONGO_LOG_DIR=/var/lib/mongodb/log
        export MONGO=$MONGOBIN/mongo
        export MONGODUMP=$MONGOBIN/mongodump
        export MONGOD=$MONGOBIN/mongod
        export MONGOEXPORT=$MONGOBIN/mongoexport
        export MONGOFILES=$MONGOBIN/mongofiles
        export MONGOIMPORT=$MONGOBIN/mongoimport
        export MONGORESTORE=$MONGOBIN/mongorestore        
        export PUNK="$YES"   
        export BACKUP_TMP=$MONGODUMP_DIR/tmp
        export BACKUP_DEST=$MONGODUMP_DIR     
        export DB_BUPS_MONGO_LOCAL=/var/lib/mongodb/dump   
        
        export DF_DIR="\var"
 
            
export ARCHIVE_DIR=/home/backups/mongodata_backups/mongodata/database_backups/mongodb_v220/$HOST/$MONGODB_SID
        
        export MONGODB_VERSION=$MONGODB_VERSION_220
        export MONGODB_VERSION_FILE="220"
        
        
elif [ $HOSTNAME == $BAD_FULL ] ; then
        export HOST=$BAD_X
        export HOME_DIR=$HOME
#        export GINA_DIR=$HOME_MONGODB/northpole/Metadata/GINA_METADATA/scripts
#        export SOURCE_DIR=$GINA_DIR

        export EXPORT_SOURCE=$HOME_MONGODB/tools/backup_scripts          

        # MONGODB stuff        
#       export HOME_MONGO=/home/mongodb
        export MONGOBIN=/usr/bin
        export MONGODUMP_DIR=/var/lib/mongodb/dump
        export MONGO_DUMP_DIR=/var/lib/mongodb/dump
        export MONGO_LOG_DIR=/var/lib/mongodb/log
        export MONGO=$MONGOBIN/mongo
        export MONGODUMP=$MONGOBIN/mongodump
        export MONGOD=$MONGOBIN/mongod
        export MONGOEXPORT=$MONGOBIN/mongoexport
        export MONGOFILES=$MONGOBIN/mongofiles
        export MONGOIMPORT=$MONGOBIN/mongoimport
        export MONGORESTORE=$MONGOBIN/mongorestore
        
        export PUNK="$YES"
    
        export BACKUP_TMP=$MONGODUMP_DIR/tmp
        export BACKUP_DEST=$MONGODUMP_DIR
     
        export DB_BUPS_MONGO_LOCAL=/var/lib/mongodb/dump    
        
        export DF_DIR="\var"
        
export ARCHIVE_DIR=/home/backups/mongodata_backups/mongodata/database_backups/mongodb_v220/$HOST/$MONGODB_SID

         
        export MONGODB_VERSION=$MONGODB_VERSION_220
        export MONGODB_VERSION_FILE="220"
            
elif [ $HOSTNAME == $UGLY_FULL ] ; then
        export HOST=$UGLY_X
          export HOME_DIR=$HOME
#        export GINA_DIR=$HOME_MONGODB/northpole/Metadata/GINA_METADATA/scripts
#        export SOURCE_DIR=$GINA_DIR

        export EXPORT_SOURCE=$HOME_MONGODB/tools/backup_scripts          

        # MONGODB stuff        
#       export HOME_MONGO=/home/mongodb
        export MONGOBIN=/usr/bin
        export MONGODUMP_DIR=/var/lib/mongodb/dump
        export MONGO_DUMP_DIR=/var/lib/mongodb/dump
        export MONGO_LOG_DIR=/var/lib/mongodb/log
        export MONGO=$MONGOBIN/mongo
        export MONGODUMP=$MONGOBIN/mongodump
        export MONGOD=$MONGOBIN/mongod
        export MONGOEXPORT=$MONGOBIN/mongoexport
        export MONGOFILES=$MONGOBIN/mongofiles
        export MONGOIMPORT=$MONGOBIN/mongoimport
        export MONGORESTORE=$MONGOBIN/mongorestore
        
        export PUNK="$YES"
    
        export BACKUP_TMP=$MONGODUMP_DIR/tmp
        export BACKUP_DEST=$MONGODUMP_DIR
     
        export DB_BUPS_MONGO_LOCAL=/var/lib/mongodb/dump    
        
        export DF_DIR="\var"
        
export ARCHIVE_DIR=/home/backups/mongodata_backups/mongodata/database_backups/mongodb_v220/$HOST/$MONGODB_SID

         
        export MONGODB_VERSION=$MONGODB_VERSION_220
        export MONGODB_VERSION_FILE="220"
        
##   end of MONGODB PROD machines...

elif [ $HOSTNAME == $SEASIDE_FULL ]; then
        export ON_SEASIDE=$YES
	     export HOST="seaside"

#if [ $DEBUG == $YES ]; then
    export HOME_MOI=/home/chaase
    export EXPORT_SOURCE=$HOME/tools/backup_scripts
    export SOURCE_DIR=$HOME_MOI/northpole/GINA_METADATA/scripts
#else
#   EXPORT_SOURCE=/mnt/raid/san/shared/northpole/tools/backup_scripts
#     export SOURCE_DIR=/mnt/raid/san/shared/northpole/GINA_METADATA/scripts   
#fi
         
         # this is important for metadata generation on seaside
          export SAN_DIR_LOCAL=/mnt/raid/san/local
          export SAN_DIR_SHARED=/mnt/raid/san/shared
          # this is important for backups on seaside
          export DB_BUPS_PGSQL_LOCAL=/mnt/raid/san/local/database/pgsqldata/database_backups
         
          export PGDUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
          export PG_DUMP_DIR=$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
			
         export GINA_DIR=$SOURCE_DIR
         export LOG_DIR=$SOURCE_DIR
         export TEMPLATE_DIR=$HOME_MOI/northpole/GINA_METADATA/templates/xml_files
         export TEMPLATE_DIR_XSL=$HOME_MOI/northpole/GINA_METADATA/templates/xsl_files

#       export DB_TYPE=$DBA
#       export POSTGRES_SID=$GINA_DBA
#       export SCHEMA_NAME=$GINA_DBA

        export POSTGRES_USER=$CHAASE
        export FROM_OWNER=$CHAASE
        export USERID=$CHAASE
        
       export DF_DIR="\mnt"

        
        # MP stuff
        export MP=$HOME_MOI/tools/metadata/usgs/bin/mp.lnx
        export METADATA_CONFIG_FILE_DIR=$HOME/tools/metadata/usgs/ext
        export METADATA_CONFIG_FILE_NAME=ion_input_txt.cfg
        export METADATA_CONFIG_FILE=$METADATA_CONFIG_FILE_DIR/$METADATA_CONFIG_FILE_NAME

        # METADATA stuff
        export SAN_DIR_METADATA=/mnt/raid/san/local/metadata
        export HOME_METADATA=$SAN_DIR_METADATA  
        export TEMP_ION=$SAN_DIR_METADATA/local/ION/$SENSOR
        export PROD_EXPORT_METADATA=$SAN_DIR_METADATA/export/htdocs/ION
        export LOCAL_EXPORT_METADATA=$SAN_DIR_METADATA/local/htdocs/ION
        export LOCAL_INGEST_METADATA=$SAN_DIR_METADATA/ingest/ION/$SENSOR/$YEAR_YYYY
        
         # SAXON stuff
         #  WORKS run_saxon  -s:AQUA1.A1.2004.12.24.1526.Dec.FGDC.detail.xml -xsl:/home/chaase/northpole/GINA_METADATA/templates/xsl_files/csdgm2iso19115-geonetwork.xslt  -o:tsetISO19115.xml
         export RUN_SAXON='java -jar /home/chaase/tools/metadata/saxonb9-1-0-8j/saxon9.jar'
         export XML_TO_JSON_XSL=/home/chaase/northpole/GINA_METADATA/templates/xsl_files/xml-to-json.xsl
         export CSDGM_TO_ISO19115_XSLT=/home/chaase/northpole/GINA_METADATA/templates/xsl_files/csdgm2iso19115-geonetwork.xslt 
              
       # PG stuff    
       ############ installed 9.2.5 11/5/2013; made it default pg version 11/6/2013  
       ############ installed 9.3.1 11/7/2013; made it default pg version 11/8/2013  
       ############ installed 9.3.2 12/9/2013; default pg version  
       ############ installed 9.3.4 4/22/2014; default pg version 
       ############ installed 9.4 10/24/2014; port 6432 NOT default pg version yet !!!!
       alias psql='/usr/pgsql-9.3/bin/psql'
       export PSQL=/usr/pgsql-9.3/bin/psql
       export PGBIN=/usr/pgsql-9.3/bin
       export PGBIN94=/usr/pgsql-9.4/bin
       export PSQL94=/usr/pgsql-9.4/bin/psql
       export PGDATA94=/mnt/raid/san/local/database/pgsqldata/data94
       export PGDATA=/mnt/raid/san/local/database/pgsqldata/data93
       export PGDUMP=$PGBIN/pg_dump
       export PG_DUMP=$PGBIN/pg_dump
       export PG_DUMPALL=$PGBIN/pg_dumpall
       export POSTGRES_VERSION="9.3.4"
       export PGLOG=$PGDATA/pg_log
       export PGSHARE=$PGBIN/share
       export PGEXTENSION=$PGSHARE/extension
       export PGCONTRIB=$PGSHARE/contrib
       export PGBULKLOAD_DIR=$PGCONTRIB/pg_bulkload-3.1.2
       export PGBULKLOADBIN=$PGBULKLOAD_DIR/bin
       export PGROUTING=$PGCONTRIB/pgrouting-2.0
       export POSTGIS_21=$PGCONTRIB/postgis-2.1


	# SQL POWER software envs
	export ARCHITECT_HOME=/home/chaase/tools/sql_power/architect-1.0.6
	alias run_architect='java -jar $ARCHITECT_HOME/architect.jar'
	export DQ_HOME=/home/chaase/tools/sql_power/dqguru-0.9.7
	alias run_dqguru='java -jar $ARCHITECT_HOME/dqguru.jar'
		
	# PENTAHO KETTLE STUFF - CE (COMMUNITY EDITION) pdi-ce-5.01-stable.zip ==> data-integration 
	alias run_spoon='/home/chaase/tools/pentaho/data-integration/spoon.sh & '
	alias run_kitchen='/home/chaase/tools/pentaho/data-integration/kitchen.sh &'
	alias run_pan='/home/chaase/tools/pentaho/data-integration/pan.sh &'
	alias run_carte='/home/chaase/tools/pentaho/data-integration/carte.sh &'
			
         # PENTAHO - KETTLE
         export PENTAHO_HOME=/home/chaase/tools/pentaho
         export KETTLE_HOME=/home/chaase/tools/pentaho/data-integration
#         export KETTLE_REPOSITORY=
 #        export KETTLE_USER=
#         export KETTLE_PASSWORD=
        
	# PENTAHO KETTLE STUFF - ENTERPRISE EDITION			
	# installation-summary.txt file. 
	# These files are found in the top-level Pentaho directory:
	# ctlscript.shStarts, stops, restarts, and shows the status of Pentaho services. Available on Linux and Mac only.
	# installation-summary.txt: Contains the information from the summary screen at the end of the installation process.
	# uninstall: A script that removes Pentaho Business Analytics.
       # BA Server: pentaho/server/biserver-ee/
	#alias pentaho_ee_ba_server='pentaho/server/biserver-ee/'
	# DI Server: pentaho/server/data-integration-server/
	# Report Designer: pentaho/design-tools/report-designer/
	# Schema Workbench: pentaho/design-tools/schema-workbench/
	# Data Integration (Spoon): pentaho/design-tools/data-integration/
	# Metadata Editor: pentaho/design-tools/metadata-editor/
	# Aggregation Designer: pentaho/design-tools/aggregation-designer/
	# Dashboard Designer: pentaho/server/biserver-ee/pentaho-solutions/system/dashboards/
	# Analyzer: pentaho/server/biserver-ee/pentaho-solutions/system/analyzer/
	# Interactive Reporting: pentaho/server/biserver-ee/pentaho-solutions/system/pentaho-interactive-reporting/
	# License Installer: pentaho/license/
	# Pentaho Mobile: pentaho/server/biserver-ee/pentaho-solutions/system/pentaho-mobile-plugin/
         # Location of logs:
		# BA Server Logs: pentaho/server/biserver-ee/logs/
		# Tomcat Logs for BA Server: pentaho/server/biserver-ee/tomcat/logs/
		# DI Server Logs: pentaho/server/data-integration-server/logs/
		# Tomcat Logs for DI Server: pentaho/server/data-integration-server/tomcat/logs/			
		# Default Port Numbers (your port numbers might differ if these ports are already used for other programs):
		# 5432: PostgreSQL Server
		# 8080: BA Server Tomcat Web Server Startup Port
		# 8012: BA Server Shutdown Port
		# 9080: DI Server Port   http://localhost:9080/pentaho-di
		# 9001: HSQL Server Port
		# 9092: Embedded H2 Database
		# 50000 or 50006: Monet Database Port
		# Note: The license installer can also be found in the report-designer, data-integration, and metadata-editor directories. All of these license installers perform the same functions, but are available in separate places to account for instances where only specific parts of Pentaho Business Analytics are installed to a particular machine. It does not matter which one you use. You can also install licenses through the Pentaho User Console. More information about license installation can be found in the next step.
			
			
         # NUODB stuff
#         export NUODB_HOME=/opt/nuodb
#         export NUODB_BIN=$NUODB_HOME/bin	
         #  as root or say sudo service nuowebconsole start
#         alias start_nuodb_webconsole='service nuowebconsole start'
#	alias start_nuodb_mgr='service nuodbmgr start'
#	alias nuosql='/opt/nuodb/bin/nuosql iarcod_nuodb --user chaase --password blahblah'
#	alias nuoloader='/opt/nuodb/bin/nuoloader'
#	alias stop_nuodb='service nuoagent stop'
			
	# RIAK stuff
#	export RIAK_START='riak start'
#	export RIAK_CONSOLE='riak console'
#	export RIAK_HOME='/usr/sbin/riak'
##	export RIAK_ADMIN='/usr/sbin/riak-admin'
##	export RIAK_DEBUG='/usr/sbin/riak-debug'
#	export RIAK_PING='riak ping'
#	export RIAK_DIAG='riak-admin diag'
#	alias riak_start='raik start'
#	alias riak_console='riak console'
#	alias riak_ping='riak ping'
	
	# COUCHDB stuff
#	export COUCHDB_BIN='/usr/bin/couchdb'
	# as chaase
#	alias start_couchdb_moi='sudo -i -u couchdb couchdb'
#	alias_couchdb_ini='couchdb -c'
	# as root
#	alias start_couchdb='service couchdb start'
#	alias couchdb_alive='curl http://127.0.0.1:5984/'
#	alias couchdb_all_dbs='curl -X GET http://127.0.0.1:5984/_all_dbs'
#	alias couchdb_create_database='curl -X PUT http://127.0.0.1:5984/gina_dba'
#	alias couchdb_delete_database='curl -X DELETE http://127.0.0.1:5984/gina_dba'
#	alias load_futon:'http://127.0.0.1:5984/_utils/'
#	alias curl_uuid='curl -X GET http://127.0.0.1:5984/_uuids'
 
 			# APACHE HADOOP  stuff
         #       
         # PIG
#         PIG_CONF_DIR
#        export PIG=/usr/bin/pig

        
export ARCHIVE_DIR=/home/backups/mongodata_backups/mongodata/database_backups/mongodb_v220/seaside/$MONGODB_SID
        
        export MONGO_DUMP_DIR=$SAN_DIR_LOCAL/database/mongodb/dump
        export MONGO_LOG_DIR=$SAN_DIR_LOCAL/database/mongodb/log
        
export BACKUP_TMP=$MONGODUMP_DIR/tmp
export BACKUP_DEST=$MONGODUMP_DIR
     
#        export DB_BUPS_MONGO_LOCAL=/var/lib/mongodb/dump     
#        export MONGODB_VERSION=$MONGODB_VERSION_246
#        export MONGODB_VERSION_FILE="246"

# 2.4.6 ==> 4/22/2014 
# /usr/bin/mongo
# /usr/bin/mongo_console
# /usr/bin/mongodump
# /usr/bin/mongoexport
# /usr/bin/mongofiles
# /usr/bin/mongoimport
# /usr/bin/mongooplog
# /usr/bin/mongoose
# /usr/bin/mongoperf
# /usr/bin/mongorestore
# /usr/bin/mongosniff
# /usr/bin/mongostat
# /usr/bin/mongotop
# /usr/bin/montage

 
       
else
	export HOST=$HOSTNAME
fi



export LOG_FILE_MONGODUMP_DATABASE=$MONGODB_SID.$HOST.ALL.$MONGODB.$OPTION_STRING_FILE-$MONGODB_VERSION_FILE.$LOGDATE.json
export LOG_FILE_MONGODUMP_SCHEMA=$MONGODB_SID.$SCHEMA_NAME.SCHEMA.$HOST.$MONGODB.$OPTION_STRING_FILE-$MONGODB_VERSION_FILE.$LOGDATE.json
export LOG_FILE_MONGODUMP_TABLE=$MONGODB_SID.$TABLE_NAME_FULL.TABLE.$HOST.$MONGODB.$OPTION_STRING_FILE-$MONGODB_VERSION_FILE.$LOGDATE.json


#echo "MONGO_DUMP_DIR: "  $MONGO_DUMP_DIR
#echo "MONGODUMP_FILE: "  $MONGO_DUMP_FILE
#echo "MONGODUMP: "       $MONGODUMP
#echo "MONGOBIN: "        $MONGOBIN


#export LOG_FILE_TMP=`echo $0 | cut -d/ -f2`
#export LOG_FILE=$LOG_FILE_TMP"_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"
LOG_FILE_BASENAME="`basename $0 .bash`"
export LOG_FILE=$LOG_FILE_BASENAME".bash_"$HOST"_"$POSTGRES_SID"_"$LOGDATE".log"

export LOG_DIR=$HOME/tools/backup_scripts/POSTGRES
if [ $WHOAMI == "postgres" ] ; then
     export LOG_DIR=/var/lib/pgsql/tools  
fi

#OPTION_STRING_FILE="-c","-g","-r","-s","-t","-ac"

#export LOG_FILE_PGDUMP_ALL=$POSTGRES_SID.CLUSTER.$HOST.$FROM_OWNER."-c"-$POSTGRES_VERSION_FILE-$LOGDATE.pg_dumpall
#export LOG_FILE_PGDUMP_ALL=$POSTGRES_SID.CLUSTER.$HOST.$FROM_OWNER.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE-$LOGDATE.pg_dumpall

export LOG_FILE_PGDUMP_ALL_CLUSTER=$POSTGRES_SID.CLUSTER.ALL.$HOST.$POSTGRES."-c"-$POSTGRES_VERSION_FILE-$LOGDATE.pg_dumpall

export LOG_FILE_PGDUMP_ALL_GLOBAL=$POSTGRES_SID.CLUSTER.GLOBAL.$HOST.$POSTGRES."-g"-$POSTGRES_VERSION_FILE-$LOGDATE.pg_dumpall
export LOG_FILE_PGDUMP_ALL_ROLES=$POSTGRES_SID.CLUSTER.ROLES.$HOST.$POSTGRES."-r"-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dumpall
export LOG_FILE_PGDUMP_ALL_SCHEMA=$POSTGRES_SID.CLUSTER.SCHEMA.$HOST.$POSTGRES."-s"-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dumpall
export LOG_FILE_PGDUMP_ALL_TBLSPC=$POSTGRES_SID.CLUSTER.TBLSPC.$HOST.$POSTGRES."-t"-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dumpall
export LOG_FILE_PGDUMP_ALL_DATA=$POSTGRES_SID.CLUSTER.DATA.$HOST.$POSTGRES."-ac"-$POSTGRES_VERSION_FILE.$LOGDATE.pg_dumpall


export DB_BUPS_PGSQL_SEASIDE=$PG_DUMP_DIR
export DB_BUPS_PGSQL_YIN=$PG_DUMP_DIR
export DB_BUPS_PGSQL_YANG=$PG_DUMP_DIR
export DB_BUPS_PGSQL_SVPROD=$PG_DUMP_DIR
export DB_BUPS_PGSQL_SVDEV=$PG_DUMP_DIR
export DB_BUPS_PGSQL_GOS==$PG_DUMP_DIR
export DB_BUPS_PGSQL_GEO==$PG_DUMP_DIR
export DB_BUPS_PGSQL_AEDI_CMS=$PG_DUMP_DIR
export DB_BUPS_PGSQL_AEDI=$PG_DUMP_DIR
export DB_BUPS_PGSQL_AKEVT_CMS=$PG_DUMP_DIR
export DB_BUPS_PGSQL_AKEVT=$PG_DUMP_DIR


export DB_BUPS_PGSQL_DOOM=$PG_DUMP_DIR
export DB_BUPS_PGSQL_PHILLY=$PG_DUMP_DIR
export DB_BUPS_PGSQL_EBB=$PG_DUMP_DIR
export DB_BUPS_PGSQL_FLOW=$PG_DUMP_DIR

export PG_LOG_FILES=CLUSTER.$HOST.PG_LOG_FILES.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.log
export PG_CONFIG_FILES=CLUSTER.$HOST.PG_CONFIG_FILES.$POSTGRES.$OPTION_STRING_FILE-$POSTGRES_VERSION_FILE.$LOGDATE.log
	
#echo "SAN_DIR_LOCAL:"  $SAN_DIR_LOCAL


REMOTE_SCP_PGDUMP()
{

   # Set the san local env var for dev, test and prods...
    cd $PG_DUMP_DIR
    gzip  $PG_DUMP_DIR/*.pg_dump

    echo "HOST:        "  $HOST
    echo "PG_DUMP_DIR: "  $PG_DUMP_DIR

    case "$HOST" in

           $HOST_DEV)

 #            gzip  $PG_DUMP_DIR/*.pg_dump 

             echo "*** Copying DB Dumps FROM Seaside TO DOOM"  >> $LOG_FILE
             scp -B -p -P 22 *$LOGDATE*  dba@doom.x.gina.alaska.edu:/home/dba/san/local/database/pgsqldata/database_backups/$POSTGRES_SID

 

#             echo "*** Copying DB Dumps FROM Seaside TO Yin"  >> $LOG_FILE
 #             scp -B -p -P 22 *$LOGDATE*  $TO_PROD_DBA:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID	
      
 	;;
       # AEDI_CMS
       $HOST_AEDI)

           echo "*** Copying DB Dumps FROM aedi TO Seaside"  >> $LOG_FILE
          scp -B -p -P 22 *$LOGDATE* chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID

           echo "*** Copying DB Dumps FROM aedi TO Yin"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yin:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 
            
            echo "*** Copying DB Dumps FROM aedi TO Yang"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yang:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 

      ;;
      
       # SIZONET is CMS
       $HOST_SIZONET)

 #          echo "*** Copying DB Dumps FROM sizonet TO Seaside"  >> $LOG_FILE
#          scp -B -p -P 22 *$LOGDATE* chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
#           Check_SCP_Status	
        
            echo "*** Copying DB Dumps FROM sizonet TO Yin"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yin:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 
            
            echo "*** Copying DB Dumps FROM sizonet TO Yang"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yang:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 

      ;;

      # PACMAN-VM is CMS
       $HOST_PACMAN)

           echo "*** Copying DB Dumps FROM PACMAN TO Seaside"  >> $LOG_FILE
           scp -B -p -P 22 *$LOGDATE* chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
#           Check_SCP_Status	
    
            echo "*** Copying DB Dumps FROM PACMAN TO Yin"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yin:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 
            
            echo "*** Copying DB Dumps FROM PACMAN TO Yang"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yang:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 

      ;;

       # FSSN Juneau
          $HOST_SETC)

            echo "*** Copying DB Dumps FROM FSSN_SETC TO seaside backup directory"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE* chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
 
     ;;

         # FSSN Anchorage
         $HOST_SCTC)

            echo "*** Copying DB Dumps FROM FSSN SCTC TO seaside backup directory"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE* chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID

     ;;

       # imiqdb.gina.alaska.edu
       $HOST_IMIQ)

           echo "*** Copying DB Dumps FROM IMIQ TO Seaside"  >> $LOG_FILE
           scp -B -p -P 22 *$LOGDATE* chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
       
 #           echo "*** Copying DB Dumps FROM IMIQ TO Yin"  >> $LOG_FILE
 #           scp -B -p -P 22 *$LOGDATE*  dba@yin:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 
            
 #         echo "*** Copying DB Dumps FROM IMIQ TO Yang"  >> $LOG_FILE
 #           scp -B -p -P 22 *$LOGDATE*  dba@yang:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 

      ;;


     # BOEM is CMS
       $HOST_BOEM)
     
            echo "*** Copying DB Dumps FROM BOEM TO Yin"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yin:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 
            
          echo "*** Copying DB Dumps FROM BOEM TO Yang"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yang:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 

      ;;

       $HOST_AKEVT)
       
#           echo "*** Copying DB Dumps FROM akevt TO Seaside"  >> $LOG_FILE
#            scp -B -p -P 22 *$LOGDATE* chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
#           Check_SCP_Status	


            echo "*** Copying DB Dumps FROM akevt TO Yin"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yin:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 
            
            echo "*** Copying DB Dumps FROM akevt TO Yang"  >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yang:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID 
 

      ;;

     # GEONET
      $HOST_PROD_METADATA_GEO)
	
           echo "*** Copying DB Dumps FROM Geonet TO Seaside"  >> $LOG_FILE
           scp -B -p -P 22 *$LOGDATE* chaase@seaside:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
           Check_SCP_Status	


 

      ;;

   
	   # currently is yang.gina.alaska.edu
      $HOST_TEST)

             gzip  $PG_DUMP_DIR/*.pg_dump 

            echo "*** Copying DB Dumps FROM Yang TO Yin" >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  dba@yin.gina.alaska.edu:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
            Check_SCP_Status
            
            echo "*** Copying DB Dumps FROM Yang TO Seaside" >> $LOG_FILE
            scp -B -p -P 22 *$LOGDATE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID			      
            Check_SCP_Status   
     
        ;;

  
	  #  currently yin.gina.alaska.edu
      $HOST_PROD)


                gzip  $PG_DUMP_DIR/*.pg_dump 
    
               echo "*** Copying DB Dumps FROM Yin TO Yang" >> $LOG_FILE
                scp -B -P 22 -p *$LOGDATE*  dba@yang.gina.alaska.edu:$DB_BUPS_PGSQL_LOCAL/$POSTGRES_SID
       
                echo "*** Copying DB Dumps FROM Yin TO Seaside" >> $LOG_FILE
                 scp -B -p -P 22 *$LOGDATE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
 #               Check_SCP_Status 

 
 	;;

         $HOST_PROD_SV)

  
                 gzip  $PG_DUMP_DIR/*.pg_dump 
 
       
#  #              echo "*** Copying DB Dumps FROM SVPROD TO Seaside" >> $LOG_FILE
#  #               scp -B -p -P 22 *$LOGDATE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
 # #              Check_SCP_Status 

#  #              echo "*** Copying DB Dumps FROM SVPROD TO GEONET"  >> $LOG_FILE
#  #               scp -B -p -P 22 *$LOGDATE*  metadata@geonet.gina.alaska.edu:/home/metadata/local/database_backups/$POSTGRES_SID	
#  #              Check_SCP_Status 
	

                 echo "*** Copying DB Dumps FROM SVPROD TO YIN "  >> $LOG_FILE
                 scp -B -p -P 22 *$LOGDATE*  dba@yin.gina.alaska.edu:/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
                  Check_SCP_Status 

### =========>
### =========> CAVEAT for SV.....delete from SVPROD so won't possibly impact SV production !!!!!!!!!!!!!!!!!!!!
### =========>

         rm *$LOGDATE*.gz
	
 	;;

      $HOST_DEV_SV)

                gzip  $PG_DUMP_DIR/*.pg_dump 
  
#                echo "*** Copying DB Dumps FROM SVPROD TO Seaside" >> $LOG_FILE
#                scp -B -p -P 22 *$LOGDATE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
#                Check_SCP_Status 

#                echo "*** Copying DB Dumps FROM SVDEV TO GEONET"  >> $LOG_FILE
#                scp -B -p -P 22 *$LOGDATE*  metadata@geonet.gina.alaska.edu:/home/backups/pgdata_backups/pgsqldata/database_backups/$POSTGRES_SID	
#                Check_SCP_Status 
	
 
### =========>
### =========> CAVEAT for SV.....delete from SVDEV so won't possibly impact SV development !!!!!!!!!!!!!!!!!!!!
### =========>

		rm *$LOGDATE*

	     ;;


      $HOST_DESPAIR)

                gzip  $PG_DUMP_DIR/*.pg_dump 

                echo "*** Copying DB Dumps FROM HOST_DESPAIR TO Seaside" >> $LOG_FILE
               scp -B -p -P 22 *$LOGDATE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID			      
               Check_SCP_Status

               rm *$LOGDATE*

	     ;;
	     
	     
	     $HOST_AGONY)
	     
	                  gzip  $PG_DUMP_DIR/*.pg_dump 

               echo "*** Copying DB Dumps FROM HOST_agony TO Seaside" >> $LOG_FILE
               scp -B -p -P 22 *$LOGDATE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID			      
               Check_SCP_Status

 #               echo "*** Copying DB Dumps FROM HOST_DESPAIR TO POD"  >> $LOG_FILE
 #               scp -B -p -P 22 *$LOGDATE*  backups@pod1.gina.alaska.edu:/home/backups/pgdata_backups/pgsqldata/database_backups/$POSTGRES_SID	
 #               Check_SCP_Status 
	     
	     ;;
	     
     $HOST_DOOM)

                gzip  $PG_DUMP_DIR/*.pg_dump 

                echo "*** Copying DB Dumps FROM DOOM TO Seaside" >> $LOG_FILE
               scp -B -p -P 22 *$LOGDATE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID			      
               Check_SCP_Status

 

#		rm *$LOGDATE*

	     ;;

     $HOST_EBB)

                gzip  $PG_DUMP_DIR/*.pg_dump 

               echo "*** Copying DB Dumps FROM EBB TO Seaside" >> $LOG_FILE
               scp -B -p -P 22 *$LOGDATE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID			      
               Check_SCP_Status

 

#		rm *$LOGDATE*

	     ;;

       $HOST_FLOW)

                gzip  $PG_DUMP_DIR/*.pg_dump 

               echo "*** Copying DB Dumps FROM FLOW TO Seaside" >> $LOG_FILE
               scp -B -p -P 22 *$LOGDATE* chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID		      
               Check_SCP_Status
               
#		rm *$LOGDATE*

	     ;;

    $HOST_PHILLY)

                gzip  $PG_DUMP_DIR/*.pg_dump 

               echo "*** Copying DB Dumps FROM PHILLY TO Seaside" >> $LOG_FILE
               scp -B -p -P 22 *$LOGDATE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID			      
               Check_SCP_Status

#		rm *$LOGDATE*

	     ;;
	     
	     	
	*)  echo "What machine are you on???" >> $LOG_FILE  ;; 

	esac


rm *.lst

Print_Blank_Line
}

REMOTE_SCP_METADATA()
{

    cd $METADATA_DUMP_DIR

if [ $DEBUG == $YES ] ; then 
    echo "HOST:                      "   $HOST
    echo "METADATA_DUMP_DIR:         "   $METADATA_DUMP_DIR
    echo "ARCHIVE_METADATA_DUMP_DIR: "   $ARCHIVE_METADATA_DUMP_DIR
    echo "PROD_METADATA_FILE_XML:    "   $PROD_METADATA_FILE_XML  
    echo "PROD_METADATA_FILE_TXT:    "   $PROD_METADATA_FILE_TXT
    echo "PROD_METADATA_FILE_JSON:    "  $PROD_METADATA_FILE_JSON  
fi 


PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
  Print_Blank_Line  
  echo "** ERROR: NO REMOTE SCP DONE FOR : "   $PROD_METADATA_FILE_XML  >> $LOG_FILE  
  Print_Blank_Line
else
	echo "ON_SEASIDE: "  $ON_SEASIDE
	if [ $COPY_TO_PROD == $YES ] ; then 
    	     echo "*** Copying DB Dumps FROM " $HOST " TO GEONET"  >> $LOG_FILE
#  ORIG      scp -B -p -P 22 $PROD_METADATA_FILE_XML  $PROD_METADATA_FILE_TXT  metadata@geonet.gina.alaska.edu:$PROD_METADATA_DUMP_DIR
#  ORIG      scp -B -p -P 22 $PROD_METADATA_FILE_XML  $PROD_METADATA_FILE_TXT  metadata@geonet.gina.alaska.edu:/home/metadata/export/htdocs/ION/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
             if [ $HOSTNAME == $SEASIDE_FULL ]; then
                  scp -P 22 $PROD_METADATA_FILE_XML  $PROD_METADATA_FILE_TXT  $PROD_METADATA_FILE_JSON metadata@geonet.gina.alaska.edu:/home/metadata/export/htdocs/ION/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
             else
 	          mv $PROD_METADATA_FILE_XML  $PROD_METADATA_FILE_TXT  $PROD_METADATA_FILE_JSON /home/metadata/export/htdocs/ION/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
             fi
        fi
	if [ $COPY_TO_ARCHIVE == $YES ] ; then 
    	     echo "*** Rsynching METADATA files FROM " $HOST " TO SEASIDE "  >> $LOG_FILE
# ORIG       scp -B -p -P 22 $PROD_METADATA_FILE_XML  $PROD_METADATA_FILE_TXT $PROD_METADATA_FILE_JSON chaase@seaside:/home/chaase/gina-alaska/dba-tools/GINA_METADATA/archive/$SENSOR/$YEAR_YYYY
    	     rm $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/*.log
    	     rm $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/*.lst
    	     rsync -av $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/* chaase@seaside:/home/chaase/gina-alaska/dba-tools/GINA_METADATA/archive/$SENSOR/$YEAR_YYYY
        fi 
fi
Print_Blank_Line
}



REMOTE_SCP_MONGODUMP()
{

#    cd $MONGODUMP_DIR

    echo "HOST:        "    $HOST
    echo "MONGODUMP_DIR: "  $MONGODUMP_DIR
    echo "BACKUP_DIR: "     $BACKUP_DIR

    case "$HOST" in

           #mongodb dumps from geonet
           
           $HOST_PROD_METADATA_GEO)
           
                  gzip  $MONGODUMP_DIR/*.bson
                  scp -B -p -P 22 *$MONGODUMP_FILE*  chaase@seaside.gina.alaska.edu:/mnt/raid/san/local/database/pgsqldata/database_backups/$POSTGRES_SID
        
           
           ;;

           $HOST_DEV)

             gzip  $MONGODUMP_DIR/*.bson

#             echo "*** Copying DB Dumps FROM Seaside TO DOOM.X"  >> $LOG_FILE
 #            scp -B -p -P 22 *$LOGDATE*  mongodb@doom.x.gina.alaska.edu:/var/lib/mongodb/san/local/database/mongodata/database_backups/$MONGODB_SID

 
	     ;;
	     
           $HOST_GOOD_X)
           
#	         echo "*** Copying MONGODB Dumps FROM GOOD.X TO BAD.X "  >> $LOG_FILE
#	         scp -B -p -P 22 *$MONGODUMP_FILE*  mongod@bad.x.gina.alaska.edu:$BACKUP_DIR
#	         echo "*** Copying MONGODB Dumps FROM GOOD.X TO UGLY.X "  >> $LOG_FILE
#	         scp -B -p -P 22 *$MONGODUMP_FILE*  mongod@ugly.x.gina.alaska.edu:$BACKUP_DIR

	        
        ;;
        
         $HOST_BAD_X)
           
#	         echo "*** Copying MONGODB Dumps FROM BAD.X TO GOOD.X "  >> $LOG_FILE
#	         scp -B -p -P 22 *$MONGODUMP_FILE*  mongod@good.x.gina.alaska.edu:$BACKUP_DIR
#	         echo "*** Copying MONGODB Dumps FROM BAD.X TO UGLY.X "  >> $LOG_FILE
#	         scp -B -p -P 22 *$MONGODUMP_FILE*  mongod@ugly.x.gina.alaska.edu:$BACKUP_DIR

	         
 	     ;;
	
      $HOST_UGLY_X)
           
#	         echo "*** Copying MONGODB Dumps FROM UGLY.X TO GOOD.X "  >> $LOG_FILE
#	         scp -B -p -P 22 *$MONGODUMP_FILE*  mongod@good.x.gina.alaska.edu:$BACKUP_DIR
	         echo "*** Copying MONGODB Dumps FROM UGLY.X TO BAD.X "  >> $LOG_FILE
#	         scp -B -p -P 22 *$MONGODUMP_FILE*  mongod@bad.x.gina.alaska.edu:$BACKUP_DIR
#

 	     ;;
		
	
	    *)  echo "What machine are you on???" >> $LOG_FILE  ;; 


	esac

Print_Blank_Line
}


REMOTE_SCP_METADATA_COPY_TO_PROD()

{
   if [ $COPY_TO_PROD == "Y" ] ; then 
    	echo "*** Copying DB Dumps FROM " $HOST " TO GEONET"  >> $LOG_FILE
        if [ $HOSTNAME == $SEASIDE_FULL ]; then
             scp -P 22  $PROD_METADATA_FILE_XML $PROD_METADATA_FILE_TXT $PROD_METADATA_FILE_JSON $OUTPUTFILE_FGDC_JSON $OUTPUTFILE_ISO_XML $OUTPUTFILE_ISO_JSON  $PROD_METADATA_HEADER_JSON metadata@geonet.gina.alaska.edu:/home/metadata/export/htdocs/ION/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
        else
             mv $PROD_METADATA_FILE_XML $PROD_METADATA_FILE_TXT $PROD_METADATA_FILE_JSON $OUTPUTFILE_FGDC_JSON $OUTPUTFILE_ISO_XML $OUTPUTFILE_ISO_JSON  $PROD_METADATA_HEADER_JSON /home/metadata/export/htdocs/ION/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY
 	       fi
        fi    
Print_Blank_Line
}

REMOTE_SCP_METADATA_COPY_TO_ARCHIVE()
{

    echo "*** Rsynching METADATA files FROM " $HOST " TO SEASIDE "  >> $LOG_FILE
    rm $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/*.log
    rm $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/*.lst
    rsync -av $PROD_EXPORT_METADATA/Content_Theme/imageryBaseMapsEarthCover/$SENSOR/$YEAR_YYYY/* chaase@seaside:/home/chaase/gina-alaska/dba-tools/GINA_METADATA/archive/$SENSOR/$YEAR_YYYY

Print_Blank_Line
}


