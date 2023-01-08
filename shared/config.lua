Config = {}

Config.IgnoreEmergencyVehicles = true
Config.IgnoreModels = {"adder", "blista"}
Config.CameraCooldown = 10 	-- seconds. cooldown after first detection
Config.CameraDetectionRadius = 20 	-- gta units
Config.Fine = 500 	-- has a multiplier (check server-side)

Config.CameraBlips = {
	sprite = 184,
	color = 0,
	scale = 0.6,
	text = "Speed Camera",
}

Config.Cameras = {
	[1] = {
		coords = vec3(-20.6, 1831.87, 205.64),
		speedlimit = 40,
		hidden = false
	},

	[2] = {
		coords = vec3(-2.4, 1784.04, 214.2),
		speedlimit = 40,
		hidden = false
	},
}