-- bridge/bridge.lua
Framework = {}
Config = Config or {}
Config.Framework = 'qbcore' -- 'qbx' | 'qbcore' | 'esx'

-- Initialize the bridge's framework name from config
Framework.name = Config.Framework

local QBCore = Config.Framework == 'qbcore' and exports['qb-core']:GetCoreObject() or nil
local ESX = Config.Framework == 'esx' and exports['es_extended']:getSharedObject() or nil
-- Get a player object from source
function Framework.GetPlayer(src)
    if Framework.name == 'qbx' then
        return exports.qbx_core:GetPlayer(src)
    elseif Framework.name == 'qbcore' then
        return QBCore.Functions.GetPlayer(src)
    elseif Framework.name == 'esx' then
        return ESX.GetPlayerFromId(src)
    else
        return nil
    end
end

-- Get metadata/stat
function Framework.GetMeta(player, key)
    if not player then return nil end
    if Framework.name == 'qbx' or Framework.name == 'qbcore' then
        return player.PlayerData.metadata[key]
    elseif Framework.name == 'esx' then
        return player.get(key)
    else
        return nil
    end
end

-- Set metadata/stat
function Framework.SetMeta(player, key, value)
    if not player then return end
    if Framework.name == 'qbx' or Framework.name == 'qbcore' then
        player.Functions.SetMetaData(key, value)
    elseif Framework.name == 'esx' then
        player.set(key, value)
    end
end