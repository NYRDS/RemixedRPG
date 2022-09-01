
local RPD                  = require "scripts/lib/commonClasses"
local RPG                  = require "scripts/lib/Functions"
local Add                  = require "scripts/lib/AdditionalFunctions"
local smithy = require "scripts/lib/smithing"
local storage = require "scripts/lib/storage"
local item = require "scripts/lib/item"

local forgedWeapon = {}
local str
local checkForBuff
local minDmg
local maxDmg
local addMin = 0
local addMax = 0


forgedWeapon.makeWeapon = function()
    return{
    desc = function(self, item)
        
        return {
            stackable     = false,
            upgradable    = true,
            data = smithy.finalStats,
            imageFile = "items/forgedBow.png",
            equipable = "weapon"
        }
        
    end,
    
    actions = function(self)
    return {"selectAmmo"}
    end,
    
    execute = function(self,item,hero,action)
      local WndBag = RPG.Objects.Ui.WndBag
      if action == "selectAmmo" then
        RPG.selectAmmo(luajava.bindClass(WndBag).Mode.ALL,"selectAmmo2")
      end
    end,
    
    info = function(self,item)
      hero = RPD.Dungeon.hero
      str = math.max(self.data.str -2*item:level(),1)
      maxDmg = self.data.maxDmg +self.data.tier*item:level()
      minDmg = self.data.minDmg +self.data.tier*item:level()
      
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
      return ""
    end,
    
    
    getVisualName = function()
      return "CompoundBow"
    end,
   
   
    getAttackAnimationClass = function()
	    return "BOW"
	  end,
	
   
    slot = function(self, item, belongings)
        return RPD.Slots.weapon
    end,
    
    
    blockSlot = function(self)
        return "LEFT_HAND"
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
    
    
    preAttack = function(self,item,enemy)
      hero = RPD.Dungeon.hero
      local choosedArrows = storage.gameGet("choosedArrows") or {}
      local file = require("scripts/items/"..choosedArrows.is)
      checkForBuff = false 
      
      if choosedArrows.is ~= nil and RPG.distance(enemy:getPos()) > 0 then
        if item:getUser():getBelongings():getItem(choosedArrows.is) ~= nil then
          checkForBuff = true
          addMin = file:desc().data.addDmg[1]
          addMax = file:desc().data.addDmg[2]
          item:getUser():getBelongings():getItem(choosedArrows.is):detach(item:getUser():getBelongings().backpack)
          RPD.zapEffect(hero:getPos(),enemy:getPos(),"Arrow")
          
        else
          RPD.glogn("dontHaveArrows")
       
        end
      end
    end,
	
	
	damageRoll = function(self,item,user,enemy)
    local hero = RPD.Dungeon.hero
    local dmg = 0
    maxDmg = self.data.maxDmg +self.data.tier*item:level()
    minDmg = self.data.minDmg +self.data.tier*item:level()
      
    local dmgRoll = math.random(minDmg +addMin,maxDmg +addMax)
    dmg = RPG.getDamage(user:getEnemy(),dmgRoll,self.data.type,self.data.element)
          
    return dmg,dmg
  end,
  
  
  postAttack = function(self,item,enemy)
  
    local choosedArrows = storage.gameGet("choosedArrows") or {}
    local file = require("scripts/items/"..choosedArrows.is)
    
    if file:desc().data.buff ~= nil and checkForBuff == true then
          
      local arrowBuff = file:desc().data.buff
      local buffName = arrowBuff[1]
      local buffDuration = arrowBuff[2]
      local buffLevel = arrowBuff[3]
      
      RPD.affectBuff(enemy,buffName, buffDuration):level(buffLevel)
      
    end
  end,
    
    
    accuracyFactor = function(self,item,user)
      str = math.max(self.data.str -2*item:level(),1)
      return self.data.accuracy + RPG.itemStrBonus(str)
    end,
    
    
    attackDelayFactor = function(self,item,user)
      str = math.max(self.data.str -2*item:level(),1)
      return math.max(self.data.delay -RPG.itemStrBonus(str),0.25)
    end,
    
    
    typicalSTR = function(self,item,user)
	  str = math.max(self.data.str -2*item:level(),1)
      return str
    end,
	
	
    requiredSTR = function(self,item,user)
      return str
    end,
    
    
    goodForMelee = function()
      return false
    end,
    
    
    range = function(self,item)
      local choosedArrows = storage.gameGet("choosedArrows") or {}
      
      if choosedArrows.is ~= nil then
      
        if item:getUser():getBelongings():getItem(choosedArrows.is) ~= nil then
          return self.data.range +20
          
        else 
          return self.data.range 
          
        end
        
      else
        return self.data.range 
        
      end
    end,
    
     
}
end
return forgedWeapon