import os
from datetime import date
import time



print("=============+++++===========","\n","Script was running on "+time.ctime())
path=os.listdir("C:\\Users\\Pantera\\Desktop\\python\\")
#NewDirectory=os.mkdir("tests_logs")
#print(path)
for pliki in path:
    print(path)



if path == "tests_logs":
    print("Directory $NewDirectory is already exists")
else:
    print("Directory $NewDirectory not exists")
    os.mkdir("tests_logs")
    