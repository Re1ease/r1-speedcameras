fx_version 'bodacious'
game 'gta5'
author "Re1ease#0001"
version "1.0.0"
description 'Speedcam'
lua54 'yes'

shared_script 'shared/*.lua'
client_script 'client/*.lua'
server_scripts {'@oxmysql/lib/MySQL.lua', 'server/*.lua'}