#! /bin/bash 

# ============> set in EXPORT_GINA_HOSTS.bash 
#export PGBIN=/usr/bin
#export PG_DUMP=$PGBIN/pg_dump
#export PG_DUMPALL=$PGBIN/pg_dumpall
#export PSQL=$PGBIN/psql
#export PG_CONTROLDATA=$PGBIN/pg_controldata
#export PG_CONFIG=pg_config
#export SHP2PGSQL=$PGBIN/shp2pgsql
#export PGSQL2SHP=$PGBIN/pgsql2shp
#export REINDEXDB=$PGBIN/reindexdb
#export VACUUMDB=$PGBIN/vacuumdb
#export VACUUMDB_OPTIONS_ALL="-z -f -e -v -d"
# ================>  set in EXPORT_GINA_HOSTS.bash





####POSTGRES_VERSION=`echo "select version();" | $PSQL -d $POSTGRES_SID -U $FROM_OWNER | grep PostgreSQL | awk '{print $2}'`
# set PG_LOG_DIR in in List_PG_Databases....PG_LOG_DIR is based upon version
#export PG_LOG_DIR=$PGDATA
#export PG_LOG_DIR=$PGDATA/pg_log


OPTION_STRING_FILE="-c"

export TEMP_OPTION=""
export TEMP_STRING_FILE=""
export DATA_ONLY_FLAG="-a "
export DATA_ONLY="a"
export ALL=" "

export PGDATABASE=$POSTGRES_SID
export DBID=$POSTGRES_SID

#export POSTGRES_VERSION_81="8.1"
#export POSTGERS_VERSION_81_FILE="81"
#export POSTGRES_VERSION_8111="8.1.11"
#export POSTGRES_VERSION_8111_FILE="8111"
#export POSTGRES_VERSION_82="8.2"
#export POSTGRES_VERSION_82_FILE="82"
#export POSTGRES_VERSION_83="8.3"
#export POSTGRES_VERSION_83_FILE="83"
#export POSTGRES_VERSION_833="8.3.3"
#export POSTGRES_VERSION_833_FILE="833"
#export POSTGRES_VERSION_8311="8.3.11"
#export POSTGRES_VERSION_8311_FILE="8311"
export POSTGRES_VERSION_84="8.4"
export POSTGRES_VERSION_844="8.4.4"
export POSTGRES_VERSION_844_FILE="844"
#export POSTGRES_VERSION_85="8.5"

export POSTGRES_VERSION_90="9.0"
export POSTGRES_VERSION_90_FILE="90"
export POSTGRES_VERSION_902="9.0.2"
export POSTGRES_VERSION_902_FILE="902"
export POSTGRES_VERSION_903="9.0.3"
export POSTGRES_VERSION_903_FILE="903"

export POSTGRES_VERSION_91="9.1"
export POSTGRES_VERSION_91_FILE="91"
export POSTGRES_VERSION_911="9.1.1"
export POSTGRES_VERSION_911_FILE="911"
export POSTGRES_VERSION_912="9.1.2"
export POSTGRES_VERSION_912_FILE="912"
export POSTGRES_VERSION_913="9.1.3"
export POSTGRES_VERSION_913_FILE="913"
export POSTGRES_VERSION_917="9.1.7"
export POSTGRES_VERSION_917_FILE="917"
export POSTGRES_VERSION_918="9.1.8"
export POSTGRES_VERSION_918_FILE="918"

export POSTGRES_VERSION_920="9.2.0"
export POSTGRES_VERSION_920_FILE="920"
export POSTGRES_VERSION_922="9.2.2"
export POSTGRES_VERSION_922_FILE="922"
export POSTGRES_VERSION_925="9.2.5"
export POSTGRES_VERSION_925_FILE="925"

export POSTGRES_VERSION_931="9.3.1"
export POSTGRES_VERSION_931_FILE="931"
export POSTGRES_VERSION_932="9.3.2"
export POSTGRES_VERSION_932_FILE="932"
export POSTGRES_VERSION_934="9.3.4"
export POSTGRES_VERSION_934_FILE="934"
export POSTGRES_VERSION_935="9.3.5"
export POSTGRES_VERSION_935_FILE="935"
export POSTGRES_VERSION_936="9.3.6"
export POSTGRES_VERSION_936_FILE="936"

export POSTGRES_VERSION_940="9.4.0"
export POSTGRES_VERSION_940_FILE="940"
export POSTGRES_VERSION_942="9.4.2"
export POSTGRES_VERSION_942_FILE="942"

