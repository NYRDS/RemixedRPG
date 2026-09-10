--
--Created by Mongol
-- VK: mongolinsult
-- 

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"
local statsMax = 3
local quanStats = 2
local tier = 1
local maxDmg = 3
local minDmg = 1
local stra = 5
local addMag = 10
local magAsLevel = 2
local attackBonus = 0.05
local hero
local str
local stats
local statsInfo = " "

local magicStaff ={}

  magicStaff.makeMagicStaff = function(name,icon,str,minDmg,maxDmg,addMag,stMax,stQuantity,tier,accuracy,delayFactor,range,dmgType,dmgMod)
    return{
    desc  = function (self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      stats = a[2]
      stats[4] = stats[4] + addMag
      statsInfo = a[1]
        return {
            imageFile     = "magicStaffs.png",
            image         = icon,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats,
            level = stra
            },
            name          = RPD.textById("WoodenStaff_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end,
    info = function(self,item)
      hero = RPD.Dungeon.hero
      str = math.max(stra-2*item:level(),1)
      local info = RPD.textById("WoodenStaff_Info").."\n\n"..RPD.textById("WoodenStaff_Name")..RPD.textById("RangedWeaponInfo0")..tier..RPD.textById("WeaponInfo1")..math.ceil((maxDmg+minDmg)/2).." + "..math.ceil(attackBonus*100).."%"..RPD.textById("WeaponInfo2")..str..RPD.textById("WeaponInfo3")..RPD.textById("").."\n\n"..self.data.sInfo
      if RPG.physStr() >= str then
        return info
      else
        return info..RPD.textById("WeaponLimit")
      end
    end,
    
    getAttackAnimationClass = function()
    return "STAFF"
    end,
    
    blockSlot = function()
      return "LEFT_HAND"
    end,
    
    damageRoll = function(self, item, user)
        return maxDmg+item:level()+math.ceil(RPG.magStr()*attackBonus),minDmg+item:level()+math.ceil(RPG.magStr()*attackBonus)
    end,
    
    activate = function(self,item,user)
      hero = RPD.Dungeon.hero
      str = math.max(stra-2*item:level(),1)
      for i = 1, self.data.level - str do
        self.data.dstats[5] = self.data.dstats[5] + magAsLevel
      end
      
      self.data.level = str
      if self.data.activationCount == 0 and user == hero then
          RPG.addStats(self.data.dstats,"StatsA")
      end
      self.data.sInfo = RPG.getItemInfo(self.data.dstats)
      if self.data.activationCount == 0 then
        hero:ht(hero:ht() + self.data.dstats[1])
        hero:setMaxSkillPoints(hero:getSkillPointsMax() + self.data.dstats[2])
      end
      self.data.activationCount = 1
    end,
    
    deactivate = function(self,item)
      hero = RPD.Dungeon.hero
        self.data.activationCount = 0
          RPG.delStats("StatsA")
        hero:ht(hero:ht() - self.data.dstats[1])
        if hero:hp() > hero:ht() then
          hero:hp(hero:ht())
        end
        hero:setMaxSkillPoints(hero:getSkillPointsMax() - self.data.dstats[2])
        if hero:getSkillPoints() > hero:getSkillPointsMax() then
          hero:setSkillPoints(hero:getSkillPointsMax())
        end
    end,
    
    goodForMelee = function()
      return true
    end,
    
    range = function()
      return 3
    end,
    
    onSelect = function(cell,selector)
    end,
    
    accuracyFactor = function(self,item,user)
     str = math.max(stra-2*item:level(),1)
     return 1 + RPG.itemStrBonus(str)
    end,
    
    attackDelayFactor = function(self,item,user)
     str = math.max(stra-2*item:level(),1)
     return 1 - RPG.itemStrBonus(str)
    end,
    
    typicalSTR = function(self,item,user)
      str = math.max(stra-2*item:level(),1)
	  return str
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
    
    
    attackProc = function(self,item,hero,enemy,dmg)
      local hero = RPD.Dungeon.hero
      return dmg
    end,
    
    actions = function(self, item, hero)
     return {}
    end,

    execute = function(self, item, hero, action)
    end
}
end
