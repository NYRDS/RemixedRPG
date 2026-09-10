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
            icon          = 71,
            name          = "PurificationPoison_BuffN",
            info          = "PurificationPoison_BuffI",
        }
    end,

    charAct = function(self,buff)
      if buff.target:buffLevel("PoisonBuff") > 1 then
        RPD.removeBuff(buff.target,"PoisonBuff")
      end
    end
}