export PGBIN_90=/usr/pgsql-9.0/bin
export PGBIN_91=/usr/pgsql-9.1/bin
export PGBIN_92=/usr/pgsql-9.2/bin
export PGBIN_93=/usr/pgsql-9.3/bin
export PGBIN_94=/usr/pgsql-9.4/bin

# only true for version 8 and below
export PGSQL_CONTRIB_DIR=/usr/share/pgsql/contrib
# at least this is true for 9 and up
export POSTGISBIN=/usr/pgsql-9.1/share/contrib/postgis-1.5
export POSTGISBIN_15=/usr/pgsql-9.1/share/contrib/postgis-1.5
export POSTGISBIN_21=/usr/pgsql-9.2/share/contrib/postgis-2.1
export POSTGISBIN_91_15=/usr/pgsql-9.1/share/contrib/postgis-1.5
export POSTGISBIN_92_21=/usr/pgsql-9.2/share/contrib/postgis-2.1
export POSTGISBIN_93_21=/usr/pgsql-9.3/share/contrib/postgis-2.1
export POSTGISBIN_94_21=/usr/pgsql-9.4/share/contrib/postgis-2.1

export SPATIAL_REF_SYS_SQL=spatial_ref_sys.sql
export POSTGIS_SQL=postgis.sql

export POSTGRES_SID_DEV=$POSTGRES_SID
export POSTGRES_SID_TEST=$POSTGRES_SID
export POSTGRES_SID_PROD=$POSTGRES_SID
#export POSTGRES_SID_PRODTEST=$POSTGRES_SID"_prodtest"
#export POSTGRES_SID_DBA=$POSTGRES_SID"_dba"
#export POSTGRES_SID_DEV_DBA=$POSTGRES_SID_DEV"_dba"
#export POSTGRES_SID_TEST_DBA=$POSTGRES_SID_TEST"_dba"
#export POSTGRES_SID_PROD_DBA=$POSTGRES_SID_PROD"_dba"
#export POSTGRES_SID_PRODTEST_DBA=$POSTGRES_SID_PRODTEST"_dba"

# ORIG export POSTGRES_SID_LIST="$POSTGRES_SID $POSTGRES_SID_PROD $POSTGRES_SID_DEV $POSTGRES_SID_TEST $POSTGRES_SID_DBA $POSTGRES_SID_DEV_DBA $POSTGRES_SID_TEST_DBA $POSTGRES_SID_PROD_DBA"
export POSTGRES_SID_LIST="$POSTGRES_SID $POSTGRES_SID_PROD $POSTGRES_SID_DEV $POSTGRES_SID_TEST $POSTGRES_SID_DBA $POSTGRES_SID_DEV_DBA $POSTGRES_SID_TEST_DBA $POSTGRES_SID_PROD_DBA"

# legal schema names
export GINA="gina"
export GINA_DBA="gina_dba"
export GINA_METADATA="gina_metadata"
export POSTGRES="postgres"
export TEMPLATE0="template0"
export TEMPLATE1="template1"
export TEMPLATE_POSTGIS="template_postgis"
export SDE="sde"
export PGBENCH="pgbench"
export CLUSTER="cluster"

export PSQL_c="-c"
export PSQL_ac="-a -c"
export PSQL_Atc="-At -c"
export PSQL_AtFCOMMAc="-AtF, -c"
export PSQL_CSV_OPTIONS="-At -c"

export PSQL_COMMAND_LINE_AtFCOMMAc_DBA="$PSQL -d $GINA_DBA -U $CHAASE $PSQL_AtFCOMMAc"
export PSQL_COMMAND_LINE_Atc_DBA="$PSQL -d $GINA_DBA -U $CHAASE $PSQL_Atc"
export PSQL_COMMAND_LINE_ac_DBA="$PSQL -d $GINA_DBA -U $CHAASE  $PSQL_ac"
export PSQL_COMMAND_LINE_c_DBA="$PSQL -d $GINA_DBA -U $CHAASE  $PSQL_c"

export PSQL_COMMAND_LINE_AtFCOMMAc="$PSQL -d $POSTGRES_SID -U $CHAASE $PSQL_AtFCOMMAc"
export PSQL_COMMAND_LINE_Atc="$PSQL -d $POSTGRES_SID -U $CHAASE $PSQL_Atc"
export PSQL_COMMAND_LINE_ac="$PSQL -d $POSTGRES_SID -U $CHAASE $PSQL_ac"
export PSQL_COMMAND_LINE_c="$PSQL -d $POSTGRES_SID -U $CHAASE $PSQL_c"

