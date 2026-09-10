--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local item = require "scripts/lib/item"

local itemInfo = RPD.textById("GnollSkin_Info")
local str =1.75

return item.init{
desc  = function(self, item)
        return {
            imageFile     = "items/materials.png",
            image         = 17,
            name          = RPD.textById("GnollSkin_Name"),
            price         = 20,
            stackable     = true,
            data          = {
              name = "",
              armorUsable = false,
              weaponUsable = false,
              exp = 0.3,
              stats =
              {2,
               0,
               0,
               0,
               0,
               0,
               0,
               0},

              armor =
              {{-1.25,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0,0},
               {0.5,0},
               {0.25,0},
               {0.2,0},
               {0.75,0}},
              dr = 0.5,

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

      return itemInfo.."\n"..sInfo
    end

    }
