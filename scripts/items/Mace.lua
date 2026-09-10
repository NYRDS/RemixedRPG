--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local onehandWeapon = require "scripts/lib/onehandWeapon"

local item = require "scripts/lib/item"
local statsMax = 6
local quanStats = 3
local stra = 35
local tier = 3
local maxDmg = 10
local minDmg = 6
local accuracy = 1.5
local delayFactor = 1
local range = 1
local str
local stats
local hero
local statsInfo
local config = onehandWeapon.makeWeapon("Mace","WeaponAccu",stra,minDmg,maxDmg,tier,accuracy,delayFactor,range,"phys","crush","SWORD")
config.desc  = function (self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
        return {
            imageFile     = "items.png",
            image         = 18,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Mace_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
	return item.init(config)
