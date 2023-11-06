#!/bin/bash

#writting by Patryk Basko
#tool to run all checks
#ver 0.1


#-----------------------------
path="/opt/TOOLS/SCRIPTS/CHECKS/plugins/"
time=$(date +%d/%m/%y)


find $path -name "check*.sh" -exec bash {} >> /opt/omd/sites/monit1/var/log/nagios.log \;

echo "$time - Runned scripts" >> /opt/TOOLS/SCRIPTS/run_all_check.log
