--
-- Created by Mongol
-- VK: mongolinsult
-- 

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 0,
            name          = RPD.textById("Iron_Name"),
            price         = 20,
            stackable     = true,
            data          = {
              name = "iron",
              armorUsable = true,
              weaponUsable = true,
              stats =
              {0,
               0,
               0,
               0,
               0,
               0,
               0,
               0},
               
              armor = 
              {{0,0},
               {0,0}, 
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0.15,0.02},
               {0.1,0.01},
               {0,0.005},
               {0.1,0}},
              dr = 0.5,
              
              weapon = 
              {{0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0}},
              dmg = 
              {1,
               1.45},
              delay = 0,
              accuracy = 0,
              range = 0
            }
        }
    end,
    typicalStr = function()
     return 2.4
    end,
    
    
    info = function(self)
      local d = self.data
      local sInfo = RPG.getMaterialsInfo(d.stats, d.armor, d.weapon, d.dmg, d.dr, d.delay, d.accuracy, d.range)
      
      return RPD.textById("Iron_Info")..sInfo
    end
    
    }
