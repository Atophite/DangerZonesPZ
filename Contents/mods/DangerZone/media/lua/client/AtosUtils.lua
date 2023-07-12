---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Atophite.
--- DateTime: 04/10/2022 19:23
---
---

if isServer() and not isClient() then
   return
end

local AtosClient = AtosDangerZones.Client

function AtosClient:printCors()

   for playerIndex = 0, getNumActivePlayers() -1 do
      local player = getSpecificPlayer(playerIndex)
      print(player:getUsername() .. " X: " .. player:getLx() .. " Y: " .. player:getLy() .. " Z: " .. player:getLz())
   end
end

function AtosClient:printTable(table)
   print(AtosClient:dump(table))

end

function AtosClient:isGeigerEquipped(player)
   local attachedItems = player:getAttachedItems()

   for count = 0, attachedItems:size() - 1 do
      if attachedItems:getItemByIndex(count):getName() == "Geiger Teller" then
            return true
      end
   end
   return false
end

function getTime()
   print(GameTime:getInstance():getHour())
end

function test(player)
   local items = player:getWornItems()

   for count = 1, items:size() - 1 do
      if items:getItemByIndex(count):getClothingItemName() == "HazmatSuit" then
         print(tostring(items:getItemByIndex(count):isVanilla()))
      end
   end

end

function AtosClient:isPlayerProtected(player)
   local items = player:getWornItems()

   --TODO check if the hazmat is from base
   --TODO check if player has masks
   --TODO check if there are holes in hazmat

   for count = 1, items:size() - 1 do
      if items:getItemByIndex(count):getClothingItemName() == "HazmatSuit"
      and items:getItemByIndex(count):getHolesNumber() < 1 then

         return true
      end
   end
   return false
end

function AtosClient:dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. AtosClient:dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function AtosClient:tableLength(T)
   local count = 0
   for k, v in pairs(T) do
      count = count + 1
   end
   return count
end
