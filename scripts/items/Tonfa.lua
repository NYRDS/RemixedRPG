--
--Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local twohandWeapon = require "scripts/lib/twohandWeapon"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"
local statsMax = 9
local quanStats = 3
local stra = 45
local tier = 4
local maxDmg = 18
local minDmg = 12
local accuracy = 1
local delayFactor = 1
local str
local stats
local hero
local statsInfo
local config = twohandWeapon.makeWeapon("Tonfa","WeaponCounter",stra,minDmg,maxDmg,tier,accuracy,delayFactor,1,"phys","crush","SWORD")
config.desc  = function(self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
        return {
            imageFile     = "rpgitems.png",
            image         = 34,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Tonfa_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end

		config.activate = function(self,item)
      hero = RPD.Dungeon.hero
			if hero then
      	RPD.removeBuff(hero,"TonfsBuff")
      	local buff = RPD.permanentBuff(hero, "TonfsBuff")
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
			RPD.removeBuff(hero,"TonfsBuff")
      self.data.activationCount = 0
      RPG.delStats("StatsA")
      RPG.decreaseHtSp(self.data.dstats)
    end
	return item.init(config)
