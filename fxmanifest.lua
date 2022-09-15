fx_version 'cerulean'
games { 'gta5' }

author 'TinoKi'
description 'Weapon Store Robbery'

client_scripts {
	'@es_extended/locale.lua',
	'client.lua',
	'config.lua',
}

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server.lua',
}