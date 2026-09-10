--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local str =1.5

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 2,
            name          = RPD.textById("Leather_Name"),
            price         = 20,
            stackable     = true,
            data          = {
              name = "leather",
              armorUsable = true,
              weaponUsable = false,
              exp = 0.35,
              stats =
              {0,
               0,
               0,
               0,
               0.5,
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
               {0.3,0.008},
               {0.2,0.004},
               {0.2,0},
               {0.2,0}},
              dr = 0.3,

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
              {0,
               0},
              delay = 0,
              accuracy = 0.15,
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

      return RPD.textById("Leather_Info").."\n"..sInfo
    end

    }
