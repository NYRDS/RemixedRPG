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
local a = "horattack"
local pos
local moveTo
local enemy
local stop = false
local type ="phys"
local elmnt ={"chop","stab"}

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
            image         = 23,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("HorAttackN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "HorAttackD",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(21-lvl-RPG.spellFast,18-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,

    castOnCell = function(self, spell, chr, cell, caster)
    local level = RPD.Dungeon.level
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
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     exp = exp+1
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end

    if exp == expMax then
       exp = 0
       expMax = expMax+5
       lvl = lvl+1
     end

    local weaponA = hero:getBelongings().weapon
    local heroPos = hero:getPos()
    moveTo = RPD.Ballistica:cast(heroPos,cell,true,false,false)
    RPD.zapEffect(heroPos, moveTo, "horattack_effect")
    for i = 0, math.min( math.min(2+lvl, 5), RPD.Ballistica.distance ) do
      enemy = RPD.Actor:findChar(RPD.Ballistica.trace[i])
      if enemy and enemy ~= hero then
        RPG.damage(enemy,math.ceil(RPG.physStr()*(0.15+lvl*0.02) + RPG.AllFast()*(0.5+lvl*0.1) + weaponA:damageRoll(hero)*0.75 ) - enemy:dr() - i, type,elmnt)
        RPD.topEffect(enemy:getPos(),"bleeding_effect")
        end
      end
     return true
   end
}
