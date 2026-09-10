--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local name = "RunicSteel"
local str =1.3

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 7,
            name          = RPD.textById(name.."_Name"),
            price         = 30,
            stackable     = true,
            data          = {
              name = "runic",
              armorUsable = false,
              weaponUsable = false,
              magicUsable = true,
              exp = 0.35,
              stats =
              {0,
               0.8,
               0,
               1.7,
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
               {2,0},
               {1,0},
               {0,0},
               {2,0}},
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
               {0.36,0},
               {0,0},
               {0,0}},
              dmg =
              {0.6,
               1},
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
