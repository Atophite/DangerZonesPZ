
local Commands = {};
Commands.Test = {};

Commands.Test.EnterZone = function(player, args)
    print(player:getUsername() .. " has entered the radation zone")
    player:Say("Radiation detected!")
end

Commands.Test.LeaveZone = function(player, args)
    print(player:getUsername() .. " has left the radation zone")
    player:Say("Radiation NOT Detected!")
end

Commands.Test.ReadCorsFile = function()
    -- http://lua-users.org/wiki/FileInputOutput
    file = "coordinates"

    -- see if the file exist

end

local onClientCommand = function(module, command, player, args)
    if Commands[module] and Commands[module][command] then
        Commands[module][command](player, args);
    end
end

local function ATOS_EveryOneMinute()

    for playerIndex = 0, getNumActivePlayers() -1 do
        local player = getSpecificPlayer(playerIndex)
        ATOS_loopCors(player)
    end
end

Events.OnClientCommand.Add(onClientCommand);
Events.EveryOneMinute.Add(ATOS_EveryOneMinute)