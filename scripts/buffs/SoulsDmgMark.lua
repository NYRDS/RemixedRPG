---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero = RPD.Dungeon.hero
local a = "soulstormentor"
local scale = 0
local type ="mag"
local elmnt

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = -1,
            name          = "",
            info          = "",
        }
    end,

    charAct = function(self,buff)
      local Spell = storage.gameGet(a) or {}
      for i= 1, buff:level()-1 %2 do
      RPG.damage(buff.target,RPG.smartInt(0 +2.5*Spell.lvl +RPG.magStr()*0.25 + buff.target:ht()*(0.02+0.01*Spell.lvl)), type,elmnt)
      buff.target:getSprite():showStatus(0xffff00,RPD.textById("torment"))
      buff:level(buff:level()-2)
      end
    end,
    detach = function(self,buff)
      RPD.glog("-")
    end
}
