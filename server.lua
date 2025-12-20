RegisterNetEvent('ylx-memenu:syncStatus')
AddEventHandler('ylx-memenu:syncStatus', function(part, data)
    local src = source
    -- Envia para todos os clientes (incluindo quem enviou, para ver o proprio status)
    TriggerClientEvent('ylx-memenu:receiveSync', -1, src, part, data)
end)

RegisterNetEvent('ylx-memenu:clearAll')
AddEventHandler('ylx-memenu:clearAll', function()
    local src = source
    TriggerClientEvent('ylx-memenu:receiveClear', -1, src)
end)