#This script was created by Patryk Basko
#version 0.1
#changelog - IN PROGRESS
#last modification date: 10/11/2022

import calendar
import time
import os
from tqdm import tqdm


global ActuallPath
ActuallPath=str(os.getcwd()+"\\")

NewFile = open(ActuallPath+"\\"+"DateTimeTest.log" , "a")


TimeLocal = time.ctime()
TimeEpoch=time.time()
TimeModify=os.stat("DateTimeTest.log")
TimeDiffrent=TimeEpoch-TimeModify.st_mtime
TimeDiffrent=str(round(TimeDiffrent, 0))

PathToLogs =("C:\\Users\\a866590\\OneDrive - Atos\\Desktop\\python_test_logs\\")


NewFile.write("==============++++++++=============\n"+"Script was starded: "+TimeLocal+"\n"+"These files are located on main directory "+ActuallPath+"\n")
NewFile.write(str(os.listdir(ActuallPath))+"\n")
NewFile.write("Last time modification of log file: "+TimeDiffrent+" seconds\n\n")
NewFile.close()


def menu():
    print("\n","Place where you are now: ",ActuallPath,"\n")
    print("Available options\n")
    print("1. Directory\n")
    print("2. File\n")
    print("3. Check IP address -> WORK IN PROGRESS\n")
    print("4. EMPTY -> WORK IN PROGRESS\n")
    print("5. EXIT to life\n")

def menuNetwork():
    print("\n","Available options\n")
    print("1. Show IP address\n")
    print("2. Show actuall connections\n")
    print("3. Ping custom IP address\n")
    print("4. WORK IN PROGRESS\n")
    print("5. Back to UP\n")

    
def clearShit():
    os.system("cls")  

def progressBar():
    progress='======'
    wait=time.sleep(1)
    for bar in progress:
        print(progress*3, end = "")
    wait
    os.system("cls")
    print("CLEAN DONE")
               
def enteringNetworkMenu():
    print("\t"*5,"***ENTERING TO NETWORK UTILITY***\n")
    for x in tqdm(range(10)):
        time.sleep(0.1)
        
    input("\nPress ENTER to continue")
    
def enteringCustomMenu():
    print("\t"*5,"***ENTERING TO CUSTOM UTILITY***\n")
    for x in tqdm(range(10)):
        time.sleep(0.1)
        
    input("\nPress ENTER to continue")    

def enteringMainMenu():
    print("\t"*5,"***ENTERING TO MAIN MENU***\n")
    for x in tqdm(range(10)):
        time.sleep(0.1)
        
    input("\nPress ENTER to continue")


choiceNetwork = int(0)
def wyborNetwork():
    
    while choiceNetwork <= 4:
        #menuNetwork();
        #choiceNetwork = int(input("What is your wish? "))
        if choiceNetwork == 5:
            print("Back to UP\n")
            time.sleep(3)
            progressBar();
            menu();
        elif choiceNetwork > 5:
            print("BAD CHOICE, SCRIPT WILL BE TERMINATED\n");
            time.sleep(3)
        else:
            match choiceNetwork:
                case 1:
                    print("IN PROGRESS\n")
                    progressBar();
                    input("\nPress ENTER to continue")
                    #break
                case 2:
                    print("IN PROGRESS\n")
                    progressBar();
                    input("\nPress ENTER to continue")
                    #break
                case 3:
                    print("IN PROGRESS\n")
                    progressBar();
                    input("\nPress ENTER to continue")
                    #break
                case 4:
                    print("IN PROGRESS\n")
                    progressBar();
                    input("\nPress ENTER to continue")
                    #break
    
    
#FileName
#NewWorld
print("\n")
#choice = input("You have one choice, please be smart")

#match choice:
#    case "1.Create a directory or file":
#print("Place where you are now: ",ActuallPath,"\n")
#print("Available options\n")
#print("1. Directory\n")
#print("2. File\n")
#print("3. Check IP address -> WORK IN PROGRESS\n")
#print("4. EMPTY -> WORK IN PROGRESS\n")
#print("5. EXIT to life\n")
#choice = int(input("What is your wish? "))