export PSQL_SLASH_DN_PLUS="\dn+"
export PSQL_LIST_DB_SCHEMA_NAMES="$PSQL_COMMAND_LINE_ac $PSQL_SLASH_DN_PLUS" 

#export PSQL_CURRENT_TIMESTAMP=`$PSQL_COMMAND_LINE_Atc_DBA "select * from current_timestamp"`
#export PSQL_NOW=`psql -d $POSTGRES_SID -At -c "select * from now()"`
#export CURRENT_RECORD_COUNT=`psql -d $POSTGRES_SID -At -c "select count(*) from $INPUT_TABLE"`
#export PSQL_COMMAND_LINE_Atc "SELECT datname FROM pg_database WHERE datname=$POSTGRES_SID"           >> $LOG_FILE     

#export PSQL_PG_DB_SIZE="select pg_size_pretty(pg_database_size('$POSTGRES_SID'))" 
#export PSQL_PG_DB_SIZE_PRETTY=`"$PSQL_COMMAND_LINE_ac $PSQL_PG_DB_SIZE"'`

export TABLESPACE_NAME=$POSTGRES_SID"_tblspc"

# This is the User/Role PUBLIC 
export PUBLIC="public"
export PUBLIC_SCHEMA="public"
 # This is the GROUP PUBLIC to which ALL user/roles AUTOMATICALLY belong..     
export PUBLIC_GROUP="PUBLIC"
export PG_CATALOG="pg_catalog"
export PG_INDEXES="pg_indexes"
export PG_ROLES="pg_roles"
export PG_TABLES="pg_tables"
export INFORMATION_SCHEMA="information_schema"
export INFORMATION_SCHEMA_SCHEMATA="information_schema.schemata"
export INFORMATION_SCHEMA_VIEW_TABLE_USAGE="information_schema.view_table_usage" 
export INFORMATION_SCHEMA_SEQUENCES="information_schema.sequences"

export SEARCH_PATH_PG="$PG_CATALOG,$INFORMATION_SCHEMA"
export SEARCH_PATH_SDE="$PUBLIC,$SDE,$SEARCH_PATH_PG"

export PLGPSQL="plpgsql"
export SQL="sql"
export C="c"
export PLRUBY="plruby"
export PLPYTHON="plpython"

export ENCODING="encoding"
export UNICODE="unicode"

export OWNER="owner"
export WITH_OWNER="with owner"
export OWNER_TO="owner to"

#export NO_RELATIONS_FOUND="No relations found."
export NO_RELATIONS_FOUND="No"

export GEOMETRY_COLUMNS="geometry_columns"
export SPATIAL_REF_SYS="spatial_ref_sys"
export SDE_SPATIAL_REFERENCES="sde_spatial_references"
export PUBLIC_GEOMETRY_COLUMNS="public.geometry_columns"
export PUBLIC_SDE_SPATIAL_REFERENCES="public.sde_spatial_references"
export PUBLIC_SPATIAL_REF_SYS="public.spatial_ref_sys"

export CREATE_DATABASE="create database"
export CREATE_SCHEMA="create schema"
export CREATE_LANGUAGE="create language"
export CREATE_TABLESPACE="create tablespace"
export CREATE_TABLE="create table"
export CREATE_INDEX="create index"

export DROP_DATABASE="drop database"
export DROP_TABLE="drop table"
export DROP_USER="drop user"
export DROP_SCHEMA="drop schema"
export DROP_COLUMN="drop column"

export ALTER_DATABASE="alter database"
export ALTER_INDEX="alter index"
export ALTER_SCHEMA="alter schema"
export ALTER_SEQUENCE="alter sequence"
export ALTER_TABLE="alter table"
export ALTER_TABLESPACE="alter tablespace"
export ALTER_VIEW="alter view"

export SELECT_DISTINCT="select distinct"
export SELECT_DISTINCT_INDEXNAME="select distinct indexname"
export SELECT_DISTINCT_SCHEMA_NAME="select distinct schema_name"
export SELECT_DISTINCT_SEQUENCE_NAME="select distinct sequence_name"
export SELECT_DISTINCT_TABLENAME="select distinct tablename"
export SELECT_DISTINCT_VIEW_NAME="select distinct view_name"
export SELECT_ROLNAME="select rolname"

