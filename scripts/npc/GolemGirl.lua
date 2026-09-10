--
--Created by Mongol
-- VK: mongolinsult
--

local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"
local Add = require "scripts/lib/AdditionalFunctions"
local storage = require "scripts/lib/storage"
local mob = require"scripts/lib/mob"
local quest = require"scripts/lib/quest"

local hero

return mob.init({

    interact = function(self, chr)
      hero = RPD.Dungeon.hero
      Add.imgMessage("mobs/GolemGirl.png","Golem girl","Hi!")
    end

})
