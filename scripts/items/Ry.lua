--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local twohandWeapon = require "scripts/lib/twohandWeapon"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"
local statsMax = 20
local quanStats = 10
local stra = 200
local tier = 10
local maxDmg = 40
local minDmg = 32
local accuracy = 2
local delayFactor = 0.5
local str
local stats
local hero
local statsInfo
local config = twohandWeapon.makeWeapon("Ry","WeaponFA",stra,minDmg,maxDmg,tier,accuracy,delayFactor,2,"phys",{"crush","stab"},"STAFF")
config.desc  = function(self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]

        return {
            imageFile     = "rpgitems.png",
            image         = 35,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Ry_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
	return item.init(config)
