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
local a = "bonearmor"

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
            image         = 33,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("BoneArmorN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "BoneArmorD",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 2,
            cooldown      = math.max(21-lvl,17),
            castTime      = 0
        }
    end,
    castOnCell = function(self, spell, chr, cell)
    local hero = RPD.Dungeon.hero
    Count = storage.gameGet(a) or {}

	 if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog(RPD.textById("LvlLimit"))
     return false
    end

    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     exp = exp+1
    if exp == expMax then
     exp = 0
     expMax = expMax+6
     lvl = lvl+1
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end
    local char = RPD.Actor:findChar(cell)
    if char and char:friendly(hero) == true or char == hero then
      RPD.removeBuff(char,"BoneArmorBuff")
      RPD.affectBuff(char, "BoneArmorBuff", 2+2*lvl)
    end
 return true
   end
}
