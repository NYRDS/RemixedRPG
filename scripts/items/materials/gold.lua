--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local str =2.8

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 5,
            name          = RPD.textById("GloomyGold_Name"),
            price         = 100,
            stackable     = true,
            data          = {
              name = "gold",
              armorUsable = false,
              weaponUsable = true,
              exp = 0.7,
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

               {0.5,0},
               {1,0},

               {0,0},
               {0,0},
               {0,0},
               {0,0}},
              dr = 1.2,

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

               {0.1,0},
               {0.15,0.003},
               {0.1,0},
               {0.2,0.005},

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
              {0.85,
               1.55},
              delay = 0,
              accuracy = 0,
              range = 0
            }
        }
    end,

    bag = function()
  		return "SeedPouch"
  	end,


    typicalStr = function()
     return str
    end,


    info = function(self)
      local d = self.data
      local sInfo = RPG.getMaterialsInfo(d.stats, d.armor, d.weapon, d.dmg, d.dr, d.delay, d.accuracy, d.range,str)

      return RPD.textById("GloomyGold_Info").."\n"..sInfo
    end

    }
