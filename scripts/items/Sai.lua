--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"

local onehandWeapon = require "scripts/lib/onehandWeapon"

local statsMax = 6
local quanStats = 2
local stra = 20
local tier = 2
local maxDmg = 10
local minDmg = 6
local accuracy = 1
local delayFactor = 0.8
local range = 1
local str
local stats
local hero
local statsInfo
local config = onehandWeapon.makeWeapon("Sai","WeaponAccu",stra,minDmg,maxDmg,tier,accuracy,delayFactor,range,"phys","stab","SWORD")
config.desc = function(self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]

        return {
            imageFile     = "rpgitems.png",
            image         = 32,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Sai_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
		config.activate = function(self,item)
      hero = RPD.Dungeon.hero
			if hero then
      	RPD.removeBuff(hero,"SaiBuff")
      	local buff = RPD.permanentBuff(hero, "SaiBuff")
      	buff:level(item:level()+1)
      end
      if self.data.activationCount == 0 or RPG.luck == nil then
      	RPG.addStats(self.data.dstats,"StatsA")
      end
      if self.data.activationCount == 0 then
        RPG.increaseHtSp(self.data.dstats)
      end
      self.data.activationCount = 1
    end

    config.deactivate = function(self,item)
      hero = RPD.Dungeon.hero
			RPD.removeBuff(hero,"SaiBuff")
      self.data.activationCount = 0
      RPG.delStats("StatsA")
      RPG.decreaseHtSp(self.data.dstats)
    end
    return item.init(config)
