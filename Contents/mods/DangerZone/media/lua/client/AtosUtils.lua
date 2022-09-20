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
