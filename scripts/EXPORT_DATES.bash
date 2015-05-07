#! /bin/bash 


export JANUARY="January"
export FEBRUARY="February"
export MARCH="March"
export APRIL="April"
export MAY="May"
export JUNE="June"
export JULY="July"
export AUGUST="August"
export SEPTEMBER="September"
export OCTOBER="October"
export NOVEMBER="November"
export DECEMBER="December"

export JAN="Jan"
export FEB="Feb"
export MAR="Mar"
export APR="Apr"
export MAY=$MAY
export JUN="Jun"
export JUL="Jul"
export AUG="Aug"
export SEP="Sep"
export OCT="Oct"
export NOV="Nov"
export DEC="Dec"

export YEAR=`date +%Y`
export YEAR_YYYY=$YEAR

export DAY=`date +%d`
export DAY_NN=$DAY

export MONTH=`date +%m`
export MONTH_NN=$MONTH

# =====> display a past date and time:
## date --date='3 seconds ago'  ==> Thu Jan 1 08:27:00 PST 2009
## date --date="1 day ago" ==> Wed Dec 31 08:27:13 PST 2008
## date --date="1 days ago" ==> Wed Dec 31 08:27:18 PST 2008
## date --date="1 month ago" ==> Mon Dec 1 08:27:23 PST 2008
## date --date="1 year ago" ==> Tue Jan 1 08:27:28 PST 2008
## date --date="yesterday" ==> Wed Dec 31 08:27:34 PST 2008
## date --date="10 months 2 day ago"
# =====>  display a future date and time.
## date --date='3 seconds'
## date --date='4 hours'
## date --date='tomorrow'
## date --date="1 day"
## date --date="1 days"
## date --date='1 month'
## date --date='1 week'
## date --date="2 years"
## date --date="next day"
## date --date="-1 days ago"
## date --date="this Wednesday"



export DATENAME=`date --date="now"`    # Thu Jan 1 08:20:05 PST 2009
export DATETODAY=`date --date="today"`   # Thu Jan 1 08:20:12 PST 2009
export DATECURRENTDATETIME=`date '+Current Date: %m/%d/%y%nCurrent Time:%H:%M:%S'` # Current Date: 01/01/09 Current Time:08:21:41


export DOW=`date +%A` # Day of the week e.g. Monday
export DNOW=`date +%u` # Day number of the week 1 to 7 where 1 represents Monday
export DOM=`date +%d` # Date of the Month e.g. 27
export M=`date +%B` # Month e.g January
export W=`date +%V` # Week Number e.g 37

export BACKUPFILE_DATE=`date +%Y%m%d_%H%M`

export FILEDATE=`date +%y%m%d`
export FILEDATETIME=`date +%y%m%d_%H%M`

export THEDATE=`date +%y%m%d_%H:%M`
export THEDATE_YYMMDD=`date +%y%m%d`
export THEDATE_YYYYMMDD=`date +%Y%m%d`
#export THEDATE_YYMMDD_TIME=`date +%y%m%d_%H%M`
#export THEDATE_YYMMDD_TIME_HHMMSS=`date +%Y-%m-%d %H%M%s`
#export THEDATE_YYMMDD_TIMESTAMP=`date +%Y-%m-%d %H:%M:%S`
export THEDATE_DATE=`date +%F`
export THEDATE_TIME=`date +%T`
export ONESPACE=" "
export THEDATE_IT=$THEDATE_DATE$ONESPACE$THEDATE_TIME
export LOGDATE=`date +%Y-%m-%d_%H%M%S`

export PUBDATE=`date +%Y%m%d`
export METADATADATE=`date +%Y%m%d`
export METADATATIME=`date +%H:%M:%S`
export METADATADATETITLE=`date +%Y/%m/%d`
export GCMD_URL_MOD_DATE=`date +%Y-%m-%d`



Verify_Leap_Year_ORIG()
{	
  # Need leap year for number of days in month....in header of metadata file
  LEAP_YEAR=$NO 	
  for YEAR_XML in  1940 1944 1948 1952 1956 1960 1964 1968 1972 1976 1980 1984 1988 1992 1996 2000 2004 2008 2012 2016 2020 2024 ; do
      LEAP_YEAR=$YES   		    
  done
}

Verify_Leap_Year_ORIG2()
{	
  # Need leap year for number of days in month....in header of metadata file
  LEAP_YEAR=$NO 	
  case "$YEAR_YYYY" in  
       1940)
          LEAP_YEAR=$YES
       ;;
       1944)
                LEAP_YEAR=$YES
       ;;
       1948)
                LEAP_YEAR=$YES
       ;;
       1952)
                LEAP_YEAR=$YES
       ;; 
       1956)
                LEAP_YEAR=$YES
       ;;
       1960)
                LEAP_YEAR=$YES
       ;; 
       1964)
                LEAP_YEAR=$YES
       ;; 
       1968)
                LEAP_YEAR=$YES
       ;; 
       1972)
                LEAP_YEAR=$YES
       ;; 
       1976)
                LEAP_YEAR=$YES
       ;; 
       1980)
                LEAP_YEAR=$YES
       ;; 
       1984)
                LEAP_YEAR=$YES
       ;; 
       1988)
                LEAP_YEAR=$YES
       ;; 
       1992)
                LEAP_YEAR=$YES
       ;; 
       1996)
                LEAP_YEAR=$YES
       ;; 
       2000)
                LEAP_YEAR=$YES
       ;;
       2004)
                LEAP_YEAR=$YES
       ;; 
       2008)
                LEAP_YEAR=$YES
       ;; 
       2012)
                LEAP_YEAR=$YES
       ;; 
       2016)
                LEAP_YEAR=$YES
       ;; 
       2020)
                LEAP_YEAR=$YES
       ;; 
       2024)
                LEAP_YEAR=$YES
       ;; 
       *)     
            LEAP_YEAR=$NO
       ;;
   esac
         		    
}


