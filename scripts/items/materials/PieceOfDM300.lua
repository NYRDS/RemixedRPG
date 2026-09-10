--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local itemName = ("PieceOfDM300")
local str =18

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materialsFromBosses.png",
            image         = 4,
            name          = RPD.textById(itemName.."_Name"),
            price         = 3000,
            stackable     = true,
            data          = {
              name = "",
              armorUsable = false,
              weaponUsable = false,
              exp = 25,
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

               {3,0.13},
               {2.4,0.1},
               {2,0.08},
               {2.4,0.1}},
              dr = 4,

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

               {3.3,0.12},
               {3.3,0.12},
               {3.3,0.12},
               {3.3,0.12},

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
              {3.4,
               4.4},
              delay = -0.2,
              accuracy = -0.2,
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
