#written by Patryk Basko
#ver 0.1a

import random
import string
import os
from subprocess import Popen, PIPE
import subprocess
import time
import sys

def get_random_password():
    random_source = string.ascii_letters + string.digits

    password = random.choice(string.ascii_lowercase)
    password += random.choice(string.ascii_uppercase)
    password += random.choice(string.digits)
    password += "@"
    password += "_"

    for i in range(password_length):
        password += random.choice(random_source)

    password_list = list(password)



    random.SystemRandom().shuffle(password_list)
    password = ''.join(password_list)
    return password

def run_ssh(host, command):
    connect = [host, command]
    return Popen(connect, stdout=PIPE, stderr=PIPE, stdin=PIPE)


change_pass = 'echo root:$password | chpasswd </dev/null'

#change this value, if you want different length of password
password_length = 20

#for linux
os.system('cat /root/.bash_profile | grep "^alias" | grep -e erc -e elm -e ace| grep -oP "ssh.*\d+\.\d+\.\d+\.\d+" > /root/tests_script/file_test')

with open("/root/tests_script/file_test", "r") as file:
   for lines in file:
        print("I will change password for: "+lines, '')
        get_random_password()
#change_pass = 'echo root:$password | chpasswd </dev/null'
#subprocess.Popen("lines change_pass".format(lines=lines, change_pass=change_pass), shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()
#        ssh = subprocess.Popen([(lines), change_pass], shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
#        result = ssh.stdout.readlines()
#        if result == []:
#          error = ssh.stderr.readlines()
#          print >>sys.stderr, "ERROR: %s" % error
#        else:
#          print(result)
#        result = run_ssh(lines, 'ls').stdout.read()
#        print(result)
        #os.system('ls')
#        p1 = Popen(split(lines), stdout=PIPE)
#        p2 = Popen(split("ls"), stdin=p1.stdout)
#        print(p2.stdout())

        commands = [lines, "ls"]
        os.system(commands)

#os.system(lines)
        print("your password: ", get_random_password(), "\n--------------")

#---------------FOR TESTING PASSWORDS-------------------
#i = 0
#while i < 50:
#    print("Random Password is ", get_random_password())
#    i += 1
#----------------------END------------------------------
