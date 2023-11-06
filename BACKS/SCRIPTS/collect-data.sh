#!bin/bash


version_os="cat /etc/os-release | grep "VERSION=" | grep -oP '\d+'"

echo $version_os
