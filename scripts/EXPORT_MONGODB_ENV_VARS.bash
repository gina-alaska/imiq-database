#! /bin/bash -x


############  these are set on a HOST by HOST case in $HOME/tools/backup_scripts/EXPORT_GINA_HOSTS.bash
##export MONGOBIN=/usr/bin
#export MONGO=$MONGOBIN/mongo
#export MONGODUMP=$MONGOBIN/mongodump
#export MONGOD=$MONGOBIN/mongod
#export MONGOEXPORT=$MONGOBIN/mongoexport
#export MONGOFILES=$MONGOBIN/mongofiles
#export MONGOIMPORT=$MONGOBIN/mongoimport
#export MONGORESTORE=$MONGOBIN/mongorestore
#export MONGOSNIFF=$MONGOBIN/mongosniff
#export MONGOSTAT=$MONGOBIN/mongostat
#export MONGOS=$MONGOBIN/mongos
#export MONGOD=$MONGOBIN/mongod



export MONGODATABASE=$MONGODB_SID
export DBID=$MONGODB_SID

export MONGODB_VERSION_182="1.8.2"
export MONGODB_VERSION_182_FILE="182"

export MONGODB_VERSION_207="2.0.7"
export MONGODB_VERSION_207_FILE="207"

export MONGODB_VERSION_220="2.2.0"
export MONGODB_VERSION_220_FILE="220"

export MONGODB_VERSION_246="2.4.6"
export MONGODB_VERSION_246_FILE="246"

export MONGODB_VERSION_2413="2.4.13"
export MONGODB_VERSION_2413_FILE="2413"

export MONGOBIN_18=/usr/bin/mongod

export MONGOBIN_22=/usr/bin/mongodb

export MONGOBIN_24=/usr/bin/mongod



# legal schema names

export MONGODB="mongodb"
export STASH="stash"
export LOGSTASH="logstash"


