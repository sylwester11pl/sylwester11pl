#!/bin/bash
#This check was created for monitoring runned checks on crontab. Use "--help" to read descritption.
#Remember to add line to crontab: && echo "[$(date '+\%F \%R')] $(hostname);YOUR_THE_BEST_NAME_OF_SCRIPT - Status OK" >>/opt/LOGI/ALL_CHECKS.log || echo "[$(date '+\%F \%R')] $(hostname);YOUR_THE_BEST_NAME_OF_SCRIPT - Status NotOK" >>/opt/LOGI/ALL_CHECKS.log
#Author: Patryk Basko
#VERSION: 0.1a
#WORK IN PROGRESS


R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
NC='\033[0m'
C='\033[0;36m'

source /root/checks.config


checks=( $(cat $checks_list | grep -v "#") )
checks_live=()
checks_dead=()
let max_diff_time=$max_diff_time*24*60*60
let l=0

#---HELP---What do you want from me?!
if [[ $1 == "--help" ]]; then echo -e "\nRun script with extra arguments to get more information about checks.\nThis check utilizes two files: "checks.list" and "ALL_CHECKS.log" definied on /root/LOGI path.\nAfter adding line to crontab, put "friendly" or "real" name of the script into the list (note: not all check have simple name - ex. simple-script.sh, simple-script.py.\nPart of the checks have single global name ex. main.py, watchdog.sh therefore "friendly name" should be used to determine which script doesn't work).\n\nAll checks should be in the new line, ex.\ndupa-jasia\ndupa-mariana\ndupsko\n\n${C}--show-debug${NC} --> show last messages with timestamp for every check definied on "checks.list" file\n\n${C}--show-table${NC} --> show simple table with statuses (working/dead) for every check definied on the list\n\n${R}REQURIED${NC} line on crontab:\n"'&& echo "[$(date '+\%F \%R')] $(hostname);YOUR_THE_BEST_NAME_OF_SCRIPT - Status OK" >>/opt/LOGI/ALL_CHECKS.log || echo "[$(date '+\%F \%R')] $(hostname);YOUR_THE_BEST_NAME_OF_SCRIPT - Status NotOK" >>/opt/LOGI/ALL_CHECKS.log'; exit 0; fi
#--HELP-SECTION-END-------------------

for i in "${checks[@]}";
do

        last_check_comm=$(grep $i $read_me_log | tail -n1)

#START counter | last message counter. Last 5 messages will be comparased on "NotOK" value
	IFS=$'\n'
	table_last_check_comm=( $(grep $i $read_me_log | tail -n5) )
	for z in "${table_last_check_comm[@]}";
	do
		if [[ $(echo "$z") =~ "NotOK" ]]; then ((l+=1)); fi
	done
	IFS=$' '
#END counter

        ts=$(echo "$last_check_comm" | grep -oP '(?<=\x5b).*(?=\x5d)')
        ts_diff=$(expr $(date +%s) - $(date -d "$ts" +%s))



        #fill arrays. First statement -> if added check to list no generated output from cron - return error.
        if [[ $last_check_comm == "" ]]; then
                error_cron="WARNING - you add $i to the checks.list but I didn't get output. Check crontab and "ALL_CHECK.log"!"
                checks_dead+=( "$i : $error_cron")
        elif [[ $ts_diff -gt $max_diff_time ]]; then
                error_time="WARNING - Last output from $i is oldest than 1 day, please check. Check $i will be mark as "dead""
                checks_dead+=( "$i : $error_time")
#DISABLED -> Remove counter and unhash this position -->>       elif [[ $(echo $last_check_comm) =~ "NotOK" ]]; then
	elif [[ $(expr $l / 2) -ge 5 ]]; then
                checks_dead+=( "$i" )
        else
                checks_live+=( "$i" )
        fi

        #----DEBUG-----show me last message and check name. I know, this is ugly :(
        if [[ $1 == "--show-debug" || $2 == "--show-debug" ]]; then
                echo -e "\n${Y}$i${NC}"
                echo -e "Last 5 outputs from check: "; for a in "${table_last_check_comm[@]}"; do echo "$a"; done
                echo -e "Last timestamp from message: ${Y}$ts${NC}"
                n=-1
                echo "${checks_dead[@]: $n}"
                n+=1
        fi
        #----DEBUG-SECTION-END--------------------
done

#-----SHOW-TABLE----show me dead and alive checks
if [[ $1 == "--show-table" || $2 == "--show-table" ]]; then

        echo -e "+++++Dead checks+++++"
        for a in "${checks_dead[@]}"; do echo -e "$a"; done
        echo -e "\n-----ALive checks-----"
        if  [[ $(echo "${#checks_live[@]}") -eq 0 ]]; then echo -e "${R}NO ALIVE CHECKS${NC}\n"; fi
        for b in "${checks_live[@]}"; do echo -e "$b"; done

fi
#---SHOW-TABLE-SECTION-END--------------------

#output for check_mk --> if it's NotOK
if [[ $(echo "${#checks_dead[@]}") -lt 2 ]]; then
        for c in "${checks_dead[@]}";
        do
                echo -e "[$(date +%s)] PROCESS_SERVICE_CHECK_RESULT;$(hostname);health-status;2;Check "$c" reported faulty status, please check manual! | Status=2"
        done
else
        echo -e "[$(date +%s)] PROCESS_SERVICE_CHECK_RESULT;$(hostname);health-status;2;More checks reported faulty status, run script with "--show-table" or "--help" for more information! | Status=2"
fi

#Output for check_mk --> if all it's OK
if [[ $(echo "${#checks_dead[@]}") -eq 0 ]]; then
        echo -e "[$(date +%s)] PROCESS_SERVICE_CHECK_RESULT;$(hostname);health-status;0;All checks runned properly, don't worry | Status=0"
fi
