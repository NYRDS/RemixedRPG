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
local a = "magicbolt"
local type ="mag"
local elmnt

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
            image         = 1,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("MagicBoltN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "MagicBoltD",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 6+lvl,
            cooldown      = math.max(15-lvl-RPG.spellFast,12-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,
    castOnCell = function(self, spell, chr, cell)
    local hero = RPD.Dungeon.hero
    Count = storage.gameGet(a) or {}
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     exp = exp+1
    if exp == expMax then
     exp = 0
     expMax = expMax+7
     lvl = lvl+1
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end
 local pos = RPD.Ballistica:cast(RPD.Dungeon.hero:getPos(),cell,true,true,true)
 local enemy = RPD.Actor:findChar(pos)

 RPD.zapEffect(RPD.Dungeon.hero:getPos(),pos,"magic_missile")

 if RPG.subclass == "BattleMage" then
   RPD.removeBuff(hero,"ResidualEffect_Buff")
   local Buff = RPD.affectBuff(hero, "ResidualEffect_Buff", 4):level(0)
 end

 if enemy and enemy ~= RPD.Dungeon.hero then
  RPG.damage(enemy,RPG.smartInt(7+RPG.magStr()*0.25+2*lvl-RPG.distance(pos) ),type,elmnt)
  return true
 else
 return true
 end
   end
}
