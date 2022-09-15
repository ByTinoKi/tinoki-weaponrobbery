ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('tinoki-weaponrobbery:Start')
AddEventHandler('tinoki-weaponrobbery:Start', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xPlayers = ESX.GetPlayers()
	local xItem = xPlayer.getInventoryItem(Config.DoorItem).count 
	if xItem > 0 then 
		xPlayer.removeInventoryItem(Config.DoorItem, 1)
		TriggerClientEvent("tinoki-weaponrobbery:Unlock", -1)
		TriggerClientEvent("tinoki-weaponrobbery:Start", xPlayer.source)
	
		for i=1, #xPlayers, 1 do
			local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer2.job.name == 'police' then
				TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification13), timeout = 5000})
			end
		end
		Wait(10000)
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification2), timeout = 5000})
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification3), timeout = 5000})
	end 
end)

RegisterNetEvent('tinoki-weaponrobbery:UR')
AddEventHandler('tinoki-weaponrobbery:UR', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local random1 = math.random(Config.minSpring, Config.maxSpring)
	local random2 = math.random(1, 3)
	xPlayer.addInventoryItem(Config.BasicItem, random1)
	if random2 == 1 then 
		xPlayer.addInventoryItem(Config.Part1, Config.Part1Amount)
	elseif random2 == 2 then 
		xPlayer.addInventoryItem(Config.Part2, Config.Part2Amount)
	elseif random2 == 3 then 
		xPlayer.addInventoryItem(Config.Part3, Config.Part3Amount)
	end 
end)

local ItemPart1 = Config.Part1
local ItemPart2 = Config.Part2
local ItemPart3 = Config.Part3

ESX.RegisterUsableItem(ItemPart1, function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xItem = xPlayer.getInventoryItem(Config.BasicItem).count 
	if xItem >= Config.PistolSpring then 
		xPlayer.removeInventoryItem(Config.Part1, 1)
		if Config.WeaponAsItem then 
			xPlayer.addInventoryItem(Config.Weapon1, 1)
		else 
			TriggerClientEvent("WeaponRobbery:AddWeapon", src, 1)
		end 
	else 
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification9), timeout = 5000})
	end 
end)

ESX.RegisterUsableItem(ItemPart2, function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xItem = xPlayer.getInventoryItem(Config.BasicItem).count 
	if xItem >= Config.SMGSpring then 
		xPlayer.removeInventoryItem(Config.BasicItem, 1)
		xPlayer.removeInventoryItem(Config.Part2, 1)
		if Config.WeaponAsItem then 
			xPlayer.addInventoryItem(Config.Weapon2, 1)
		else 
			TriggerClientEvent("WeaponRobbery:AddWeapon", src, 2)
		end 
	else 
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification9), timeout = 5000})
	end 
end)


ESX.RegisterUsableItem(ItemPart3, function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xItem = xPlayer.getInventoryItem(Config.BasicItem).count 
	if xItem >= Config.AssaultSpring then
		xPlayer.removeInventoryItem(Config.Part3, 1)
		if Config.WeaponAsItem then 
			xPlayer.addInventoryItem(Config.Weapon3, 1)
		else 
			TriggerClientEvent("WeaponRobbery:AddWeapon", src, 3)
		end 
	else 
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification9), timeout = 5000})
	end 
end)

ESX.RegisterServerCallback('tinoki-weaponrobbery:getPolice', function(source, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	
	local xPlayers = ESX.GetPlayers()

	totalPolice = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			totalPolice = totalPolice + 1
		end
	end
	
	if totalPolice >= Config.MinPolice then 
		cb(true)
	else 
		cb(false)
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification12), timeout = 5000})
	end 
end)