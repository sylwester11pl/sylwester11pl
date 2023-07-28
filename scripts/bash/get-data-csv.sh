#!/bin/bash
#ver 0.2
#script to collect data from OS
#author: Patryk Basko

#CHANGELOG
#0.1 -> create script to collect data
#0.2 -> added function to creating and fill CSV file

Date=$(date +%d/%m/%y)
#defined colors, NC use to disable painting
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
NC='\033[0m'


#additional variables
#===================
path=$HOME
log_file=$path/get-data-CSV.log
csv_file=$path/Data-$HOSTNAME.csv
error_code=0


function collect {
HOSTNAME=$(hostname)
OS_FAMILY="Linux"
OS_NAME=$(grep -E "^NAME=" /etc/os-release | grep -oP '(?<=\x22).*(?=\x22)')
OS_VERSION=$(grep -E "^VERSION=" /etc/os-release | grep -oP '(?<=\x22)\d+.\d+.\d+|\d+(?=\s)')
IP=$(ip a | grep -P "ens|eth|docker" | grep -P "inet" | grep -oP '(?<=inet\s).*?(?=/)' | sed ':a;N;$!ba;s/\n/ /g')
MAC=$(ip a | grep -oP '(?<=link/ether\s).*?(?=\s)' | sed ':a;N;$!ba;s/\n/ /g'))
memory_total=$(vmstat -s | grep -e "total memory" | grep -oP "\d+")
MEMORY=$(expr $memory_total / 1024)
cpu_core_socket=$(lscpu | grep -e "per socket" | grep -oP "\d+")
cpu_socket=$(lscpu | grep -e "Socket*" | grep -oP "\d+")
cpu_mhz=$(lscpu | grep -e "CPU MHz" | grep -oP "\d+.\d+")
STORAGE=$(lsblk -l | grep -P 'sd\w\s' | awk -F " " '{ print $4 }' | grep -oP '\d+')
}

function create_csv {
echo "Unique ID,Class,Name,Company,Criticality,DNS,Domain,Host name,Inactive,Is Monitored,Is Virtual,Location,Model ID,Operational status,OS Family,OS Version,Room,Serial number,Support Status,Asset tag,Auto Ticketing,Building,Category,Comments,CPU core count,CPU count,CPU speed (MHz),Description,Disk space (GB),Firmware Version,Floor,Fully qualified domain name,Function Type,IP Address,Is the CI Supported?,MAC Address,Manufacturer,Mounting Height U,NAT Address,Operating System,Platform Type,RAM (MB),Server Type,Service Scope,Site Room Name,Special Location Info,Support Group L1,Support Group L2,Used for,Vendor,Last Ticket Number" > $csv_file
}
function fill {
echo ",,,,,,,$HOSTNAME,,,,,,,$OS_FAMILY,$OS_VERSION,,,,,,,,,$cpu_core_socket,$cpu_socket,$cpu_mhz,,$STORAGE,$OS_VERSION,,,,$IP,,$MAC,$OS_NAME,,,$OS_NAME,,$MEMORY,,,,,,,,$OS_NAME," >> $csv_file
}

function logger {
if  [[ $? == $error_code ]]
then
        fill
        echo -e "Task runned at: $Date\nScript result: ${G}succesfully!!${NC}\nCollected data was saved on $path/DATA-$HOSTNAME.csv file"
else
        echo -e "Task runned at: $Date\nScript result: ${R}failed!!${NC} Please run again"
fi
}

#===================

#MAIN PROGRAM
#---------------

collect
create_csv
logger >> $log_file
tail -n2 $log_file

#---------------
