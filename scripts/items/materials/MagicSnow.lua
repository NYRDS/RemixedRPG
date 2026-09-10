--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local itemName = ("MagicSnowball")
local str = 1

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 45,
            name          = RPD.textById(itemName.."_Name"),
            price         = 100,
            stackable     = true,
            data          = {
              name = "",
              armorUsable = false,
              weaponUsable = false,
              exp = 1,
              stats =
              {0,
               7.2,
               0,
               0,
               2.2,
               4.4,
               3.6,
               0},

              armor =
              {{-1.25,-0.01},
               {-1.25,-0.01},

               {1,0},
               {1.75,0.25},

               {0,0},
               {0,0},

               {-1.25,-0.01},
               {0,0},

               {0,0},
               {0,0},

               {0,0},
               {0,0},
               {0,0},
               {0,0}},
              dr = 1,

              weapon =
              {{-1.25,-0.01},
               {0,0},

               {0,0},
               {1.75,0.02},

               {0,0},
               {0,0},

               {-1.25,-0.01},
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

      return RPD.textById(itemName.."_Info").."\n"..sInfo
    end

    }
