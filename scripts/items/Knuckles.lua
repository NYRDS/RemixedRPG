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
local statsMax = 3
local quanStats = 2
local stra = 10
local tier = 1
local maxDmg = 4
local minDmg = 2
local accuracy = 1
local delayFactor = 0.8
local range = 1
local str
local stats
local hero
local statsInfo
local config = onehandWeapon.makeWeapon("Knuckles","WeaponFast",stra,minDmg,maxDmg,tier,accuracy,delayFactor,range,"phys","crush","NONE")
config.desc  = function (self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
        return {
            imageFile     = "items.png",
            image         = 16,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Knuckles_Name")..": "..tostring(math.max(1,stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
	return item.init(config)
