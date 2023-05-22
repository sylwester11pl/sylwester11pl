#!/bin/bash
#ver 0.1
#script to collect data from OS
#author: Patryk Basko


Date=$(date +%D%M%Y)
#defined colors, NC use to disable painting
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
NC='\033[0m'

echo -e "Collecting data\n============"
#===================================
HOSTNAME=$(hostname)
OS_FAMILY="Linux"
OS_NAME=$(grep -E "^NAME=" /etc/os-release | grep -oP '(?<=\x22).*(?=\x22)')
OS_VERSION=$(grep -E "^VERSION=" /etc/os-release | grep -oP '(?<=\x22)\d+.\d+.\d+(?=\s)')
IP=$(ip a | grep -P "ens|eth" | grep -P "inet" | grep -oP '(?<=inet\s).*?(?=/)')
MAC=$(ip a | grep -oP '(?<=link/ether\s).*?(?=\s)')
memory_total="$(vmstat -s | grep -e "total memory" | grep -oP "\d+")"
MEMORY=$(expr $memory_total / 1024)
cpu_core_socket="$(lscpu | grep -e "per socket" | grep -oP "\d+")"
cpu_socket="$(lscpu | grep -e "Socket*" | grep -oP "\d+")"
cpu_mhz="$(lscpu | grep -e "CPU MHz" | grep -oP "\d+.\d+")"
STORAGE=$(lsblk -l | grep -P 'sd\w\s' | awk -F " " '{ print $4 }' | grep -oP '\d+')
#======================================

if [[ $($storage|wc -l) == 0 ]]
then
        echo -e "IS only 1 disk\n"
else
        echo -e "Exist more than 1 disk\n"
fi
echo -e "Task was finished: ${G}succesfully!!${NC}"
echo -e "Script runnig at: $Date on $(hostname)\nHostname: $HOSTNAME\nOS Family: $OS_FAMILY\nOS Version: $OS_VERSION\nCPU core count: $cpu_core_socket\nCPU count: $cpu_socket\nCPU speed: $cpu_mhz\nDisk space (GB): $STORAGE\nFirmware version: $OS_VERSION\nIP address: $IP\nMAC address: $MAC\nManufactured: $OS_NAME\nOperating system: $OS_NAME\nRAM (MB): $MEMORY\nVendor: $OS_NAME\n" # >> /opt/get-data.log
