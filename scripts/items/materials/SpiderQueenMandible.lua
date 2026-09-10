--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local itemName = ("SpiderQueenMandible")
local str =6

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materialsFromBosses.png",
            image         = 1,
            name          = RPD.textById(itemName.."_Name"),
            price         = 800,
            stackable     = true,
            data          = {
              name = "",
              armorUsable = false,
              weaponUsable = false,
              exp = 10,
              stats =
              {5,
               0,
               8,
               0,
               5,
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

               {0,0},
               {0,0},
               {0,0},
               {0,0}},
              dr = 0,

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

               {1,0.03},
               {1,0.03},
               {2,0.075},
               {2,0.05},

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
              {1,
               2},
              delay = 0.2,
              accuracy = 0.2,
              range = 1.1
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
