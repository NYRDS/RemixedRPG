---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero = RPD.Dungeon.hero
local a = "placetrap"
local scale = 0
local type ="true"
local elmnt ="poison"

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 3,
            name          = "PoisonN",
            info          = "PoisonD",
        }
    end,

    charAct = function(self,buff)
      local Spell = storage.gameGet(a) or {}
      RPG.damage(buff.target,RPG.smartInt(buff:level()*(1+scale*0.005)), type,elmnt)
      scale = scale +1
    end
}
