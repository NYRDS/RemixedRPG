--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local name = "Ruby"
local str =1.8

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 8,
            name          = RPD.textById(name.."_Name"),
            price         = 50,
            stackable     = true,
            data          = {
              name = "ruby",
              armorUsable = false,
              weaponUsable = false,
              magicUsable = true,
              exp = 0.45,
              stats =
              {0.5,
               1,
               0,
               2,
               0,
               0,
               0,
               0},

              armor =
              {{1.5,0},
               {0.5,0},

               {-0.5,0},
               {-0.75,0},

               {1.5,0},
               {0,0},

               {-0.75,0},
               {0,0},

               {1,0},
               {0,0},

               {2,0},
               {1,0},
               {0,0},
               {0,0}},
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

               {0.24,0},
               {0,0},

               {-0.06,0},
               {-0.12,0},

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
               1.4},
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
