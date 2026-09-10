--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local name = "Wood"
local str = 0.7

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 6,
            name          = RPD.textById(name.."_Name"),
            price         = 18,
            stackable     = true,
            data          = {
              name = "wood",
              armorUsable = false,
              weaponUsable = false,
              magicUsable = true,
              exp = 0.25,
              stats =
              {0.5,
               0.6,
               0,
               1.3,
               0,
               0,
               0,
               0},

              armor =
              {{-0.5,0},
               {0,0},

               {1,0},
               {0,0},

               {1,0},
               {0,0},

               {0,0},
               {0,0},

               {0,0},
               {0,0},

               {0,0},
               {0,0},
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
              accuracy = 0.1,
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
