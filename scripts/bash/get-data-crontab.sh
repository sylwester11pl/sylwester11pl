#!/bin/bash
#ver 0.1
#script to collect data from crontabs
#author: Patryk Basko

#CHANGELOG
#0.1 -> created script to collect data
#0.2 ->

#defined colors, NC use to disable painting
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
NC='\033[0m'

check_targets=$(ls -la /var/spool/cron/crontabs/ | awk '{print $9}' | grep -oP "^\w*|^\d+" | grep -v "monitoring")
target=($check_targets)
#drawing output

for i in "${target[@]}";
do
        list_crontab=$(cat /var/spool/cron/crontabs/$i | grep -P "\s" | grep -v "^#")
        echo -e "####${G}ENABLED${NC} ENTRIES####\nFor: ${Y}$i${NC}\n$list_crontab\n####END#OF#FILE####\n" >> /root/get-data-crontab.log
done

log=/root/get-data-crontab.log
cat  $log
scripts=$(cat $log | grep -oP "\s\/.+(sh|py)" | sed 's/ //g')
echo -e "\n***Below are listed scripts, which are running from crontab from ${Y}EACH OF USER${NC}***\n$scripts\n"
rm $log
echo -e "\n####Stats for noobs####"
echo "Items which were added: ${target[*]}"
echo "Count items on array: ${#target[*]}"
