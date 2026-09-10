--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local armor = require "scripts/lib/armor"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"

local statsMax = 6
local quanStats = 3
local stra = 20
local tier = 3
local str
local stats
local hero
local statsInfo
local config = armor.makeArmor("SpiderArmor",stra,tier)

config.desc = function(self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]

        return {
            imageFile     = "items/armor.png",
            image         = 21,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("SpiderArmor_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="armor"
        }
    end

	config.defenceProc = function(self, item, enemy, damage)
	  hero = RPD.Dungeon.hero
	  if math.random(0,100) >= 50 then
	    RPD.placeBlob(RPD.Blobs.Web, hero:getPos(), 4)
	  end
	  return damage
	end

	config.charAct = function(self, item)
		hero = RPD.Dungeon.hero
	  RPD.removeBuff(hero, RPD.Buffs.Roots)
	end
	return item.init(config)
