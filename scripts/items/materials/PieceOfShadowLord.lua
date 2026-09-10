--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local itemName = ("PieceOfShadowLord")
local str =15

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materialsFromBosses.png",
            image         = 7,
            name          = RPD.textById(itemName.."_Name"),
            price         = 15000,
            stackable     = true,
            data          = {
              name = "",
              armorUsable = false,
              weaponUsable = false,
              exp = 40,
              stats =
              {15,
               25,
               10,
               20,
               0,
               12,
               5,
               0},

              armor =
              {{0,0},
               {-8,-0.08},

               {0,0},
               {0,0},

               {0,0},
               {8,0.1},

               {0,0},
               {0,0},

               {-8,-0.15},
               {14,0.23},

               {0,0},
               {0,0},
               {0,0},
               {0,0}},
              dr = 3.4,

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

               {-5,-0.11},
               {10,0.22},

               {0,0},
               {0,0},
               {0,0},
               {0,0}},
              dmg =
              {3,
               4},
              delay = 0.25,
              accuracy = 1,
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
