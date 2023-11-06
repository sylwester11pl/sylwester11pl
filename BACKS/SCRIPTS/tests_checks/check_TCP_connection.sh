#!/bin/bash

#This script monitoring a actuall count connections TCP state ESTAB in host
#Written by Patryk Basko

source /opt/TOOLS/SCRIPTS/config_value.list

if [ $enabled_tcpConn == 0 ] || [ $enabled_tcpConn == disabled ];
	then
	exit 0;
fi


ts=`date +%s`
tcp_connections=`ss -nt4 | tail -n +2 | wc -l`

if [ $tcp_connections -le 5 ];
	then
	echo "[$ts] PROCESS_SERVICE_CHECK_RESULT;Raspberry_Pi_4_SERWER>;check_TCP_connection;0;Everything is fine. Connections are less than 5. You can go sleep :-)";
	else
	echo "[$ts] PROCESS_SERVICE_CHECK_RESULT;Raspberry_Pi_4_SERWER>;check_TCP_connection;2;Please, check the count of connections. Connections are more than 5. Not good :-(";
fi
