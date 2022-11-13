#This "check" will update local repo 
#Patryk Basko
#ver 0.1
#replace my name by your if it is necessery

#!/bin/bash

echo "This script will check all MAIN ONLINE repo and update LOCAL if it necessary - everyday (now only TE) and save logs"
echo "============================================="


#move to catalog where are a repo name "TE"
cd /opt/GITHUB/TE


#here is log from git command with operation date
date >> /opt/LOG/update_local_repo.log
git pull -v --progress >> /opt/LOG/update_local_repo.log
echo "=========++++++++++==========" >> /opt/LOG/update_local_repo.log
#here is log for me (daily audit)
echo "`date` - All repo has been updated!!" >> /opt/LOG/check_local_github.log

