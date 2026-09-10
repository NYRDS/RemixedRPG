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
            icon          = 59,
            info          = "PoisonedBloodD",
        }
    end,

    charAct = function()
      RPD.BuffIndicator:refreshHero()
    end,


    name = function()
      return RPD.textById("PoisonedBloodN").."("..tostring(Spell.staks)..")"
    end,


    detach = function(self,buff)
    Spell = storage.gameGet(a) or {}
      local hero = RPD.Dungeon.hero
     hero:ht(hero:ht() +Spell.bp)

     storage.gamePut(a,{exp = Spell.exp, expMax = Spell.expMax, lvl = Spell.lvl, bp = Spell.bp, staks = 0})
    end,


    icon = function()
      Spell = storage.gameGet(a) or {}
        if tonumber(Spell.staks) == 5 then
          return 60
        else
          return 59
        end
      end
}
