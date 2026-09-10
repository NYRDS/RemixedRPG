---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"
local buff = require "scripts/lib/buff"

local hero = RPD.Dungeon.hero

return buff.init{
    desc  = function ()
        return {
            icon          = -1,
            name          = "",
            info          = "",
        }
    end,

    charAct = function(self,buff)
	  RPD.removeBuff(buff.target, RPD.Buffs.Roots)
    end
}
