#/bin/bash

while IFS="," read VARID VARCODE; do
     OUTFILE="./${VARCODE}_datavalues.csv"
     OUTFILE_VARNAME="${VARCODE}_OUTFILE"
     eval $OUTFILE_VARNAME=\$OUTFILE
     mkdir -p "`dirname \"$OUTFILE\"`" 2>/dev/null
done < <(cat ../variableid_varcode.csv )
while IFS="," read datastreamid sitename varcode; do
     SITENAME=`echo $sitename | sed "s/-/_/g"`
     DATASTREAMID_VARNAME="${SITENAME}_${varcode}"
     eval $DATASTREAMID_VARNAME=\$datastreamid
done  < <(cat datastreamid_site_field.csv )
cat stations.txt | while IFS="," read station; do
  STATION_MOD=`echo $station | sed "s/-/_/g"`
  cat ${STATION_MOD}.txt | tail -n +2 | while IFS=" " read Yr Mo Dy Hr Mn Lat Lon Elev T TQ1 TQ2 Td TdQ1 TdQ2 RH RHQ1 RHQ2 Spd SpdQ1 SpdQ2 Dir DirQ1 DirQ2 StnP StnPQ1 StnPQ2 SLP SLPQ1 SLPQ2 Alt AltQ1 AltQ2 SW SWQ1 SWQ2 LW LWQ1 LWQ2 Pcp1 Pcp1Q1 Pcp1Q2 Pcp6 Pcp6Q1 Pcp6Q2 Pcp24 Pcp24Q1 Pcp24Q2 SnoD SnoDQ1 SnoDQ2 USAF WBAN; do
       printf -v month "%02d" ${Mo}
       printf -v day "%02d" ${Dy}
       printf -v min "%02d" ${Mn}
       printf -v hour "%02d" ${Hr}
       if [[ ${T} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_T
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${T_OUTFILE}"
       elif [[ ${TQ1} = 0 && ${TQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_T
        echo ${T},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${T_OUTFILE}"
       elif [[ ${TQ1} > 0 || ${TQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_T
        echo ${T},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${T_OUTFILE}"
       fi
       if [[ ${Td} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_Td
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${Td_OUTFILE}"
       elif [[ ${TdQ1} = 0 && ${TdQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Td
        echo ${Td},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${Td_OUTFILE}"
       elif [[ ${TdQ1} > 0 || ${TdQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Td
        echo ${Td},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${Td_OUTFILE}"
       fi
       if [[ ${RH} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_RH
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${RH_OUTFILE}"
       elif [[ ${RHQ1} = 0 && ${RHQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_RH
        echo ${RH},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${RH_OUTFILE}"
       elif [[ ${RHQ1} > 0 || ${RHQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_RH
        echo ${RH},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${RH_OUTFILE}"
       fi
       if [[ ${Spd} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_Spd
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${Spd_OUTFILE}"
       elif [[ ${SpdQ1} = 0 && ${SpdQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Spd
        echo ${Spd},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${Spd_OUTFILE}"
       elif [[ ${SpdQ1} > 0 || ${SpdQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Spd
        echo ${Spd},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${Spd_OUTFILE}"
       fi
       if [[ ${Dir} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_Dir
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${Dir_OUTFILE}"
       elif [[ ${DirQ1} = 0 && ${DirQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Dir
        echo ${Dir},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${Dir_OUTFILE}"
       elif [[ ${DirQ1} > 0 || ${DirQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Dir
        echo ${Dir},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${Dir_OUTFILE}"
       fi
       if [[ ${StnP} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_StnP
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${StnP_OUTFILE}"
       elif [[ ${StnPQ1} = 0 && ${StnPQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_StnP
        echo ${StnP},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${StnP_OUTFILE}"
       elif [[ ${StnPQ1} > 0 || ${StnPQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_StnP
        echo ${StnP},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${StnP_OUTFILE}"
       fi
       if [[ ${SLP} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_SLP
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${SLP_OUTFILE}"
       elif [[ ${SLPQ1} = 0 && ${SLPQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_SLP
        echo ${SLP},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${SLP_OUTFILE}"
       elif [[ ${SLPQ1} > 0 || ${SLPQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_SLP
        echo ${SLP},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${SLP_OUTFILE}"
       fi
       if [[ ${Alt} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_Alt
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${Alt_OUTFILE}"
       elif [[ ${AltQ1} = 0 && ${AltQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Alt
        echo ${Alt},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${Alt_OUTFILE}"
       elif [[ ${AltQ1} > 0 || ${AltQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Alt
        echo ${Alt},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${Alt_OUTFILE}"
       fi
       if [[ ${SW} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_SW
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${SW_OUTFILE}"
       elif [[ ${SWQ1} = 0 && ${SWQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_SW
        echo ${SW},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${SW_OUTFILE}"
       elif [[ ${SWQ1} > 0 || ${SWQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_SW
        echo ${SW},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${SW_OUTFILE}"
       fi
       if [[ ${LW} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_LW
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${LW_OUTFILE}"
       elif [[ ${LWQ1} = 0 && ${LWQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_LW
        echo ${LW},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${LW_OUTFILE}"
       elif [[ ${LWQ1} > 0 || ${LWQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_LW
        echo ${LW},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${LW_OUTFILE}"
       fi
       if [[ ${Pcp1} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_Pcp1
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${Pcp1_OUTFILE}"
       elif [[ ${Pcp1Q1} = 0 && ${Pcp1Q2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Pcp1
        echo ${Pcp1},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${Pcp1_OUTFILE}"
       elif [[ ${Pcp1Q1} > 0 || ${Pcp1Q2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Pcp1
        echo ${Pcp1},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${Pcp1_OUTFILE}"
       fi
       if [[ ${Pcp6} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_Pcp6
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${Pcp6_OUTFILE}"
       elif [[ ${Pcp6Q1} = 0 && ${Pcp6Q2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Pcp6
        echo ${Pcp6},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${Pcp6_OUTFILE}"
       elif [[ ${Pcp6Q1} > 0 || ${Pcp6Q2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Pcp6
        echo ${Pcp6},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${Pcp6_OUTFILE}"
       fi
       if [[ ${Pcp24} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_Pcp24
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${Pcp24_OUTFILE}"
       elif [[ ${Pcp24Q1} = 0 && ${Pcp24Q2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Pcp24
        echo ${Pcp24},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${Pcp24_OUTFILE}"
       elif [[ ${Pcp24Q1} > 0 || ${Pcp24Q2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_Pcp24
        echo ${Pcp24},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${Pcp24_OUTFILE}"
       fi
       if [[ ${SnoD} = "-999.000" ]]; then
        eval datastreamid=\$${STATION_MOD}_SnoD
        echo null,${month}/${day}/${Yr} ${hour}:${min},0,198,${datastreamid},nc | tr -d $"\r" >> "${SnoD_OUTFILE}"
       elif [[ ${SnoDQ1} = 0 && ${SnoDQ2} = 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_SnoD
        echo ${SnoD},${month}/${day}/${Yr} ${hour}:${min},0,199,${datastreamid},nc | tr -d $"\r" >> "${SnoD_OUTFILE}"
       elif [[ ${SnoDQ1} > 0 || ${SnoDQ2} > 0 ]]; then
        eval datastreamid=\$${STATION_MOD}_SnoD
        echo ${SnoD},${month}/${day}/${Yr} ${hour}:${min},0,200,${datastreamid},nc | tr -d $"\r" >> "${SnoD_OUTFILE}"
       fi
  done 
 done
