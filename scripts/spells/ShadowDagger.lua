---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local spell = require "scripts/lib/spell"

local storage = require "scripts/lib/storage"

local lvl
local expMax
local exp
local a = "shadowdagger"

return spell.init{
    desc  = function ()
    local Count = storage.gameGet(a) or {}

     if Count.lvl == nil then
  lvl = 1
  else
   if lvl == nil then
    lvl = Count.lvl
   end
  end
        return {
            image         = 28,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("ShadowDaggerN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "ShadowDaggerD",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 3,
            cooldown      = math.max(16-lvl-RPG.spellFast,10-math.ceil(RPG.spellFast/2)),
            castTime      = 0
        }
    end,
    cast = function(self, spell, chr, cell)
    Count = storage.gameGet(a) or {}

    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog(RPD.textById("LvlLimit"))
     return false
    end

    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 10
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end

    RPD.removeBuff(RPD.Dungeon.hero,"ShadowDaggerBuff")
    RPD.permanentBuff(RPD.Dungeon.hero, "ShadowDaggerBuff")
   return true
   end
}
