#This "check" check when ssl cert will be expired
#Patryk Basko
#ver 0.1
#replace "XXXXX" to your site
#replace "YYYYY" to your hostname
#replace "ZZZZZ" to your service name

#!/bin/bash



#intructions to keep order
clear
ts=`date +%s`
date_actual_os=`date`

#date for human
date_expiry_ssl=`curl -vk https://XXXXX/ 2>&1 | grep -E "expire\sdate:" | cut -c17-40`

#convert to helpful format (like date from OS)
date_ssl=`date -d "${date_expiry_ssl}" +'%a %d %b %Y %r'`

ts_expiry_ssl=`date -d "${date_ssl}" +%s`

echo "========================" 
echo "Actuall date: "$date_actual_os 
echo
echo "Cert SSL expire: "$date_expiry_ssl 
echo

let time_exp=$ts_expiry_ssl-$ts

if [ $time_exp -gt 1300000 ]; 
	then
	echo "PROCESS_SERVICE_CHECK_RESULT;<YYYYY>;<ZZZZZ>;<0>;<HTTPS certifiacte for "XXXXX" is already fresh - OK>"
elif [ $time_exp -ge 600000 && $time_exp -lt 1300000 ];
	then
		echo "PROCESS_SERVICE_CHECK_RESULT;<YYYYY>;<ZZZZZ>;<1>;<HTTPS certifiacte for "XXXXX" expire on 14 days  - PREPARE A NEW CERT>"	
	else
		echo "PROCESS_SERVICE_CHECK_RESULT;<YYYYY>;<ZZZZZ>;<2>;<HTTPS certifiacte for "XXXXX" is expired - RENEW CERT!!>"
fi
 
#ts_ssl=$date_actual_ssl | `date +%s`
#let ts_now=$ts-$ts_ssl
#echo "Different beetwen Dates by seconds is: "$time_exp
