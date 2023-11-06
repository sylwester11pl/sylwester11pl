#This "check" will update local repo 
#Patryk Basko
#ver 0.1
#replace my name by your if it is necessery

#!/bin/bash

echo "This script will check my repo and logging operation"
echo "============================================="


#move to catalog where are a repo name 
cd /opt/TOOLS/GITHUB/sylwester11pl


#here is log from git command with operation date
date >> /opt/LOGs/update_local_repo.log
git pull -v --progress >> /opt/TOOLS/SCRIPTS/update_local_repo.log
echo "=========++++++++++==========" >> /opt/LOGs/update_local_repo.log
#here is log for me (daily audit)
echo "`date` - All repo has been updated!!" >> /opt/LOGs/check_local_github.log

