--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"
local str =0.5

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 3,
            name          = RPD.textById("Cloth_Name"),
            price         = 10,
            stackable     = true,
            data          = {
              name = "cloth",
              armorUsable = true,
              weaponUsable = false,
              exp = 0.25,
              stats =
              {0,
               0.5,
               0,
               0,
               0,
               0,
               0,
               0},

              armor =
              {{-1,0},
               {0,0},

               {0,0},
               {0,0},

               {0,0},
               {0,0},

               {0,0},
               {0,0},

               {0,0},
               {0,0},

               {0.3,0},
               {0.2,0},
               {0,0},
               {0.15,0}},
              dr = 0.2,

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

      return RPD.textById("Cloth_Info").."\n"..sInfo
    end

    }
