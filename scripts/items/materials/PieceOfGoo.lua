--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local itemName = ("PieceOfGoo")
local str =5

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materialsFromBosses.png",
            image         = 0,
            name          = RPD.textById(itemName.."_Name"),
            price         = 500,
            stackable     = true,
            data          = {
              name = "",
              armorUsable = false,
              weaponUsable = false,
              exp = 5,
              stats =
              {10,
               0,
               0,
               0,
               0,
               5,
               0,
               0},

              armor =
              {{0,0},
               {-2,-0.05},

               {3,0.06},
               {-1,-0.02},

               {0,0},
               {0,0},

               {0,0},
               {0,0},

               {-1,-0.02},
               {3,0.06},

               {0,0},
               {0,0},
               {0,0},
               {0,0}},
              dr = 1,

              weapon =
              {{0,0},
               {0,0},

               {0,0},
               {0,0},

               {0,0},
               {3,0.1},

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
               {2,0.08}},
              dmg =
              {0,
               0},
              delay = 0,
              accuracy = 0.5,
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
