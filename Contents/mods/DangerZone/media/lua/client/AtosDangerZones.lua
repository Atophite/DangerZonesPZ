---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Atophite.
--- DateTime: 04/10/2022 19:23
---
---


if isServer() and not isClient() then
	return
end

local player = getPlayer()
local geigerSound = nil
--Is radiation detected by the geiger teller
local isRadiationDetected = false
local isInZone = false
local isProtected = false
local isProtectedByPills = false
local isProtectByPillsSince = null
local radSickness = 1
local hasGeiger = false
local hasEnteredZone = false
local radLevels = {200, 400, 1000}

local zones

local AtosClient = AtosDangerZones.Client
local AtosShared = AtosDangerZones.Shared



local function onGameStart()
	player = getPlayer()


	--if client is online send request to server
	if isClient() then
		print("requesting zones")
		sendClientCommand("Atos", "RequestAllZones", {
			player = player
		});
	else
		--If client is offline, manually read the file
		zones = AtosShared:readZonesFile()

	end

  	-- Check if player is wearing hazmat
	--if AtosClient:getIsProtectedByPills() then
	--	AtosClient:setIodineMoodle(1.0)--float
	--end

end

function testCommand()
	zones = AtosShared:readCorsFile()
	print(isClient())
	sendClientCommand("Atos", "RequestAllZones", {
		player = player
	});
end

local function onConnected()
	print("Connected to server")
end

local function OnGameBoot()
	print("game is booted!")
end

local function everyOneMinute()

	--Check for pills
	if AtosClient:getIsProtectedByPills() then
		local pillTotalDuration = 5 -- 5 hours
		local pillLowDuration = 4
		local currentWorldHour = GameTime:getInstance():getWorldAgeHours()

		if currentWorldHour - AtosClient:getIsProtectedByPillsSince() >= pillTotalDuration then
			AtosClient:setIsProtectedByPills(false)
			AtosClient:setIodineMoodle(0.5)--float
			print("The effects of the Iodine Pills has fallen off")
		elseif currentWorldHour - AtosClient:getIsProtectedByPillsSince() >= pillLowDuration then
			AtosClient:setIodineMoodle(0.2)--float
		else
			AtosClient:setIodineMoodle(1.0)--float
		end
	end

	--If zones are empty
	--sendClientCommand only works on multiplayer
	--For some reason the sendClientCommand doesnt work on onGameStart()
	if zones == nil then
		if(isClient()) then
			sendClientCommand("Atos", "RequestAllZones", {
				player = player
			});
		else
			zones = AtosShared:readZonesFile()
		end
	else
		AtosClient:loopZones()
	end

	AtosClient:onClothingUpdated()
end



function AtosClient:onClothingUpdated()

	--https://zomboid-javadoc.com/41.65/zombie/characters/ILuaGameCharacterClothing.html

	--getModID
	--Check if player equipped a geiger when clothing is updated
	--Also checks if the player already has the geiger equipped.
	if AtosClient:isGeigerEquipped(player) and not hasGeiger then
		hasGeiger = true

		if not isInZone then
			player:Say("Radiation not detected!")
		elseif isInZone then
			player:Say("Radiation detected!")
		end

	elseif not AtosClient:isGeigerEquipped(player) then
		hasGeiger = false
	end

	if AtosClient:isPlayerProtected(player)  then
		isProtected = true
		AtosClient:setHazmatMoodle(1.0)
	else
		isProtected = false
		AtosClient:setHazmatMoodle(0.5)
	end
end


function AtosClient:loopZones()
    local playerX, playerY = player:getX(), player:getY()
    isInZone = false

    for i, zone in ipairs(zones) do
        local zoneXMin, zoneXMax = zone[1][1], zone[1][2]
        local zoneYMin, zoneYMax = zone[2][1], zone[2][2]

        if playerX > zoneXMin and playerX < zoneXMax and playerY > zoneYMin and playerY < zoneYMax then
            isInZone = true
            break  -- No need to check further if the player is already in a zone
        end
    end

    AtosClient:validateZone()
end


function AtosClient:validateZone()

	-- Check if the player is in the radiation zone
	if isInZone then

		--Check if its the first time that the ATOS_player has entered the zone.
		--To prevent a loop
		if not hasEnteredZone then

			if hasGeiger then
				player:Say("Radiation detected!")
			end
			hasEnteredZone = true
			AtosClient:onClothingUpdated()
		end


		if isProtected or AtosClient:getIsProtectedByPills() then
			print("player is wearing protection")
		else
			print("player is NOT wearing protection")
			radSickness = AtosClient:getRadiation() * 1.2
			print(radSickness)
			print(player:getBodyDamage():getFoodSicknessLevel())
			print("health: " .. tostring(player:getHealth()))
			if(radSickness > 2000) then
				player:Kill(player)
				radSickness = 2000
			elseif radSickness > 1000 then
				player:getBodyDamage():setFoodSicknessLevel(100);
			elseif radSickness > 400 then
				player:getBodyDamage():setFoodSicknessLevel(80);
			elseif radSickness > 200 then
				player:getBodyDamage():setFoodSicknessLevel(40);
			end
			AtosClient:setRadiation(radSickness)

		end

		--If the ATOS_player has a geiger the ATOS_player can detect the radiation
		if hasGeiger then
			isRadiationDetected = true
			AtosClient:playSound()
		else
			isRadiationDetected = false
			AtosClient:stopSound()
		end
	else
		--Check if its the first time that the player has left the zone.
		--To prevent a loop
		if hasEnteredZone then
			AtosClient:stopSound()
			--Send message to server that player left zone.
			if hasGeiger then
				player:Say("Radiation not detected!")
			end

			hasEnteredZone = false
		end
	end
end

function AtosClient:playSound()
	if geigerSound == nil then
		geigerSound = player:playSoundLocal("Geiger")
	elseif geigerSound ~= nil and not player:getEmitter():isPlaying("Geiger") and hasGeiger == true then
		geigerSound = player:playSoundLocal("Geiger")

	end
end

function AtosClient:stopSound()
	if geigerSound ~= nil and isRadiationDetected or not hasGeiger then
		player:getEmitter():stopSoundByName("Geiger")

		geigerSound = nil
	end
end

function AtosClient:setZones(paramZones)
	zones = paramZones
end

function AtosClient:setRadSickness(number)
	radSickness = number
end

function AtosClient:getRadSickness()
	return radSickness
end


Events.OnClothingUpdated.Add()
Events.OnGameStart.Add(onGameStart)
Events.EveryOneMinute.Add(everyOneMinute)
Events.OnConnected.Add(onConnected)
Events.OnGameBoot.Add(OnGameBoot)


