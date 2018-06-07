#!/bin/bash

wdir=/home/fmuser2/scripts/4g_sites_report
cd ${wdir}/

#TO="vit.dan@life.com.ua"

FROM="ericsson-oss-rc2@life.com.ua"
SUBJECT="Ericcson 4G report"

#num_diff=$(diff 4g_sites_all.csv 4g_sites_all_old.csv | perl -pi -e 's/^\d+.*$//gi' | grep '.' | wc -l)
#res_diff=$(diff 4g_sites_all.csv 4g_sites_all_old.csv | perl -pi -e 's/^\d+.*$//gi' | grep '.')

num_diff=$(diff 4g_sites_all.csv 4g_sites_all_old.csv | grep -v '^[0-9]' | wc -l)
res_diff=$(diff 4g_sites_all.csv 4g_sites_all_old.csv | grep -v '^[0-9]')

BODY="Pls, find attached file with the list of all 4G sites integrated to the OSS-RC2.\n There were changed the following number of 4G sites in comporation to the last script running: $num_diff.\n There were updated such 4G sites: \n $res_diff"
(echo 'From: '$FROM;echo 'To:'$TO;echo 'Cc:'$CC;echo 'Subject: '$SUBJECT;  echo $BODY ;uuencode $1 $1)| /usr/sbin/sendmail -f vit.dan@life.com.ua -t
exit
