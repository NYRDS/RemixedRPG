
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
local dmg = 0
local dmgFromArrow = 0
local addMin = 0
local addMax =0
local hits = 0
local prevEnemy = ""


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
        RPG.selectAmmo(luajava.bindClass(WndBag).Mode.ALL,RPD.textById("selectAmmo2"))
      end
    end,

    info = function(self,item)
      hero = RPD.Dungeon.hero
      str = math.max(self.data.str -2*item:level(),1)
      maxDmg = RPG.smartInt(self.data.maxDmg +self.data.tier*item:level())
      minDmg = RPG.smartInt(self.data.minDmg +self.data.tier*item:level())

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
      return "CompoundBow"
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
	    return "BOW"
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


    preAttack = function(self,item,enemy)
      hero = RPD.Dungeon.hero
      local choosedArrows = storage.gameGet("choosedArrows") or {}
      local file = require("scripts/items/"..choosedArrows.is)
      checkForBuff = false

      if choosedArrows.is ~= nil and RPG.distance(enemy:getPos()) > 0 then
        if item:getUser():getBelongings():getItem(choosedArrows.is) ~= nil then
          checkForBuff = true
          addMin = file:dmg()[1]
          addMax = file:dmg()[2]
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
    local dmgRoll

    if RPG.distance(hero:getEnemy():getPos()) > 0 then
      dmgRoll =math.random(minDmg +addMin,maxDmg+addMax)
    else
      dmgRoll =math.random((minDmg +addMin)*0.5,(maxDmg+addMax)*0.5)
    end

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

    local choosedArrows = storage.gameGet("choosedArrows") or {}
    local file = require("scripts/items/"..choosedArrows.is)

    if file:buff() ~= nil and checkForBuff == true then

      local arrowBuff = file:buff()
      local buffName = arrowBuff[1]
      local buffDuration = arrowBuff[2]
      local buffLevel = arrowBuff[3]

      RPD.affectBuff(enemy,buffName, buffDuration):level(buffLevel)

    end

    RPG.weaponOtherDmg(enemy,dmg,self.data.addstats)
    local f =2 +hits +self.data.rareScale
    local chanceRoll = math.random(1,12)
      if chanceRoll <= f and dmg > 0 and not RPG.noBloodMobs[enemy:getMobClassName()] then
        hits = 0
        local bleed = RPD.affectBuff(enemy,"FastBleeding",3)
        bleed:level( math.max(1, RPG.smartInt(2+dmg*(0.4 +0.1*self.data.rareScale)/3)) )
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

		price = function(self,item)
      mediumDmg = RPG.smartInt( (self.data.minDmg+self.data.maxDmg)/3 )
      return mediumDmg*(item:level()+1)*self.data.tier*10 +2^(self.data.tier-1)-4^math.max(self.data.tier-10,0)+50*(self.data.tier-1)*item:level() +RPG.conversionStatsToGold(self.data.dstats,self.data.addstats,self.data.delay,self.data.accuracy,self.data.range,"weapon")
    end


}
end
return forgedWeapon
