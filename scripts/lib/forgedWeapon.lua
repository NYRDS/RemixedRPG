
local RPD                  = require "scripts/lib/commonClasses"
local RPG                  = require "scripts/lib/Functions"
local Add                  = require "scripts/lib/AdditionalFunctions"
local smithy = require "scripts/lib/smithing"
local item = require "scripts/lib/item"

local forgedWeapon = {}
local str
local image = "forgedArmor.png"


forgedWeapon.makeWeapon = function()
    return{
    desc = function(self, item)

        return {
            stackable     = false,
            upgradable    = true,
            data = smithy.finalStats,
            imageFile = image,
        }

    end,


    info = function(self,item)

      hero = RPD.Dungeon.hero
      str = math.max(self.data.str-2*item:level(),1)
      image = "forged"..self.data.choosenObject..".png"

      local info = RPD.textById("WeaponInfo0")..self.data.tier..RPD.textById("WeaponInfo1")..RPD.textById("WeaponInfo2")..str..RPD.textById("WeaponInfo3").."\n\n"..self.data.info
      if RPG.physStr() >= str then
        return info
      else
        return info..RPD.textById("WeaponLimit")
      end
    end,

   imageFile = function(self)
     local image1 = "forged"..self.data.choosenObject..".png"
     return image1
   end,

    image = function(self)
      return self.data.icon
    end,

    name = function(self)
      return ""
    end,

    slot = function(self, item, belongings)
        if belongings:slotBlocked(RPD.Slots.weapon) and self.data.wType ~= "twoHanded" then
            return RPD.Slots.leftHand
        end
        return RPD.Slots.weapon
    end,

    blockSlot = function(self)
      if self.data.wType == "twoHanded" then
        return "LEFT_HAND"
      else
        return ""
      end
    end,

    activate = function(self,item)
      hero = RPD.Dungeon.hero
      if self.data.activationCount == 0 and item.user == hero then
      if RPG.handCheck(item) then
          RPG.addStats(self.data.dstats,"StatsA2")
          else
          RPG.addStats(self.data.dstats,"StatsA")
      end
      end
      if self.data.activationCount == 0 then
        RPG.increaseHtSp(self.data.dstats)
      end
      self.data.activationCount = 1
    end,

    deactivate = function(self,item)
        hero = RPD.Dungeon.hero
        self.data.activationCount = 0
        if RPG.handCheck(item) then
            RPG.delStats("StatsA2")
            else
            RPG.delStats("StatsA")
        end
        RPG.decreaseHtSp(self.data.dstats)
    end,

	damageRoll = function(self,item,user)
      local hero = RPD.Dungeon.hero
      local dmgRoll = math.random(self.data.minDmg +self.data.tier*item:level(),self.data.maxDmg +self.data.tier*item:level())
      local dmg = RPG.getDamage(user:getEnemy(),dmgRoll,self.data.type,self.data.element)
      return dmg,dmg
    end,

    accuracyFactor = function(self,item,user)
      str = math.max(self.data.str-2*item:level(),1)
      return self.data.accuracy + RPG.itemStrBonus(str)
    end,

    attackDelayFactor = function(self,item,user)
      str = math.max(self.data.str-2*item:level(),1)
      return self.data.delay - RPG.itemStrBonus(str)
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

    range = function()
      return self.data.range
    end,


}
end
return forgedWeapon
