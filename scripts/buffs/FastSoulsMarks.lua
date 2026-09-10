---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"

local hero = RPD.Dungeon.hero
local a = "soulstormentor"
local buff = require "scripts/lib/buff"
local storage = require "scripts/lib/storage"

return buff.init{
    desc  = function ()
        return {
            icon          = 68,
            name          = "FastAttacks_BuffN",
            info          = "FastAttacks_BuffD",
        }
    end
}
