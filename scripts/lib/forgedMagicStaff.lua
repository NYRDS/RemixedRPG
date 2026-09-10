
local RPD                  = require "scripts/lib/commonClasses"
local RPG                  = require "scripts/lib/Functions"
local Add                  = require "scripts/lib/AdditionalFunctions"
local smithy = require "scripts/lib/smithing"
local item = require "scripts/lib/item"

local forgedWeapon = {}
local str
local minDmg
local maxDmg
local dmg
local dmgCoef


forgedWeapon.makeWeapon = function()
    return{
    desc = function(self, item)

        return {
            stackable     = false,
            upgradable    = true,
            data = smithy.finalStats,
            imageFile = "items/forgedMagicStaff.png",
            equipable = "weapon"
        }

    end,


    info = function(self,item)
      hero = RPD.Dungeon.hero
      local d = self.data
      str = math.max(d.str -2*item:level(),1)
      maxDmg = RPG.smartInt((d.tier*2.5 +RPG.magStr()*(d.tier*0.06+item:level()*0.02))*1.25)
      minDmg = RPG.smartInt((d.tier*2.5 +RPG.magStr()*(d.tier*0.06+item:level()*0.02))*0.75)

      local info = d.name.." "..RPD.textById("RangedWeaponInfo0")..d.tier..RPD.textById("WeaponInfo1")..minDmg.." — "..maxDmg..RPD.textById("WeaponInfo2")..str..RPD.textById("WeaponInfo3").."\n\n"..d.info
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
      return "StudentStaff"
    end,


    statsRequirementsSatisfied = function(self,item)
      str = math.max(self.data.str-2*item:level(),1)
      if str <= RPG.physStr() then
        return true
      else
        return false
      end
    end,

    getAttackAnimationClass = function()
	    return "STAFF"
	  end,


    slot = function(self, item, belongings)
        return RPD.Slots.weapon
    end,


    blockSlot = function(self)
        return "LEFT_HAND"
    end,


    activate = function(self,item,user)
      hero = RPD.Dungeon.hero
      if self.data.activationCount == 0 and user == hero then
          RPG.addStats(self.data.dstats,"StatsA")
          RPG.increaseHtSp(self.data.dstats)
          self.data.activationCount = 1
      end
    end,


    deactivate = function(self,item)
        hero = RPD.Dungeon.hero
        if self.data.activationCount == 1 then
          RPG.delStats("StatsA")
          self.data.activationCount = 0
          RPG.decreaseHtSp(self.data.dstats)
        end
    end,


	damageRoll = function(self,item,user)
      local hero = RPD.Dungeon.hero
      local d = self.data
      maxDmg = (d.tier*2.5 +RPG.magStr()*(d.tier*0.06+item:level()*0.02))*1.25
      minDmg = (d.tier*2.5 +RPG.magStr()*(d.tier*0.06+item:level()*0.02))*0.75

      local dmgRoll = math.random(minDmg,maxDmg)
      dmg = RPG.getDamage(user:getEnemy(),dmgRoll,"mag","")

      RPG.dmgText("mag",self.data.element,user:getEnemy())

      return dmg,dmg
    end,

    postAttack = function(self,item,enemy)
      RPG.weaponOtherDmg(enemy,dmg,self.data.addstats)
    end,


    accuracyFactor = function(self,item,user)
      str = math.max(self.data.str -2*item:level(),1)
      return self.data.accuracy + RPG.itemStrBonus(str)
    end,


    attackDelayFactor = function(self,item,user)
      str = math.max(self.data.str -2*item:level(),1)
      return math.max(self.data.delay -RPG.itemStrBonus(str)+0.15,0.25)
    end,


    typicalSTR = function(self,item,user)
	  str = math.max(self.data.str -2*item:level(),1)
	  if self.data.level < item:level() then
        self.data.level = item:level()
        self.data.dstats[4] = self.data.dstats[4] +2^self.data.tier
          if self.data.activationCount == 1 then
            RPG.delStats("StatsA")
            RPG.addStats(self.data.dstats,"StatsA")
          end
        self.data.info = RPG.getWeaponInfo(self.data.dstats,self.data.addstats)
      end
      return str
    end,


    requiredSTR = function(self,item,user)
      return str
    end,


    goodForMelee = function(self)
      return true
    end,


    range = function(self)
      return self.data.range +3
    end,

		price = function(self,item)
		  local d = self.data
      mediumDmg = RPG.smartInt( (d.tier*2.5*(6+2*item:level())) )
      return mediumDmg*4 +2^(self.data.tier-1)-4^math.max(self.data.tier-10,0)+50*(self.data.tier-1)*item:level() +RPG.conversionStatsToGold(self.data.dstats,self.data.addstats,self.data.delay,self.data.accuracy,self.data.range,"weapon")
    end


}
end
return forgedWeapon
