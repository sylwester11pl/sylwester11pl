import random
import string
import os


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

def change_password():
    change_pass = os.system("echo root:$password | chpasswd </dev/null")


#change this value, if you want different length of password
password_length = 20

#for linux
find_ssh = os.system("cat /root/.bash_profile | grep "^alias" | grep -e erc -e elm -e ace| grep -oP 'ssh.*\d+\.\d+\.\d+\.\d+' > /root/file_test")
ssh_file = open("/root/file_test", "r")
count = 0

while True:
    count += 1
    line = ssh_file.readline()
    get_random_password()
    change_password()
    print("{} Password is ", password)
ssh_file.close()

#---------------FOR TESTING PASSWORDS-------------------
#i = 0
#while i < 50:
#    print("Random Password is ", get_random_password())
#    i += 1
#----------------------END------------------------------
