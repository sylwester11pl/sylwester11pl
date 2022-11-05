#This is first script to run my skills engine :-)


import time
import os
import sys


print("This is test a new envroinment\n")
print("Now date/time is: ", time.ctime(),"\n")
directory1=os.chdir("C:\\Users\\Pantera\\Desktop\\python\\testy2")
print("I'm moving to main catalog\n")
time.sleep(2)
directory1

print("Now you are on: ", os.getcwd(), "\n")
print("Program has been closed at 5s", "\n")
for t in range(5,0,-1):
    print("Program has been closed at: ", t , " seconds\n")
    time.sleep(1)
else:
    print("Program say 'goodbyee'")
    input("Press any key to continue...")