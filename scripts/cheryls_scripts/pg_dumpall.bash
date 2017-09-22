#! /bin/bash -x
#
#**************************************************************************************
#
# File Name:  ~/pgsql/tools/pg_dumpall.bash
#
# Author:     Cheryl L. Haase
#
# How to run:  ~/pgsql/tools/pg_dumpall.bash 
#
# Permissions:  
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
#
#----------------------------------------------------------------------------------------------------		


#########################################################################
#
# Environmental variables ==> SOURCE INCLUDE FILES
#
if [ $DEBUG == $YES ]; then
     EXPORT_SOURCE=$HOME/tools/backup_scripts/POSTGRES
else 
     EXPORT_SOURCE=$HOME/tools/backup_scripts/POSTGRES
fi
for EXPORT_NAME in $EXPORT_SOURCE/EXPORT*.bash; do
    echo "sourcing: "  $EXPORT_NAME
    source $EXPORT_NAME
done


######################################################################### 
BUP_LOG=$LOG_DIR/$FROM_OWNER.$POSTGRES_SID.$HOST.$POSTGRES_VERSION-$LOGDATE.pg_dumpall
export BUP_LOG

LOG_FILE=$LOG_DIR/$FROM_OWNER.$POSTGRES_SID.$HOST.$POSTGRES_VERSION-$LOGDATE.pg_dumpall_log
export LOG_FILE


#----------------------------------------------------------------------------
#  Let the games begin.........................
#----------------------------------------------------------------------------

echo " "								      	 > $LOG_FILE;
echo `date '+%m/%d/%y %A %X'` "*** log BEGIN ***"                         	>> $LOG_FILE;
echo "----------------------------------------------------------------"   	>> $LOG_FILE;
echo "Script      : "$0                                                   	>> $LOG_FILE;
echo "Database    : "$TOSID                                          		>> $LOG_FILE;
echo "Server      : "`uname -n`                                           	>> $LOG_FILE;
echo "----------------------------------------------------------------\n" 	>> $LOG_FILE;
echo " "								        >> $LOG_FILE;

echo " "								        >> $LOG_FILE;
echo "***********************************************************"		>> $LOG_FILE;
echo "* Backup database .....  "  	                                        >> $LOG_FILE;
echo "***********************************************************"		>> $LOG_FILE;
echo " "								        >> $LOG_FILE;

pg_dumpall -v -U $FROM_OWNER > $BUP_LOG

PGSQL_STATUS=$?
if [ $PGSQL_STATUS -ne $SE_SUCCESS ]; then
    rm $BUP_LOG
    rm $LOG_FILE
    echo "** ERROR: PGSQL command died ==> sqlplus_status  = "  $PGSQL_STATUS  
    echo "** ERROR: ......... filename: pg_dump"  $POSTGRES_SID  $FROM_OWNER    
    echo " " 									
    echo " " 									 
else
    echo " " 							  		  >> $LOG_FILE;
    echo "** Successful Dumping of DB: "   $POSTGRES_SID  " Owner: " $FROM_OWNER  >> $LOG_FILE;
    echo " " 									  >> $LOG_FILE;

   gzip $BUP_LOG

echo " "								      	>> $LOG_FILE;
echo `date '+%m/%d/%y %A %X'` "*** log END ***"                         	>> $LOG_FILE;
echo "----------------------------------------------------------------"   	>> $LOG_FILE;
echo "Script      : "$0                                                   	>> $LOG_FILE;
echo "Database    : "$TOSID                                         	        >> $LOG_FILE;
echo "Server      : "`uname -n`                                           	>> $LOG_FILE;
echo "----------------------------------------------------------------\n" 	>> $LOG_FILE;
echo " "								        >> $LOG_FILE;
   
    
fi

 

exit
