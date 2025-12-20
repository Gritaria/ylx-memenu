rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

fx_version 'rdr3' 
games { 'rdr3' }

name 'ylx-memenu'
author 'yLx'
description 'Sistema de status médico 3D para RedM - 100% Standalone (sem dependências)'
version '2.0.0'

ui_page 'UI/index.html'

files {
    'UI/index.html',
    'UI/style.css',
    'UI/script.js'
}

-- Config deve ser carregado PRIMEIRO
shared_script 'config.lua'

-- Scripts client e server depois
client_script 'client.lua'
server_script 'server.lua'