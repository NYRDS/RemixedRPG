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
local a = "ragesouls"
local pos
local enemy
local type ="mag"
local elmnt ="dark"

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
            image         = 32,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("RageSoulsN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "RageSoulsD",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 9+lvl,
            cooldown      = math.max(14-lvl-RPG.spellFast,8-math.ceil(RPG.spellFast/2)),
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
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end

    if exp == expMax then
       exp = 0
       expMax = expMax+5
       lvl = lvl+1
     else
       exp = exp+1
     end

    local from = hero:getPos()
    local to = cell
    local enName

    pos = RPD.Ballistica:cast(from,to,true,false,false)
    for i = 2, RPD.Ballistica.distance do
      enemy = RPD.Actor:findChar(RPD.Ballistica.trace[i])
      if enemy and enemy ~= hero then
        enName = enemy:getMobClassName()
      else
        enName = nil
      end
      if enName == "BoneGolem_lvl1" or enName == "BoneGolem_lvl2" or enName == "BoneGolem_lvl3" then
        enemy:heal(math.ceil(RPG.magStr()*0.4 + 3*lvl),hero)

        RPD.Sfx.CellEmitter:get(enemy:getPos()):burst(RPD.Sfx.Speck:factory(RPD.Sfx.Speck.HEALING ), 3)
      else
        if enemy and enemy ~= hero then
          RPG.damage(enemy,math.ceil(RPG.magStr()*0.3 + 2*lvl),type,elmnt)
          RPD.zapEffect(from, enemy:getPos(), "ragesouls_effect")
          break
        end
      end
      if i == RPD.Ballistica.distance then
        RPD.zapEffect(from, RPD.Ballistica.trace[i], "ragesouls_effect")
      end
    end

     return true
   end
}
