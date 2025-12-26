rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

fx_version 'rdr3' 
games { 'rdr3' }

name 'ylx-memenu'
author 'yLx'
description 'Status display system with /me and /memenu commands for body parts with customizable NUI'
version '1.1.0'

ui_page 'UI/index.html'

files {
    'UI/index.html',
    'UI/style.css',
    'UI/script.js'
}

shared_script 'config.lua'

client_script 'client.lua'
server_script 'server.lua'