Verify_Leap_Year()
{	
  # Need leap year for number of days in month....in header of metadata file
LEAP_YEAR=$NO 	
LEAP_YEAR=`psql  gina_dba -U $CHAASE -AtF, -c  "SELECT DISTINCT leap_year from gina_dba.calsysdates where year_yyyy=$YEAR_YYYY"`
  
        		    
}



Get_Alpha_Month_ORIG()
{	
 	  case "$MONTH_N" in
	  	1)      MONTH_ALPHA=$JANUARY
                         MONTH_Mon=$JAN
			DAYS_IN_MONTH=$THIRTY_ONE
                         MONTH_NN="01"
			;;
		2)      MONTH_ALPHA=$FEBRUARY
                         MONTH_Mon=$FEB
			DAYS_IN_MONTH=$TWENTY_EIGHT
			if [ $LEAP_YEAR == $YES ]; then
			     DAYS_IN_MONTH=$TWENTY_NINE
			fi
                         MONTH_NN="02"
			;;
		 3)     MONTH_ALPHA=$MARCH
                         MONTH_Mon=$MAR
			DAYS_IN_MONTH=$THIRTY_ONE
                         MONTH_NN="03"
			;;                        
		 4)     MONTH_ALPHA=$APRIL
                         MONTH_Mon=$APR
			DAYS_IN_MONTH=$THIRTY
                         MONTH_NN="04"
			;;
		 5)     MONTH_ALPHA=$MAY
                         MONTH_Mon=$MAY
			DAYS_IN_MONTH=$THIRTY_ONE
                         MONTH_NN="05"
			;;                      
		 6)     MONTH_ALPHA=$JUNE
                         MONTH_Mon=$JUN
			DAYS_IN_MONTH=$THIRTY
                         MONTH_NN="06"
			;;
		 7)     MONTH_ALPHA=$JULY
                         MONTH_Mon=$JUL
			DAYS_IN_MONTH=$THIRTY_ONE
                         MONTH_NN="07"
			;;
		 8)     MONTH_ALPHA=$AUGUST
                         MONTH_Mon=$AUG
			DAYS_IN_MONTH=$THIRTY_ONE
                         MONTH_NN="08"
			;;
		 9)     MONTH_ALPHA=$SEPTEMBER
                         MONTH_Mon=$SEP
			DAYS_IN_MONTH=$THIRTY
                         MONTH_NN="09"
			;;
		10)     MONTH_ALPHA=$OCTOBER
                         MONTH_Mon=$OCT
			DAYS_IN_MONTH=$THIRTY_ONE
                         MONTH_NN=$MONTH_N
			;;
		11)     MONTH_ALPHA=$NOVEMBER
                         MONTH_Mon=$NOV
			DAYS_IN_MONTH=$THIRTY
                         MONTH_NN=$MONTH_N
			;;
		12)     MONTH_ALPHA=$DECEMBER
                         MONTH_Mon=$DEC
			DAYS_IN_MONTH=$THIRTY_ONE
                         MONTH_NN=$MONTH_N
			;;
		*)      echo "Bad Month" ;;
		esac
                
                 MONTH_NN_ALPHA=$MONTH_NN"_"$MONTH_ALPHA
                 MONTH_NN_Mon=$MONTH_NN"_"$MONTH_Mon
}

Get_Alpha_Month()
{	
MONTH_ALPHA=$BLANK
MONTH_Mon=$BLANK
DAYS_IN_MONTH=$BLANK
MONTH_NN=$BLANK	
#YEAR_YYYY=$BLANK

#YEAR_YYYY=`psql  gina_dba -U $CHAASE -AtF, -c  "SELECT DISTINCT year_yyyy from gina_dba.calsysdates where month_n=$MONTH_N" and `
MONTH_ALPHA=`psql  gina_dba -U $CHAASE -AtF, -c  "SELECT DISTINCT month_desc from gina_dba.calsysdates where month_n=$MONTH_N"`
MONTH_Mon=`psql  gina_dba -U $CHAASE -AtF, -c  "SELECT DISTINCT month_mon from gina_dba.calsysdates where month_n=$MONTH_N"`
DAYS_IN_MONTH=`psql  gina_dba -U $CHAASE -AtF, -c  "SELECT DISTINCT days_in_month from gina_dba.calsysdates where month_n=$MONTH_N"`
MONTH_NN=`psql  gina_dba -U $CHAASE -AtF, -c  "SELECT DISTINCT month_nn from gina_dba.calsysdates where month_n=$MONTH_N"`
       
MONTH_NN_ALPHA=$MONTH_NN"_"$MONTH_ALPHA
MONTH_NN_Mon=$MONTH_NN"_"$MONTH_Mon
}

