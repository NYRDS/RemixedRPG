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
local a = "lightning"
local type ="mag"
local elmnt ="lightning"

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
            image         = 10,
            imageFile     = "spellsIcons/spellicons.png",
            name          = RPD.textById("LightningN").." ["..tostring(lvl).." "..RPD.textById("Lvl").."]",
            info          = "LightningD",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 15+lvl,
            cooldown      = math.max(31-lvl-RPG.spellFast,27-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,
    castOnCell = function(self, spell, chr, cell)
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
     exp = exp+1
    if exp == expMax then
     exp = 0
     expMax = expMax+5
     lvl = lvl+1
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end

    if RPG.subclass == "BatleMage" then
      RPD.removeBuff(hero,"ResidualEffect_Buff")
      RPD.affectBuff(hero,"ResidualEffect_Buff",5):level(3)
    end

    local pos = RPD.Ballistica:cast(RPD.Dungeon.hero:getPos(),cell,true,true,true)
    local enemy = RPD.Actor:findChar(pos)
    RPD.zapEffect(RPD.Dungeon.hero:getPos(),pos,"Lightning")
    if enemy and enemy ~= RPD.Dungeon.hero then
      RPD.playSound("snd_lightning.ogg")
      enemy:damage(math.ceil(RPG.magStr()*(0.3+lvl*0.05)),RPD.Dungeon.hero)
      RPD.affectBuff(enemy,RPD.Buffs.Paralysis,1)
      local x = level:cellX(enemy:getPos())
      local y = level:cellY(enemy:getPos())

      for i = x-1,x+1 do
        for j = y-1,y+1 do
          local pos2 = level:cell(i,j)
          local enemy2 = RPD.Actor:findChar(pos2)
          if enemy2 and enemy2 ~= RPD.Dungeon.hero and enemy2 ~= enemy then
          RPD.zapEffect(enemy:getPos(),enemy2:getPos(),"Lightning")
          enemy2:damage(math.ceil(RPG.magStr()*(0.2+lvl*0.03)), RPD.Dungeon.hero)
          RPD.affectBuff(enemy2,RPD.Buffs.Paralysis,1)
       end
      end
     end
  return true
 else
 return true
 end
   end
}
