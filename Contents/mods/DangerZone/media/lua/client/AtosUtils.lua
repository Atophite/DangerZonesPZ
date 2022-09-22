function test()
	print("test")
end

function printCors()

   for playerIndex = 0, getNumActivePlayers() -1 do
      local player = getSpecificPlayer(playerIndex)
      -- print(inspect(getmetatable(player)))
      print(player:getUsername() .. " X: " .. player:getLx() .. " Y: " .. player:getLy() .. " Z: " .. player:getLz())
   end
end

function printTable(table)
   print(dump(cors))

end

function readCorsFile()
   --sendClientCommand("Test", "ReadCorsFile", {
   --
   --});

   local reader = getFileReader("coordinates.txt", true)
   if reader then
      local line = reader:readLine()
      print(line)
      reader:close();

   end
   print(tostring(reader))

end

function playerIsProtected(player)
   local items = player:getWornItems()


   for count = 1, items:size() - 1 do
      if items:getItemByIndex(count):getClothingItemName() == "HazmatSuit" then
         --print(items:getItemByIndex(count):getClothingItemName())
         return true
      end
   end
   return false
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
