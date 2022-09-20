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

local onClientCommand = function(module, command, player, args)
    if Commands[module] and Commands[module][command] then
        Commands[module][command](player, args);
    end
end

Events.OnClientCommand.Add(onClientCommand);