#!/bin/bash

#script generate randomize 3 numbers for each line
#author: Patryk Basko

#######

date=$(date +%D)
#defined colors, NC use to disable painting
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
NC='\033[0m'

$(shuf -i 1-81 -n81 > informatyka-numbers.log)

while IFS= read -r line
do
	echo -e "${G}$line${NC}"
		
		
		number=$(head -n 3 informatyka-numbers.log)
		$(sed '1,3d' informatyka-numbers.log)
		echo -e "$number"
	
done < informatyka-users.list
