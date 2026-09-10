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
local a = "earthheal"

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
            image         = 37,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("EarthHealN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "EarthHealD",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 10+2*lvl,
            cooldown      = math.max(35-lvl-RPG.spellFast,10-math.ceil(RPG.spellFast/2)),
            castTime      = 0
        }
    end,
    cast = function(self, spell, chr, cell)
    Count = storage.gameGet(a) or {}
    local hero = RPD.Dungeon.hero

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
     expMax = 6
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end

    hero:heal(math.ceil(RPG.magStr()*(0.45 + 0.03*lvl)), hero)

    RPD.removeBuff(RPD.Dungeon.hero,"ResidualEffect_Buff")
    RPD.affectBuff(RPD.Dungeon.hero, "ResidualEffect_Buff", 4):level(2)
   return true
   end
}
