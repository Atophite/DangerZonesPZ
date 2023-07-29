---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Wesley.
--- DateTime: 29/07/2023 15:31
---
local AtosClient = AtosDangerZones.Client

local function doMenu(player, context, items)
    for i, v in ipairs(items) do
        local item = v;
        if not instanceof(v, "InventoryItem") then
            item = v.items[1];
        end

        if item:getType() then
            -- This is where you put your code!
            if item:getType() == "GeigerTeller" then
                -- Change MyItemsID to the ID you used in your items.txt file.
                -- (e.g., for base.Axe, this would be Axe)
                context:addOption("Measure Body Radiation", item, clickMeasureRadiation, player);
            end
            -- This is where you put your code!
        end
    end
end


function clickMeasureRadiation(item, player)
    -- This is where the code goes for when someone clicks the option in the menu

    ISTimedActionQueue.add(AtosIsMeasureRadiationAction:new(getPlayer(), item))

end

-- The link to the right-click menu event
Events.OnFillInventoryObjectContextMenu.Add(doMenu);