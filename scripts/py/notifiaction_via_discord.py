#This script sending notification via Discord
#Use this script to send notification when torrents download done
#On this version, you must integrate script with your torrent application
#version 0.1
#Patryk Basko


from discordwebhook import Discord

discord = Discord(url="https://discord.com/api/webhooks/1041453417106771988/VFfPUIzixszP5nT9LDTQnnAIvlxfCBCA32i-BRqcp6iBzR7hXV9cp0P-x9e0vVzV_CNS")
discord.post(content="Ukończono pobieranie torrenta!!!")