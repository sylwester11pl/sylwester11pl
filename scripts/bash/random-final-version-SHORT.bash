#!/bin/bash
#version 0.4
#by Patryk Basko
#Script generate password which include min. 1 digit, 1 lower, 1 upper char, "@" and "_" chars.
#File "file_test" is using to save ssh connections.

date=$(date +%D)
#defined colors, NC use to disable painting
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
NC='\033[0m'

#--------------HERE YOU CAN CHANGE LENGTH OF PASSWORD-------
password_length=20
#------------------------------------------------------------

cat /root/.bash_profile | grep "^alias" | grep -e XXX -e XXX -e XXX | grep -oP 'ssh.*\d+\.\d+\.\d+\.\d+' > /root/tests_script/file_test

function generate_pass {
                password=$(tr -dc '[:lower:][:upper:][:digit:]' < /dev/urandom | head -c $password_length)
                password+=$(tr -dc '[:lower:]' < /dev/urandom | head -c 1)
                password+=$(tr -dc '[:upper:]' < /dev/urandom | head -c 1)
                password+=$(tr -dc '[:digit:]' < /dev/urandom | head -c 1)
                password+="@"
                password+="_"

                generated_pass=$(echo "$password" | fold -w1 | shuf | tr -d '\n')
}

function change_pass {
                $($line "echo "root:$generated_pass" | chpasswd" </dev/null)
}

#-------MAIN-SCRIPT-SEGMENT-------------

while IFS= read -r line
do
        echo -e "\n${G}$line${NC}"

                generate_pass
                change_pass
                echo -e "Date of operation: ${R}$date${NC}"
                echo -e "Password was ${Y}generated${NC}: $generated_pass"

done < /root/tests_script/file_test

#--------END-MAIN--SEGMENT--------------