choice = int(0)

while choice <= 4:
    menu();
    choice = int(input("What is your wish? "))
    if choice == 5:
            print("I'm leave on...\n")
            time.sleep(2)
            NewFile = open(ActuallPath+"\\"+"DateTimeTest.log" , "a")
            NewFile.write("\nScript ending at " + time.ctime() + "\n")
            NewFile.close()
    elif choice > 5:
            print("You don't choice beetwen 1-5, please try again!")
            input("Press ENTER to continue")
            NewFile = open(ActuallPath+"\\"+"DateTimeTest.log" , "a")
            NewFile.write("\nScript ending at " + time.ctime() + "\n")
            NewFile.close()
    else:
        match choice:
            case 1:
                
                print("\n****Directories and files which already exists*****\n",str(os.listdir(ActuallPath)))
                print("Name's a directory: \n")
                DirectoryName=input()
                DirectoryName1=ActuallPath+DirectoryName
                try:
                    os.mkdir(DirectoryName1)
                    print("Directory has been created!!\n")
                    NewFile = open(ActuallPath+"\\"+"DateTimeTest.log" , "a")
                    NewFile.write("\nUsed commands: " + "CREATE DIRECTORY")
                    NewFile.close()
                except:
                    print("Directory ",DirectoryName," is exists!!")
                input("Press ENTER to continue")
                progressBar();
                time.sleep(2)
                clearShit();            
        
            case 2:
                print("\n****Directories and files which already exists*****\n",str(os.listdir(ActuallPath)))
                print("Name's a file: \n")
                FileName=input()
                FileName1=ActuallPath+FileName
                try:
                    open (FileName1+".test","w")
                    print("File ",FileName," has been created!!\n")
                except:
                    print("File ",FileName," is exists!!")
                NewFile = open(ActuallPath+"\\"+"DateTimeTest.log" , "a")
                NewFile.write("\nUsed commands: " + "CREATE FILE")
                NewFile.close()
                input("Press ENTER to continue")
                progressBar();
                time.sleep(2)
                clearShit();
        
            case 3:
                clearShit();
                enteringNetworkMenu();
                NewFile = open(ActuallPath+"\\"+"DateTimeTest.log" , "a")
                NewFile.write("\nUsed commands: " + "NETWORK UTILITY")
                NewFile.close()
                
                #here is new loop (next menu)
                #menuNetwork();                
                #choiceNetwork = int(input("What is your wish? "))
                #wyborNetwork();
                while choiceNetwork <= 4:
                        menuNetwork();
                        choiceNetwork = int(input("What is your wish? "))
                        if choiceNetwork == 5:
                            print("Back to UP\n")
                            print("I'm leaving..\n")
                            time.sleep(2)
                            clearShit();
                            enteringMainMenu();
                                                       
                            
                        elif choiceNetwork > 5:
                            print("BAD CHOICE, SCRIPT WILL BE TERMINATED\n");
                            time.sleep(3)
                        else:
                            match choiceNetwork:
                                case 1:
                                    print("IN PROGRESS\n")
                                    progressBar();
                                    input("\nPress ENTER to continue")
                    #break
                                case 2:
                                    print("IN PROGRESS\n")
                                    progressBar();
                                    input("\nPress ENTER to continue")
                    #break
                                case 3:
                                    print("IN PROGRESS\n")
                                    progressBar();
                                    input("\nPress ENTER to continue")
                    #break
                                case 4:
                                    print("IN PROGRESS\n")
                                    progressBar();
                                    input("\nPress ENTER to continue")
                    #break
                
                
                
                #progressBar();
                #time.sleep(2)
                #clearShit();
       
            case 4:
                clearShit();
                enteringCustomMenu();
                NewFile = open(ActuallPath+"\\"+"DateTimeTest.log" , "a")
                NewFile.write("\nUsed commands: " + "CUSTOM UTILITY")
                NewFile.close()
                #progressBar();
                #time.sleep(2)
                clearShit();
        
            #case 5:
             #   print("I'm leave on...\n")
              #  time.sleep(5)
               # break

