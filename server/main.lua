if Config.Framework == "ESX" then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    print('here')
    ESX.RegisterUsableItem(Config.ItemName,function(source)
        -- local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('experience_studio:startLight', source)
    end)
elseif Config.Framework == "QB-Core" then
    local QBCore = exports['qb-core']:GetCoreObject()
    QBCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
        TriggerClientEvent('experience_studio:startLight', source)
    end)
end