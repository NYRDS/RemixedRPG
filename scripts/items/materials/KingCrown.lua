--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local itemName = ("KingCrown")
local str =24

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materialsFromBosses.png",
            image         = 6,
            name          = RPD.textById(itemName.."_Name"),
            price         = 8000,
            stackable     = true,
            data          = {
              name = "",
              armorUsable = false,
              weaponUsable = false,
              exp = 35,
              stats =
              {20,
               0,
               30,
               0,
               0,
               10,
               0,
               15},

              armor =
              {{0,0},
               {0,0},

               {0,0},
               {0,0},

               {0,0},
               {0,0},

               {0,0},
               {0,0},

               {4,0.12},
               {2,0.06},

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

               {10,0.22},
               {8,0.16},
               {3,0.08},
               {3,0.08},

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

               {5,0.1},
               {0,0},
               {0,0},
               {0,0}},
              dmg =
              {4,
               5.5},
              delay = 0.3,
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
