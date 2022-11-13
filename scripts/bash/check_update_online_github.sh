#This "check" will update online repo from local
#Patryk Basko
#ver 0.1
#replace my name by your if it is necessery

#!/bin/bash

echo "This script will check all LOCAL repo and send update to ONLINE MASTER if it necessary - everyday (now only TE) and save logs"
echo "============================================="



cd /opt/GITHUB/TE


#here is log from git command with operation date
date >> /opt/LOG/update_online_repo.log
git commit -m "Update from DEBIAN" >> /opt/LOG/update_online_repo.log
git push --force origin main -v >> /opt/LOG/update_online_repo.log
echo "=========++++++++++==========" >> /opt/LOG/update_online_repo.log
#here is log for me (daily audit)
echo "`date` - All repo has been updated!!" >> /opt/LOG/check_online_github.log

