#/bin/bash

cat stations.txt | while IFS=',' read site; do
OUTFILE="./site_metadata.csv"
mkdir -p "`dirname \"$OUTFILE\"`" 2>/dev/null
head -2  ${site}.txt | tail -n +2 | while IFS=' ' read Yr Mo Dy Hr Mn Lat Lon Elev T Q1 Q2 Td Q1 Q2 RH Q1 Q2 Spd Q1 Q2 Dir Q1 Q2 StnP Q1 Q2 SLP Q1 Q2 Alt Q1 Q2 SW Q1 Q2 LW Q1 Q2 Pcp1 Q1 Q2 Pcp6 Q1 Q2 Pcp24 Q1 Q2 SnoD Q1 Q2USAF WBAN; do
  echo BOEM_NCDC_${site},${site},POINT,252,Unknown,Alaska,3,POINT\(${Lon} ${Lat} ${Elev}\),5/14/2015 | tr -d $'\r' >> "${OUTFILE}"
 done
done 
