#!/bin/bash

#This check verify volumes storage. 
#Output is generate for each of volume.

#check how many "backups" directory are exist
let count=$(ls /backup/ | wc -l)
let x=1

#volumes="/backup/backup0$x/bareos"


#check how many "devices" are exist
#let z=1
#let count_dev=$(ls $volumes | wc -l)

for (( i=1; i<=$count; i++ )); do
	volumes="/backup/backup0$x/bareos"
	let z=1
	let count_dev=$(ls $volumes | wc -l)
	#let "x+=1"
	#for (( y=1; y<=$count_dev; y++ )); do
	declare -a "volumes_array$x=($(cd $volumes && du -sh * | sed -n '1,5p'))"
	echo "volumes_array$x" >> /root/tmp.list
	let "z+=1"
	let "x+=1"
	#done
done

#for each backup directory check storage

#for (( i=1; i<=$count; i++ )); do
	#volumes="/backup/backup0$x/bareos"#
#	declare -a "volumes_array$x=($(ls $volumes | du -sh * | sed -n 1p ))"
#	let "x+=1"
#done

#let "x-=1"

#echo "Koniec pierwszej petli, x=$x"
#for earch main directory, print included storages

echo -e "Spis storage oraz zajete miejsce."
echo "${volumes_array1[*]}"
echo "${volumes_array2[*]}"

echo "AUTOMAT"
echo ""

while read -r line
do
	echo $line
done < /root/tmp.list

rm /root/tmp.list
#z=x
#let x=1
#read_array="volumes_array$x"
#for (( i=1; i>=$z; i++ )); do
#	echo "${read_array[@]}"
#	let "x+=1"
#done

#echo -e "${volumes_array1[*]}"
#echo -e "${volumes_array2[*]}"
#echo -e "${volumes_array3[*]}"
