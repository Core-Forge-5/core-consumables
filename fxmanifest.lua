name "Core-Consumables"
author "CoreForge"
version "1.0.0"
description "Core Consumables — Add drugs, food, drinks with effects in minutes."
fx_version "cerulean"
game "gta5"

shared_scripts {
    '@ox_lib/init.lua',
    'config/consume.lua',
}

client_scripts {
    'client/cl_consume.lua',
}

server_scripts {
    'server/sv_consume.lua',
}