--
--Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"
local name = "CompositeScepter"
local icon = 18
local statsMax = 6
local quanStats = 3
local tier = 3
local maxDmg = 12
local minDmg = 6
local stra = 20
local addMag = 20
local magAsLevel = 8
local attackBonus = 0.2
local hero
local str
local stats
local statsInfo = " "

return item.init{
    desc  = function (self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      stats = a[2]
      stats[4] = stats[4] +addMag
      statsInfo = RPG.getItemInfo(stats)
        return {
            imageFile     = "rpgitems.png",
            image         = icon,
            data          = {
            equipped = 0,
            sInfo = statsInfo,
            dstats = stats,
            level = 0
            },
            name          = RPD.textById(name.."_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end,
    info = function(self,item)
      hero = RPD.Dungeon.hero
      str = math.max(stra-2*item:level(),1)
      local info = RPD.textById(name.."_Info").."\n\n"..RPD.textById(name.."_Name")..RPD.textById("RangedWeaponInfo0")..tier..RPD.textById("WeaponInfo1")..math.ceil((maxDmg+minDmg)/2).." + "..math.ceil(attackBonus*100).."%"..RPD.textById("WeaponInfo2")..str..RPD.textById("WeaponInfo3").."\n\n"..self.data.sInfo
      if RPG.physStr() >= str then
        return info
      else
        return info..RPD.textById("WeaponLimit")
      end
    end,

    getAttackAnimationClass = function()
    return "STAFF"
    end,


    statsRequirementsSatisfied = function(self,item)
      str = math.max(stra - 2*item:level(),1)
      if str <= RPG.physStr() then
        return true
      else
        return false
      end
    end,


    blockSlot = function()
      return "LEFT_HAND"
    end,


    activate = function(self,item,user)
      hero = RPD.Dungeon.hero
      str = math.max(stra-2*item:level(),1)
      if self.data.equipped == 0 and user == hero then
          RPG.addStats(self.data.dstats,"StatsA")
          RPG.increaseHtSp(self.data.dstats)
      end
      self.data.equipped = 1
    end,

    deactivate = function(self,item)
      hero = RPD.Dungeon.hero
        self.data.equipped = 0
          RPG.delStats("StatsA")
          RPG.decreaseHtSp(self.data.dstats)
    end,


    attackProc = function(self,item,hero,enemy,dmg)
      local hero = RPD.Dungeon.hero
      local dmgRoll = RPG.intRoll((maxDmg+item:level() +RPG.magStr()*attackBonus)*1.25,(minDmg+item:level() +RPG.magStr()*attackBonus)*0.75)
      RPG.damage(enemy,RPG.smartInt(dmgRoll),"mag")
      return 0
    end,


    damageRoll = function()
      return 0,0
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
      if self.data.level < item:level() then
        self.data.level = item:level()
        self.data.dstats[4] = self.data.dstats[4] +magAsLevel
          if self.data.equipped == 1 then
            RPG.delStats("StatsA")
            RPG.addStats(self.data.dstats,"StatsA")
          end
        self.data.sInfo = RPG.getItemInfo(self.data.dstats)
      end
	    return str
    end,

    requiredSTR = function(self,item,user)
      return str
    end,


    actions = function(self, item, hero)
     return {}
    end,

    execute = function(self, item, hero, action)
    end
}
