#This script sending notification via Discord
#Use this script to send notification when torrents download done
#On this version, you must integrate script with your torrent application
#version 0.1
#Patryk Basko

#replace XXXX by your weebhook

from discordwebhook import Discord

discord = Discord(url="XXXXXXX")
discord.post(content="Ukończono pobieranie torrenta!!!")
