local QBCore = exports['qb-core']:GetCoreObject()
local vehicleChecked = false
local vehicleValid = false

local function CreateBlip(coords)
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipDisplay(blip, 6)
	SetBlipSprite(blip, Config.CameraBlips.sprite)
	SetBlipColour(blip, Config.CameraBlips.color)
	SetBlipScale(blip, Config.CameraBlips.scale)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.CameraBlips.text)
	EndTextCommandSetBlipName(blip)
end

local function IsVehicleValid(vehicle)
	local vehicleClass = GetVehicleClass(vehicle)
	if vehicleClass == 18 then return false end

	local vehicleHash = GetEntityModel(vehicle)
	local vehicleSpawn = GetDisplayNameFromVehicleModel(vehicleHash)
	for _, v in pairs(Config.IgnoreModels) do
		if string.upper(v) == vehicleSpawn then
			return false
		end
	end
	vehicleValid = true
	return true
end

local function CameraDistance(pCoords)
	local tempDistance = 1000
	local camId = nil
	for i = 1, #Config.Cameras do
		local distance = #(pCoords-Config.Cameras[i].coords)
		if distance < tempDistance then
			tempDistance = distance
			camId = i
		end
	end
	return tempDistance, camId
end

CreateThread(function()
	while true do
		Wait(50)
		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped, false) then
			if not vehicleChecked then
				vehicleChecked = true
				local vehicle = GetVehiclePedIsIn(ped, false)
				IsVehicleValid(vehicle)
			end

			if vehicleValid then
				local pCoords = GetEntityCoords(ped)
				local camDist, camId = CameraDistance(pCoords)
				if camDist > (Config.CameraDetectionRadius*5) then
					Wait(1000)
				else
					if camDist <= Config.CameraDetectionRadius then
						local vehicle = GetVehiclePedIsIn(ped, false)
						local mph = GetEntitySpeed(vehicle)*2.236936
						if mph > Config.Cameras[camId].speedlimit then
							TriggerServerEvent("r1-speedcam:server:fine", mph, camId)
							Wait(Config.CameraCooldown*1000)
						end
					end
				end
			else
				Wait(1000)
			end
		else
			Wait(1000)
			if vehicleChecked then
				vehicleChecked = false
				vehicleValid = false
			end
		end
	end
end)

CreateThread(function()
	for i = 1, #Config.Cameras do
		if not Config.Cameras[i].hidden then
			CreateBlip(Config.Cameras[i].coords)
		end
	end
end)