export ROLNAME_NOT_ADMIN="rolname not similar to 'admin_*'"
export ROLNAME_NOT_DATA="rolname not similar to 'data_*'"
export ROLNAME_NOT_POSTGRES="rolname != '$POSTGRES'"
export ROLNAME_NOT_SDE="rolname != '$SDE'"
export ROLNAME_NOT_PUBLIC="rolname != '$PUBLIC'"
export ROLNAME_NOT_PGBENCH="rolname != '$PGBENCH'"
export ROLNAME_NOT_CHAASE="rolname != '$CHAASE'"
export ROLNAME_NOT_DBA="rolname != '$DBA'"
export ROLNAME NOT_PETE="rolname != '$PETE'"
export ROLNAME_NOT_ANNE="rolname != '$ANNE'"

export SCHEMA_IS_PG="schema_name similar to 'pg_*'"
export SCHEMA_IS_INFORMATION_SCHEMA="schema_name = '$INFORMATION_SCHEMA'"

export SCHEMA_IS_DBA="schema_name = 'gina_dba' or schema_name = 'gina_metadata' or schema_name = 'gina_sos'"
export SCHEMA_IS_DBA_PUBLIC="schema_name = 'gina_dba' or schema_name = 'gina_metadata' or schema_name = 'gina_sos' or schema_name = 'public'"

export SCHEMA_NOT_PG="schema_name not similar to 'pg_*'"
export SCHEMA_NOT_PUBLIC_SCHEMA="schema_name != '$PUBLIC_SCHEMA'"
export SCHEMA_NOT_INFORMATION_SCHEMA="schema_name != '$INFORMATION_SCHEMA'"
export SCHEMA_NOT_SDE="schema_name != '$SDE'"

export ORDER_BY="order by"
export ORDER_BY_ROLNAME="order by rolname"
export ORDER_BY_INDEXNAME="order by indexname"
export ORDER_BY_TABLENAME="order by tablename"
export ORDER_BY_SEQUENCE_NAME="order by sequence_name"
export ORDER_BY_VIEW_NAME="order by view_name"

export REVOKE_ALL="revoke all"
export GRANT_ALL="grant all"
export GRANT_USAGE="grant usage"
export GRANT_CREATE_USAGE="grant create,usage"
export GRANT_SELECT="grant select"
export GRANT_SELECT_DELETE="grant select,delete"
export GRANT_SELECT_INSERT="grant select,insert"
export GRANT_SELECT_UPDATE="grant select,update"
export GRANT_SELECT_INSERT_DELETE="grant select,insert,delete"
export GRANT_SELECT_INSERT_UPDATE="grant select,insert,update"
export GRANT_SELECT_INSERT_UPDATE_DELETE="grant select,insert,update,delete"
export GRANT_CREATE="grant create"
export GRANT_DELETE="grant delete"
export GRANT_INSERT="grant insert"
export GRANT_UPDATE="grant update"

export DELETE="delete"
export INSERT="insert"
export COPY="copy"
export UPDATE="update"

export UPDATE_TABLE="update table"
export INSERT_TABLE="insert table"
export DROP_TABLE="drop table"
export TRUNCATE_TABLE="truncate table"

export SELECT_STAR="select *"
export SELECT_COUNT_STAR="select count(*)"

export PSQL_CSV_OPTIONS="-At -c"
export DELIMITER_AS_NULL="delimiter '|' null as ''"

export ADD_HOST_VARCHAR10="add host varchar(10)"
export ADD_CREATED_AT_TIMESTAMP="add created_at timestamp"
export ADD_UPDATED_AT_TIMESTAMP="add updated_at timestamp"

export TYPNAMESPACES_TO_IGNORE="typnamespace = 11 or typnamespace = 99 or typnamespace = 11313"

# =================> PostgreSQL PG_CATALOG tables <========================
# these default to pg_catalog !!!
export PG_CATALOG_PG=pg_catalog.pg_catalog
export PG_AUTHID_PG=pg_catalog.pg_authid
export PG_DATABASE_PG=pg_catalog.pg_database 
export PG_LANGUAGE_PG=pg_catalog.pg_language 
export PG_NAMESPACE_PG=pg_catalog.pg_namespace 
export PG_INDEXES_PG=pg_catalog.pg_indexes
export PG_PLTEMPLATE_PG=pg_catalog.pg_pltemplate 
export PG_ROLES_PG=pg_catalog.pg_roles 
export PG_TABLES_PG=pg_catalog.pg_tables 
export PG_TABLESPACE_PG=pg_catalog.pg_tablespace 
export PG_TYPE_PG=pg_catalog.pg_type



