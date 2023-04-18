#!/bin/bash
#created and tuning by Patryk Basko
#INSTRUCTION
#1.Run
#2.Wait
#3.After finish, you can verify check manual or using "SHOW ME CHANGE" (if you don't like this, you can uncomment section)

#LOCAL change
sed -i 's/msg = msg + " |records = "/msg = msg + " |XXX="/' /root/XXX.sh
sed -i 's/msg = msg + " |records = "/msg = msg + " |XXX="/g' /root/XXX.sh
sed -i 's/msg = msg + " |XXX = "/msg = msg + " |XXX="/g' /root/XXX.sh
sed -i 's/msg = msg + ";XXX = "/msg = msg + ";XXX="/g' /root/XXX.sh
sed -i 's/msg = msg + ";XXX = "/msg = msg + ";XXX="/g' /root/XXX.sh
sed -i 's/msg = msg + ";XXX = "/msg = msg + ";XXX="/g' /root/XXX.sh

#REMOTE change
cat /root/.bash_profile | grep "^alias" | grep -e XXX | grep -oP 'ssh.*\d+\.\d+\.\d+\.\d+' > /home/root/file_test
 
while IFS= read -r line 
do
	echo $line | grep -oP '\d+\.\d+\.\d+\.\d+'
	$line	'$(sed -i -e '"'"'s/msg = msg + " |records = "/msg = msg + " |records="/g'"'"' /root/XXX.sh
			&&
			sed -i -e '"'"'s/msg = msg + " |records = "/msg = msg + " |records="/g'"'"' /root/XXX.sh 
			&&
			sed -i -e '"'"'s/msg = msg + " |XXX = "/msg = msg + " |XXX="/g'"'"' /root/XXX.sh
			&&
			sed -i -e '"'"'s/msg = msg + ";XXX = "/msg = msg + ";XXX="/g'"'"' /root/XXX.sh
			&&
			sed -i -e '"'"'s/msg = msg + ";XXX = "/msg = msg + ";XXX="/g'"'"' /root/XXX.sh
			&&
			sed -i -e '"'"'s/msg = msg + ";XXX = "/msg = msg + ";XXX="/g'"'"' /root/XXX.sh
			)' < /dev/null
done < /home/root/file_test

#=======================
#SHOW ME CHANGE

echo ""
echo ""
echo -e "\e[1;32m PRESS ENTER TO RUN CHECKING\e[0m \n"
read

while IFS= read -r line
do
   echo $line | grep -oP '\d+\.\d+\.\d+\.\d+'
   $line 'echo -e "File: \e[0;31m XXX.sh\e[0m" && cat /root/XXX.sh | grep "msg = msg" 
			&& 
			echo -e "File: \e[3;31m XXX.sh\e[0m" && cat /root/XXX.sh | grep "msg = msg"' < /dev/null
done < /home/root/file_test
