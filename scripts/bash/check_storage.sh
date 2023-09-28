#!/bin/bash

#This check verify volumes storage.
#Output is generate for each of volume.
#Created by: Patryk Basko


#---------------
#General variables
ts=$(date +%s)


#---------------
#check how many "backups" directories are exist.
#This is main statement for script.
let count=$(ls /backup/ | wc -l)
let x=1                                                                                 #global variable, do not modify

#---------------
#Check how many "devices" are exist.
#On this step, loop checking how many "devices" directories exists on backup path.
#Next create arrays for each of "devices" and filled.
for (( i=1; i<=$count; i++ )); do
        volumes="/backup/backup0$x/bareos"
        let z=1
        let count_dev=$(ls $volumes | wc -l)
        #let "x+=1"
        #for (( y=1; y<=$count_dev; y++ )); do
        declare -a "volumes_array$x=($(cd $volumes && du -sh * | sed -n '1,5p'))"
        let "z+=1"
        let "x+=1"
        #done
done

#test space - for debuging. This is for me and should be removed.
#echo -e "Spis storage oraz zajete miejsce."
#echo "${volumes_array1[*]}"
#echo "${volumes_array2[*]}"

#echo -e "========+++++============\nAUTOMAT"
#echo ""

#---------------
#Print info from each of array included output for check_mk.
#This value is increase depends on arrays count.
let array_num=1                                                                         #global variable, do not modify

for (( i=1; i<=$x; i++ )); do
        array_name=volumes_array$array_num[@]
        printf "P "check_storage" |storage=%s;20;50 volume=%s \n" ${!array_name}
        let "array_num+=1"
done