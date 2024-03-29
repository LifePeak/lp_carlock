
-- Resource Metadata
fx_version 'cerulean'
games {'gta5'}
author 'ZickZackHD <ZickZackHD#4834>, SeaLife'
description 'Car lock System by Lifepeak'
version '1.0.6'
name 'lp_carlock'
url 'https://github.com/zickzackhd'
lua54 'yes'

shared_script '@es_extended/imports.lua'

shared_script {
	'config.lua',
}

client_scripts {
	"@es_extended/locale.lua",
	'locales/*.lua',
    "client.lua",

}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	"server.lua"
}

dependencies {
	'es_extended'
}
