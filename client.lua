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

local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
	while PlayerData == nil do
        Citizen.Wait(10)
    end
end)

-- notification Handler
function notificationHandler(icon,title,msg,color,sound)
	if Config.NotificationSystem ~= 'lp_notify' then
		ESX.ShowNotification(title..", "..msg, Config.Notification.displaytime, "info")
	else
		TriggerEvent("lifepeak.notify",icon,title,msg,color,true,Config.Notification.Postion,Config.Notification.displaytime,sound)
	end
end
-- Script Variables (dont change them)
local IsLockingCar   = false
local MyVehicles     = {}
local SharedVehicles = {}
local NotMyVehicle   = {}
local Animation 	 = "anim@mp_player_intmenu@key_fob@"
local function ToggleCarLock(Car)
	IsLockingCar = true

	Citizen.CreateThread(function()
		local lock = GetVehicleDoorLockStatus(Car)

		local networkId = NetworkGetNetworkIdFromEntity(Car)

		if lock <= 1 then
			SetVehicleDoorShut(Car, 0, false)
			SetVehicleDoorShut(Car, 1, false)
			SetVehicleDoorShut(Car, 2, false)
			SetVehicleDoorShut(Car, 3, false)
			SetVehicleDoorsLocked(Car, 2)
			SetVehicleDoorsLockedForAllPlayers(Car, 1) -- new
			PlayVehicleDoorCloseSound(Car, 1)
			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			notificationHandler("car",_U('car_interaction'),_U('car_locked',plate),"red","success.mp3")
			--TriggerEvent("notifications", -1,_U('car_interaction'), _U('car_locked'))
			if not IsPedInAnyVehicle(PlayerPedId(), true) then
				TaskPlayAnim(PlayerPedId(), Animation, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
			end
			SetVehicleLights(Car, 2)
			Citizen.Wait(150)
			SetVehicleLights(Car, 0)
			Citizen.Wait(150)
			SetVehicleLights(Car, 2)
			Citizen.Wait(150)
			SetVehicleLights(Car, 0)

			ESX.TriggerServerCallback('lp_carlock:server:syncLockState', function() end, networkId, true)
		elseif lock > 1 then
			SetVehicleDoorsLocked(Car, 1)
			PlayVehicleDoorOpenSound(Car, 0)
			SetVehicleDoorsLockedForAllPlayers(Car, 0) -- new
			notificationHandler("car",_U('car_interaction'),_U('car_unlocked',plate),"green","success.mp3")
			--TriggerEvent('notifications', -1, _U('car_interaction'), _U('car_unlocked'))
			if not IsPedInAnyVehicle(PlayerPedId(), true) then
				TaskPlayAnim(PlayerPedId(), Animation, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
			end
			SetVehicleLights(Car, 2)
			Citizen.Wait(150)
			SetVehicleLights(Car, 0)
			Citizen.Wait(150)
			SetVehicleLights(Car, 2)
			Citizen.Wait(150)
			SetVehicleLights(Car, 0)

			ESX.TriggerServerCallback('lp_carlock:server:syncLockState', function() end, networkId, false)
		end

		IsLockingCar = false
	end)
end

local function GetClosestKnownCarPlate()
	local LocalPedId = PlayerPedId()
	local PlayerCoords = GetEntityCoords(LocalPedId)

	local CarList = ESX.Game.GetVehiclesInArea(PlayerCoords, Config.PlayerCarArea)
	local CloseCars = {}

	-- Return if not cars where found.
	if #CarList == 0 then
		notificationHandler("car",_U('car_interaction'),_U('no_vehicle_in_range'),"red","error.mp3")
		--ESX.ShowNotification(_U('no_vehicle_in_range'))
		return
	end

	for k, v in ipairs(CarList) do
		local VehicleCoords = GetEntityCoords(v)
		local VehicleDistance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, PlayerCoords.x, PlayerCoords.y, PlayerCoords.z)

		local VehiclePlate = ESX.Math.Trim(GetVehicleNumberPlateText(v))

		if MyVehicles[VehiclePlate] then
			table.insert(CloseCars, {
				Car = v,
				Plate = VehiclePlate,
				Distance = VehicleDistance
			})
		end
	end

	local ClosestVehicle = 999
	local ClosestVehiclePlate = nil

	for k, v in ipairs(CloseCars) do
		if v.Distance < ClosestVehicle then
			ClosestVehicle = v.Distance
			ClosestVehiclePlate = v.Plate
		end
	end

	return ClosestVehiclePlate
end

local function GetClosestCarPlate()
	local LocalPedId = PlayerPedId()
	local PlayerCoords = GetEntityCoords(LocalPedId)

	local CarList = ESX.Game.GetVehiclesInArea(PlayerCoords, Config.PlayerCarArea)
	local CloseCars = {}

	-- Return if not cars where found.
	if #CarList == 0 then
		notificationHandler("car",_U('car_interaction'),_U('no_vehicle_in_range'),"red","error.mp3")
		--ESX.ShowNotification(_U('no_vehicle_in_range'))
		return
	end

	for k, v in ipairs(CarList) do
		local VehicleCoords = GetEntityCoords(v)
		local VehicleDistance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, PlayerCoords.x, PlayerCoords.y, PlayerCoords.z)

		local VehiclePlate = ESX.Math.Trim(GetVehicleNumberPlateText(v))

		table.insert(CloseCars, {
			Car = v,
			Plate = VehiclePlate,
			Distance = VehicleDistance
		})
	end

	local ClosestVehicle = 999
	local ClosestVehiclePlate = nil

	for k, v in ipairs(CloseCars) do
		if v.Distance < ClosestVehicle then
			ClosestVehicle = v.Distance
			ClosestVehiclePlate = v.Plate
		end
	end

	return ClosestVehiclePlate
