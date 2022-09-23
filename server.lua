------------------------------------| Register ESX |-------------------------------------
ESX = nil

TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)
-- notification Handler
function notificationHandler(xPlayer,icon,title,msg,color,sound)
	if Config.Notification.System ~= 'lp_notify' then
		xPlayer.showNotification(title..", "..msg, false, false, 140)
	else
		xPlayer.triggerEvent("lifepeak.notify",icon,title,msg,color,true,Config.Notification.Postion,Config.Notification.displaytime,sound)
	end
end

ESX.RegisterServerCallback('lp_carlock:server:syncLockState', function(source, cb, vehicleId, locked)
	TriggerClientEvent('lp_carlock:client:syncLockState', -1, vehicleId, locked)
	cb()
end)

ESX.RegisterServerCallback('lp_carlock:server:sendKeysTo', function(source, cb, plate, targetId)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(targetId)

	if xTarget then
		TriggerClientEvent('lp_carlock:client:allowKeysForCar', xTarget.source, plate)
	else
		notificationHandler(xPlayer,"car",_U('car_interaction'),_U('player_not_exist'),"red","error.mp3")
		--TriggerClientEvent('notification', xPlayer.source, -1, _U('car_interaction'), _U('player_not_exist'))
	end
	cb()
end)

ESX.RegisterServerCallback('lp_carlock:server:sendKeysToAdmin', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.AdminGroups[xPlayer.group] or IsPlayerAceAllowed(source, 'admincarlockkeys') then
		notificationHandler(xPlayer,"car",_U('admin_car_interaction'),_U('admin_got_key',plate),"green","success.mp3")
		--TriggerClientEvent('notification', xPlayer.source, -1, _U('admin_car_interaction'), _U('admin_got_key',plate))
		TriggerClientEvent('lp_carlock:client:allowKeysForCar', xPlayer.source, plate)
	else
		--TriggerClientEvent('notification', xPlayer.source, -1, _U('admin_car_interaction'), _U('not_allowed'))
		notificationHandler(xPlayer,"car",_U('admin_car_interaction'),_U('not_allowed'),"red","error.mp3")

	end
	cb()
end)

ESX.RegisterServerCallback('lp_carlock:server:revokeKeysFrom', function(source, cb, plate, targetId)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(targetId)

	if xTarget then
		TriggerClientEvent('lp_carlock:client:revokeKeysFromCar', xTarget.source, plate)
	else
		notificationHandler(xPlayer,"car",_U('car_interaction'),_U('player_not_exist'),"red","error.mp3")
		--TriggerClientEvent('notification', xPlayer.source, -1, _U('car_interaction'), _U('player_not_exist'))
	end
	cb()
end)

ESX.RegisterServerCallback('lp_carlock:isVehicleOwner', function(source, cb, plate)
	local returncode = false
	local xTarget	 = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchScalar('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xTarget.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			returncode = result[1].owner == xTarget.identifier
		end
		if returncode == false then
			if Config.EnableJobvehicle == true then

				returncode=MySQL.scalar.await('SELECT job FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {['@owner'] = xTarget.identifier,['@plate'] = plate})
			end
		end
	
		if returncode == nil then
			returncode=false
		end
		cb(returncode)
	end)
end)
