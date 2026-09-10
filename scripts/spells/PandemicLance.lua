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
local a = "pandemiclance"
local pos
local moveTo
local enemy
local type ="mag"
local elmnt ="poison"

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
            image         = 35,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("PandemicLanceN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "PandemicLanceD",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 15+lvl,
            cooldown      = math.max(16-lvl-RPG.spellFast,10-math.ceil(RPG.spellFast/2)),
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
    Spell = storage.gameGet("bloodspikes") or {}
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end

    if exp == expMax then
       exp = 0
       expMax = expMax+5
       lvl = lvl+1
     else
       exp = exp+1
     end

    RPD.removeBuff(hero,"BloodPoisoning")
    local heroPos = hero:getPos()
    pos = RPD.Ballistica:cast(heroPos,cell,true,false,false)
    RPD.zapEffect(heroPos, RPD.Ballistica.trace[math.min( math.min(2+(Spell.staks or 0), 6), RPD.Ballistica.distance)], "pandemiclance_effect")
    for i = 0, math.min( math.min(2+(Spell.staks or 0), 6), RPD.Ballistica.distance ) do
      enemy = RPD.Actor:findChar(RPD.Ballistica.trace[i])
      if enemy and enemy ~= hero then
        RPG.damage(enemy,math.ceil(RPG.magStr()*(0.25+0.05*Spell.staks)), type,elmnt)
        buff = RPD.affectBuff(enemy, "PoisonBuff", Spell.staks or 0)
        buff:level(RPG.magStr()*(0.8+0.15*Spell.staks))
        RPD.topEffect(enemy:getPos(),"bleeding_effect")
        end
      end
     return true
   end
}
