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
local a = "fireball"
local type ="mag"
local elmnt ="fire"

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
            image         = 36,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("FireballN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "FireballD",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 14+lvl,
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
     expMax = 3
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end


    local pos = RPD.Ballistica:cast(RPD.Dungeon.hero:getPos(),cell,true,true,true)
    local enemy = RPD.Actor:findChar(pos)
    RPD.zapEffect(RPD.Dungeon.hero:getPos(),pos,"fireball_effect")


    RPD.removeBuff(hero,"ResidualEffect_Buff")
    local Buff = RPD.affectBuff(hero, "ResidualEffect_Buff", 4):level(1)


    if enemy and enemy ~= RPD.Dungeon.hero then
      RPG.damage(enemy,math.ceil(RPG.magStr()*0.8+2*lvl), type,elmnt)
      RPD.affectBuff(enemy, "BurningBuff", 2)
      storage.gamePut("burningbuff",{dmg = dmg})
      return true
    else
      return true
  end


  end
}
