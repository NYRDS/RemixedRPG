--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local itemName = ("LichBone")
local str =8

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materialsFromBosses.png",
            image         = 3,
            name          = RPD.textById(itemName.."_Name"),
            price         = 0,
            stackable     = true,
            data          = {
              name = "",
              armorUsable = false,
              weaponUsable = false,
              exp = 20,
              stats =
              {0,
               15,
               0,
               15,
               0,
               5,
               3,
               0},

              armor =
              {{0,0},
               {0,0},

               {-1,-0.01},
               {0,0},

               {2,0.05},
               {3,0.08},

               {0,0},
               {0,0},

               {-3,-0.07},
               {5,0.12},

               {0,0},
               {-2,-0.02},
               {-1,-0.01},
               {-3,-0.03}},
              dr = 2.4,

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
               {3,0.15},
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
