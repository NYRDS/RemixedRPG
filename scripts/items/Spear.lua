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
local statsMax = 6
local quanStats = 2
local stra = 20
local tier = 2
local maxDmg = 14
local minDmg = 6
local accuracy = 1.5
local delayFactor = 1.25
local str
local stats
local hero
local statsInfo
local config = twohandWeapon.makeWeapon("Spear","WeaponAccuNotFast",stra,minDmg,maxDmg,tier,accuracy,delayFactor,2,"phys","stab","STAFF")
config.desc  = function(self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
        return {
            imageFile     = "items.png",
            image         = 29,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Spear_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+20*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
	return item.init(config)
