
local RPD                  = require "scripts/lib/commonClasses"
local RPG                  = require "scripts/lib/Functions"
local Add                  = require "scripts/lib/AdditionalFunctions"
local smithy = require "scripts/lib/smithing"
local storage = require "scripts/lib/storage"
local item = require "scripts/lib/item"

local forgedWeapon = {}
local str
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
            imageFile = "items/forgedCrossbow.png",
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
      str = math.max(self.data.str-2*item:level(),1)
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
      return "CompositeCrossbow"
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
	    return "CROSSBOW"
	  end,


    slot = function(self, item, belongings)
        return RPD.Slots.weapon
    end,


    blockSlot = function(self)
        return "LEFT_HAND"
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
			local dmg = 0
      maxDmg = self.data.maxDmg +self.data.tier*item:level()
       minDmg = self.data.minDmg +self.data.tier*item:level()

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

      local chanceRoll = math.random(1,12)
      if chanceRoll <= 2 +hits +self.data.rareScale and dmg > 0 then
        hits = 0
        dmg = RPG.smartInt(math.max(dmg + user:getEnemy():dr()*(0.5 +0.1*self.data.rareScale),user:getEnemy():dr()*(1+0.1*self.data.rareScale) ))
        RPG.flyText(user:getEnemy(),RPD.textById("stabbed"),"red")
        RPD.topEffect(user:getEnemy():getPos(),"shield_broken")

      elseif prevEnemy == user:getEnemy() or hits == 0 then
        hits = hits +1
      else
        hits = 1
      end

      prevEnemy = user:getEnemy()

			RPG.dmgText("phys",self.data.element,user:getEnemy())
      return dmg,dmg
    end,


    accuracyFactor = function(self,item,user)
      str = math.max(self.data.str-2*item:level(),1)
      return self.data.accuracy + RPG.itemStrBonus(str) +0.5
    end,


    attackDelayFactor = function(self,item,user)
      str = math.max(self.data.str-2*item:level(),1)
      return math.max(self.data.delay*1.5 - RPG.itemStrBonus(str) +0.25,0.25)
    end,


    typicalSTR = function(self,item,user)
	  str = math.max(self.data.str-2*item:level(),1)
      return str
    end,


    requiredSTR = function(self,item,user)
      return str
    end,


    goodForMelee = function(self)
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
      end
    end,

		price = function(self,item)
      mediumDmg = RPG.smartInt( (self.data.minDmg+self.data.maxDmg)/3 )
      return mediumDmg*(item:level()+1)*self.data.tier*10 +2^(self.data.tier-1)-4^math.max(self.data.tier-10,0)+50*(self.data.tier-1)*item:level() +RPG.conversionStatsToGold(self.data.dstats,self.data.addstats,self.data.delay,self.data.accuracy,self.data.range,"weapon")
    end


}
end
return forgedWeapon
