---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Wesley.
--- DateTime: 09/10/2022 21:14
---

local AtosClient = AtosDangerZones.Client

function OnEat_Iodine(food, player, percentage)
    print("Taking iodine")
    print(player:getUsername())
    AtosClient:setRadSickness(1)
    player:getBodyDamage():setFoodSicknessLevel(0);
    AtosClient:setIsProtectedByPills(true)
    AtosClient:setIsProtectedByPillsSince(GameTime:getInstance():getWorldAgeHours())
end