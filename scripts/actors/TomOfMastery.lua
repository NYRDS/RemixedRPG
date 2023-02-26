---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 04.08.18 18:14
---

local RPD = require "scripts/lib/commonClasses"

local actor = require "scripts/lib/actor"

local dungeonEntrance = {13, 4}
local shopEntrance    = {18, 16}

local lastWarningTime = 0
local time = 0

return actor.init({


    act = function()
        
      local levelW = RPD.Dungeon.level:getWidth()
      local levelH = RPD.Dungeon.level:getHeight()
      
      for i = 0, levelW do
        for j = 0, levelH do
          local cell = RPD.Dungeon.level:cell(i,j)
          local enemy = RPD.Actor:findChar(cell)
        end 
      end
        
        if hero:getBelongings():getItem("TomeOfMastery") ~= nil then
         hero:getBelongings():getItem("TomeOfMastery"):detach(hero:getBelongings().backpack)
    end

        return true
    end,
    
    
    actionTime = function()
        return 1
    end,
    
    
    activate = function()
    end
})