end

Citizen.CreateThread(function()
	-- Load Animation
	RequestAnimDict(Animation)
	while not HasAnimDictLoaded(Animation) do
		Citizen.Wait(0)
	end

	while true do
		Citizen.Wait(0)

		if (IsControlJustPressed(1, Keys[Config.RequiredKey])) and not IsLockingCar then
			local LocalPedId = PlayerPedId()
			local PlayerCoords = GetEntityCoords(LocalPedId)

			local CarList = ESX.Game.GetVehiclesInArea(PlayerCoords, Config.PlayerCarArea)

			-- Return if not cars where found.
			if #CarList == 0 then
				notificationHandler("car",_U('car_interaction'),_U('no_vehicle_in_range'),"red","error.mp3")
				--ESX.ShowNotification(_U('no_vehicle_in_range'))
				return
			end

			local CloseCars = {}
			local SleepIfCallback = 0

			print("Known Keys: ")
			print("Shared:          " .. json.encode(SharedVehicles))
			print("My Vehicles:     " .. json.encode(MyVehicles))
			print("Not my Vehicles: " .. json.encode(NotMyVehicle))

			for k, v in ipairs(CarList) do
				local VehicleCoords = GetEntityCoords(v)
				local VehicleDistance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, PlayerCoords.x, PlayerCoords.y, PlayerCoords.z)

				local VehiclePlate = ESX.Math.Trim(GetVehicleNumberPlateText(v))

				if MyVehicles[VehiclePlate] or NotMyVehicle[VehiclePlate] or SharedVehicles[VehiclePlate] then
					if MyVehicles[VehiclePlate] or SharedVehicles[VehiclePlate] then
						table.insert(CloseCars, {
							Car = v,
							Distance = VehicleDistance
						})
					end
				else
					SleepIfCallback = 300
					ESX.TriggerServerCallback('carlock:isVehicleOwner', function(owner)
						if owner then
							MyVehicles[VehiclePlate] = true
							table.insert(CloseCars, {
								Car = v,
								Distance = VehicleDistance
							})
						else
							NotMyVehicle[VehiclePlate] = true
						end
					end, VehiclePlate)
				end
			end

			Citizen.Wait(SleepIfCallback)

			local ClosestVehicle = 999
			local ClosestVehicleEntity = nil

			for k, v in ipairs(CloseCars) do
				if ClosestVehicle > v.Distance then
					ClosestVehicle = v.Distance
					ClosestVehicleEntity = v.Car
				end
			end

			if ClosestVehicleEntity == nil then
				notificationHandler("car",_U('car_interaction'),_U('no_vehicle_in_range'),"red","error.mp3")
				--TriggerEvent('notifications', -1, _U('car_interaction'), _U('no_vehicle_in_range'))
			else
				ToggleCarLock(ClosestVehicleEntity)
			end
		end
	end
