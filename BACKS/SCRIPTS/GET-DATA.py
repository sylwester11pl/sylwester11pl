#!/usr/bin/env python3

import os


print("WELCOME TO THE COLLECTOR!!!11!\n")

ubuntu = ["uname -r" , "cat /etc/hosts" , "ip a | grep -oP '\d+.\d+.\d+.\d+'" , "whoami"]
debian = ["uname -r" , "cat /etc/hosts" , "ip a | grep -oP '\d+.\d+.\d+.\d+'"]
centos = ["uname -r" , "ip a | grep -oP '\d+.\d+.\d+.\d+'" , "whoami"]

#check_me = 'cat /etc/os-release | grep -E ^NAME'
test = "pizda"

#print("Test output from os.command: " + str(os.system('cat /etc/os-release | grep -E ^NAME')))

dupa = input("Give me your system name: ")

while dupa != test:
	print("NOPE")
	dupa 

else:
	print("correct madam!")

