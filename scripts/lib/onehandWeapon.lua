
local RPD                  = require "scripts/lib/commonClasses"
local RPG                  = require "scripts/lib/Functions"
local Add                  = require "scripts/lib/AdditionalFunctions"
local item = require "scripts/lib/item"

local onehandWeapon = {}

onehandWeapon.makeWeapon = function(name,mod,stra,minDmg,maxDmg,tier,accuracy,delayFactor,range,dmgType,dmgMod,anim,visualName)
    return {
        info = function(self,item)
      hero = RPD.Dungeon.hero
      str = math.max(stra-2*item:level(),1)
      local info = RPD.textById(name.."_Info").."\n\n"..RPD.textById(name.."_Name")..RPD.textById("WeaponInfo0")..tier..RPD.textById("WeaponInfo1")..math.ceil((maxDmg+minDmg+tier*item:level()*2)/2)..RPD.textById("WeaponInfo2")..str..RPD.textById("WeaponInfo3")..RPD.textById(mod) .."\n\n"..self.data.sInfo
      if RPG.physStr() >= str then
        return info
      else
        return info..RPD.textById("WeaponLimit")
      end
    end,

    getVisualName = function()
      return visualName or name
    end,

    slot = function(self, item, belongings)
        if belongings:slotBlocked(RPD.Slots.weapon) then
            return RPD.Slots.leftHand
        end
        return RPD.Slots.weapon
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

    deactivate = function(self,item,user)
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
      local dmgRoll = math.random(minDmg +tier*item:level(),maxDmg +tier*item:level())
      local dmg = RPG.getDamage(user:getEnemy(),dmgRoll,dmgType,dmgMod)

      RPG.dmgText(dmgType,dmgMod,user:getEnemy())

      return dmg,dmg
    end,

    accuracyFactor = function(self,item,user)
      str = math.max(stra-2*item:level(),1)
      return accuracy + RPG.itemStrBonus(str)
    end,

    attackDelayFactor = function(self,item,user)
      str = math.max(stra-2*item:level(),1)
      return delayFactor - RPG.itemStrBonus(str)
    end,

    typicalSTR = function(self,item,user)
	  str = math.max(stra-2*item:level(),1)
      return str
    end,

	getAttackAnimationClass = function()
	return anim
	end,

    requiredSTR = function(self,item,user)
      return str
    end,

    statsRequirementsSatisfied = function(self,item)
      str = math.max(stra-2*item:level(),1)
      if str <= RPG.physStr() then
        return true
      else
        return false
      end
    end,

    goodForMelee = function()
      return true
    end,

    range = function()
      return range
    end,

    onSelect = function(cell,selector)
    end,

    actions = function(self, item, hero)
      return {}
    end,

    execute = function(self, item, hero, action)
    end,

    isIdentified = function(self)
      return false
    end
    }
end

return onehandWeapon
