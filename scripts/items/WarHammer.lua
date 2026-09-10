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
local quanStats = 4
local stra = 60
local tier = 5
local maxDmg = 18
local minDmg = 10
local accuracy = 1.5
local delayFactor = 1
local str
local stats
local hero
local statsInfo
local config = twohandWeapon.makeWeapon("WarHammer","WeaponAccu",stra,minDmg,maxDmg,tier,accuracy,delayFactor,1,"phys","crush","HEAVY")
config.desc  = function(self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
        return {
            imageFile     = "items.png",
            image         = 23,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("WarHammer_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
	return item.init(config)