end)


-- Some Chat-Commands
RegisterCommand("sharekey", function(source, args)
	if #args == 1 then
		local car = GetClosestKnownCarPlate()
		local playerId = tonumber(args[1])
		if car then
			--TriggerEvent('notifications', -1, _U('car_interaction'), _U('share_key_with',car,playerId))
			notificationHandler("car",_U('car_interaction'),_U('share_key_with',car,playerId),"blue","sound.mp3")

			ESX.TriggerServerCallback('lp_carlock:server:sendKeysTo', function() end, car, playerId)
		else
			notificationHandler("car",_U('car_interaction'),_U('no_vehicle_in_range'),"red","error.mp3")
			--TriggerEvent('notifications', -1, _U('car_interaction'), _U('no_vehicle_in_range'))
		end
	--else
		--print(json.encode(args))
	end
end)

RegisterCommand("revokekey", function(source, args)
	if #args == 1 then
		local car = GetClosestKnownCarPlate()
		local playerId = tonumber(args[1])
		if car then
			--TriggerEvent('notifications', -1, _U('car_interaction'),_U('stop_share_key_with',car,playerId))
			notificationHandler("car",_U('car_interaction'),_U('stop_share_key_with',car,playerId),"blue","sound.mp3")

			ESX.TriggerServerCallback('lp_carlock:server:revokeKeysFrom', function() end, car, playerId)
		else
			notificationHandler("car",_U('car_interaction'),_U('no_vehicle_in_range'),"red","error.mp3")
			--TriggerEvent('notifications', -1, _U('car_interaction'), _U('no_vehicle_in_range'))
		end
	end
end)

RegisterCommand("adminkeys", function(source, args)
	local car = GetClosestCarPlate()
	if car then
		ESX.TriggerServerCallback('lp_carlock:server:sendKeysToAdmin', function() end, car)
	else
		notificationHandler("car",_U('car_interaction'),_U('no_vehicle_in_range'),"red","error.mp3")
		--TriggerEvent('notifications', -1, _U('car_interaction'), _U('no_vehicle_in_range'))
	end
end)

RegisterCommand("fixcarlock", function(source, args)
	NotMyVehicle = {}
	MyVehicles = {}
	SharedVehicles = {}
end)

-- Server Hooks
RegisterNetEvent("lp_carlock:client:allowKeysForCar")
AddEventHandler("lp_carlock:client:allowKeysForCar", function(plate)
	SharedVehicles[plate] = true
	--TriggerEvent('notifications', -1, _U('car_interaction'), _U('got_key_for_car',plate))
	notificationHandler("car",_U('car_interaction'),_U('got_key_for_car',plate),"blue","sound.mp3")

end)

RegisterNetEvent("lp_carlock:client:revokeKeysFromCar")
AddEventHandler("lp_carlock:client:revokeKeysFromCar", function(plate)
	SharedVehicles[plate] = false
	notificationHandler("car",_U('car_interaction'),_U('revoke_key_for_car',plate),"blue","sound.mp3")
	--TriggerEvent('notifications', -1, _U('car_interaction'), _U('revoke_key_for_car',plate))

end)

RegisterNetEvent("lp_carlock:client:syncLockState")
AddEventHandler("lp_carlock:client:syncLockState", function(vehicleId, lockState)
	local lockId = 1
	if lockState then lockId = 2 end

	local Car = NetworkGetEntityFromNetworkId(vehicleId)

	SetVehicleDoorsLocked(Car, lockId)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
	TriggerEvent("chat:addSuggestion", "/sharekey", _U('chat_suggestion_sharekey'), {{ name = "{playerId}", help = _U('playerId') }})
	TriggerEvent("chat:addSuggestion", "/revokekey", _U('chat_suggestion_revokekey'), {{ name = "{playerId}", help = _U('playerId') }})
	TriggerEvent("chat:addSuggestion", "/fixcarlock", _U('chat_suggestion_fixcarlock'))
	TriggerEvent("chat:addSuggestion", "/adminkeys", _U('chat_suggestion_adminkeys'))
end)
