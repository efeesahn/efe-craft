ESX = nil
PlayerData = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('efe-uret:kontrol', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = xPlayer.getInventoryItem(item).count
	local quanity2 = xPlayer.getInventoryItem(item).count
	local quanity3 = xPlayer.getInventoryItem(item).count
	local quanity4 = xPlayer.getInventoryItem(item).count
    
    cb(quantity, quanity2, quanity3, quanity4)
end)

RegisterServerEvent("efe-uret:ballas")
AddEventHandler("efe-uret:ballas", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem("sgovde", 38)
	xPlayer.removeInventoryItem("smetal", 53)
	xPlayer.removeInventoryItem("aluminum", 105)
	xPlayer.removeInventoryItem("silahyayi", 48)
	
	xPlayer.addInventoryItem(Config.Ballas, 1)
	TriggerClientEvent('notification', source, 'Elde edilen : 1x AP Pistol', 3)
end)

RegisterServerEvent("efe-uret:grove")
AddEventHandler("efe-uret:grove", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem("sgovde", 38)
	xPlayer.removeInventoryItem("smetal", 53)
	xPlayer.removeInventoryItem("aluminum", 105)
	xPlayer.removeInventoryItem("silahyayi", 48)

	xPlayer.addInventoryItem(Config.Families, 1)
	TriggerClientEvent('notification', source, 'Elde edilen : 1x Heavy Pistol', 3)
end)

RegisterServerEvent("efe-uret:vagos")
AddEventHandler("efe-uret:vagos", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem("sgovde", 38)
	xPlayer.removeInventoryItem("smetal", 53)
	xPlayer.removeInventoryItem("aluminum", 105)
	xPlayer.removeInventoryItem("silahyayi", 48)

	xPlayer.addInventoryItem(Config.Vagos, 1)
	TriggerClientEvent('notification', source, 'Elde edilen : 1x Machine Pistol', 3)
end)

RegisterServerEvent("efe-uret:astecas")
AddEventHandler("efe-uret:astecas", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem("sgovde", 38)
	xPlayer.removeInventoryItem("smetal", 53)
	xPlayer.removeInventoryItem("aluminum", 105)
	xPlayer.removeInventoryItem("silahyayi", 48)

	xPlayer.addInventoryItem(Config.Astecas, 1)
	TriggerClientEvent('notification', source, 'Elde edilen : 1x Vıntage Pistol', 3)
end)

RegisterServerEvent("efe-uret:lost")
AddEventHandler("efe-uret:lost", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem("sgovde", 38)
	xPlayer.removeInventoryItem("smetal", 53)
	xPlayer.removeInventoryItem("aluminum", 105)
	xPlayer.removeInventoryItem("silahyayi", 48)
	
	xPlayer.addInventoryItem(Config.Lost, 1)
	TriggerClientEvent('notification', source, 'Elde edilen : 1x COMPACT RIFLE', 3)
end)
