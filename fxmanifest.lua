
fx_version 'cerulean'
game 'gta5'

description 'LVS LicensePlate - calma anneni yalarim'
author 'Arda'
version '1.0.0'

client_script 'client.lua'
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"server.lua",
}


ui_page 'html/index.html'

files {
  'html/index.html',
  'html/style.css',
  'html/script.js',
  'html/plate.png',
  'html/arkaplan.jpg'
}
