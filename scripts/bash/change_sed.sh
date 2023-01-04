#!/bin/bash

#script to modify line in check "recs_bhnd" on all ERCs -> output line for OMD (msg)
#created and tuning by Patryk B (basis on script to change passwords)
#INSTRUCTION
#1.Run on ESM
#2.Wait
#3.After finish, you can verify check manual or using "SHOW ME CHANGE" (if you don't like this, you can uncomment section)

#LOCAL change

sed -i 's/msg = msg + " |records = "/msg = msg + " |records="/' /root/checks/check.erc.rec_behind.sh
sed -i 's/msg = msg + " |records = "/msg = msg + " |records="/g' /root/checks/check.erc.eps.sh
sed -i 's/msg = msg + " |eps = "/msg = msg + " |eps="/g' /root/checks/check.erc.eps.sh
sed -i 's/msg = msg + ";INCOMING_EPS_10M = "/msg = msg + ";INCOMING_EPS_10M="/g' /root/checks/check.erc.eps.sh
sed -i 's/msg = msg + ";PARSE_AFTER_FILTERS_10M = "/msg = msg + ";PARSE_AFTER_FILTERS_10M="/g' /root/checks/check.erc.eps.sh
sed -i 's/msg = msg + ";EPS_TO_ELM_10M = "/msg = msg + ";EPS_TO_ELM_10M="/g' /root/checks/check.erc.eps.sh

#REMOTE change

cat /root/.bash_profile | grep "^alias" | grep -e erc | grep -oP 'ssh.*\d+\.\d+\.\d+\.\d+' > /home/a866590/ERCs_IP
 
#sed -i 's/ssh /ssh -tt /' /root/tests_script/file_test
#sleep 2


while IFS= read -r line 
do
 
	echo $line | grep -oP '\d+\.\d+\.\d+\.\d+'
	$line	'$(sed -i -e '"'"'s/msg = msg + " |records = "/msg = msg + " |records="/g'"'"' /root/checks/check.erc.rec_behind.sh
			&&
			sed -i -e '"'"'s/msg = msg + " |records = "/msg = msg + " |records="/g'"'"' /root/checks/check.erc.eps.sh 
			&&
			sed -i -e '"'"'s/msg = msg + " |eps = "/msg = msg + " |eps="/g'"'"' /root/checks/check.erc.eps.sh
			&&
			sed -i -e '"'"'s/msg = msg + ";INCOMING_EPS_10M = "/msg = msg + ";INCOMING_EPS_10M="/g'"'"' /root/checks/check.erc.eps.sh
			&&
			sed -i -e '"'"'s/msg = msg + ";PARSE_AFTER_FILTERS_10M = "/msg = msg + ";PARSE_AFTER_FILTERS_10M="/g'"'"' /root/checks/check.erc.eps.sh
			&&
			sed -i -e '"'"'s/msg = msg + ";EPS_TO_ELM_10M = "/msg = msg + ";EPS_TO_ELM_10M="/g'"'"' /root/checks/check.erc.eps.sh
			)' < /dev/null
done < /home/a866590/ERCs_IP

#=======================
#+++++++++++++++++++++++
#=======================
#SHOW ME CHANGE

echo ""
echo ""
echo -e "\e[1;32m PRESS ENTER TO RUN CHECKING\e[0m \n"
read


while IFS= read -r line
do

   echo $line | grep -oP '\d+\.\d+\.\d+\.\d+'
   $line 'echo -e "File: \e[0;31m check.erc.rec_behind.sh\e[0m" && cat /root/checks/check.erc.rec_behind.sh | grep "msg = msg" 
			&& 
			echo -e "File: \e[3;31m check.erc.eps.sh\e[0m" && cat /root/checks/check.erc.eps.sh | grep "msg = msg"' < /dev/null

done < /home/a866590/ERCs_IP
