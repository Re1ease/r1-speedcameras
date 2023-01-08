local QBCore = exports['qb-core']:GetCoreObject()

local function Round(value, numDecimalPlaces)
	if not numDecimalPlaces then return math.floor(value + 0.5) end
    local power = 10 ^ numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
end

local function CalculateMultiplier(miles, camId)
	local c = Config.Cameras[camId].speedlimit
	return ((miles-c)/c)+1
end

RegisterNetEvent("r1-speedcam:server:fine", function(miles, camId)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if camId then
		local multiplier = CalculateMultiplier(miles, camId)
		local fine = math.ceil(Config.Fine*multiplier)
		if Player.PlayerData.money.bank >= fine then
			Player.Functions.RemoveMoney('bank', fine, "speedcamera")
		end
		TriggerClientEvent('QBCore:Notify', src, "$"..fine.." deducted for speeding ["..Round(Config.Cameras[camId].speedlimit, 0).."|"..Round(miles, 0).." MPH]")
	end
end)