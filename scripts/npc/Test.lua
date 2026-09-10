--
--Created by Mongol
-- VK: mongolinsult
--


local RPD = require "scripts/lib/commonClasses"



local Add = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local mob = require"scripts/lib/mob"

local quest = require"scripts/lib/quest"

local sum
local need
local data
local hero

local npc = "Test"


local recipes = {
}

dialog = function(index)
  local hero = RPD.Dungeon.hero
end

return mob.init({
    interact = function(self, chr)
    hero = RPD.Dungeon.hero
     Add.imgMessage("mobs/Alchemist.png","Старик \n\n\n","О-о, привет! Ты ведь приключенец, да? Ты откуда пришел? Честно, я давно таких как ты не видел.")
    end
})
