---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero = RPD.Dungeon.hero

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 47,
            name          = "DrPercent_Name",
            info          = "DrPercent_Info"
        }
    end,
    drBonus = function(self,buff)
      return buff.target:dr() *(0.01*buff:level())
    end
    }
