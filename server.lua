------------------------------------| Register ESX |-------------------------------------
ESX = nil

TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)

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
		TriggerClientEvent('notification', xPlayer.source, -1, _U('car_interaction'), _U('player_not_exist'))
	end
	cb()
end)

ESX.RegisterServerCallback('lp_carlock:server:sendKeysToAdmin', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.AdminGroups[xPlayer.group] or IsPlayerAceAllowed(source, 'admincarlockkeys') then
		TriggerClientEvent('notifications', xPlayer.source, -1, _U('admin_car_interaction'), _U('admin_got_key',plate))
		TriggerClientEvent('lp_carlock:client:allowKeysForCar', xPlayer.source, plate)
	else
		TriggerClientEvent('notification', xPlayer.source, -1, _U('admin_car_interaction'), _U('not_allowed'))
	end
	cb()
end)

ESX.RegisterServerCallback('lp_carlock:server:revokeKeysFrom', function(source, cb, plate, targetId)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(targetId)

	if xTarget then
		TriggerClientEvent('lp_carlock:client:revokeKeysFromCar', xTarget.source, plate)
	else
		TriggerClientEvent('notification', xPlayer.source, -1, _U('car_interaction'), _U('player_not_exist'))
	end
	cb()
end)

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate)
	local xTarget	 = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xTarget.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == xTarget.identifier)
		else
			cb(false)
		end
	end)
end)