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
local statsMax = 12
local quanStats = 4
local stra = 80
local tier = 6
local maxDmg = 28
local minDmg = 18
local accuracy = 1
local delayFactor = 1
local range = 1
local str
local stats
local hero
local statsInfo
local config = twohandWeapon.makeWeapon("Claymore","",stra,minDmg,maxDmg,tier,accuracy,delayFactor,range,"phys",{"cut","chop"},"HEAVY")
config.desc  = function (self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
        return {
            imageFile     = "items/swords.png",
            image         = 6,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Claymore_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
	return item.init(config)
