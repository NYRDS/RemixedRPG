
local RPD                  = require "scripts/lib/commonClasses"
local RPG                  = require "scripts/lib/Functions"
local Add                  = require "scripts/lib/AdditionalFunctions"

local armor = {}

armor.makeArmor = function(name,stra,tier)
    return{
info = function(self,item)
      hero = RPD.Dungeon.hero
      str = math.max(stra-2*item:level(),1)
      local info = RPD.textById(name.."_Info").."\n\n"..RPD.textById(name.."_Name")..RPD.textById("ArmorInfo0")..tier..RPD.textById("ArmorInfo1")..tier*2+item:level()*tier..RPD.textById("ArmorInfo2")..str..RPD.textById("ArmorInfo3").."\n\n"..self.data.sInfo
      if RPG.physStr() >= str then
        return info
      else
        return info..RPD.textById("ArmorLimit")
      end
    end,

    getVisualName = function()
      return visualName or name
    end,

    statsRequirementsSatisfied = function(self,item)
      str = math.max(stra - 2*item:level(),1)
      if str <= RPG.physStr() then
        return true
      else
        return false
      end
    end,

	effectiveDr = function(self,item)
	  return tier*2 + item:level()*tier
	end,

	typicalDR = function(self,item)
	  return tier*2
	end,

    activate = function(self,item,user)
      hero = RPD.Dungeon.hero
	  str = math.max(stra-2*item:level(),1)
      if self.data.activationCount == 0 and user == hero then
          RPG.addStats(self.data.dstats,"StatsB")
        RPG.increaseHtSp(self.data.dstats)
        self.data.activationCount = 1
      end
    end,

    deactivate = function(self,item)
      hero = RPD.Dungeon.hero
      if self.data.activationCount == 1 then
        RPG.delStats("StatsB")
        RPG.decreaseHtSp(self.data.dstats)
        self.data.activationCount = 0
      end
    end,

    typicalSTR = function(self,item,user)
	  str = math.max(stra-2*item:level(),1)
      return str
    end,

    requiredSTR = function(self,item,user)
      return str
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
return armor
