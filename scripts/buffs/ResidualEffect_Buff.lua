---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero = RPD.Dungeon.hero
local state = {}

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 69,
            name          = "ResidualEffectN",
            info          = "ResidualEffectI",
            data          =
            {
            type = 1
            }
        }
    end,

    attackProc = function(self,buff,enemy,damage)
    local hero = RPD.Dungeon.hero
    local data = self:desc().data
    local level = RPD.Dungeon.level
     local weaponA = hero:getBelongings().weapon
     local weaponB = hero:getBelongings().leftHand
     local weaponRoll = weaponA:damageRoll(hero) + weaponB:damageRoll(hero)
     local dmg = math.ceil((weaponA:damageRoll(hero) + weaponB:damageRoll(hero))*0.3) or 0

     if buff:level() == 0 then
       RPD.affectBuff(enemy, "DrPercent_Buff",2):level(20)
     elseif buff:level() == 1 then

       if enemy:buffLevel("BurningBuff") > 0 then
         RPD.removeBuff(enemy,"BurningBuff")
         RPD.affectBuff(enemy, "BurningBuff", 2):level(enemy:buffLevel("BurningBuff") +1)
         storage.gamePut("burningbuff",{dmg = dmg})
       else
         RPD.affectBuff(enemy, "BurningBuff", 2)
         storage.gamePut("burningbuff",{dmg = dmg})
       end

     elseif buff:level() == 2 then
       hero:heal(math.ceil((weaponA:damageRoll(hero) + weaponB:damageRoll(hero))*0.15))

     else
     local x = level:cellX(enemy:getPos())
     local y = level:cellY(enemy:getPos())
     RPG.damage(enemy,math.ceil(weaponRoll*0.1), "mag","lightning")
     RPD.affectBuff(enemy,RPD.Buffs.Paralysis,0.2)

     for i = x-1,x+1 do
      for j = y-1,y+1 do
       local pos2 = level:cell(i,j)
       local enemy2 = RPD.Actor:findChar(pos2)
       if enemy2 and enemy2 ~= RPD.Dungeon.hero and enemy2 ~= enemy then
       RPD.zapEffect(enemy:getPos(),enemy2:getPos(),"Lightning")
        RPG.damage(enemy2,RPG.smartInt(weaponRoll*0.1), "mag","lightning")
        RPD.affectBuff(enemy2,RPD.Buffs.Paralysis,0.2)
       end
      end
     end
     end


     return damage
    end
}
