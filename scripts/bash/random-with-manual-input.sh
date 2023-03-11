#!/bin/bash
#version 0.3
#by Patryk Basko
#in this version script is in "verbose" mode

date=$(date +%D)
#defined colors, NC use to disable painting
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
NC='\033[0m'
count=1

#----------------TESTING AREA--------------------------------
#read -p "***FOR TESTING*** Give me your password: " password
password="maladupaniejestzla"
#-----------------END TESTING AREA--------------------------
while IFS= read -r line
do
        echo -e "\n${G}$line${NC}"
                #-------------------TESTING AREA || UNCOMMENT BELOW SECTION TO NORMAL WORKING--------
                #password=$( tr -dc '[:lower:][:upper:][:digit:]@_' < /dev/urandom | head -c 20)
                echo "Password before looping and if: $password"
                        if [[ "$password" =~ [[:lower:]] && "$password" =~ [[:upper:]] && "$password" =~ [[:digit:]] && "$password" =~ "@" && "$password" =~ "_" ]]; then
                        echo -e "Password is ${G}correct${NC}: $password"
                        else
                        until [[ "$password" =~ [[:lower:]] && "$password" =~ [[:upper:]] && "$password" =~ [[:digit:]] && "$password" =~ "@" && "$password" =~ "_" ]]
                        do
                        if [[ "$password" != *[[:lower:]]* ]]; then
                        char_1="${password:$(( RANDOM % ${#password} )):1}"
                        char_1_new=$(tr -dc '[:lower:]' < /dev/urandom | head -c 1)
                        new_password="${password//$char_1/$char_1_new}"
                        password=$new_password
                                else
                                if [[ "$password" != *[[:upper:]]* ]]; then
                                char_2="${password:$(( RANDOM % ${#password} )):1}"
                                char_2_new=$(tr -dc '[:upper:]' < /dev/urandom | head -c 1)
                                new_password="${password//$char_2/$char_2_new}"
                                password=$new_password
                                        else
                                        if [[ "$password" != *[[:digit:]]* ]]; then
                                        char_3="${password:$(( RANDOM % ${#password} )):1}"
                                        char_3_new=$(tr -dc '[:digit:]' < /dev/urandom | head -c 1)
                                        new_password="${password//$char_3/$char_3_new}"
                                        password=$new_password
                                        else
                                                if [[ "$password" != "@" && "$password" != "_" ]]; then
                                                char_4="${password:$(( RANDOM % ${#password} )):2}"
                                                new_password="${password//$char_4/@_}"
                                                password=$new_password

                ((count++))

                echo -e "Password was ${Y}generated${NC}: $password"

                                                fi
                                        fi
                                fi
                        fi
                        done
                        fi
                echo "Count operation: $count"

done < /root/custom_users

