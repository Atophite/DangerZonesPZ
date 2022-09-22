require("AtosUtils")
require("AtosServer")
local ATOS_sound = nil
local ATOS_detected = false
local ATOS_protected = false

-- First cor is X. Second cor is Y

local zone1 = {{10610, 9694}, {10599, 9694}, {10599, 9688}, {10610, 9688}}
local zone2 = {{10600, 9635}, {10585, 9632}, {10585, 9611}, {10598, 6969}}
local zones = {zone1}

local function ATOS_onGameStart()
	if playerIsProtected(player) == true then
		ATOS_protected = true
	else
		ATOS_protected = false
	end
	print("test")
end



local function ATOS_EveryOneMinute()

	for playerIndex = 0, getNumActivePlayers() -1 do
		local player = getSpecificPlayer(playerIndex)
		ATOS_loopCors(player)
	end

end

local function ATOS_OnClothingUpdated(player)

	--https://zomboid-javadoc.com/41.65/zombie/characters/ILuaGameCharacterClothing.html

	--getModID
	if playerIsProtected(player) == true then
		ATOS_protected = true
	else
		ATOS_protected = false
	end


end


function ATOS_loopCors(player)
	-- print(getSoundManager())

	for i, zone in ipairs(zones) do
		-- print("zone " .. i)
		ATOS_validateZone(player, zone)
		-- for x, cor in ipairs(zone) do
		-- 	print(cor[1] .. " " .. cor[2])
		-- end
		-- and playerY >= zone[1][2] and playerX <= zone[1][3] and playerY <= zone[1][4]
	end

end

function ATOS_checkZone(player, zone)
	local playerX = player:getLx()
	local playerY = player:getLy()

	if(			playerX <= zone[1][1] and playerY <= zone[1][2]
			and playerX >= zone[2][1] and playerY <= zone[2][2]
			and playerX >= zone[3][1] and playerY >= zone[3][2]
			and playerX <= zone[4][1] and playerY >= zone[4][2]) then
		return true
	end

	return false

end

function ATOS_validateZone(player, zone)
	-- print("validating " .. tostring(zone[4][2]))

	-- Check if the player is in the zone
	if(ATOS_checkZone(player, zone)) then

		ATOS_detected = true

		if ATOS_protected then
			print("player is wearing protection")
		else
			print("player is NOT wearing protection")
		end

		ATOS_playSound(player)
			-- player:stopSound(sound)
			-- print(sound:playUISound("UISelectListItem"))
	else
		ATOS_stopSound(player)
	end
end

function ATOS_playSound(player)
	if ATOS_sound == nil then
		ATOS_sound = player:playSound("Geiger")
		sendClientCommand("Test", "EnterZone", {
			player = player
		});

	elseif ATOS_sound ~= nil and not player:getEmitter():isPlaying(ATOS_sound) then
		ATOS_sound = player:playSound("Geiger")
	end
end

function ATOS_stopSound(player)
	if ATOS_sound ~= nil and ATOS_detected then
		player:getEmitter():stopSoundByName("Geiger")

		sendClientCommand("Test", "LeaveZone", {
			player = player
		});

		ATOS_sound = nil
		ATOS_detected = false
	end
end

Events.OnClothingUpdated.Add(ATOS_OnClothingUpdated)
Events.EveryOneMinute.Add(ATOS_EveryOneMinute)
Events.OnGameStart.Add(ATOS_onGameStart)

