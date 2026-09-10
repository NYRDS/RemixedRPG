--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local name = "Nephrite"
local str =2.3

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 9,
            name          = RPD.textById(name.."_Name"),
            price         = 100,
            stackable     = true,
            data          = {
              name = "nephrite",
              armorUsable = false,
              weaponUsable = false,
              magicUsable = true,
              exp = 0.7,
              stats =
              {0,
               1.3,
               0,
               2.3,
               0,
               0.7,
               0.4,
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

               {1.6,0},
               {1.6,0},
               {1.6,0},
               {1.6,0}},
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
              {1.3,
               1.8},
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

      return RPD.textById(name.."_Info").."\n"..sInfo
    end

    }
