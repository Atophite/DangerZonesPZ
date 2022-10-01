local ATOS_sound = nil
local ATOS_detected = false
local ATOS_protected = false
local ATOS_sickness = 1

-- First cor is X. Second cor is Y

function ATOS_onGameStart()
	if playerIsProtected(player) == true then
		ATOS_protected = true
	else
		ATOS_protected = false
	end
	print("test")
end


function ATOS_OnClothingUpdated(player)

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
	local playerX = player:getLx()
	local playerY = player:getLy()
	local isInZone = false
	--printCors()

	--10605 9691
	--ATOS_validateZone(player, zone)
	for i, zone in ipairs(coordinates) do
		if(playerX > zone[1][1] and playerX < zone[1][2] and playerY > zone[2][1] and playerY < zone[2][2]) then
			isInZone = true
		end
	end
	ATOS_validateZone(player, isInZone)
end

function ATOS_checkZone(player, zone)
	--local playerX = player:getLx()
	--local playerY = player:getLy()
	--local isInZone = false
	--
	--if(			playerX <= zone[1][1] and playerY <= zone[1][2]
	--		and playerX >= zone[2][1] and playerY <= zone[2][2]
	--		and playerX >= zone[3][1] and playerY >= zone[3][2]
	--		and playerX <= zone[4][1] and playerY >= zone[4][2]) then
	--	isInZone = true
	--else
	--	isInZone = false
	--end
	--ATOS_validateZone(player, isInZone)

end

function ATOS_validateZone(player, isInZone)
	-- print("validating " .. tostring(zone[4][2]))

	-- Check if the player is in the zone
	if(isInZone) then

		ATOS_detected = true

		if ATOS_protected then

			print("player is wearing protection")
		else
			print("player is NOT wearing protection")
			ATOS_sickness = ATOS_sickness * 1.5
			if(ATOS_sickness <= 100) then
				print(ATOS_sickness)
				player:getBodyDamage():setFoodSicknessLevel(ATOS_sickness);
			else
				player:getBodyDamage():setFoodSicknessLevel(100);
			end

		end

		ATOS_playSound(player)
			-- player:stopSound(sound)
			-- print(sound:playUISound("UISelectListItem"))
	elseif ATOS_sound ~= nil then
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
Events.OnGameStart.Add(ATOS_onGameStart)

