ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('merty:addmoney')
AddEventHandler('merty:addmoney', function()
    local source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
        xPlayer.addMoney(Config.Para)
end)
