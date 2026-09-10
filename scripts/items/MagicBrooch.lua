--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"
local absorb = 0.5
local tier = 2

return item.init{
    desc  = function (self, item)

        return {
            imageFile     = "rpgitems.png",
            image         = 64,
            name          = "MagicBrooch_Name",
            info          = "MagicBrooch_Info",
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            data          ={
            activationCount = 0
            },
            stackable     = false,
            upgradable    = true,
            isArtifact    = true
        }
    end,


    activate = function(self, item)
      local hero = RPD.Dungeon.hero
      if hero then
      RPD.removeBuff(hero, "MagicAbsorb")
      RPD.permanentBuff(hero, "MagicAbsorb"):level(item:level())
      end
    end,


    deactivate = function(self, item)
      local hero = RPD.Dungeon.hero
      RPD.removeBuff(hero, "MagicAbsorb")
    end,


    isIdentified = function(self)
      return false
    end

}
