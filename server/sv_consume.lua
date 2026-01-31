Consume = Consume or {}

RegisterNetEvent('core-consumables:server:consume', function(item)
    local src = source
    local cfg = Consume[item]
    if not cfg then return end

    local count = exports.ox_inventory:Search(src, 'count', item)
    if count < 1 then return end

    local shouldRemove = cfg.remove ~= false --True if nil or true, only false if false
    if shouldRemove then
        exports.ox_inventory:RemoveItem(src, item, 1)
    end
end)

RegisterNetEvent('core-consumables:server:updateStatus', function(stat, value)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    if not Player then return end

    local metadata = Player.PlayerData.metadata
    if metadata[stat] == nil then return end

    local newValue = metadata[stat] + value
    if newValue < 0 then newValue = 0 end

    Player.Functions.SetMetaData(stat, newValue)
end)
