---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"

local hero = RPD.Dungeon.hero
local storage = require "scripts/lib/storage"
local buff = require "scripts/lib/buff"
local Spell

local a = "bloodspikes"

return buff.init{
    desc  = function ()
    Spell = storage.gameGet(a) or {}
        return {
            icon          = 56,
            name          = "Заражение крови("..tostring(Spell.staks)..")",
            info          = "",
        }
    end,

    charAct = function()
      RPD.BuffIndicator:refreshHero()
    end,

    detach = function(self,buff)
    Spell = storage.gameGet(a) or {}
      local hero = RPD.Dungeon.hero
     hero:ht(hero:ht() +Spell.bp)

     storage.gamePut(a,{exp = Spell.exp, expMax = Spell.expMax, lvl = Spell.lvl, bp = Spell.bp, staks = 0})
    end,
    icon = function()
    Spell = storage.gameGet(a) or {}
      if tonumber(Spell.staks) == 2 then
        return 57
      else
        return 56
      end
    end
}
