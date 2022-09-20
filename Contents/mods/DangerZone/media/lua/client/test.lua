require("AtosUtils")
require("servertest")
local sound = nil
local detected = false

-- First cor is X. Second cor is Y

zone1 = {{10610, 9694}, {10599, 9694}, {10599, 9688}, {10610, 9688}}
zone2 = {{10600, 9635}, {10585, 9632}, {10585, 9611}, {10598, 6969}}
zones = {zone1}



local function OnPlayerMove()

	for playerIndex = 0, getNumActivePlayers() -1 do
		local player = getSpecificPlayer(playerIndex)
		-- print(inspect(getmetatable(player)))
		loopCors(player)
	end


	-- printCors(player)

	-- print(dump(cors))


	

end

Events.EveryOneMinute.Add(OnPlayerMove)


function loopCors(player)
	-- print(getSoundManager())

	for i, zone in ipairs(zones) do
		-- print("zone " .. i)
		validateZone(player, zone)
		-- for x, cor in ipairs(zone) do
		-- 	print(cor[1] .. " " .. cor[2])
		-- end
		-- and playerY >= zone[1][2] and playerX <= zone[1][3] and playerY <= zone[1][4]
	end

end

function validateZone(player, zone)
	-- print("validating " .. tostring(zone[4][2]))
	local playerX = player:getLx()
	local playerY = player:getLy()
	-- Check if the player is in the zone
	if(
			playerX <= zone[1][1] and playerY <= zone[1][2]
 		and playerX >= zone[2][1] and playerY <= zone[2][2]
		and playerX >= zone[3][1] and playerY >= zone[3][2]
		and playerX <= zone[4][1] and playerY >= zone[4][2]
		)

 	then

		detected = true
		

		if sound == nil then
			sound = player:playSound("Geiger")

			sendClientCommand("Test", "EnterZone", {
				player = player
			});

		elseif sound ~= nil and not player:getEmitter():isPlaying(sound) then
				sound = player:playSound("Geiger")
		end

		


			-- player:stopSound(sound)
			-- print(sound:playUISound("UISelectListItem"))
	else
		if sound ~= nil and detected then
			player:getEmitter():stopSoundByName("Geiger")

			sendClientCommand("Test", "LeaveZone", {
				player = player
			});

			sound = nil
			detected = false
		end
	end 
end

function printTable()
	print(dump(cors))

end