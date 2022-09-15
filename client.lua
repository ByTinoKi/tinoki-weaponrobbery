local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
ESX = nil

local RobberyInProgress = false 
local Done1, Done2, Done3, isCraftingWeapon = false, false, false , false  
soundid = GetSoundId()

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) 
	ESX.PlayerData.job = job
end)

CreateThread(function()
	local AmmunationDoor = Config.AmmunationDoor.coords
	local Blip1Coords = Config.BlipReward1.coords
	local Blip2Coords = Config.BlipReward2.coords
	local Blip3Coords = Config.BlipReward3.coords
	local AmmunationDoorLeft = GetClosestObjectOfType(AmmunationDoor , 2.5, GetHashKey("v_ilev_gc_door04"), false)
	local AmmunationDoorRight = GetClosestObjectOfType(AmmunationDoor , 2.5, GetHashKey("v_ilev_gc_door03"), false)
	FreezeEntityPosition(AmmunationDoorLeft, true)
	FreezeEntityPosition(AmmunationDoorRight, true)
	while true do
		waitHouseRobbery3 = 1000
		local coords = GetEntityCoords(PlayerPedId())
		local AmmunationDoorCoords = GetDistanceBetweenCoords(coords, AmmunationDoor, true)
		local Blip1 = GetDistanceBetweenCoords(coords, Blip1Coords, true)
		local Blip2 = GetDistanceBetweenCoords(coords, Blip2Coords, true)
		local Blip3 = GetDistanceBetweenCoords(coords, Blip3Coords, true)
		if AmmunationDoorCoords < 3.0 and not RobberyInProgress then 
			waitHouseRobbery3 = 1
			DrawMarker(1, AmmunationDoor, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.5, 255, 0, 0, 100, false, true, 2, false, nil, nil, false)
			if AmmunationDoorCoords < 1.5 then 
				DrawText3Ds(Config.AmmunationDoor.coords , Config.Notification1 , 0.4)
				if IsControlJustReleased(0, Keys['E']) then
					ESX.TriggerServerCallback('tinoki-weaponrobbery:getPolice', function(passed)
						if passed then 
					SetEntityCoords(PlayerPedId(), AmmunationDoor)
					SetEntityHeading(PlayerPedId(), Config.AmmunationDoor.heading)
					exports.rprogress:Custom({
						Duration = 5500,
						Label = Config.Notification10,
						Animation = {
							scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
							animationDictionary = "", -- https://alexguirre.github.io/animations-list/
						},
						DisableControls = {
							Mouse = false,
							Player = true,
							Vehicle = true
						}
					})
					Wait(5500)
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent("tinoki-weaponrobbery:Start")
				end
			end) 
		end 
	end 
end 
		
		if RobberyInProgress then 
			if not Done1 then 
				waitHouseRobbery3 = 1
				DrawMarker(1, Blip1Coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.5, 255, 0, 0, 100, false, true, 2, false, nil, nil, false)
				if Blip1 < 1.5 then 
					DrawText3Ds(Config.BlipReward1.coords , Config.Notification4 , 0.4)
					if IsControlJustReleased(0, Keys['E']) then
						SetEntityCoords(PlayerPedId(), Blip1Coords)
						SetEntityHeading(PlayerPedId(), Config.BlipReward1.heading)
						exports.rprogress:Custom({
							Duration = Config.StealTime,
							Label = Config.Notification11,
							Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "", -- https://alexguirre.github.io/animations-list/
							},
							DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
							}
						})
						Wait(Config.StealTime)
						ClearPedTasksImmediately(PlayerPedId())
						TriggerServerEvent("tinoki-weaponrobbery:UR")
						Done1 = true 
						exports.pNotify:SendNotification({
							text = (Config.Notification8), 
							type = "success", 
							timeout = math.random(3500, 4000), 
							layout = "centerLeft", 
							queue = "left"
						})

					end 
				end 	
			end 
			
			if not Done2 then 
				waitHouseRobbery3 = 1
				DrawMarker(1, Blip2Coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.5, 255, 0, 0, 100, false, true, 2, false, nil, nil, false)
				if Blip2 < 1.5 then 
					DrawText3Ds(Config.BlipReward2.coords , Config.Notification4 , 0.4)
					if IsControlJustReleased(0, Keys['E']) then
						SetEntityCoords(PlayerPedId(), Blip2Coords)
						SetEntityHeading(PlayerPedId(), Config.BlipReward2.heading)
						exports.rprogress:Custom({
							Duration = Config.StealTime,
							Label = Config.Notification11,
							Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "", -- https://alexguirre.github.io/animations-list/
							},
							DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
							}
						})
						Wait(Config.StealTime)
						ClearPedTasksImmediately(PlayerPedId())
						TriggerServerEvent("tinoki-weaponrobbery:UR")
						Done2 = true 
						exports.pNotify:SendNotification({
							text = (Config.Notification8), 
							type = "success", 
							timeout = math.random(3500, 4000), 
							layout = "centerLeft", 
							queue = "left"
						})

					end 
				end 
			end 
			
			if not Done3 then 
				waitHouseRobbery3 = 1
				DrawMarker(1, Blip3Coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.5, 255, 0, 0, 100, false, true, 2, false, nil, nil, false)
				if Blip3 < 1.5 then 
					DrawText3Ds(Config.BlipReward3.coords , Config.Notification4 , 0.4)
					if IsControlJustReleased(0, Keys['E']) then
						SetEntityCoords(PlayerPedId(), Blip3Coords)
						SetEntityHeading(PlayerPedId(), Config.BlipReward3.heading)
						exports.rprogress:Custom({
							Duration = Config.StealTime,
							Label = Config.Notification11,
							Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "", -- https://alexguirre.github.io/animations-list/
							},
							DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
							}
						})
						Wait(Config.StealTime)
						ClearPedTasksImmediately(PlayerPedId())
						TriggerServerEvent("tinoki-weaponrobbery:UR")
						Done3 = true 
						exports.pNotify:SendNotification({
							text = (Config.Notification8), 
							type = "success", 
							timeout = math.random(3500, 4000), 
							layout = "centerLeft", 
							queue = "left"
						})

					end 
				end 	
			end 
		end 

		if isCraftingWeapon then 
			DisableAllControlActions(0)
			if IsEntityPlayingAnim(PlayerPedId(), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@', function()
					TaskPlayAnim(PlayerPedId(), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		end 
		Citizen.Wait(waitHouseRobbery3)
	end
end)

RegisterNetEvent('tinoki-weaponrobbery:Unlock')
AddEventHandler('tinoki-weaponrobbery:Unlock', function() 
	RobberyInProgress = true 
	local AmmunationDoor = Config.AmmunationDoor.coords
	local AmmunationDoorPFX = Config.AmmunationDoorParticle.coords
	PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", AmmunationDoor)
	RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
	SetPtfxAssetNextCall("scr_ornate_heist")
	local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", AmmunationDoorPFX, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	local AmmunationDoorLeft = GetClosestObjectOfType(AmmunationDoor , 2.5, GetHashKey("v_ilev_gc_door04"), false)
	local AmmunationDoorRight = GetClosestObjectOfType(AmmunationDoor , 2.5, GetHashKey("v_ilev_gc_door03"), false)
	Wait(10000)
	FreezeEntityPosition(AmmunationDoorLeft, false)
	FreezeEntityPosition(AmmunationDoorRight, false)
    StopParticleFxLooped(effect, 0)
	Wait(30000)
	StopSound(soundid)
end)

RegisterNetEvent('tinoki-weaponrobbery:Start')
AddEventHandler('tinoki-weaponrobbery:Start', function() 
	RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
        RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
        Citizen.Wait(10)
    end
	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(7000)
    ClearPedTasks(PlayerPedId())
	Citizen.Wait(3000)
end)

RegisterNetEvent('tinoki-weaponrobbery:Reset')
AddEventHandler('tinoki-weaponrobbery:Reset', function() 
	local AmmunationDoor = Config.AmmunationDoor.coords
	local AmmunationDoorLeft = GetClosestObjectOfType(AmmunationDoor , 2.5, GetHashKey("v_ilev_gc_door04"), false)
	local AmmunationDoorRight = GetClosestObjectOfType(AmmunationDoor , 2.5, GetHashKey("v_ilev_gc_door03"), false)
	FreezeEntityPosition(AmmunationDoorLeft, true)
	FreezeEntityPosition(AmmunationDoorRight, true)
	RobberyInProgress = false
end)

RegisterNetEvent('tinoki-weaponrobbery:AddWeapon')
AddEventHandler('tinoki-weaponrobbery:AddWeapon', function(stats) 
	if stats == 1 then 
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), 5, false, false)
		exports.pNotify:SendNotification({
			text = (Config.Notification5), 
			type = "success", 
			timeout = math.random(3500, 4000), 
			layout = "centerLeft", 
			queue = "left"
		})

	elseif stats == 2 then 
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MINISMG"), 5, false, false)
		exports.pNotify:SendNotification({
			text = (Config.Notification6), 
			type = "success", 
			timeout = math.random(3500, 4000), 
			layout = "centerLeft", 
			queue = "left"
		})

	elseif stats == 3 then 
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE"), 5, false, false)
		exports.pNotify:SendNotification({
			text = (Config.Notification7), 
			type = "success", 
			timeout = math.random(3500, 4000), 
			layout = "centerLeft", 
			queue = "left"
		})
	end
end)

---3d text function

DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 370

	DrawRect(_x, _y + 0.0140, 0.030 + factor, 0.025, 0, 0, 0, 100)
end


