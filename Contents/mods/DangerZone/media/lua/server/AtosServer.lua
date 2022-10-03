
local Commands = {};
Commands.Atos = {};

--When the player entered the zone with or without geiger
Commands.Atos.EnterZone = function(player, args)
    print(player:getUsername() .. " has entered the radation zone")

    if args.hasGeiger then
        player:Say("Radiation detected!")
    end
end

--When the player left the zone with or without geiger
Commands.Atos.LeaveZone = function(player, args)
    print(player:getUsername() .. " has left the radation zone")

    if args.hasGeiger then
        player:Say("Radiation not detected!")
    end
end

--When the player equipped the geigerteller outside the zone
Commands.Atos.EquipGeigerOutsideZone = function(player, args)

    player:Say("Radiation not detected!")
end

--When the player equipped the geigerteller inside the zone
Commands.Atos.EquipGeigerInsideZone = function(player, args)

    player:Say("Radiation detected!")
end

local onClientCommand = function(module, command, player, args)
    if Commands[module] and Commands[module][command] then
        Commands[module][command](player, args);
    end
end

Events.OnClientCommand.Add(onClientCommand);