--
-- Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local twohandWeapon = require "scripts/lib/twohandWeapon"

local item = require "scripts/lib/item"

local statsMax = 6
local quanStats = 2
local stra = 20
local tier = 2
local maxDmg = 8
local minDmg = 6
local accuracy = 1
local delayFactor = 0.7
local range = 1
local str
local stats
local hero
local statsInfo

local config = twohandWeapon.makeWeapon("Quarterstaff","WeaponFast",stra,minDmg,maxDmg,tier,accuracy,delayFactor,range,"phys","crush","STAFF")

    config.desc  = function (self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]

        return {
            imageFile     = "items.png",
            image         = 17,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = RPD.textById("Quarterstaff_Name")..": "..tostring(math.max(stra-2*item:level(),1)),
            price         = 20*2^(tier-1)+10*2^(tier-1)*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end
    return item.init(config)
