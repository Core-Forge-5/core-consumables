name "Core-Consumables"
author "CoreForge"
version "1.0.0"
description "Core Consumables — Add drugs, food, drinks with effects in minutes. https://github.com/Core-Forge-5/core-consumables"
fx_version "cerulean"
game "gta5"

shared_scripts {
    '@ox_lib/init.lua',
    'config/consume.lua',
    'bridge/bridge.lua'
}

client_scripts {
    'client/cl_consume.lua',
}

server_scripts {
    'server/sv_consume.lua',
}