
local RPD                  = require "scripts/lib/commonClasses"
local RPG                  = require "scripts/lib/Functions"
local Add                  = require "scripts/lib/AdditionalFunctions"
local smithy = require "scripts/lib/smithing"
local item = require "scripts/lib/item"

local forgedWeapon = {}
local str
local minDmg
local maxDmg


forgedWeapon.makeWeapon = function()
    return{
    desc = function(self, item)
        
        return {
            stackable     = false,
            upgradable    = true,
            data = smithy.finalStats,
            imageFile = "items/forgedHalberd.png",
            equipable = "weapon"
        }
        
    end,
    
    
    info = function(self,item)
      hero = RPD.Dungeon.hero
      str = math.max(self.data.str -2*item:level(),1)
      maxDmg = RPG.smartInt((self.data.maxDmg +self.data.tier*item:level())*1.3)
      minDmg = RPG.smartInt(self.data.minDmg +self.data.tier*item:level())
      
      local info = RPD.textById("WeaponInfo0")..self.data.tier..RPD.textById("WeaponInfo1")..minDmg.." — "..maxDmg..RPD.textById("WeaponInfo2")..str..RPD.textById("WeaponInfo3").."\n\n"..self.data.info
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
      return "Halberd"
    end,
    
    
    getAttackAnimationClass = function()
	return "SPEAR_ATTACK"
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
      maxDmg = (self.data.maxDmg +self.data.tier*item:level())*1.3
      minDmg = self.data.minDmg +self.data.tier*item:level()
      
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
      local dmg = RPG.getDamage(user:getEnemy(),dmgRoll *((dmgFrSt1[2]+dmgFrSt2[2])/200 +1) + dmgFrSt1[1] +dmgFrSt2[1],self.data.type,self.data.element)
      
      RPG.weaponOtherDmg(user:getEnemy(), dmg, self.data.addstats) 
			user:getEnemy():getSprite():showStatus(0xffff00,RPD.textById(self.data.element[1] or self.data.element).."/"..(RPD.textById(self.data.element[2]) or "")..":")
      return dmg,dmg
    end,
    
    
    accuracyFactor = function(self,item,user)
      str = math.max(self.data.str -2*item:level(),1)
      return self.data.accuracy + RPG.itemStrBonus(str)-0.35
    end,
    
    
    attackDelayFactor = function(self,item,user)
      str = math.max(self.data.str -2*item:level(),1)
      return math.max(self.data.delay -RPG.itemStrBonus(str)+0.15,0.25)
    end,
    
    
    typicalSTR = function(self,item,user)
	  str = math.max(self.data.str -2*item:level(),1)
      return str
    end,
	
	
    requiredSTR = function(self,item,user)
      return str
    end,
    
    
    goodForMelee = function(self)
      return true
    end,
    
    
    range = function(self)
      return self.data.range +1
    end,
		
		price = function(self,item)
      return 8*2^(self.data.tier-1)+10*2^(self.data.tier-1)*item:level() +RPG.conversionStatsToGold(self.data.dstats,self.data.addstats,self.data.delay,self.data.accuracy,self.data.range,"weapon")
    end
    
     
}
end
return forgedWeapon