#/bin/bash

OUTFILE="./datastream_metadata.csv"
mkdir -p "`dirname \"$OUTFILE\"`" 2>/dev/null
cat siteid_sitecode.csv | while IFS=',' read siteid sitename; do
  echo ${sitename}_AirTemperature,${siteid},1032,T,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_DewPoint,${siteid},1033,Td,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_RelativeHumidity,${siteid},1034,RH,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_WindSpeed,${siteid},1035,Spd,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_WindDirection,${siteid},1036,Dir,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_StationPressure,${siteid},1037,StnP,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_SeaLevelPressure,${siteid},1038,SLP,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_Altimeter,${siteid},1039,Alt,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_ShortwaveRadiation,${siteid},1040,SW,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_LongwaveRadiation,${siteid},1041,LW,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_Precip_1HR,${siteid},1042,Pcp1,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_Precip_6HR,${siteid},1043,Pcp6,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_Precip_24HR,${siteid},1044,Pcp24,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
  echo ${sitename}_SnowDepth,${siteid},1045,SnoD,1,1,1,10/28/2014 | tr -d $'\r' >> "${OUTFILE}"
done 
