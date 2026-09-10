---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "bonearmor"
local hero = RPD.Dungeon.hero
local level
local scale = 0
local acc = 0
local type ="phys"
local elmnt ="crush"

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 66,
            name          = "BoneArmor_BuffN",
            info          = "BoneArmor_BuffD",
        }
    end,
    charAct = function(self,buff)
      scale = scale +1
    end,

    defenceProc = function(self,buff,enemy,damage)
      acc = acc - math.ceil(damage*0.5)
      return damage
    end,

    drBonus = function(self,buff)
     local Count = storage.gameGet(a) or {}
     return math.ceil(RPG.magStr()*(0.35 + 0.1*scale) + 2*Count.lvl)
    end,

    speedMultiplier = function(self, buff)
        return 0.7 + RPG.AllFast()*0.2
    end,

    detach = function(self,buff)
      hero = RPD.Dungeon.hero
      level = RPD.Dungeon.level
      if buff.target == hero then
        if (hero:getSkillPoints() + acc) > hero:getSkillPointsMax() then
          hero:setSkillPoints(hero:getSkillPointsMax())
          acc = acc - (hero:getSkillPointsMax() - hero:getSkillPoints())
        else
          hero:setSkillPoints(hero:getSkillPoints() + acc)
          acc = 0
        end
      else
        if buff.target:hp() + acc > buff.target:ht() then
          buff.target:hp(buff.target:ht())
          acc = acc - (buff.target:ht() - buff.target:hp())
        else
          buff.target:heal(acc,buff.target)
          acc = 0
        end
      end
      local x = level:cellX(buff.target:getPos())
      local y = level:cellY(buff.target:getPos())
      local enName

      for i = x-1,x+1 do
        for j = y-1,y+1 do
          local pos = level:cell(i,j)
          local enemy = RPD.Actor:findChar(pos)
          if enemy and enemy ~= hero then
            enName = enemy:getMobClassName()
          else
            enName = nil
          end
          if enemy and enemy ~= hero and (enName ~= "BoneGolem_lvl1" and enName ~= "BoneGolem_lvl2" and enName ~= "BoneGolem_lvl3") then
            RPG.damage(enemy,acc, type,elmnt)
          end
        end
      end
    end
}
