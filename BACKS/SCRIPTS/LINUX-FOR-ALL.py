import os
import time

os_commands = ["ls -la" , 'cat /etc/passwd | grep "root"' , "date" , "whoami"]
results_of_commands = []

print("TESTING OS COMMANDS\n*******\n")

i = 0

for i in os_commands:

	os.system(i)
	time.sleep(1)
	NewFile = ("\\root\\test-output-python", a)
	NewFile.write(
