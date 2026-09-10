--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local onehandWeapon = require "scripts/lib/onehandWeapon"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"
local statsMax = 6
local quanStats = 3
local stra = 35
local tier = 3
local maxDmg = 12
local minDmg = 6
local accuracy = 1
local delayFactor = 1
local str
local stats
local hero
local statsInfo
local config = onehandWeapon.makeWeapon("Sword","",stra,minDmg,maxDmg,tier,accuracy,delayFactor,1,"phys",{"cut","stab"},"SWORD")
config.desc  = function(self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
        return {
            imageFile     = "items.png",
            image         = 20,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Sword_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
	return item.init(config)
