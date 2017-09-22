#! /bin/bash 


# Environmental variables

export  LINUX_UC="LINUX"
export  LINUX_LC="linux"

export USR_BIN=/usr/bin

export AWK=$USR_BIN/awk
export GUNZIP=$USR_BIN/gunzip
export GZIP=$USR_BIN/gzip
export FIND=$USR_BIN/find
export FTP=$USR_BIN/ftp
export SCP=$USR_BIN/scp
export SCP_Bp="$SCP -B -p "
export SED=$USR_BIN/sed
export TAR=$USR_BIN/tar
export TAR_CVF="$TAR -cvf"
export WGET=$USR_BIN/wget
export ZIP=$USR_BIN/zip

export WHOAMI=`/usr/bin/whoami`

export N="N"
export Y="Y"
export n="n"
export y="y"
export YES=$Y
export NO=$N

export ALL="all"
export all="all"
export both="both"
export BOTH="both"
export ONESPACE=" "
export SPACE=" "
export NONE="None."
export UNKNOWN="Unknown"
export TBD="TBD"
export NULL=""
export PERIOD="."
export DOT=$PERIOD
export STAR='*'
export CSV="CSV"
export UNDERSCORE="_"
export DASH="-"
export COMMA=","
export BAR="|"
export SLASH_VAR="/var"
export SLASH_MNT="/mnt"
export SLASH_SAN="/san"

export ZERO="0"
export ONE="1"
export TWO="2"
export THREE="3"
export FOUR="4"
export FIVE="5"
export SIX="6"
export SEVEN="7"
export EIGHT="8"
export NINE="9"
export TEN="10"
export ELEVEN="11"
export TWELVE="12"
export FOURTEEN="14"
export FIFTEEN="15"
export SIXTEEN="16"
export SEVENTEEN="17"
export EIGHTEEN="18"
export NINETEEN="19"
export TWENTY="20"
export TWENTY_ONE="21"
export TWENTY_TWO="22"
export TWENTY_THREE="23"
export TWENTY_FOUR="24"
export TWENTY_FIVE="25"
export TWENTY_SIX="26"
export TWENTY_SEVEN="27"
export TWENTY_EIGHT="28"
export TWENTY_NINE="29"
export THIRTY="30"
export THIRTY_ONE="31"

export NINETY="90"
export HUNDRED="100"

#export INITIAL="i"
#export MAINT="m"


# ==================> diff exit codes <============================
#	An  exit status of 0 means no differences were found
#	1 means some differences were found
#       2 means trouble
#
export DIFF_SUCCESS=0
export DIFF_DIFF_FAILURE=1
export DIFF_FOOBAR=2

# ==================> Return Code Env Vars <============================
export SE_SUCCESS=0
export SE_FAILURE=-1

export return_code=-1

# =================> Return Codes - PostgreSQL <========================
export PSQL_STATUS=0
export PSQL_SUCCESS=00000
export PSQL_NODATA=02000
export PSQL_INVALID_CATALOG=3D000
export PSQL_INVALID_SCHEMA=3F000
export PSQL_NODATA_FOUND=P0002
export PSQL_INVALID_NAME=42602
export PSQL_DUPLICATE_TABLE=42P07  # table name exists ?????

export SE_FAILURE=-1;
export SE_SUCCESS=0; 
export SE_TABLE_NOEXIST=-37; 
export SE_TABLE_NOREGISTERED=-220; 
export SE_INVALID_USER=-9;
export SE_NO_PERMISSIONS=-25;  ##  NO PERMISSION TO PERFORM OPERATION 



#  just for documentation in case i ever need them
export max_attempts=4
export SE_APP_SDE_INTERNAL_ID=999; 
export DBS_CONNECTION_GENERATOR=12;
export SE_EDIT_ACTION_CLOSE=2;
export SE_EDIT_ACTION_OPEN=1;
export SE_edit_mode_start=2; 
export SE_edit_state_stop=1;
export SE_exclusive_lock='E';
export SE_exclusive_lock_all='X';
export SE_FINISHED=-4; 
export SE_GENERATE_UNIQUE_NAME=1; 
export SE_INVALID_PARAM_VALUE=-66;   ##  SPECIFIED PARAMETER VALUE IS INVALID 
export SE_INVALID_USER=-9;     ##  CANNOT VALIDATE THE SPECIFIED USER  
export SE_INVALID_VERSION_NAME=-171;  ##  Illegal or blank version name 
export SE_is_autolock='Y';
export SE_is_not_autolock='N';
export SE_marked_lock='M';
export SE_LOCK=1; 
export SE_MVV_EDIT_DEFAULT=-500;
export SE_MVV_IN_EDIT_MODE=-501;
export SE_MVV_NAMEVER_NOT_CURRVER=-503;
export SE_MVV_NOT_STD_EDIT_MODE=-504; 
export SE_MVV_ROWID_UPDATE=-499; 
export SE_MVV_SET_DEFAULT=-507; 
export SE_MVV_VERSION_IN_USE=-553;   ## The version is in use. 
export SE_NO_LOCKS=-48;    ##  NO LOCKS DEFINED 
export SE_OBJECT_VERSION_TYPE=1;  ##  For use with the SDE Internal app 
export SE_OGC_COLLECTION=6; 
export SE_OGC_CURVE=2; 
export SE_OGC_GEOMETRY=0; 
export SE_OGC_LINESTRING=3; 
export SE_OGC_MULTICURVE=8; 
export SE_OGC_MULTILINESTRING=9; 
export SE_OGC_MULTIPOINT=7; 
export SE_OGC_MULTIPOLYGON=11; 
export SE_OGC_MULTISURFACE=10; 
export SE_OGC_POINT=1; 
export SE_OGC_POLYGON=5; 
export SE_OGC_SURFACE=4; 
export SE_PARENT_NOT_CLOSED=-176;  ## To create a state, the parent state must be closed. 
export SE_PRIVATE=0; 
export SE_PROTECTED=2;  
export SE_PUBLIC=1; 
export SE_ROWID_GENERATOR=2; 
export SE_STATE_IS_CLOSED=2;
export SE_shared_lock='S'; 
export SE_shared_lock_all='-'; 
export SE_SPATIALREF_NOEXIST=-255; 
export SE_STATE_NOEXIST=-172; ##  A specified state is not in the VERSION_STATES table. 
export SE_VERSION_HAS_MOVED=-174; 
export SE_VERSION_GENERATOR=9; 
export SE_VERSION_HAS_CHILDREN=-285;  ##  Version has children. 
export SE_VERSION_NOEXIST=-126;   ##  Version not found. 

#  just for documentation in case i ever need them

# =================> Return Codes - MongoDB  <========================

export MONGODB_SUCCESS=0
export MONGODB_ERROR=2
export MONGODB_HOSTNAME_MISMATCH=3
export MONGODB_VERSION_MISMATCH=4
export MONGODB_MOVECHUNK_COMMIT_FAIL=5
export MONGODB_UNCAUGHT_EXCEPTION=14
export MONGODB_CANNOT_OPEN_FILE=45
export MONGODB_LARGE_CLOCK_SLEW=47
export MONGODB_SERVER_SOCKET_CLOSE=48
export MONGODB_PROCESS_UNCAUGHT_EXCEPTION=100






