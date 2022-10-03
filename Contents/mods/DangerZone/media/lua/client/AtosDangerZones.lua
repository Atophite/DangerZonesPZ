local ATOS_sound = nil
--Is radiation detected by the geiger teller
local ATOS_isRadiationDetected = false
local ATOS_isInZone = false
local ATOS_isProtected = false
local ATOS_sickness = 1
local ATOS_hasGeiger = false
local ATOS_hasEnteredZone = false

function ATOS_onGameStart()
	if ATOS_isPlayerIsProtected(player) == true then
		ATOS_isProtected = true
	else
		ATOS_isProtected = false
	end

end

local function ATOS_EveryOneMinute()

	for playerIndex = 0, getNumActivePlayers() -1 do
		local player = getSpecificPlayer(playerIndex)
		ATOS_loopCors(player)
	end
end


function ATOS_OnClothingUpdated(player)

	--https://zomboid-javadoc.com/41.65/zombie/characters/ILuaGameCharacterClothing.html

	--getModID
	if ATOS_isGeigerEquipped(player) and not ATOS_hasGeiger then
		ATOS_hasGeiger = true

		if not ATOS_isInZone then
			sendClientCommand("Atos", "EquipGeigerOutsideZone", {
				player = player,
			});
		elseif ATOS_isInZone then
			sendClientCommand("Atos", "EquipGeigerInsideZone", {
				player = player,
			});
		end

	elseif not ATOS_isGeigerEquipped(player) then
		ATOS_hasGeiger = false
	end

	if ATOS_isPlayerIsProtected(player) then
		ATOS_isProtected = true
	else
		ATOS_isProtected = false
	end
end



function ATOS_loopCors(player)
	local playerX = player:getLx()
	local playerY = player:getLy()
	local isInZone = false

	--Check if player is in the zone
	--zone[1][1] is lowest x coordinate and zone[1][2] is highest.
	--Same with y coordinate
	for i, zone in ipairs(ATOS_coordinates) do
		if(playerX > zone[1][1] and playerX < zone[1][2] and playerY > zone[2][1] and playerY < zone[2][2]) then
			isInZone = true
		end
	end
	if isInZone then
		ATOS_isInZone = true
	else
		ATOS_isInZone = false
	end
	ATOS_validateZone(player)
end


function ATOS_validateZone(player)

	-- Check if the player is in the zone
	if(ATOS_isInZone) then

		--Check if its the first time that the player has entered the zone.
		--To prevent a loop
		if not ATOS_hasEnteredZone then
			sendClientCommand("Atos", "EnterZone", {
				player = player,
				hasGeiger = ATOS_hasGeiger
			});
			ATOS_hasEnteredZone = true
			ATOS_OnClothingUpdated(player)
		end


		if ATOS_isProtected then
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

		--If the player has a geiger the player can detect the radiation
		if ATOS_hasGeiger then
			ATOS_isRadiationDetected = true
			ATOS_playSound(player)
		else
			ATOS_isRadiationDetected = false
			ATOS_stopSound(player)
		end
	else
		--Check if its the first time that the player has left the zone.
		--To prevent a loop
		if ATOS_hasEnteredZone then
			ATOS_stopSound(player)
			--Send message to server that player left zone.
			sendClientCommand("Atos", "LeaveZone", {
				player = player,
				hasGeiger = ATOS_hasGeiger
			});
			ATOS_hasEnteredZone = false
		end

	end
end

function ATOS_playSound(player)
	if ATOS_sound == nil then
		ATOS_sound = player:playSound("Geiger")

	elseif ATOS_sound ~= nil and not player:getEmitter():isPlaying(ATOS_sound) and ATOS_hasGeiger == true then
		ATOS_sound = player:playSound("Geiger")
	end
end

function ATOS_stopSound(player)
	if ATOS_sound ~= nil and ATOS_isRadiationDetected or not ATOS_hasGeiger then
		player:getEmitter():stopSoundByName("Geiger")

		ATOS_sound = nil
	end
end

Events.OnClothingUpdated.Add(ATOS_OnClothingUpdated)
Events.OnGameStart.Add(ATOS_onGameStart)
Events.EveryOneMinute.Add(ATOS_EveryOneMinute)

