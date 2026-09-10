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
local maxDmg = 24
local minDmg = 14
local accuracy = 1.5
local delayFactor = 1.5
local str
local stats
local hero
local statsInfo
local config = twohandWeapon.makeWeapon("Glaive","WeaponAccuNotFast",stra,minDmg,maxDmg,tier,accuracy,delayFactor,2,"phys",{"cut","stab"},"STAFF")
config.desc  = function(self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
        return {
            imageFile     = "items.png",
            image         = 30,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Glaive_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
    return item.init(config)
