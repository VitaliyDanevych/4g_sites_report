#!/bin/sh

#4G
wdir=/home/fmuser2/scripts/4g_sites_report
cd ${wdir}/
cp -p ${wdir}/4g_sites_all.csv  ${wdir}/old/4g_sites_all_$(date '+DATE: %d_%m_%Y_%H_%m' | sed 's/DATE: //').csv
mv ${wdir}/4g_sites_all.csv ${wdir}/4g_sites_all_old.csv
/opt/ericsson/ddc/util/bin/listme | grep RN_ | sed -e 's/[@=,]/ /g' | awk '{print $4";"$6";"$7}'  | uniq | sort | unix2dos > ${wdir}/4g_sites_all_temp.csv

#add headers
gawk 'NR==1{1;print "SubNetwork;NODE_NAME;NODE_IP"}1' ${wdir}/4g_sites_all_temp.csv > ${wdir}/4g_sites_all.csv 
rm -rf 4g_sites_all_temp.csv

echo "send result via email"
cd ${wdir}/
${wdir}/smail.sh 4g_sites_all.csv

#clean old files
find ${wdir}/old -name "*.csv" -mtime +15 -exec rm '{}' \;