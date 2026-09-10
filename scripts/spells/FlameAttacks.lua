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
local a = "flameattacks"

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
            image         = 21,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("FlameAttacksN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "FlameAttacksD",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(11-lvl-RPG.spellFast,6-math.ceil(RPG.spellFast/2)),
            castTime      = 0
        }
    end,
    cast = function(self, spell, chr, cell)
    local hero = RPD.Dungeon.hero

    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog(RPD.textById("LvlLimit"))
     return false
    end

    Count = storage.gameGet(a) or {}
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     exp = exp+1
    if exp == expMax then
     exp = 0
     expMax = expMax+8
     lvl = lvl+1
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 15
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end

    RPD.removeBuff(RPD.Dungeon.hero,"FlameAttacksBuff")
    RPD.affectBuff(RPD.Dungeon.hero, "FlameAttacksBuff", 3+1.5*lvl)
 return true
   end
}
