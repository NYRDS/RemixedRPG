
local RPD                  = require "scripts/lib/commonClasses"
local RPG                  = require "scripts/lib/Functions"
local Add                  = require "scripts/lib/AdditionalFunctions"
local smithy = require "scripts/lib/smithing"
local item = require "scripts/lib/item"

local forgedWeapon = {}
local str
local image = "forgedArmor.png"
local minDmg
local maxDmg
local dmg
local hits = 0
local prevEnemy = ""

forgedWeapon.makeWeapon = function()
    return{
    desc = function(self, item)

        return {
            stackable     = false,
            upgradable    = true,
            data = smithy.finalStats,
            imageFile = "items/forgedDagger.png",
            equipable = "weapon"
        }

    end,


    info = function(self,item)
      hero = RPD.Dungeon.hero
      str = math.max(self.data.str-2*item:level(),1)
      maxDmg = RPG.smartInt((self.data.maxDmg +self.data.tier*item:level())*1.8)
      minDmg = RPG.smartInt((self.data.minDmg +self.data.tier*item:level())*0.8)

      local info = self.data.name..RPD.textById("WeaponInfo0")..self.data.tier..RPD.textById("WeaponInfo1")..minDmg.." — "..maxDmg..RPD.textById("WeaponInfo2")..str..RPD.textById("WeaponInfo3").."\n\n"..self.data.info
      if RPG.physStr() >= str then
        return info
      else
        return info..RPD.textById("WeaponLimit")
      end
    end,


    image = function(self)
      return self.data.icon
    end,


    name = function(self)
      return self.data.name
    end,

    getVisualName = function()
      return "Dagger"
    end,


    statsRequirementsSatisfied = function(self,item)
      str = math.max(self.data.str-2*item:level(),1)
      if str <= RPG.physStr() then
        return true
      else
        return false
      end
    end,


    slot = function(self, item, belongings)
        if belongings:slotBlocked(RPD.Slots.weapon) then
          return RPD.Slots.leftHand
        else
          return RPD.Slots.weapon
        end
    end,


    activate = function(self,item,user)
      hero = RPD.Dungeon.hero
      if self.data.activationCount == 0 and user == hero then
      if RPG.handCheck(item) then
          RPG.addStats(self.data.dstats,"StatsA2")
          else
          RPG.addStats(self.data.dstats,"StatsA")
      end
      self.data.activationCount = 1
      RPG.increaseHtSp(self.data.dstats)
      end
    end,


    deactivate = function(self,item)
      hero = RPD.Dungeon.hero
      if self.data.activationCount == 1 then
        if RPG.handCheck(item) then
            RPG.delStats("StatsA2")
            else
            RPG.delStats("StatsA")
        end
        RPG.decreaseHtSp(self.data.dstats)
        self.data.activationCount = 0
      end
    end,


	damageRoll = function(self,item,user)
      local hero = RPD.Dungeon.hero
      maxDmg = RPG.smartInt((self.data.maxDmg +self.data.tier*item:level())*1.8)
      minDmg = RPG.smartInt((self.data.minDmg +self.data.tier*item:level())*0.8)


      local dmgRoll = math.random(minDmg,maxDmg)
      local d = self.data
      local id =
      {
        cut = 10,
        chop = 11,
        stab = 12,
        crush = 13
      }
      local dmgFrSt1 = d.addstats[id[d.element[1] or d.element]]
      local dmgFrSt2 = d.addstats[id[d.element[2]]] or {0,dmgFrSt1[2]}
      dmg = RPG.getDamage(user:getEnemy(),dmgRoll *((dmgFrSt1[2]+dmgFrSt2[2])/200 +1) + dmgFrSt1[1] +dmgFrSt2[1],self.data.type,self.data.element)

			RPG.dmgText("phys",self.data.element,user:getEnemy())

      return dmg,dmg
    end,


    postAttack = function(self,item,enemy)
      RPG.weaponOtherDmg(enemy,dmg,self.data.addstats)
      local chanceRoll = math.random(1,12)
      if chanceRoll <= 4 +hits +self.data.rareScale  and dmg > 0 and not RPG.noBloodMobs[enemy:getMobClassName()] then
        hits = 0
        local bleed = RPD.affectBuff(enemy,"FastBleeding",2)
        bleed:level( math.max(1, RPG.smartInt(2 + dmg*(0.4 +0.1*self.data.rareScale) /2)) )
        RPG.flyText(enemy,RPD.textById("bleeding"),"red")
        RPD.topEffect(enemy:getPos(),"bleeding_effect")

      elseif prevEnemy == enemy or hits == 0 then
        hits = hits +1
      else
        hits = 1
      end

      prevEnemy = enemy
    end,


    accuracyFactor = function(self,item,user)
      str = math.max(self.data.str-2*item:level(),1)
      return self.data.accuracy + RPG.itemStrBonus(str) +0.5
    end,


    attackDelayFactor = function(self,item,user)
      str = math.max(self.data.str-2*item:level(),1)
      return math.max(self.data.delay - RPG.itemStrBonus(str)-0.25,0.25)
    end,


    typicalSTR = function(self,item,user)
	  str = math.max(self.data.str-2*item:level(),1)
      return str
    end,


    requiredSTR = function(self,item,user)
      return str
    end,


    goodForMelee = function(self)
      return true
    end,


    range = function(self)
      return self.data.range
    end,

		price = function(self,item)
      mediumDmg = RPG.smartInt( (self.data.minDmg+self.data.maxDmg)/3 )
      return mediumDmg*(item:level()+1)*self.data.tier*10 +2^(self.data.tier-1)-4^math.max(self.data.tier-10,0)+50*(self.data.tier-1)*item:level() +RPG.conversionStatsToGold(self.data.dstats,self.data.addstats,self.data.delay,self.data.accuracy,self.data.range,"weapon")
    end


}
end
return forgedWeapon
