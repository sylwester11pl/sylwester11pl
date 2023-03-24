#!/bin/bash
#version 0.4
#by Patryk Basko
#in this version script is "non interactive" mode.

date=$(date +%D)
#defined colors, NC use to disable painting
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
NC='\033[0m'
count=0


function generate_pass {
                password=$( tr -dc '[:lower:][:upper:][:digit:]@_' < /dev/urandom | head>
                char1=$(tr -dc '[:lower:]' < /dev/urandom | head -c 1)
                char2=$(tr -dc '[:upper:]' < /dev/urandom | head -c 1)
                char3=$(tr -dc '[:digit:]' < /dev/urandom | head -c 1)
                char4="@_"
                generated_pass=$password$char1$char2$char3$char4
}

function change_pass {
                #LINE BELOW ->  USE TO LOCAL CHANGE (LAB VERSION)
                #$(echo "$line:$generated_pass" | chpasswd)

                #LINE BELOW -> USE TO REMOTE CHANGE (LAB VERSION)
                $(ssh root@10.0.1.92 "echo "$line:$generated_pass" | chpasswd" </dev/nul>

                #LINE BELOW -> USE TO REMOTE CHANGE (MCAFEE VERSION)
                #$($line "echo "root:$generated_pass" | chpasswd" </dev/null)
}

#-------MAIN-SCRIPT-SEGMENT-------------

while IFS= read -r line
do
        echo -e "\n${G}$line${NC}"

                generate_pass
                change_pass
                echo -e "Password was ${Y}generated${NC}: $generated_pass"

done < /root/custom_users